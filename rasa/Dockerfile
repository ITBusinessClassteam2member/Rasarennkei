FROM rasa/rasa:3.0.0-full

WORKDIR /app

COPY rasa/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY rasa/ /app/

CMD ["rasa", "run", "--model", "models", "--enable-api", "--cors", "*", "--debug"]
