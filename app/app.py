from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/chat', methods=['POST'])
def chat():
    user_input = request.json.get('message')
    response = requests.post(
        "http://rasa:5005/webhooks/rest/webhook",
        json={"sender": "user", "message": user_input}
    )
    return jsonify(response.json())

# if __name__ == '__main__':
#     app.run(host="0.0.0.0", port=5000, debug=True)

