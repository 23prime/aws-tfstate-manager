output "projects" {
  description = "List of projects for state management"
  value = {
    for project_name, config in local.projects : project_name => {
      s3_bucket_name = aws_s3_bucket.terraform_state[project_name].bucket
      aws_region     = var.aws_region
    }
  }
}

output "s3_bucket_names" {
  description = "List of S3 buckets for state management"
  value = {
    for project_name, config in local.projects :
    project_name => aws_s3_bucket.terraform_state[project_name].bucket
  }
}


# Backend configuration examples
output "backend_configs" {
  description = "Terraform backend configuration examples for each project"
  value = {
    for project_name, config in local.projects : project_name => {
      bucket       = aws_s3_bucket.terraform_state[project_name].bucket
      key          = "terraform.tfstate"
      region       = var.aws_region
      encrypt      = true
      use_lockfile = true
    }
  }
}
