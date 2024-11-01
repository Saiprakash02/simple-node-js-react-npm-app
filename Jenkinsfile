pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }
        
        stage('Lint Dockerfile') {
            steps {
                script {
                    sh 'docker volume create data'
                    sh 'docker run --rm -v $PWD:/data -i hadolint/hadolint:latest-debian hadolint data/Dockerfile > hadolint_output.txt || true'
                    sh 'cat hadolint_output.txt'
                }
            }
        }
        
        stage('Archive Output') {
            steps {
                archiveArtifacts artifacts: 'hadolint_output.txt', allowEmptyArchive: true
            }
        }
    }
}
