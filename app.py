from flask import Flask, request, jsonify
import requests
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # CORSを有効化（WordPressと通信するため）

RASA_URL = "http://localhost:5005/webhooks/rest/webhook"  # Rasaのエンドポイント

@app.route("/chat", methods=["POST"])
def chat():
    data = request.get_json()
    user_message = data.get("message")

    # Rasaにメッセージを送信
    response = requests.post(RASA_URL, json={"sender": "user", "message": user_message})
    
    if response.status_code == 200:
        messages = response.json()
        bot_response = messages[0].get("text", "エラー: 応答がありません") if messages else "エラー: 応答がありません"
    else:
        bot_response = "エラー: Rasaと接続できません"

    return jsonify({"response": bot_response})

if __name__ == "__main__":
    app.run(port=5000, debug=True)