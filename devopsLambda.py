import json
import requests

def handler(event, context):
    url = 'https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data'
    headers = {'X-Siemens-Auth': 'test'}
    payload = {
        "subnet_id": "xxx",
        "name": "Emiliano Poggi",
        "email": "emiliano.poggi@siemens.com"
    }

    response = requests.post(url, headers=headers, json=payload)

    return {
        'statusCode': response.status_code,
        'body': response.text
    }
