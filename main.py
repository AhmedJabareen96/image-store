from flask import Flask

app = Flask(__name__)



@app.route('/')
def index():
   return 'Welcome to home page !'

@app.route('/upload')
def upload_image():
    pass

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)


