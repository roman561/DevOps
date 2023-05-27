resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name     = "${var.environment}-${var.region}"
    location = var.region
    purpose  = var.environment
  }
  enable_dns_support   = true
  enable_dns_hostnames = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table_association" "subnet-public" {
  route_table_id = aws_vpc.vpc.main_route_table_id
  subnet_id      = aws_subnet.subnet-public.id
}

resource "aws_route_table_association" "private-rt-ass-a" {
  subnet_id      = aws_subnet.subnet-private.id
  route_table_id = aws_route_table.private-nat-gt.id
}

resource "aws_subnet" "subnet-public" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "${var.region}a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 2, 0)
  map_public_ip_on_launch = true
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "subnet-private" {
  vpc_id                          = aws_vpc.vpc.id
  availability_zone               = "${var.region}a"
  cidr_block                      = cidrsubnet(aws_vpc.vpc.cidr_block, 2, 3)
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false
  lifecycle {
    ignore_changes = [tags]
  }
}


resource "aws_eip" "eip-nat-gt" {
  vpc = true
  tags = {
    Name = "NAT-EIP"
  }
}

resource "aws_nat_gateway" "private-ng" {
  allocation_id = aws_eip.eip-nat-gt.id
  subnet_id     = aws_subnet.subnet-public.id
  tags = {
    Name = "NAT-Gateway"
  }
}

resource "aws_route_table" "private-nat-gt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private-ng.id
  }
  tags = {
    Name = "RT-Private"
  }
}