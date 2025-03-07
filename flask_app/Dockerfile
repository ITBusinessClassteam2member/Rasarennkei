# ベースイメージ
FROM python:3.9

# 作業ディレクトリ
WORKDIR /app

# 依存関係をコピー
COPY requirements.txt .

# 依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# アプリのコードをコピー
COPY . .

# ポートの公開
EXPOSE 5000

# アプリの実行
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
