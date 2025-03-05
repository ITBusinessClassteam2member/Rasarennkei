# from flask import Flask, request, jsonify, render_template
# from flask_cors import CORS
# import requests
# import os

# app = Flask(__name__)
# CORS(app)  # CORS対応

# # Rasaのエンドポイントを環境変数に応じて設定
# RASA_ENV = os.getenv("RASA_ENV", "development")
# RASA_URL = "http://rasa:6000/webhooks/rest/webhook" if RASA_ENV == "production" else "http://localhost:6000/webhooks/rest/webhook"

# @app.route("/")
# def home():
#     return render_template("index.html")

# @app.route("/chat", methods=["POST"])
# def chat():
#     user_message = request.json.get("message")
#     if not user_message:
#         return jsonify({"error": "Message is required"}), 400

#     response = requests.post(RASA_URL, json={"sender": "user", "message": user_message})
#     return jsonify(response.json())

# if __name__ == "__main__":
#     app.run(host='0.0.0.0', port=int(os.environ.get("PORT", 8000)))
#-------------------------------------------------------------------------
from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import requests
import os
import subprocess

app = Flask(__name__)
CORS(app)  # CORS対応

# 環境変数に応じてRasaのエンドポイントを設定
RASA_ENV = os.getenv("RASA_ENV", "development")
RASA_HOST = os.getenv("RASA_HOST", "0.0.0.0")
RASA_PORT = os.getenv("RASA_PORT", "6000")
RASA_URL = f"http://{RASA_HOST}:{RASA_PORT}/webhooks/rest/webhook"

# # Rasaをバックグラウンドで起動する関数
# def start_rasa():
#     command = f"rasa run --enable-api --cors '*' --port {RASA_PORT} --host {RASA_HOST}"
#     subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# # production環境ではRasaを起動
# if RASA_ENV == "production":
#     start_rasa()

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/chat", methods=["POST"])
def chat():
    user_message = request.json.get("message")
    if not user_message:
        return jsonify({"error": "Message is required"}), 400

    try:
        response = requests.post(RASA_URL, json={"sender": "user", "message": user_message}, timeout=5)
        response.raise_for_status()
        return jsonify(response.json())
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e), "message": "Rasaサービスに接続できません"}), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ.get("PORT", 8000)))

