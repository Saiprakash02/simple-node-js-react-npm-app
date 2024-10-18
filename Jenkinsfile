pipeline {
        agent any
    
        environment {
            DOCKER_IMAGE = 'saiprakash02/reactapp'
            DOCKER_BUILDKIT = '1'
        }
    
        stages {
            stage('Checkout') {
                steps {
                    git 'https://github.com/Saiprakash02/simple-node-js-react-npm-app.git'
                }
            }
    
            stage('Build') {
                steps {
                    script {
                        sh 'npm install'
                    }
                }
            }
    
            stage('Test') {
                steps {
                    sh './jenkins/scripts/test.sh'
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
                        withDockerRegistry(credentialsId: 'dockercred') {
                            sh "docker push ${DOCKER_IMAGE}:${env.BUILD_ID}"
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