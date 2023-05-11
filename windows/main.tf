resource "aws_instance" "windows" {
  ami                     = "ami-05b0cd1af6c0c34e3"
  instance_type           = "m5.large"
  vpc_security_group_ids = [aws_security_group.jboss-windows.id]
  key_name = "ajith-keys"
  user_data = <<-EOF
    <powershell>
    winrm quickconfig -q
    Set-ExecutionPolicy Unrestricted -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install -y jdk8
    choco install -y jboss-eap7
    </powershell>
  EOF
}


resource "aws_security_group" "jboss-windows" {
  name        = "jboss-windows"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "wildfly port number"
    from_port        = 9990
    to_port          = 9990
    protocol         = "tcp"
  }

  ingress { 
    description      = "jboss port number"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jboss-windows"
  }
}