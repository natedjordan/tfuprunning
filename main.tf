provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami = "ami-01938df366ac2d954"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    # from_port = var.server_port
    # to_port = var.server_port
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# variable "server_port" {
#   description = "The port the server will use for HTTP requests"
#   type = number
#   # default = 42
# }

output "public_ip" {
  value = aws_instance.example.public_ip
  description = "The public ip address of the web server"
}
