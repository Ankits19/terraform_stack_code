# Create a public subnet
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_azs)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.public_subnet_azs[count.index]
  map_public_ip_on_launch = true
  tags = merge({
    Name = "MyTerraformSubnet"
    }, var.compliance_tags
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = merge({
    Name = "MyTerraformIGW"
    }, var.compliance_tags
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = merge({
    Name = "MyTerraformRT"
    }, var.compliance_tags
  )
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_rt_association" {
  count          = length(var.public_subnet_azs)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}