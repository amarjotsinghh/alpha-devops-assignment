## Architecture Overview

```mermaid
flowchart LR

Dev[Developer Push] --> GitHub
GitHub --> CI[GitHub Actions]

CI --> ECR[(Amazon ECR)]
ECR --> EKS[EKS Cluster]

User --> ALB[Application Load Balancer]

ALB --> Frontend[Frontend Service]
ALB --> Backend[Backend API]

Backend --> RDS[(PostgreSQL RDS)]

EKS --> CloudWatch[CloudWatch Logs]
```

## Live Application

Frontend

http://k8s-default-alphaing-e4acd881d2-1206483414.ap-southeast-1.elb.amazonaws.com

Backend Health Check

http://k8s-default-alphaing-e4acd881d2-1206483414.ap-southeast-1.elb.amazonaws.com/api/health


## Infrastructure

The infrastructure is deployed using Terraform on AWS.

Components:

- VPC with public and private subnets
- EKS Kubernetes cluster
- RDS PostgreSQL database
- ECR container registry
- Application Load Balancer via Kubernetes Ingress
- CloudWatch logging and monitoring
- CI/CD pipeline using GitHub Actions