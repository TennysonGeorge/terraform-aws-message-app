# terraform-aws-message-app

This project is a simple messaging application that allows users to upload photos or files. The application utilizes AWS services to process and store the uploaded content.

## Project Structure

```
terraform-aws-message-app
├── lambda
│   ├── handler.py        # AWS Lambda function code
├── main.tf               # Terraform configuration file
├── variables.tf          # Input variables for Terraform
├── outputs.tf            # Outputs of the Terraform configuration
└── README.md             # Project documentation
```

## Setup Instructions

1. **Prerequisites**
   - Ensure you have Terraform installed on your machine.
   - Configure your AWS credentials using the AWS CLI.

2. **Clone the Repository**
   ```bash
   git clone https://github.com/your-repo/terraform-aws-message-app.git
   cd terraform-aws-message-app
   ```

3. **Configure Variables**
   - Update the `variables.tf` file with your desired S3 bucket name and AWS region.

4. **Initialize Terraform**
   ```bash
   terraform init
   ```

5. **Plan the Deployment**
   ```bash
   terraform plan
   ```

6. **Apply the Configuration**
   ```bash
   terraform apply
   ```

7. **Usage**
   - Once deployed, you can use the API Gateway endpoint to upload files. The Lambda function will process the uploads and store them in the specified S3 bucket.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.


