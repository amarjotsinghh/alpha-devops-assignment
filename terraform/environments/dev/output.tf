output "backend_irsa_role_arn" {
  description = "IAM role ARN used by backend service account (IRSA)"
  value       = module.iam.backend_irsa_role_arn
}