pipeline {
    agent any
    environment {
        SCANNER_HOME = tool 'sonarscanner'
    }
    
    stages {
        stage('Checkout Github') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
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
        stage('Owasp Dependency Check') {
            steps {
                dependencyCheck additionalArguments: ''' 
                    -o "./" 
                    -s "./"
                    -f "ALL" 
                    --prettyPrint''', odcInstallation: 'dependency-check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
    }
}
