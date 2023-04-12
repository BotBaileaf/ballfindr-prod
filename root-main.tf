module "VPC" {
  source = "./VPC"
}
module "SEC-GROUP" {
  source = "./SEC-GROUP"
  vpc-id = module.VPC.vpc-id
}
module "EC2" {
  source               = "./EC2"
  aws_subnet-public-SN = module.VPC.aws_subnet-public-SN
  aws_subnet-public-SN-2 = module.VPC.aws_subnet-public-SN-2
  aws_subnet-private-SN = module.VPC.aws_subnet-private-SN
  SEC-GR-TF                = module.SEC-GROUP.SG-TF
  asg-tg = module.LOAD-BALANCER.asg-tg
}

module "LOAD-BALANCER" {
  source               = "./LB"
  aws_subnet-public-SN = module.VPC.aws_subnet-public-SN
  aws_subnet-public-SN-2 = module.VPC.aws_subnet-public-SN-2
  SEC-GR-TF                = module.SEC-GROUP.SG-TF
  ec2_instance          = "EC2-TF-Public"
  vpc-id = module.VPC.vpc-id
}