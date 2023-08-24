from flask import Flask, request, render_template, redirect
import csv
import os


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
        return redirect('lobby', code=302)

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
        return redirect('lobby', code=302)
    else:
        return render_template('login.html')



@app.route('/lobby', methods=['POST', 'GET'])
def lobby():
    if request.method=='POST':
        roomName=request.form["new_room"]+".txt"
        fileDirect = os.path.join("./rooms", roomName)
        f = open(fileDirect, 'w').close()

    rooms = os.listdir("./rooms")
    rooms = [os.path.splitext(room)[0] for room in rooms]
    return render_template('lobby.html', room_names=rooms)
    














def checkIfUserExist(username, password):
    rows = []
    with open("./users.csv", 'r') as file:
        csvreader = csv.reader(file)
        header = next(csvreader)
        for row in csvreader:
            rows.append(row)
    if username in rows:
        return True
    else:
        return False 



def addUser(username, password):
    row = [username, password]
    with open('./users.csv', 'a', newline='\n') as file:  
        writer = csv.writer(file, lineterminator='\n')
        writer.writerow(row)





if __name__ == "__main__":
    app.run(host='0.0.0.0')