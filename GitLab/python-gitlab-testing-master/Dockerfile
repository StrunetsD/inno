FROM python:slim 

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python3", "-m", "unittest", "tests/test_app.py"]