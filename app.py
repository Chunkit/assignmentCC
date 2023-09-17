from curses import flash
from flask_wtf.csrf import CSRFProtect, CSRFError
from flask import Flask, render_template, request, redirect, flash, jsonify
from pymysql import connections
import os
import boto3
import botocore
import pdfplumber
# Use BytesIO to handle the binary content
from io import BytesIO
from flask import send_file
from werkzeug.utils import secure_filename

customhost = "internshipdb.c9euwctn4e9a.us-east-1.rds.amazonaws.com"
customuser = "admin"
custompass = "admin123"
customdb = "internshipDB"
custombucket = "bucket-internship"
customregion = "us-east-1"

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'pdf'}

app = Flask(__name__, static_folder='assets')
#encrypt
csrf = CSRFProtect(app)

bucket = custombucket
region = customregion


db_conn = connections.Connection(
    host=customhost,
    port=3306,
    user=customuser,
    password=custompass,
    db=customdb

)
output = {}
def allowed_file(filename):
    # Get the file extension from the filename
    _, file_extension = os.path.splitext(filename)
    # Check if the file extension (without the dot) is in the allowed extensions set
    return file_extension.lower()[1:] in ALLOWED_EXTENSIONS

@app.route("/", methods=['GET', 'POST'])
def home():
    return render_template('supervisorMainPage.html')

@app.route("/viewStudentInfoByCohort", methods=['GET'])
def viewStudentInfoByCohort():
    return render_template('viewStudentInfoByCohort.html')

@app.route("/viewStudentInfo", methods=['GET'])
def viewStudentInfo():
    statement = "SELECT s.* FROM Student s JOIN Student_List sl ON s.stud_id = sl.stud_id JOIN Supervisor sv ON sl.sv_id = sv.sv_id WHERE sl.sv_id = 1;"
    cursor = db_conn.cursor()
    cursor.execute(statement)
    result = cursor.fetchall()
    return render_template('viewStudentInfo.html', data=result)

@app.route('/viewStudentInfoDetails/<stud_id>')
def viewStudentInfoDetails(stud_id):
    statement = "SELECT * FROM Student s WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id,))
    result = cursor.fetchone() #Assuming there's only one student with the given ID
            
    return render_template('viewStudentInfoDetails.html', student=result)

@app.route('/view_resume/<stud_id>')
def view_resume(stud_id):
    statement = "SELECT * FROM Student s WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id,))
    result = cursor.fetchone()

    resume_key = "stud_id-" + str(stud_id) + "_pdf"

    s3 = boto3.client('s3', region_name=region)
    try:
        with BytesIO() as resume_buffer:
            s3.download_fileobj(bucket, resume_key, resume_buffer)
            resume_buffer.seek(0)


        try:
            # Return the PDF file
            return send_file(
                resume_buffer,
                as_attachment=True,
                download_name="resume-" + str(stud_id) + "_pdf",
                mimetype='application/pdf'
            )
                    
        except Exception as e:
            return str(e)
    finally:
        cursor.close()
        
    return render_template('viewStudentInfoDetails.html', student=result)

@app.route('/editStudentInfoDetails/<stud_id>')
def editStudent(stud_id):

    statement = "SELECT * FROM Student WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id,))
    result = cursor.fetchone()

    return render_template('editStudentInfoDetails.html', student=result)

@app.route('/updateStudent', methods=['POST','GET'])
@csrf.exempt 
def updateStudent():

    stud_id =  request.form['stud_id']
    ic = request.form['ic']
    gender = request.form['gender']
    programme = request.form['programme']
    group = request.form['group']
    cgpa = request.form['cgpa']
    password = request.form['password']
    intern_batch = request.form['intern_batch']
    ownTransport = request.form['ownTransport']
    currentAddress = request.form['currentAddress']
    contactNo = request.form['contactNo']
    personalEmail = request.form['personalEmail']
    homeAddress = request.form['homeAddress']
    homePhone = request.form['homePhone']
    resume = request.files['resume']

    cursor = db_conn.cursor()

    if resume.filename == "":
        return "Please add a resume"

    if not allowed_file(resume.filename):
        return "File type not allowed. Only PDFs are allowed."

    try:
        cursor.execute(statement, (ic, gender, programme, group, cgpa, password, intern_batch, ownTransport, currentAddress, contactNo, personalEmail, homeAddress, homePhone, resume, stud_id))
        db_conn.commit()  # Commit the changes to the database

        resume_in_s3 = "stud_id-" + str(stud_id) + "_pdf"
        s3 = boto3.resource('s3')

        try:
            print("Data inserted in MySQL RDS... uploading pdf to S3...")
            s3.Bucket(custombucket).put_object(Key=resume_in_s3, Body=resume, ContentType=resume.content_type)

            # Generate the object URL
            object_url = f"https://{custombucket}.s3.amazonaws.com/{resume_in_s3}"
            statement = "UPDATE Student SET ic = %s, gender = %s, programme = %s, `group` = %s, cgpa = %s, password = %s, intern_batch = %s, ownTransport = %s, currentAddress = %s, contactNo = %s, personalEmail = %s, homeAddress = %s , homePhone = %s, resume = object_url WHERE stud_id = %s;"
            
        except Exception as e:
            return str(e)
            
    finally:
        cursor.close()
        
    return redirect("/viewStudentInfoDetails/" + stud_id)

        
if __name__ == '__main__':
    app.secret_key = 'chunkit_key'
    app.run(host='0.0.0.0', port=80, debug=True)
