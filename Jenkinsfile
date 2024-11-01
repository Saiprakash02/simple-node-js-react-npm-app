pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/your-username/your-repo.git', branch: 'main'
            }
        }
        
        stage('Lint Dockerfile') {
            steps {
                sh 'docker run --rm -i hadolint/hadolint:latest-debian < Dockerfile > hadolint_output.txt'
            }
        }
        
        stage('Archive Output') {
            steps {
                archiveArtifacts artifacts: 'hadolint_output.txt', allowEmptyArchive: true
            }
        }
    }
}
