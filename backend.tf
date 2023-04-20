terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    key    = "emiliano.poggi"
    region = "ap-south-1"
  }
}
