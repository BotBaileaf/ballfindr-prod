# data "aws_ami" "amazon_linux" {
# 	most_recent = true
# 	owners = ["amazon"]
# 	filter {
# 		name = "name"
# 		values = ["amzn2-ami-hvm-*-x86_64-gp2"]
# 	}
# }

# resource "aws_instance" "ec2-public" {
# 	ami = data.aws_ami.amazon_linux.id
# 	instance_type = var.chassis
# 	key_name = "LAB2-KEY"
# 	subnet_id = var.aws_subnet-public-SN
# 	security_groups = [var.SEC-GR-TF]
# 	tags = { Name = "EC2-TF-Public" }
# 	user_data = file("user-data.sh")
# }
# resource "aws_instance" "ec2-private" {
# 	ami = data.aws_ami.amazon_linux.id
# 	instance_type = var.chassis
# 	key_name = "LAB2-KEY"
# 	subnet_id = var.aws_subnet-private-SN
# 	security_groups = [var.SEC-GR-TF]
# 	tags = { Name = "EC2-TF-Private" }
# 	user_data = file("user-data.sh")
# }

resource "aws_launch_configuration" "ec2cluster" {
	image_id = "ami-0ed9277fb7eb570c9"
	instance_type = "t2.micro"
 	security_groups = [var.SEC-GR-TF]
	user_data = file("user-data.sh")
	lifecycle {
	  create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "asg" {
	launch_configuration = aws_launch_configuration.ec2cluster.name
	vpc_zone_identifier = [var.aws_subnet-public-SN, var.aws_subnet-public-SN]
	target_group_arns = [var.asg-tg]
	health_check_type = "ELB"
	min_size = 2
	max_size = 4
	tag {
	  key = "Name"
	  value = "asg"
	  propagate_at_launch = true
	}
}