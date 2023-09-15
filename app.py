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
    statement = "SELECT s.* FROM Student s JOIN Student_List sl ON s.stud_id = sl.stud_id JOIN Supervisor sv ON sl.sv_id = sv.sv_id WHERE sl.sv_id = 2;"
    cursor = db_conn.cursor()
    cursor.execute(statement)
    result = cursor.fetchall()
    return render_template('viewStudentInfo.html', data=result)

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
