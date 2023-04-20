module "vpc" {
  source = "terraform-aws-modules/vpc/aws"  #when you run terraform init, this module will be downloaded

  name = var.VPC_NAME
  cidr = var.vpcCIDR
  azs  = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets = [var.PrivSub1CIDR, var.PrivSub2CIDR, var.PrivSub3IDR]
  public_subnets = [var.PubSub1CIDR, var.PubSub2CIDR, var.PubSub3CIDR]

  enable_nat_gateway = true  #if you have multi subnets it will create multi nat gateways which will
  single_nat_gateway = true  # be very expensive for this exercise, hence restrict to single nat gateway
  enable_dns_hostnames = true
  enable_dns_support = true   #IGW will get automatically created because you have the pub. subnets
                            #Route table will also get created auto. and link the subnets
  tags = {
    Terraform = "true"
    Environment = "Prod"
  }
  vpc_tags = {
    Name = var.VPC_NAME
  }
}