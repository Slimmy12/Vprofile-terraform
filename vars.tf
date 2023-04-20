variable AWS_REGION {
	default = "us-east-2"
}

variable ZONE1 {
	default = "us-east-2a"
}

variable ZONE2 {
	default = "us-east-2b"
}

variable ZONE3 {
	default = "us-east-2c"
}

variable AMIS {
	type = map
	default = {
	  us-east-2 = "ami-xxxxxxxxxx"
	  us-east-1 = "ami-xxxxxxxxxx"   #the 2 regions below are dumy, they will not be used
	  ap-south-1 = "ami-xxxxxxxxx"
	}
}

variable USER {
	default = "ubuntu"
}

variable PUB_KEY_PATH {
	default = "vprofilekey.pub"
}

variable PRIV_KEY_PATH {
	default = "vprofilekey"
}

variable MYIP {
	default = "xxxxxxxxxxxxxxx"
}

variable rmquser {
	default = "active"
}

variable rmqpass {
	default = "rabactive4356"
}

variable dbuser {
	default = "admin"
}

variable dbname {
	default = "accounts"
}

variable dbpass {
	default = "slide12"
}

variable instance_count {
	default = "1"
}

variable VPC_NAME {
	default = "vprofile-VPC"
}

variable vpcCIDR {
	default = "172.21.0.0/16"
}

variable PubSub1CIDR {
	default = "172.21.1.0/24"
}

variable PubSub2CIDR {
	default = "172.21.2.0/24"
}

variable PubSub3CIDR {
	default = "172.21.3.0/24"
}

variable PrivSub1CIDR {
	default = "172.21.4.0/24"
}

variable PrivSub2CIDR {
	default = "172.21.5.0/24"
}

variable PrivSub3IDR {
	default = "172.21.6.0/24"
}