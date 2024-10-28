pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    
    environment {
        SCANNER_HOME = tool 'sonarscanner'
    }
    
    stages {
        stage("compile") {
            steps {
                sh "mvn compile"
            }
        }
        
        stage('test') {
            steps {
                sh "mvn test"
            }
        }

        stage('install') {
            steps {
                sh "mvn clean install"
            }
        }

        stage("Sonarqube Analysis") {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh '''
                        $SCANNER_HOME/bin/sonarscanner \
                        -Dsonar.projectName=ReactApp \
                        -Dsonar.java.binaries=. \
                        -Dsonar.projectKey=ReactApp
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
