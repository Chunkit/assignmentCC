from flask import Flask, render_template, request
from pymysql import connections
import os
import boto3

customhost = "internshipdatabase.cpkr5ofaey5p.us-east-1.rds.amazonaws.com"
customuser = "admin"
custompass = "admin123"
customdb = "internshipdb"
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
def viewStudentInfo():

    stud_id = 1
    statement = "SELECT stud_id, stud_name FROM Student WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id))

    result = cursor.fetchall()
    cursor.close()
    
    return render_template('viewStudentInfoByCohort.html', data=result)

@app.route('/viewStudentInfoDetails/<int:stud_id>')
def view_internship(internship_id):

    statement = "SELECT * FROM Student WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id))
    result = cursor.fetchone()

    return render_template('viewStudentInfoDetails.html', intern=result)

@app.route('/editStudentInfoDetails.html/<int:stud_id>')
def edit_internship(internship_id):

    statement = "SELECT * FROM Students WHERE stud_id = %s"
    cursor = db_conn.cursor()
    cursor.execute(statement, (stud_id))
    result = cursor.fetchone()

    return render_template('viewStudentInfoDetails.html', intern=result)

        
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
