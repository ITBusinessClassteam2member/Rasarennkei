# ベースイメージ
FROM python:3.10

# 作業ディレクトリを設定
WORKDIR /app

# Rasa モデルとアプリのソースコードをコピー
COPY ./rasa /rasa
COPY ./app /app

# パッケージをインストール
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    python -m spacy download ja_ginza

# ポートを公開
EXPOSE 5000
EXPOSE 5005

# アプリと Rasa を同時に起動
CMD sh -c 'rasa run --model /rasa/models --enable-api --cors "*" --port 5005 & python app.py'
