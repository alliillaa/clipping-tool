FROM python:3.11-slim

# Install system dependencies (ffmpeg, git, and nodejs for yt-dlp challenge solving)
RUN apt-get update && apt-get install -y --no-install-commends \
    ffmpeg \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set up system-wide yt-dlp configuration for Node.js and EJS
RUN echo "js-runtimes node\nremote-components ejs:github" > /etc/yt-dlp.conf

WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . .

# Expose FastAPI default port
EXPOSE 8000

# Run Uvicorn web server bound to all interfaces
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
