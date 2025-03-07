# ベースイメージ
FROM rasa/rasa:3.6.7

# 作業ディレクトリ
WORKDIR /app

# Rasa関連ファイルをコピー
COPY . /app

# 日本語対応のja-ginzaをインストール
RUN pip install --no-cache-dir ginza ja-ginza

# ポートの公開
EXPOSE 5005

# Rasaサーバーを起動
CMD ["run", "--enable-api", "--cors", "*", "--debug"]
