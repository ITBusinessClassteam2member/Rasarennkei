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

# Supervisor のインストール
RUN apt-get update && apt-get install -y supervisor

# Supervisor 設定ファイルのコピー
COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# ポートを公開（必要に応じて変更）
EXPOSE 5005

# Supervisor を使ってプロセスを管理
CMD ["/usr/bin/supervisord"]
