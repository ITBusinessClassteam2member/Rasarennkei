#!/bin/bash

# Rasaをバックグラウンドで実行
python3 -m app.rasa_server &
# Flaskアプリを実行
gunicorn --bind 0.0.0.0:5000 app.run:app
