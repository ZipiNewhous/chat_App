from flask import Flask, request, render_template
import csv


app = Flask(__name__)



@app.route('/register', methods=['POST', 'GET'])
def register():
    # on submit
    if request.method=='POST':
        userName = request.form["username"]
        password = request.form["password"]
        #exist user move to the login page
        if checkIfUserExist(userName, password):
            return redirect('login')
        addUser(userName, password)
        return redirect('lobby')

    # on loading    
    else:
        return render_template('register.html')



@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method=='POST':
        userName = request.form["username"]
        password = request.form["password"]
        if not checkIfUserExist(userName, password):
            return redirect('register')
        return redirect('lobby')

    else:
        return render_template('login.html')







def checkIfUserExist(username, password):
    rows = []
    with open("users.csv", 'r') as file:
        csvreader = csv.reader(file)
        header = next(csvreader)
        for row in csvreader:
            rows.append(row)
    print(rows)
    if username in rows:
        return True
    else:
        return False 









if __name__ == "__main__":
    app.run(host='0.0.0.0')