resource "aws_vpc" "web-app-vpc" {
  cidr_block        = "10.0.0.0/16"
  tags              = {
    Name            = "Web-app"
  }
}

resource "aws_subnet" "web-sub-1" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "web-app-sub"
  }
}

resource "aws_subnet" "web-sub-2" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "web-app-sub"
  }
}

resource "aws_subnet" "app-sub-1" {
  cidr_block        = "10.0.11.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags              = {
    Name            = "app-sub"
  }
}

resource "aws_subnet" "app-sub-2" {
  cidr_block        = "10.0.12.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags              = {
    Name            = "app-sub"
  }
}

resource "aws_subnet" "db-sub-1" {
  cidr_block        = "10.0.21.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  tags              = {
    Name            = "db-sub"
  }
}

resource "aws_subnet" "db-sub-2" {
  cidr_block        = "10.0.22.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  tags              = {
    Name            = "db-sub"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id            = aws_vpc.web-app-vpc.id
  tags              = {
    Name            = "IGW"
  }
}

resource "aws_route_table" "web-rt" {
  vpc_id             = aws_vpc.web-app-vpc.id
  route {
    cidr_block       = "0.0.0.0/0"
    gateway_id       = aws_internet_gateway.igw.id
  }
  tags               = {
    Name             = "webrt"
  }
}

resource "aws_route_table_association" "web-a" {
  route_table_id    = aws_route_table.web-rt.id
  subnet_id         = aws_subnet.web-sub-1.id
}

resource "aws_route_table_association" "web-b" {
  route_table_id    = aws_route_table.web-rt.id
  subnet_id         = aws_subnet.web-sub-2.id
}