#!/bin/bash
export API_BASE="https://todo.dev.askrike.app"
cd /app/backend && uvicorn main:app --host 0.0.0.0 --port 8000 &
caddy run --config /etc/caddy/Caddyfile
