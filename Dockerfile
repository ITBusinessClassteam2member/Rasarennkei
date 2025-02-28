# ベースイメージ
FROM python:3.9-slim

# 作業ディレクトリを設定
WORKDIR /app

# 必要な依存関係をコピー
COPY requirements.txt .

# 必要なパッケージをインストール
RUN pip install --no-cache-dir -r requirements.txt

# Rasa サーバーとFlaskを実行するスクリプトをコピー
COPY . /app

# ポート設定
EXPOSE 5000

# コンテナ起動時に実行されるコマンド
CMD ["sh", "run.sh"]
