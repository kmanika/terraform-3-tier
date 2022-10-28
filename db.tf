resource "aws_db_subnet_group" "db-subnet" {
  name          = "mysqldb-subnet"
  subnet_ids    = [aws_subnet.db-sub-1.id,aws_subnet.db-sub-2.id]

  tags          = {
    Name        = "mysql DB"
  }
}

resource "aws_db_instance" "mysql-db" {
  instance_class = "db.t2.micro"
  allocated_storage = 10
  db_subnet_group_name = aws_db_subnet_group.db-subnet.id
  engine          = "mysql"
  engine_version  = "8.0.28"
  multi_az        = true
  name            = "mysqldb"
  username        = "admin"
  password        = "admin123"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.db-sg.id]
}