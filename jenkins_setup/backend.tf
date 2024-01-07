terraform {
  backend "s3" {
    bucket = "pranaytech-eks-bucket"
    key    = "var.key-name"
    region = "us-east-1"
  }
}