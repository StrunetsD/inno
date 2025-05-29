FROM python:3.7-buster

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt 

COPY . .

CMD ["python", "server.py"]
