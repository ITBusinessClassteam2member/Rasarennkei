# ベースイメージ
FROM python:3.10

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコピー
COPY ./app /app
COPY ./rasa /rasa
COPY requirements.txt /app/requirements.txt

# パッケージをインストール
RUN pip install --upgrade pip && \
    pip install -r /app/requirements.txt && \
    python -m spacy download ja_core_news_sm

# ポートを公開
EXPOSE 5000 5005

# アプリとRasaを起動
CMD ["sh", "-c", "rasa run --model /rasa/models --enable-api --cors '*' --port 5005 & python /app/app.py"]
