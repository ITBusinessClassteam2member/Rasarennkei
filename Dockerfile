# 1. Pythonベースのイメージを使用
FROM python:3.9

# 2. 作業ディレクトリの作成
WORKDIR /app

# 3. 必要なパッケージをインストール
COPY flask_app/requirements.txt rasa_app/requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 4. 必要なファイルをコピー
COPY flask_app/ ./flask_app/
COPY rasa_app/ ./rasa_app/

# 5. Rasa のモデルをトレーニング
# RUN rasa train --domain rasa_app/domain.yml --data rasa_app/data --out rasa_app/models

# 6. `supervisord` の設定を追加
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 7. `supervisord` を使用して Rasa と Flask を並行実行
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
