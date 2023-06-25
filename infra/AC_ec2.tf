resource "aws_instance" "rockolify_app" {
  ami                    = "ami-0e820afa569e84cc1"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.rockolify_public.id
  vpc_security_group_ids = [aws_security_group.rockolify_public.id]
  iam_instance_profile   = aws_iam_instance_profile.ecr_ec2_iprofile.name

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

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow",
        }
      ]
    }
  )
}

resource "aws_iam_instance_profile" "ecr_ec2_iprofile" {
  name = "ecr_ec2_iprofile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy" "ec2_ecr_policy" {
  name = "ec2_ecr_polict"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "ecr:*",
            "s3:*",
            "ssm:*"
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        }
      ]
    }
  )
}

################# OUTPUTS #########################################################

output "ec2_elastic_ip" {
  value       = aws_eip.rockolify_ec2_ip.public_ip
  description = "The public IP taken from the elastic ip resource"
}
