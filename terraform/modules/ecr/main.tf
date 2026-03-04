resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-frontend"
  }
}

resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-${var.environment}-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-backend"
  }
}