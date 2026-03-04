data "aws_eks_cluster" "cluster" {
  name = "alpha-devops-dev-eks"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "alpha-devops-dev-eks"
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "9e99a48a9960b14926bb7f3b02e22da0ecd3e11b"
  ]
}

resource "aws_iam_policy" "secret_access" {
  name = "${var.project_name}-${var.environment}-secret-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = var.secret_arn
      }
    ]
  })
}


resource "aws_iam_role" "backend_irsa" {
  name = "${var.project_name}-${var.environment}-backend-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:default:backend-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backend_secret_access" {
  role       = aws_iam_role.backend_irsa.name
  policy_arn = aws_iam_policy.secret_access.arn
}