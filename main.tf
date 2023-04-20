resource "aws_vpc" "devopsVpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devopsVpc"
  }
}

resource "aws_subnet" "devopsSubnet" {
  vpc_id     = aws_vpc.devopsVpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "devopsSubnet"
  }
}

resource "aws_security_group" "devopsSecurityGroup" {
  name_prefix = "devopsSecurityGroup"

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

  vpc_id = aws_vpc.devopsVpc.id
}

data "aws_iam_role" "lambdaRole" {
  name = "DevOps-Candidate-Lambda-Role"
}


data "archive_file" "lambdaZip" {
  type        = "zip"
  output_path = "${path.module}/devopsLambda.py.zip"
  source_file  = "${path.module}/devops_lambda.py"
}

resource "aws_lambda_function" "devopsLambda" {
  function_name    = "devopsLambda"
  role             = aws_iam_role.lambdaRole.arn
  handler          = "devopsLambda.handler"
  runtime          = "python3.8"
  filename         = "${path.module}/devopsLambda.py.zip"
  source_code_hash = data.archive_file.lambdaZip.output_base64sha256
  vpc_config {
    subnet_ids = [aws_subnet.devopsSubnet.id]
    security_group_ids = [aws_security_group.devopsSecurityGroup.id]
  }
}
