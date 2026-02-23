import json
import os
import time

def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps({
            "service": "health",
            "region": os.environ.get("AWS_REGION"),
            "timestamp": int(time.time()),
            "status": "ok"
        })
    }