resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = merge({
      Name = "MyTerraformVPC"
    },var.compliance_tags
  )
}
