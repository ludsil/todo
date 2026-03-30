FROM python:3.13-slim

RUN apt-get update && \
    apt-get install -y curl libpq-dev && \
    curl -o /usr/bin/caddy -L "https://caddyserver.com/api/download?os=linux&arch=amd64" && \
    chmod +x /usr/bin/caddy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install uv

COPY backend/pyproject.toml backend/uv.lock ./backend/
RUN cd backend && uv pip install --system --no-cache -r pyproject.toml

COPY backend/main.py ./backend/
COPY frontend/index.html ./frontend/
COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 8080

CMD ["./start.sh"]
