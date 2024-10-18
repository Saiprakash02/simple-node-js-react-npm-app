pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'saiprakash02/reactapp'  // Replace with your Docker Hub username and desired image name
        DOCKER_CREDENTIALS_ID = 'dockercred'    // Replace with the ID of your Docker credentials in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/jenkins-docs/simple-node-js-react-npm-app.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Set npm cache directory
                    sh 'npm config set cache /tmp/npm-cache --global'
                    // Clean npm cache
                    sh 'npm cache clean --force'
                    // Install dependencies
                    sh 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repo
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Log in to Docker
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        // Push the Docker image
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
