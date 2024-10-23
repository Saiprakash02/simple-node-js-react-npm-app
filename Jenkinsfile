pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: docker
                image: docker:latest
                command:
                - cat
                tty: true
            '''
        }
    }
    environment {
        DOCKER_IMAGE = 'saiprakash02/reactapp01'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                container('docker') {
                    git 'https://github.com/Saiprakash02/simple-node-js-react-npm-app.git'
                }
            }
        }

        stage('Docker Build') {
            steps {
                container('docker') {
                    script {
                        sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ."
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                container('docker') {
                    script {
                        withDockerRegistry(credentialsId: 'docker-cred') {
                            sh "docker push ${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                        }
                    }
                }
            }
        }

        stage('Deploy to EKS Cluster') {
            steps {
                container('docker') {
                    script {
                        withCredentials([kubeconfig(credentialsId: 'jenkinsk8s')]) {
                            sh "sed -i 's#TAG#${BUILD_NUMBER}#g' deployment.yaml"
                            sh "kubectl apply -f k8s_manifest/namespace.yaml"
                            sh "kubectl apply -f k8s_manifest/deployment.yaml"
                            sh "kubectl apply -f k8s_manifest/service.yaml"
                        }
                    }
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
