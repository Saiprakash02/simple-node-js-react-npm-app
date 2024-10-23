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
                        sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                }
            }
            }
            stage('Docker Push') {
                steps {
                    script {
                        withDockerRegistry(credentialsId: 'docker-cred') {
                            sh "docker push ${DOCKER_IMAGE}:${env.BUILD_ID}"
                        }
                    }
                }
            }
            stage('Deploy to EKS Cluster') {
                steps {
                    withCredentials([aws(credentialsId: 'aws-cred', region: AWS_REGION)]) {
                        dir('k8s_manifest') {
                            sh "sed -i 's#TAG#${BUILD_NUMBER}#g' deployment.yaml"
                            // sh "aws eks update-kubeconfig --region us-east-1 --name React-App-EKS"
                            sh "kubectl apply -f namespace.yaml"
                            sh "kubectl apply -f deployment.yaml"
                            sh "kubectl apply -f service.yaml"
                    }
                    echo "Deployed to EKS Cluster"
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