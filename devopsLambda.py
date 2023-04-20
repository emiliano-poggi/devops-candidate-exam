import json
import urllib.request

def lambda_handler(event, context):
    url = 'https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data'
    data = {
        "subnet_id": "xxx",
        "name": "Emiliano Poggi",
        "email": "emiliano.poggi@siemens.com"
    }
    headers = {'X-Siemens-Auth': 'test'}
    
    req = urllib.request.Request(url, json.dumps(data).encode(), headers)
    response = urllib.request.urlopen(req)
    
    print(response.read())
    
    return {
        'statusCode': response.status,
        'body': response.read().decode('utf-8')
    }
