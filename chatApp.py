from flask import Flask, request, render_template, redirect, session
import csv
import os
import datetime

app = Flask(__name__)
app.secret_key = "123"
PATH_ROOMS =  os.environ["PATH_ROOMS"]

@app.route('/')
def home_page():
    return render_template('register.html')

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
        session['username'] = userName
        return redirect('lobby', code=302)

    # on loading  
    return render_template('register.html')

@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method=='POST':
        userName = request.form["username"]
        password = request.form["password"]
        if not checkIfUserExist(userName, password):
            return redirect('register')
        session['username'] = userName
        return redirect('lobby', code=302)
    return render_template('login.html')

@app.route('/lobby', methods=['POST', 'GET'])
def lobby():
    if request.method == 'POST':
        if 'new_room' in request.form and 'Create' in request.form:
            roomName = request.form["new_room"] + ".txt"
            fileDirect = os.path.join(PATH_ROOMS, roomName)
            f = open(fileDirect, 'w').close()
        elif 'room' in request.form and 'enter' in request.form:
            roomName = request.form["room"]
            return redirect(url_for('chat', room_name=roomName))
    rooms = os.listdir(PATH_ROOMS)
    rooms = [os.path.splitext(room)[0] for room in rooms]
    return render_template('lobby.html', room_names=rooms)
    

@app.route('/chat/<room_id>')
def chat(room_id):
    return render_template('chat.html', room=room_id)

@app.route('/api/chat/<room_id>', methods=['POST', 'GET'])
def update_chat(room_id):
    if request.method=='POST':
        message=request.form["msg"]
        addMessage(room_id, message)
    messages=getMessages(room_id)
    return messages

# 
@app.route('/api/chat/clear/<room_id>', methods=['POST'])

def clear(room_id):
    with open(f'{PATH_ROOMS}/{room_id}.txt', 'w') as file:
        file.write('')

    


@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect('/register')




def addMessage(room_id, msg):
    if 'username' in session:
        username = session['username']
    else:
        username = 'guest'
    date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(f'{PATH_ROOMS}/{room_id}.txt', 'a') as file:
        file.write(f'[{date}] {username} : {msg}\n')

        

def getMessages(room_id):
    # messages=[]
    with open(f'{PATH_ROOMS}/{room_id}.txt', 'r') as file:
        # for line in file:
        #     messages.append(line.rstrip())
        messages=file.read()
    return messages



def checkIfUserExist(username, password):
    with open('users.csv', 'r') as file:
        reader = csv.reader(file)
        for row in reader:
            if row and row[0] == username and row[1] == password:
                return True
    return False

def addUser(username, password):
    row = [username, password]
    with open('./users.csv', 'a', newline='\n') as file:
        writer = csv.writer(file, lineterminator='\n')
        if file.tell() == 0:
            writer.writerow(['username', 'password'])
        writer.writerow(row)


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)


