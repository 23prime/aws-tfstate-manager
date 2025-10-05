variable "aws_account_id" {
  description = "AWS account ID to use for state management"
  type        = string
}

variable "aws_region" {
  description = "AWS region to use for state management"
  type        = string
  default     = "ap-northeast-1"
}
