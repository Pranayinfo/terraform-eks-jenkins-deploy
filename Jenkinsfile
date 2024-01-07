pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/Pranayinfo/terraform-eks-jenkins-deploy.git'
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('vpc'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatting Terraform Code'){
            steps{
                script{
                    dir('vpc'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('vpc'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the Infra using Terraform'){
            steps{
                script{
                    dir('vpc'){
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS Cluster'){
            steps{
                script{
                    dir('vpc') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            steps{
                script{
                    dir('./') {
                        sh 'aws eks update-kubeconfig --name ed-eks-01'
                        sh 'kubectl apply -f nginx.yaml'
                        sh 'kubectl apply -f service.yaml'
                        sh 'kubectl apply -f autoscaling.yaml'
                    }
                }
            }
        }
    }
}
