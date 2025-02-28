#!/bin/bash

# Rasa サーバーをバックグラウンドで起動
rasa run --enable-api --cors "*" &

# Flask アプリケーションを起動
gunicorn -b 0.0.0.0:5000 app:app
