pipeline {
    agent any
    environment {
        SCANNER_HOME = tool 'sonarscanner'
        }    
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'npm install'
                }
            }
        }

        stage('SonarQube Analysis') {
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

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitUntil {
                        script {
                            def qualityGate = waitForQualityGate()
                            return qualityGate.status == 'OK'
                        }
                    }
                }
            }
        }

        stage('OWASP Dependency Check') {
            steps {
                script {
                    dependencyCheck additionalArguments: ''' 
                        -o "./reports" 
                        -s "./"
                        --project "ReactApp" 
                        --format ALL 
                        --prettyPrint 
                    ''', odcInstallation: 'dependency-check'
                    if (!fileExists('reports/dependency-check-report.xml')) {
                        error "Dependency Check report not found!"
                    }
                }
                dependencyCheckPublisher pattern: '**/reports/dependency-check-report.xml'
            }
        }
    }
}
