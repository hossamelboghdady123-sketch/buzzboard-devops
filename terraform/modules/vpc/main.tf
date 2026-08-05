resource "aws_vpc" "this" {

  cidr_block = var.vpc_cidr

  enable_dns_support = true

  enable_dns_hostnames = true

  tags = {
    Name = "${local.name}-vpc"
  }

}
resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${local.name}-igw"
  }

}

resource "aws_subnet" "public" {

  count = length(var.public_subnets)

  vpc_id = aws_vpc.this.id

  cidr_block = var.public_subnets[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name}-public-${count.index + 1}"
  }

}
resource "aws_subnet" "private" {

  count = length(var.private_subnets)

  vpc_id = aws_vpc.this.id

  cidr_block = var.private_subnets[count.index]

  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${local.name}-private-${count.index + 1}"
  }

}
####################################
# Elastic IP
####################################

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = {
    Name = "${local.name}-nat-eip"
  }

  depends_on = [
    aws_internet_gateway.this
  ]
}
####################################
# NAT Gateway
####################################

resource "aws_nat_gateway" "this" {

  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${local.name}-nat"
  }

  depends_on = [
    aws_internet_gateway.this
  ]
}
####################################
# Public Route Table
####################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.this.id

  }

  tags = {

    Name = "${local.name}-public-rt"

  }

}
####################################
# Private Route Table
####################################

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.this.id

  }

  tags = {

    Name = "${local.name}-private-rt"

  }

}
####################################
# Public Route Association
####################################

resource "aws_route_table_association" "public" {

  count = length(var.public_subnets)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id

}
####################################
# Private Route Association
####################################

resource "aws_route_table_association" "private" {

  count = length(var.private_subnets)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private.id

}

