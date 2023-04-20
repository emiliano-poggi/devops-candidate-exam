terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
