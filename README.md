# Terraform Infrastructure as Code for EKS Cluster and VPC Setup

## Introduction

In this assignment, we will explore the setup of an Amazon EKS (Elastic Kubernetes Service) cluster along with the associated Virtual Private Cloud (VPC) using Terraform. The infrastructure is organized into different modules for clarity and modularity. The project includes the creation of security groups, VPCs, EKS clusters, and instances with Jenkins automation.

![image](https://github.com/Pranayinfo/terraform-eks-jenkins-deploy/assets/97338976/542d6144-d676-4a4d-b8ab-c124b99be243)

## Project Structure

The project is organized into different folders, each dedicated to a specific aspect of the infrastructure setup.

### EKS Cluster Setup (eks_setup Folder)

1. **IAM Role Setup (eks.tf)**
   - The IAM roles for EKS master and worker nodes are defined. Policies for EKS cluster, service, VPC resource controller, worker nodes, autoscaler, and various other permissions are attached to these roles.

2. **EKS Cluster Configuration (eks.tf)**
   - The EKS cluster is configured with the necessary dependencies on IAM roles and VPC. Subnet IDs are specified, and the EKS cluster is created with the name "ed-eks-01".

3. **EKS Node Group Setup (eks.tf)**
   - An EKS node group named "dev" is created, specifying the cluster name, node role, subnet IDs, capacity type, disk size, instance types, and other configurations.

4. **Output Configuration (output.tf)**
   - The EKS cluster endpoint is defined as an output variable for reference in subsequent stages.

5. **Variable Configuration (variable.tf)**
   - Variables for subnet IDs, VPC ID, and security group IDs are defined for flexibility and reusability.

### Security Group Setup (sg_eks Folder)

1. **Security Group Configuration (sg.tf)**
   - A security group named "eks-test" is created with ingress rules allowing HTTP and SSH traffic. This security group is associated with the worker nodes.

2. **Output Configuration (output.tf)**
   - The security group ID is defined as an output variable.

### VPC Setup (vpc Folder)

1. **VPC Configuration (vpc.tf)**
   - The VPC, along with two public subnets in different availability zones, is created. Internet gateway, route table, and associations are also configured.

2. **Output Configuration (output.tf)**
   - Outputs include the VPC ID and public IP addresses of instances.

### EC2 Instances Setup (ec2_instance.tf)

- EC2 instances are defined for the EKS cluster and Jenkins setup with configurations like AMI, instance type, key name, security group, and subnet.

### Jenkins Setup (jenkins_setup Folder)

1. **Backend Configuration (backend.tf)**
   - Terraform backend configuration is set to store the state file in an S3 bucket.

2. **Jenkins Installation Script (jenkins.sh)**
   - A bash script to install Jenkins along with Git, Terraform, and kubectl is provided.

3. **Jenkins EC2 Instance Configuration (main.tf)**
   - An EC2 instance for Jenkins is defined with necessary configurations like AMI, instance type, key name, security groups, and subnet.

4. **Variable Configuration (variable.tf)**
   - Variables for AMI, instance type, key name, VPC CIDR, and subnet CIDR are defined for flexibility.

### Jenkins Pipeline (Jenkinsfile)

- A Jenkins pipeline script is defined to automate the entire process. Stages include SCM checkout, Terraform initialization, formatting, validation, preview, infrastructure creation/destruction, and application deployment.

## Execution Flow

- **Checkout SCM:** Git repository is cloned to Jenkins workspace.
- **Initializing Terraform:** Terraform is initialized within the VPC module.
- **Formatting Terraform Code:** Terraform code is formatted for consistency.
- **Validating Terraform:** Code is validated for correctness.
- **Previewing the Infra:** A preview of changes is displayed, and user confirmation is sought.
- **Creating/Destroying EKS Cluster:** EKS cluster and associated resources are created or destroyed based on user input.
- **Deploying Nginx Application:** Kubeconfig is updated, and Nginx application is deployed to the EKS cluster.

## Conclusion

This project demonstrates the power of Terraform in automating the setup of complex cloud infrastructures, providing reproducibility, scalability, and maintainability. The Jenkins pipeline automates the entire process, making it suitable for continuous integration and continuous deployment (CI/CD) workflows. The modular structure enhances readability and facilitates future modifications and additions to the infrastructure.

