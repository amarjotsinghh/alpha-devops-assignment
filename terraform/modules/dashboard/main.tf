resource "aws_cloudwatch_dashboard" "eks_dashboard" {
  dashboard_name = "alpha-devops-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x    = 0
        y    = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_name ]
          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "ALB Request Count"
        }
      },

      {
        type = "metric"
        x    = 12
        y    = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [ "AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", var.alb_name ]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "ALB Response Time"
        }
      },

      {
        type = "metric"
        x    = 0
        y    = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.nodegroup_name ]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "EKS Node CPU Utilization"
        }
      },

      {
        type = "metric"
        x    = 12
        y    = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            [ "AWS/EC2", "NetworkIn", "AutoScalingGroupName", var.nodegroup_name ]
          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "EKS Node Network In"
        }
      }
    ]
  })
}