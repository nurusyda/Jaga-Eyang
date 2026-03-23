FROM python:3.12-slim

# 1. Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr tini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. Setup user and directory
RUN useradd --create-home --shell /bin/bash appuser
WORKDIR /app

# 3. Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy application code
COPY . .
RUN chown -R appuser:appuser /app
USER appuser

# 5. Use tini as init (PID 1)
ENTRYPOINT ["/usr/bin/tini", "--"]

# 6. Optimized Start Command
# Using ["sh", "-c", "exec ..."] allows tini to manage the shell, 
# while 'exec' makes uvicorn replace the shell process to receive 
# signals (SIGTERM/SIGINT) directly.
CMD ["sh", "-c", "exec uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]