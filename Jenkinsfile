pipeline {
    agent any()
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
    }
    stages {
        stage ('Create Cluster') {
            sh 'terraform init'
            sh 'terraform apply --auto-approve'
            sh "aws eks update-kubeconfig --name myapp-cluster --region eu-central-1"
        }
    }
}