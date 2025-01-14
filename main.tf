resource "aws_s3_bucket" "message_app_bucket" {
  bucket = var.message_app_bucket
}

# resource "aws_s3_bucket_acl" "message_app_bucket_acl" {
#   bucket = aws_s3_bucket.message_app_bucket.id
# }

resource "aws_lambda_function" "upload_handler" {
  function_name    = "uploadHandler"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "handler.lambda_handler"
  source_code_hash = filebase64sha256("lambda/handler.py")
  filename         = "handler.zip" 

  depends_on = [aws_s3_bucket.message_app_bucket]
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy" {
  name       = "lambda_policy_attachment"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_api_gateway_rest_api" "message_app_api" {
  name        = "MessageAppAPI"
  description = "API for uploading messages and files"
}

resource "aws_api_gateway_resource" "upload" {
  rest_api_id = aws_api_gateway_rest_api.message_app_api.id
  parent_id   = aws_api_gateway_rest_api.message_app_api.root_resource_id
  path_part   = "upload"
}

resource "aws_api_gateway_method" "upload_method" {
  rest_api_id   = aws_api_gateway_rest_api.message_app_api.id
  resource_id   = aws_api_gateway_resource.upload.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "upload_integration" {
  rest_api_id             = aws_api_gateway_rest_api.message_app_api.id
  resource_id             = aws_api_gateway_resource.upload.id
  http_method             = aws_api_gateway_method.upload_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.upload_handler.invoke_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.message_app_api.id
  stage_name  = "prod"

  depends_on = [aws_api_gateway_integration.upload_integration]
}


