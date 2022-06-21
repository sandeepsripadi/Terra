provider "aws" {
 
  region     = "ap-south-1"

}

resource "aws_instance" "websrvr" {
  ami             = "ami-0f2e255ec956ade7f"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.new_public.id
  security_groups = [aws_security_group.public_security_group.id]
  key_name = "mynewkey"
  tags = {
    Name = "New webserver"
  }
  user_data = <<-EOF
                #! /bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable apache2
                echo "Welcome to your New web sever sandeep" | sudo tee /var/www/html/index.html
                EOF
}

output "PublicIp" {
  value=aws_instance.websrvr.public_ip
}
output "PublicDNS" {
  value=aws_instance.websrvr.public_dns
}
