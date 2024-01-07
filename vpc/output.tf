output "VPC_name" {
    description = "VPC id name"
    value = "${aws_vpc.rtp03-vpc.id}" 
  
}

output "master-public-ip" {
    description = "this is jenkins master ip"
    value = try(aws_instance.demo-ec2["master"].public_ip,"")
  
}

output "worker01-public-ip" {
    description = "this is jenkins slave ip"
    value = try(aws_instance.demo-ec2["worker-1"].public_ip,"")
  
}

output "worker02-public-ip" {
    description = "this is Ansible public ip"
    value = try(aws_instance.demo-ec2["worker-2"].public_ip,"")
  
}