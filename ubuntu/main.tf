resource "aws_instance" "ubuntu" {
  ami           = "ami-007855ac798b5175e" # Ubuntu 18.04 LTS
  instance_type = "t2.micro"
  key_name      = "ajith-keys"
  vpc_security_group_ids = [aws_security_group.jboss-ubuntu.id]
  user_data =  =  "${file("jboss_install.sh")}"
  tags = {
    Name = "my-ubuntu-server"
  }
  provisioner "file" {
    source      = "path/to/your/local/file.jar"
    destination = "/opt/jboss/jboss/standalone/deployments/"
  }
}

resource "aws_security_group" "jboss-ubuntu" {
  name        = "jboss-windows"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "wildfly port number"
    from_port        = 9990
    to_port          = 9990
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress { 
    description      = "jboss port number"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jboss-ubuntu"
  }
}