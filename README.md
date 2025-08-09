# Infrastructure as Code & CI/CD Demo

This repository demonstrates a complete IaC and CI/CD pipeline using:
- **Terraform** for AWS EC2 provisioning
- **GitHub Actions** for automated deployment
- **Docker** for containerized web application
- **CloudWatch** for monitoring and alerting

## Architecture

1. Push to `main` → Provision EC2 with Terraform
2. Push to `main` → Build Docker image and deploy to EC2
3. EC2 shutdown → CloudWatch alarm → SNS notification

## Setup

1. **AWS Credentials**: Add to GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION` (default: us-east-1)

2. **SSH Key**: Generate and add to GitHub Secrets:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/demo-key
   ```
   - `EC2_SSH_PRIVATE_KEY` (private key content)

3. **Incident Management**: Configure SNS topic ARN in `terraform/variables.tf`

## Workflows

- **Infrastructure**: `.github/workflows/infrastructure.yml`
- **Deployment**: `.github/workflows/deploy.yml`

## Local Testing

```bash
# Test the application
cd app
docker build -t demo-app .
docker run -p 3000:3000 demo-app
```