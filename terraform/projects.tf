locals {
  projects = {
    aws-tfstate-manager = {
      bucket_name = "tfstate-aws-tfstate-manager-${var.aws_account_id}"
      tags = {
        Environment = "production"
        Project     = "aws-tfstate-manager"
      }
    }

    "23prime-xyz" = {
      bucket_name = "tfstate-23prime-xyz-${var.aws_account_id}"
      tags = {
        Environment = "production"
        Project     = "23prime-xyz"
      }
    }
  }
}
