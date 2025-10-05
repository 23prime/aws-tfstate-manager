terraform {
  required_version = ">= 1.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-aws-tfstate-manager-678084882233"
    key          = "terraform.tfstate"
    region       = "ap-northeast-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
}

# S3 buckets for tfstate
resource "aws_s3_bucket" "terraform_state" {
  for_each = local.projects
  bucket   = each.value.bucket_name

  tags = merge(each.value.tags, {
    Name = "Terraform State - ${each.key}"
  })
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  for_each = local.projects
  bucket   = aws_s3_bucket.terraform_state[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  for_each = local.projects
  bucket   = aws_s3_bucket.terraform_state[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_pab" {
  for_each = local.projects
  bucket   = aws_s3_bucket.terraform_state[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
