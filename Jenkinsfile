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
                    sh 'docker volume create data_output'
                    sh '''
                        docker run --rm \
                        -v data:/data_output \
                        -v $PWD:/data \
                        hadolint/hadolint sh -c "mkdir -p /data_output && hadolint /data/Dockerfile > /data_output/hadolint_output.txt 2>&1"
                    '''
                    sh '''
                        docker run --rm -v data:/data_output busybox sh -c "ls -l /data_output"
                    '''
                }
            }
        }
    }
}
