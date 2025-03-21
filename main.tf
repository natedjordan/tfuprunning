provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami = "ami-00ae2c3d8c3a99b55"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}
