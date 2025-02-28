FROM rasa/rasa:3.0.0-full

WORKDIR /app

COPY rasa/ /app/

RUN pip install ja-ginza

CMD ["rasa", "run", "--model", "models", "--enable-api", "--cors", "*", "--debug"]
