from flask import Flask, request, render_template


app = Flask(__name__)

@app.route('/', methods=['POST'])
def homePage():
    if methods=='POST'




    return render_template('register.html')



@app.route('/login')
def loginPage():
    return render_template('login.html')





if __name__ == "__main__":
    app.run(host='0.0.0.0')