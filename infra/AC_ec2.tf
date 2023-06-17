resource "aws_instance" "rockolify_app" {
  ami           = "ami-0e820afa569e84cc1"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.rockolify_public.id

  tags = {
    Name = "Rockolify-app"
  }
}
