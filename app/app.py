from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import requests
import os

app = Flask(__name__)
CORS(app)

# RasaサーバーのURLを環境変数から取得
RASA_URL = os.getenv('RASA_URL', 'http://localhost:5005/webhooks/rest/webhook')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/chat', methods=['POST'])
def chat():
    user_message = request.json.get('message')
    try:
        response = requests.post(RASA_URL, json={"sender": "user", "message": user_message})
        response.raise_for_status()
        return jsonify(response.json())
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to connect to Rasa"}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

