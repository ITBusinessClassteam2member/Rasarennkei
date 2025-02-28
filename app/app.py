from flask import Flask, request, jsonify
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)

RASA_URL = "http://rasa:5005/webhooks/rest/webhook"  # RasaのURL

@app.route("/webhook", methods=["POST"])
def webhook():
    # Flask経由でRasaにデータを送信し、レスポンスを返す
    user_message = request.json.get("message")
    if user_message:
        response = requests.post(RASA_URL, json={"message": user_message})
        return jsonify(response.json())
    return jsonify({"error": "No message received"}), 400

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=5000, debug=True)


