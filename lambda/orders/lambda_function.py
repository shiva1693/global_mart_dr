import json
import os

def lambda_handler(event, context):
    print("Orders service invoked")

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps({
            "service": "orders",
            "region": os.environ.get("AWS_REGION"),
            "env": os.environ.get("APP_ENV")
        })
    }