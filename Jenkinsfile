pipeline {
    agent any   
    stages {
        stage('git checkout') {
            steps {
                checkout scm
                }
            }
        stage('Hadolind') {
            steps {
                script {
                    sh "docker run --rm -i hadolint/hadolint < Dockerfile > hadolint_output.txt || true"
                    sh "cat hadolint_output.txt"
            }
        }
    }
}
}
