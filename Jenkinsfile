pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'saiprakash02/reactapp01'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Saiprakash02/simple-node-js-react-npm-app.git'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        sh "docker push ${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Deploy to EKS Cluster') {
            steps {
                script {
                    kubernetesDeploy(
                        configs: 'k8s_manifest/*.yaml',
                        kubeconfigId: 'jenkinsk8s',
                        enableConfigSubstitution: true
                    )
                }
            }
        }
    }

    post {
        success {
            mail to: 'saiprakash0229@gmail.com',
                 subject: "Build Successful: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
                 body: "The build was successful! Check it out at ${env.BUILD_URL}"
        }
        failure {
            mail to: 'saiprakash0229@gmail.com',
                 subject: "Build Failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
                 body: "The build failed! Check it out at ${env.BUILD_URL}"
        }
    }
}
