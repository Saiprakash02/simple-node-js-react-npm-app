pipeline {
        agent any
        environment {
            DOCKER_IMAGE = 'saiprakash02/reacteksapp'
            AWS_REGION = 'us-east-1'
        }
    
        stages {
            stage('Checkout') {
                steps {
                    checkout scm
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
            stage('Deploy to kubernetes'){
                steps{
                    withCredentials([aws(credentialsId: 'aws-cred', region: AWS_REGION)]) {
                        script{
                            withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'jenkinsk8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                            sh "sed -i 's#IMAGE#${DOCKER_IMAGE}#g' k8s_manifest/deployment.yaml"
                            sh "sed -i 's#TAG#${BUILD_NUMBER}#g' k8s_manifest/deployment.yaml"
                            sh 'kubectl apply -f k8s_manifest/namespace.yaml'
                            sh 'kubectl apply -f k8s_manifest/deployment.yaml'
                            sh 'kubectl apply -f k8s_manifest/service.yaml'
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