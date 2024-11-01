pipeline {
    agent any
    stages {
        stage('Lint Dockerfile') {
            agent {
                docker {
                    image 'hadolint/hadolint:latest'
                }
            }
            steps {
                sh 'hadolint Dockerfile > hadolint_output.txt'
                sh 'cat hadolint_output.txt'
            }
        }
    }
}
