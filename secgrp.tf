resource "aws_security_group" "vprofile-bean-elb-sg" {
  name = "vprofile-bean-elb-sg"
  description = "Security group for bean-elb"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    protocol = "-1"   # -1 means all the protocol
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vprofile-bastion-sg" {
  name = "vprofile-bastion-sg"
  description = "Security group for bastionisioner ec2 instance"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.MYIP]
  }
}

resource "aws_security_group" "vprofile-prod-sg" {
  name = "vprofile-prod-sg"
  description = "Security group for beanstalk instances"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = [aws_security_group.vprofile-bastion-sg.id]
  }
}

resource "aws_security_group" "vprofile-backend-sg" {
  name = "vprofile-backend-sg"
  description = "Security group for RDS, activemq, elastic cache"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_groups = [aws_security_group.vprofile-prod-sg.id]
  }
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
  type = "ingress"
  from_port = 0
  to_port = 65535   #Traffic to all ports
  protocol = "tcp"
  security_group_id = aws_security_group.vprofile-backend-sg.id
  source_security_group_id = aws_security_group.vprofile-backend-sg.id
}

#SG has to be in the vpc you created. The vpc is created by a module and you
# need the id. you need to find the output of the module from the doc., search for vpc_id, you
#can select eitehr the default or the vpc_id, hence (module.vpc.vpc_id)

#security group for the beanstalk instances. Since the beanstalk is part of the private subnet, you
# can not do ssh to beanstalk i.e you can't access it from the pub. network. You can access it from the
# bastion host, you can do ssh to bastion host first and from there you can do ssh to the beanstalk instance
#so only the private connection from the bastion host SG is allowed to the SG of the BS on port 22.