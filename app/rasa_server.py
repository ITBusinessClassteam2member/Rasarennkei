import subprocess

def start_rasa():
    subprocess.run(["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"])
