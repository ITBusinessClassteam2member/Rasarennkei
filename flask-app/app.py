from flask import Flask, request, jsonify
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)

RASA_URL = "http://rasa:5005/webhooks/rest/webhook"  # RasaコンテナへのURL

@app.route('/webhook', methods=['POST'])
def webhook():
    user_message = request.json.get('message')
    if not user_message:
        return jsonify({"error": "No message provided"}), 400
    
    payload = {
        "sender": "user",
        "message": user_message
    }

    try:
        response = requests.post(RASA_URL, json=payload)
        response.raise_for_status()
        return jsonify(response.json())
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
