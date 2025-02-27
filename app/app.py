from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import os

app = Flask(__name__)
CORS(app, resources={r"/chat": {"origins": "*"}})

# Render 用の Rasa URL 環境変数
RASA_URL = os.getenv('RASA_URL', 'http://localhost:5005/webhooks/rest/webhook')

@app.route('/chat', methods=['POST'])
def chat():
    # Content-Type が application/json の場合に対応
    if request.content_type != 'application/json':
        return jsonify({"error": "Content-Type must be application/json"}), 400

    user_message = request.json.get('message')
    if not user_message:
        return jsonify({"error": "No message provided"}), 400

    try:
        # Rasa サーバーに POST リクエスト
        response = requests.post(
            RASA_URL,
            json={"sender": "user", "message": user_message},
            headers={'Content-Type': 'application/json'}
        )
        response.raise_for_status()
        return jsonify(response.json())
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to connect to Rasa"}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
