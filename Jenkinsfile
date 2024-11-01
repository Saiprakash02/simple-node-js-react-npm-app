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
                    sh 'docker volume create data'
                    sh '''
                        docker run --rm \
                        -v $PWD:/data \
                        hadolint/hadolint hadolint /data/Dockerfile > hadolint_output.txt 2>&1 || true
                    '''
                    sh 'cat hadolint_output.txt'
                }
            }
        }
    }
}
