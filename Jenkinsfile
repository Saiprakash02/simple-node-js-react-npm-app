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
                    sh 'docker create volume data'
                    sh 'docker run --rm -v $PWD:/data -i hadolint/hadolint < data/Dockerfile > data/hadolint_output.txt || true'
                    sh 'cat hadolint_output.txt'
                }
            }
        }
    }
}
