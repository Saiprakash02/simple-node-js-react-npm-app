pipeline {
    agent any
    environment {
        SCANNER_HOME = tool 'sonarscanner'
    }
    
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh '''
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectName=ReactApp \
                        -Dsonar.projectKey=ReactApp \
                        -Dsonar.sources=. \
                        -Dsonar.language=js \
                        -Dsonar.sourceEncoding=UTF-8
                    '''
                }
            }
        }


        stage("Quality Gate") {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }

        // stage('Owasp Dependency Check') {
        //     steps {
        //         catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
        //             timeout(time: 60, unit: 'MINUTES') {
        //                 dependencyCheck additionalArguments: '--scan ./', odcInstallation: 'dependency-check'
        //                 dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        //             }
        //         }
        //     }
        // }
    }
}
