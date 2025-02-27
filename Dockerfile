# ベースイメージ
FROM python:3.10

# 作業ディレクトリを設定
WORKDIR /app

# Flask アプリのソースコードをコピー
COPY ./app /app

# パッケージをインストール
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# ポートを公開
EXPOSE 5000

# アプリを起動
CMD ["python", "app.py"]
