"""Minimal scheduled lambda for spawned QA (P4)."""
import json
import os
from datetime import datetime, timezone


def handler(event, context):
    msg = {
        "ts": datetime.now(timezone.utc).isoformat(),
        "source": event.get("source", "direct"),
        "db_host": os.getenv("TODODB_HOST", os.getenv("DB_HOST", "unset")),
    }
    print(json.dumps(msg))
    return {"statusCode": 200, "body": json.dumps(msg)}
