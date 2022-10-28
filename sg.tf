resource "aws_security_group" "web-sg" {
  name            = "Web-SG"
  description     = "Allow HTTP inbound traffic"
  vpc_id          = aws_vpc.web-app-vpc.id

  ingress {
    from_port     = 80
    protocol      = "tcp"
    to_port       = 80
    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    protocol      = "-1"
    to_port       = 0
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags            = {
    Name          = "Web-SG"
  }
}

resource "aws_security_group" "webserver-sg" {
  name             = "webserver-SG"
  vpc_id           = aws_vpc.web-app-vpc.id

  ingress {
    from_port      = 80
    protocol       = "tcp"
    to_port        = 80
    security_groups = [aws_security_group.web-sg.id]
  }
  egress {
    from_port      = 0
    protocol       = "-1"
    to_port        = 0
    cidr_blocks    = ["0.0.0.0/0"]
  }
  tags = {
    Name            = "webserver-SG"
  }
}

resource "aws_security_group" "db-sg" {
  name          = "DB-SG"
  vpc_id        = aws_vpc.web-app-vpc.id

  ingress {
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    security_groups = [aws_security_group.webserver-sg.id]
  }

  egress {
    from_port   = 32768
    protocol    = "tcp"
    to_port     = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name      = "DB-SG"
  }
}