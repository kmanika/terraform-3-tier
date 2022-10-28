resource "aws_instance" "webserver-1" {
  ami               = "ami-09d3b3274b6c5d4aa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id         = aws_subnet.web-sub-1.id
  user_data         = file("install_apache.sh")
  tags              = {
    Name            = "Web-server"
  }
}

resource "aws_instance" "webserver-2" {
  ami               = "ami-09d3b3274b6c5d4aa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id         = aws_subnet.web-sub-2.id
  user_data         = file("install_apache.sh")
  tags              = {
    Name            = "Web-server"
  }
}

