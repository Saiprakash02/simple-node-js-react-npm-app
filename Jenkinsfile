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
                    sh '''
                        docker run --rm \
                        -v $PWD:/data \
                        -i hadolint/hadolint:latest-debian \
                        sh -c "mkdir -p /data && hadolint /data/Dockerfile > /data/hadolint_output.txt; echo $? > /data/hadolint_exit_code.txt"
                    '''
                    
                    // Check exit code
                    sh 'docker run --rm -v data:/data alpine cat /data/hadolint_exit_code.txt'
                    
                    // To view the Hadolint output
                    sh 'docker run --rm -v data:/data alpine cat /data/hadolint_output.txt || echo "No output generated"'
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
