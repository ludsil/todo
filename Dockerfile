FROM python:3.13-slim

RUN apt-get update && apt-get install -y libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install uv

COPY backend/pyproject.toml backend/uv.lock ./backend/
RUN cd backend && uv pip install --system --no-cache -r pyproject.toml

COPY backend/main.py ./backend/
COPY frontend/index.html ./frontend/

EXPOSE 8000

CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
