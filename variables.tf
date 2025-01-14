# variable "message_app_bucket" {
#   description = "The name of the S3 bucket to store uploaded files"
#   type        = string
# }

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "messageAppLambda"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "messageAppApi"
}

variable "message_app_bucket" {
  description = "The name of the S3 bucket to store uploaded files"
  type        = string
  default     = "message-app-s3"
}