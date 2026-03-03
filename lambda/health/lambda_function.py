import json
import os
import time

def lambda_handler(event, context):
    # if os.getenv("FORCE_FAIL") == "1":
    #     return {"statusCode": 500, "body": "fail"}

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