variable "ami" {
    default = "ami-079db87dc4c10ac91"  
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key-name" {
    default = "ssh.key"
}

variable "vpc_cidr" {
    default = "10.1.0.0/16"
}

variable "subnet_cidr" {
    default = "10.1.1.0/24"
}