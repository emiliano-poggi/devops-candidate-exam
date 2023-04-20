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

resource "aws_lambda_function" "devopsexam_lambda" {
  function_name    = "devopsexam_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "devopsexam_lambda.handler"
  runtime          = "python3.8"
  filename         = "devopsexam_lambda.zip"
  source_code_hash = filebase64sha256("devopsexam_lambda.zip")
  vpc_config {
    subnet_ids = [aws_subnet.devopsexam_subnet.id]
    security_group_ids = [aws_security_group.devopsexam_security_group.id]
  }
}
