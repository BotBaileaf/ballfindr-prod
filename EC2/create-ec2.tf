data "aws_ami" "amazon_linux" {
	most_recent = true
	owners = ["amazon"]
	filter {
		name = "name"
		values = ["amzn2-ami-hvm-*-x86_64-gp2"]
	}
}

resource "aws_instance" "ec2-public" {
	ami = data.aws_ami.amazon_linux.id
	instance_type = var.chassis
	key_name = "LAB2-KEY"
	subnet_id = var.aws_subnet-public-SN
	security_groups = [var.SEC-GR-TF]
	tags = { Name = "EC2-TF-Public" }
	user_data = file("user-data.sh")
}
resource "aws_instance" "ec2-private" {
	ami = data.aws_ami.amazon_linux.id
	instance_type = var.chassis
	key_name = "LAB2-KEY"
	subnet_id = var.aws_subnet-private-SN
	security_groups = [var.SEC-GR-TF]
	tags = { Name = "EC2-TF-Private" }
	user_data = file("user-data.sh")
}