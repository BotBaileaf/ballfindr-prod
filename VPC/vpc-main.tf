resource "aws_vpc" "vpc-tf" {
  cidr_block                       = var.cidr-block
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true
  tags                             = { Name = "${var.tf-name}" }
}
resource "aws_internet_gateway" "igw-tf" {
  vpc_id = aws_vpc.vpc-tf.id
  tags   = { NAME = "igw-${var.tf-name}" }
}
resource "aws_route_table" "vpc-tf-public-RT" {
  vpc_id = aws_vpc.vpc-tf.id
  tags   = { NAME = "{var.tf-name}-public-RT" }
}
# resource "aws_route_table" "vpc-tf-private-RT" {
#   vpc_id = aws_vpc.vpc-tf.id
#   tags   = { NAME = "{var.tf-name}-private-RT" }
# }
resource "aws_route" "internet-route" {
  route_table_id         = aws_route_table.vpc-tf-public-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw-tf.id
}
resource "aws_route" "ipv6_internet-route" {
  route_table_id              = aws_route_table.vpc-tf-public-RT.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw-tf.id
}
resource "aws_subnet" "public-SN" {
  vpc_id            = aws_vpc.vpc-tf.id
  availability_zone = var.azs[0]
  cidr_block        = var.public-cidr
  map_public_ip_on_launch = true
  tags              = { Name = "public-tf-SN" }
}

resource "aws_subnet" "public-SN-2" {
  vpc_id            = aws_vpc.vpc-tf.id
  availability_zone = var.azs[1]
  cidr_block        = var.public-cidr-2
  map_public_ip_on_launch = true
  tags              = { Name = "public-tf-SN-2" }
}

# resource "aws_subnet" "private-SN" {
#   vpc_id            = aws_vpc.vpc-tf.id
#   availability_zone = var.azs[1]
#   cidr_block        = var.private-cidr
#   tags              = { Name = "private-tf-SN" }
# }
resource "aws_route_table_association" "public-SN-RT" {
  route_table_id = aws_route_table.vpc-tf-public-RT.id
  subnet_id      = aws_subnet.public-SN.id

}

resource "aws_route_table_association" "public-SN-RT-2" {
  route_table_id = aws_route_table.vpc-tf-public-RT.id
  subnet_id      = aws_subnet.public-SN-2.id

}

# resource "aws_route_table_association" "private-SN-RT" {
#   route_table_id = aws_route_table.vpc-tf-private-RT.id
#   subnet_id      = aws_subnet.private-SN.id

# }