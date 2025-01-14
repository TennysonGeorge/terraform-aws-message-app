import json
import boto3
import os
from datetime import datetime

s3_client = boto3.client('s3')
bucket_name = os.environ['S3_BUCKET']

def lambda_handler(event, context):
    try:
        # Get the file from the event
        file_content = event['body']
        file_name = event['headers']['file-name']
        
        # Create a timestamp
        timestamp = datetime.utcnow().isoformat()
        
        # Create the full file name with timestamp
        full_file_name = f"{timestamp}_{file_name}"
        
        # Upload the file to S3
        s3_client.put_object(Bucket=bucket_name, Key=full_file_name, Body=file_content)
        
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'File uploaded successfully', 'file_name': full_file_name})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }