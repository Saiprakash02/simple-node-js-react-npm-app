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
                    sh 'docker run --rm -i -v $PWD:/data hadolint/hadolint:latest-debian < Dockerfile > data/hadolint_output.txt'
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
