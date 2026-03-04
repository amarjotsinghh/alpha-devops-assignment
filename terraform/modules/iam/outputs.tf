output "policy_arn" {
  value = aws_iam_policy.secret_access.arn
}

output "irsa_role_arn" {
  value = aws_iam_role.backend_irsa.arn
}