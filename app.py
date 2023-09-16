from flask import Flask, render_template, request
from pymysql import connections
import os
import boto3

customhost = "internshipdb.c9euwctn4e9a.us-east-1.rds.amazonaws.com"
customuser = "admin"
custompass = "admin123"
customdb = "internshipDB"
custombucket = "bucket-internship"
customregion = "us-east-1"


app = Flask(__name__, static_folder='assets')

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

@app.route('/editStudentInfoDetails/<stud_id>')
def editStudent(stud_id):

    statement = "SELECT * FROM Student WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id,))
    result = cursor.fetchone()

    return render_template('editStudentInfoDetails.html', student=result)

@app.route('/updateStudent', methods=['POST','GET'])
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
    #resume = request.files['resume']

    statement = "UPDATE Student SET ic = %s, gender = %s, programme = %s, group = %d, cgpa = %d, password = %s, intern_batch = %s, ownTransport = %s, currentAddress = %s, contactNo = %s, personalEmail = %s, homeAddress = %s , homePhone = %s WHERE stud_id = %s;"
    cursor = db_conn.cursor()
    cursor.execute(statement, (ic, gender, programme, group, cgpa, password, intern_batch, ownTransport, currentAddress, contactNo, personalEmail, homeAddress, homePhone, stud_id))
    db_conn.commit()  # Commit the changes to the database

    return redirect("/viewStudentInfoDetails/" + stud_id)
        
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
