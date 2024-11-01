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
                    docker.image('hadolint/hadolint:latest').inside {
                        sh 'hadolint Dockerfile > hadolint_output.txt'
                    }
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
