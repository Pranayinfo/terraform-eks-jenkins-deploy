provider "aws" {
  region = "us-east-1"
  profile = "default"
}

resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key-name
   // security_groups = ["rgt01-sg"]
   vpc_security_group_ids = ["${aws_security_group.rgt01-sg.id}"]
   subnet_id = "${aws_subnet.rgt01-public_subent_01.id}"
   //user_data = file("jenkins.sh")
}

resource "aws_security_group" "rgt01-sg" {
    name = "rgt01-sg"
    vpc_id = "${aws_vpc.rgt01-vpc.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
    description = "HTTP from jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh-sg"

    }

}

//creating a VPC
resource "aws_vpc" "rgt01-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "rpt03-vpc"
    }
  
}

// Creatomg a Subnet 
resource "aws_subnet" "rgt01-public_subent_01" {
    vpc_id = "${aws_vpc.rgt01-vpc.id}"
    cidr_block = var.subnet_cidr
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
      Name = "rgt01-public_subent_01"
    }
  
}

//Creating a Internet Gateway 
resource "aws_internet_gateway" "rgt01-igw" {
    vpc_id = "${aws_vpc.rgt01-vpc.id}"
    tags = {
      Name = "rgt01-igw"
    }
}

// Create a route table 
resource "aws_route_table" "rgt01-public-rt" {
    vpc_id = "${aws_vpc.rgt01-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.rgt01-igw.id}"
    }
    tags = {
      Name = "rgt01-public-rt"
    }
}

// Associate subnet with routetable 

resource "aws_route_table_association" "rgt01-rta-public-subent-1" {
    subnet_id = "${aws_subnet.rgt01-public_subent_01.id}"
    route_table_id = "${aws_route_table.rgt01-public-rt.id}"
  
}