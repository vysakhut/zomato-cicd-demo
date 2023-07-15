terraform {
  backend "s3" {
    bucket = "gitwork-mywork201.online"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
