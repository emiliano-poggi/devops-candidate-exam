resource "aws_vpc" "devopsexam_vpc" {
  cidr_block = "10.0.0.0/12"

  tags = {
    Name = "devopsexam-vpc"
  }
}

resource "aws_subnet" "devopsexam_subnet" {
  vpc_id     = aws_vpc.devopsexam_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "devopsexam-subnet"
  }
}

resource "aws_security_group" "devopsexam_security_group" {
  name_prefix = "devopsexam-security-group"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.devopsexam.id
}
