# ベースイメージ
FROM python:3.9

# 作業ディレクトリ
WORKDIR /app

# Flaskのセットアップ
COPY flask /app/flask
WORKDIR /app/flask
RUN pip install --no-cache-dir -r requirements.txt

# Rasaのセットアップ
COPY rasa /app/rasa
WORKDIR /app/rasa
RUN pip install --no-cache-dir -r requirements.txt

# Docker起動時のコマンド
CMD ["sh", "-c", "cd /app/rasa && rasa run --enable-api --cors \"*\" & cd /app/flask && gunicorn --bind 0.0.0.0:8000 app:app"]
