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
                sh 'sudo chmod +x script.sh'
                sh './script.sh'
            }
        }
    }
}
