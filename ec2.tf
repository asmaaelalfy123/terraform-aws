data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
   vpc_security_group_ids = [aws_security_group.allow_ssh.id]
   associate_public_ip_address = true
   key_name = "asmaa"
   tags = {
    Name = "Bastion"
   }
}


resource "aws_instance" "private" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
    subnet_id = aws_subnet.private1.id
   vpc_security_group_ids = [aws_security_group.allow_ssh_and_3000.id]
     key_name = "asmaa"
   tags = {
    Name = "private"
   }
}