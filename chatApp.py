from flask import Flask, request, render_template
import csv


app = Flask(__name__)


@app.route('/register', methods=['POST, GET'])
def homePage():
    # on submit
    if request.methods=='POST':
        userName = request.form["username"]
        password = request.form["password"]
        #exist user move to the login page
        if checkIfUserExist(userName, password):
            return redirect(url_for('login.html'))
        addUser(userName, password)
        return redirect(url_for('lobby.html'))

    # on loading    
    else:
        return render_template('register.html')



@app.route('/login', methods=['POST', 'GET'])
def loginPage():
    if methods=='POST':
        userName = request.form["username"]
        password = request.form["password"]
        if ! checkIfUserExist(userName, password):
            return redirect(url_for('register'))
        return redirect(url_for('lobby.html'))

    else:
        return render_template('login.html')

        




if __name__ == "__main__":
    app.run(host='0.0.0.0')