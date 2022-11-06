
# VPC creation's
resource "aws_vpc" "main" {
    cidr_block = "${var.vpccidr}"

    tags = {
        name = "${var.vpcName}"
    }
}


# Subnet Creations

resource "aws_subnet" "public_subnets" {
 count      = length(var.CMS_public_subnets)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.CMS_public_subnets, count.index)
 availability_zone = element(var.az, count.index)
 
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}


# Subnet Creations 
resource "aws_subnet" "private_subnets" {
 count      = length(var.CMS_private_subnets)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.CMS_private_subnets, count.index)
 availability_zone = element(var.az, count.index)
 
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}


# Internetgatweway-creations
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id

    tags = {
        name = "internet-gatway"
    }
}

# public route table
resource "aws_route_table" "rt-public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
}


# route table is attaching to internet gateway
resource "aws_route_table_association" "attachment-rt-public" {
    count = length(var.CMS_public_subnets)
    subnet_id = "${element(aws_subnet.public_subnets[*].id, count.index)}"    
    route_table_id = aws_route_table.rt-public.id

}


#route private has to create.
