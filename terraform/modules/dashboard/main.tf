resource "aws_cloudwatch_dashboard" "eks_dashboard" {

  dashboard_name = "alpha-devops-dashboard"

  dashboard_body = jsonencode({

    widgets = [

      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              "app/k8s-default-alphaing-e4acd881d2/17f299fc1ee6e6f8"
            ]
          ]

          period = 300
          stat   = "Sum"
          region = "ap-southeast-1"
          title  = "ALB Request Count"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              "app/k8s-default-alphaing-e4acd881d2/17f299fc1ee6e6f8"
            ]
          ]

          period = 300
          stat   = "Average"
          region = "ap-southeast-1"
          title  = "ALB Response Time"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "i-0124c0a5b9fa995f6"
            ],
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "i-044c6daf4f5ef7456"
            ]
          ]

          period = 300
          stat   = "Average"
          region = "ap-southeast-1"
          title  = "EKS Node CPU Utilization"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "InstanceId",
              "i-0124c0a5b9fa995f6"
            ],
            [
              "AWS/EC2",
              "NetworkIn",
              "InstanceId",
              "i-044c6daf4f5ef7456"
            ]
          ]

          period = 300
          stat   = "Sum"
          region = "ap-southeast-1"
          title  = "EKS Node Network In"
        }
      },

      {
  type   = "metric"
  x      = 0
  y      = 12
  width  = 24
  height = 6

  properties = {
    metrics = [

      [
        "AWS/RDS",
        "CPUUtilization",
        "DBInstanceIdentifier",
        "alpha-devops-dev-postgres"
      ],

      [
        "AWS/RDS",
        "DatabaseConnections",
        "DBInstanceIdentifier",
        "alpha-devops-dev-postgres"
      ],

      [
        "AWS/RDS",
        "FreeStorageSpace",
        "DBInstanceIdentifier",
        "alpha-devops-dev-postgres"
      ]

    ]

    period = 300
    stat   = "Average"
    region = "ap-southeast-1"
    title  = "RDS Database Metrics"
  }
}

    ]
  })
}