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
                sh 'apk add --no-cache coreutils'
                sh 'hadolint Dockerfile > hadolint_output.txt'
            }
        }
    }
}
