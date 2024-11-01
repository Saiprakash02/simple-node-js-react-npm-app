pipeline {
    agent any
    tools { 
        docker 'docker'
    }
    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Lint Dockerfile') {
            steps {
                sh 'docker run --rm -i hadolint/hadolint < Dockerfile > hadolint_output.txt'
                // sh 'cat hadolint_output.txt'
            }
        }
    }
}
