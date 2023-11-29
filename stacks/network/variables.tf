#Common tags
variable "compliance_tags" {
  type        = map(string)
  description = "Tags required for all resources in the project"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR block for public subnet"
}

variable "public_subnet_azs" {
  type        = list(string)
  description = "AZ to create public subnet"
}
