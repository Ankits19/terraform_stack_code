#Common tags
variable "compliance_tags" {
  type        = map(string)
  description = "Tags required for all resources in the project"
}

variable "nginx_ami_id" {
  type        = string
  description = "AMI ID for nginx instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type nginx instance"
}

variable "environment" {
  type        = string
  description = "Environment to deploy resources"
}

variable "region" {
  type        = string
  description = "AWS Region"
}