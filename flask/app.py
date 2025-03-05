from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)  # CORS対応

# Rasaのエンドポイントを環境変数に応じて設定
RASA_ENV = os.getenv("RASA_ENV", "development")
RASA_URL = "http://rasa:5005/webhooks/rest/webhook" if RASA_ENV == "production" else "http://localhost:5005/webhooks/rest/webhook"

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/chat", methods=["POST"])
def chat():
    user_message = request.json.get("message")
    if not user_message:
        return jsonify({"error": "Message is required"}), 400

    response = requests.post(RASA_URL, json={"sender": "user", "message": user_message})
    return jsonify(response.json())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)

