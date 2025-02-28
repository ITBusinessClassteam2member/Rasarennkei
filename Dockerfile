# ベースイメージとして Python 3.10 を使用
FROM python:3.10-slim

# 作業ディレクトリを作成
WORKDIR /app

# 必要なファイルをコピー
COPY requirements.txt /app/
COPY app.py /app/
COPY templates /app/templates/
COPY rasa /app/rasa/
COPY entrypoint.sh /app/

# 必要なパッケージをインストール
RUN pip install --no-cache-dir -r requirements.txt

# entrypoint.sh に実行権限を付与
RUN chmod +x entrypoint.sh

# ポート5000番を開放
EXPOSE 5000

# コンテナ起動時に entrypoint.sh を実行
CMD ["./entrypoint.sh"]
