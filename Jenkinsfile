pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        AWS_ACCOUNT_ID = "820183542066"
        ECR_REPO = "820183542066.dkr.ecr.ap-south-1.amazonaws.com/devops-app"
        IMAGE_NAME = "devops-app"
        IMAGE_TAG = "IMAGE_TAG = "18""
        CLUSTER_NAME = "devops-eks"
        DEPLOYMENT_NAME = "devops-app"
        CONTAINER_NAME = "devops-app"
    }

    stages {

        stage('Clone Code') {
            steps {
                git 'https://github.com/rahulrana16112005-design/eks-devops-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh '''
                    docker build -t devops-app .
                    '''
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION \
                | docker login --rahul-admin AWS --password-stdin 820183542066.dkr.ecr.ap-south-1.amazonaws.com
                '''
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh '''
                docker tag devops-app:820183542066.dkr.ecr.ap-south-1.amazonaws.com/devops-app:18
                docker tag devops-app:820183542066.dkr.ecr.ap-south-1.amazonaws.com/devops-app:latest
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                docker push 820183542066.dkr.ecr.ap-south-1.amazonaws.com/devops-app:18
                docker push 820183542066.dkr.ecr.ap-south-1.amazonaws.com/devops-app:latest
                '''
            }
        }

        stage('Update Kubeconfig') {
            steps {
                sh '''
                aws eks update-kubeconfig \
                --region ap-south-1 \
                --name devops-eks
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                dir('k8s') {
                    sh '''i
                    kubectl set image deployment/devops-app devops-app=820183542066.dkr.ecr.ap-south-1.amazonaws.com/devops-app:18
                    kubectl apply -f .
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                kubectl rollout status deployment/devops-app
                kubectl get pods
                kubectl get svc
                kubectl get ingress
                '''
            }
        }
    }

    post {
        success {
            echo "🚀 Deployment Successful"
        }
        failure {
            echo "❌ Deployment Failed"
        }
    }
}
