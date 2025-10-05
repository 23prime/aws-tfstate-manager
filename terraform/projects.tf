locals {
  projects = {
    terraform-bootstrap-aws = {
      bucket_name = "tfstate-terraform-bootstrap-aws-${var.aws_account_id}"
      tags = {
        Environment = "production"
        Project     = "terraform-bootstrap-aws"
      }
    }
  }
}
