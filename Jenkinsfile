pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AccessKey')     // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('SecretKey')     // Jenkins credentials ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/sravandevops09/jenkinsdemo.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Plan Terraform') {
            steps {
                sh 'terraform plan -var "access_key=$AWS_ACCESS_KEY_ID" -var "secret_key=$AWS_SECRET_ACCESS_KEY"'
            }
        }

        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -auto-approve -var "access_key=$AWS_ACCESS_KEY_ID" -var "secret_key=$AWS_SECRET_ACCESS_KEY"'
            }
        }
    }
}
