FROM python:3.10-slim
RUN apt-get update && apt-get install -y ffmpeg git
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 3000
CMD ["python", "app/main.py"]
