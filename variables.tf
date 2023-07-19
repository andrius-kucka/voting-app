variable "aws_region" {
  type = string
  default = "eu-central-1"
  description = "The AWS region to be used for tan be changed to any other. Default is used eu-north-1"
}

variable "default_vpc_subnets" {
  type = list(string)
  description = "Two subnets that needs to be provided from AWS account"

  validation {
    condition     = length(var.default_vpc_subnets) == 2
    error_message = "Value default_vpc_subnetshas to be exactly TWO subnets in this configuration."
  }
}