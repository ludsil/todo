FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir fastapi uvicorn sqlalchemy psycopg2-binary python-multipart
COPY backend/main.py ./
COPY frontend /frontend
EXPOSE 8000
# Spawned's Container->Database connection injects split vars (TODODB_HOST etc.);
# the app reads a single DATABASE_URL, so compose it at startup when present.
CMD ["sh", "-c", "if [ -n \"$TODODB_HOST\" ]; then export DATABASE_URL=\"postgresql://${TODODB_USER}:${TODODB_PASSWORD}@${TODODB_HOST}:${TODODB_PORT}/${TODODB_NAME}\"; fi; exec uvicorn main:app --host 0.0.0.0 --port 8000"]
