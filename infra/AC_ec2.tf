resource "aws_instance" "rockolify_app" {
  ami                    = "ami-0e820afa569e84cc1"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.rockolify_public.id
  vpc_security_group_ids = [aws_security_group.rockolify_public.id]

  tags = {
    Name = "Rockolify-app"
  }
}

resource "aws_eip" "rockolify_ec2_ip" {
  instance = aws_instance.rockolify_app.id
  domain   = "vpc"
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("terraform_ec2_key.pub")
}

################# OUTPUTS #########################################################

output "ec2_elastic_ip" {
  value       = aws_eip.rockolify_ec2_ip.public_ip
  description = "The public IP taken from the elastic ip resource"
}
