resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/eks/alpha-devops"
  retention_in_days = 7

  tags = {
    Project = "alpha-devops"
  }
}