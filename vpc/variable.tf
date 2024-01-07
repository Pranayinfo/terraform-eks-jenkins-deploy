variable "ami" {
    default = "ami-079db87dc4c10ac91"
  
}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "key" {

    default = "ssh.key"
  
}

variable "vpc" {

    default = "10.2.0.0/16"
  
}

variable "subnet" {

    default = "10.2.5.0/24"
  
}

variable "subnet2" {

    default = "10.2.4.0/24"
  
}