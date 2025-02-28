# ベースイメージ
FROM python:3.9-slim

# 作業ディレクトリ設定
WORKDIR /app

# 依存関係のコピーとインストール
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# SpaCy 日本語モデルのインストール
RUN python -m spacy download ja_ginza

# Ginza のモデルをリンク（必要な場合）
RUN python -m ginza -m ja_ginza

# アプリのソースコードをコピー
COPY . .

# ポートを公開（必要に応じて変更）
EXPOSE 5005

# アプリの起動
CMD ["rasa", "run", "--enable-api", "--cors", "*"]
