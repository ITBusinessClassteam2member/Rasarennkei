# ベースイメージ
FROM python:3.10

# 作業ディレクトリを設定
WORKDIR /app

# ソースコードをコピー
COPY ./app /app

# パッケージをインストール
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# ポートを公開
EXPOSE 5000 5005

# Rasa モデルのコピー
COPY ./models /app/models
COPY ./config /app/config
COPY ./data /app/data
COPY ./actions /app/actions

# Rasa アクションサーバーのセットアップ
RUN rasa train
RUN rasa --version

# アプリを起動
CMD ["sh", "-c", "rasa run --enable-api --cors '*' --model models --port 5005 & python app.py"]
