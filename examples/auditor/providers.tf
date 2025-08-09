variable "region" {
  type        = string
  description = "AWS region to use."
  default     = "us-east-1"
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

variable "profile" {
  type        = string
  description = "CLI profile with credentials."
  default     = null
}
