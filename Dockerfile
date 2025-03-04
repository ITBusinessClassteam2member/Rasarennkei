# ベースイメージ
FROM python:3.9

# 作業ディレクトリ
WORKDIR /app

# Flaskのセットアップ
COPY flask /app/Flask
WORKDIR /app/Flask
RUN pip install --no-cache-dir -r requirements.txt

# Rasaのセットアップ
COPY rasa /app/Rasa
WORKDIR /app/Rasa
RUN pip install --no-cache-dir -r requirements.txt

# Docker起動時のコマンド
CMD ["sh", "-c", "cd /app/Rasa && rasa run --enable-api --cors \"*\" & cd /app/Flask && gunicorn --bind 0.0.0.0:8000 app:app"]
