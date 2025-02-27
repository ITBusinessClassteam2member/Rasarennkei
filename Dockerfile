# ベースイメージ
FROM python:3.10

# 作業ディレクトリ
WORKDIR /app

# パッケージをインストール
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# ソースコードをコピー
COPY ./app /app
COPY ./rasa /rasa

# Spacy 日本語モデルのインストール
RUN python -m spacy download ja_ginza

# ポートを公開
EXPOSE 5000 5005

# 起動スクリプト
CMD ["sh", "-c", "rasa run --model /rasa/models --enable-api --cors '*' --port 5005 & python app.py"]
