pipeline {
        agent any
        environment {
            DOCKER_IMAGE = 'saiprakash02/reactapp'
        }
    
        stages {
            stage('Checkout') {
                steps {
                    git 'https://github.com/Saiprakash02/simple-node-js-react-npm-app.git'
                }
            }
    
            // stage('Build') {
            //     steps {
            //         script {
            //             sh 'npm ci'
            //         }
            //     }
            // }

            
            // stage('Test') {
            //     steps {
            //         sh './jenkins/scripts/test.sh'
            //     }
            // }
            // stage('Docker Build') {
            //     steps {
            //         script {
            //             sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
            //     }
            // }
            // }

            stage('Login to docker hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                sh 'sudo docker login -u ${USERNAME} -p ${PASSWORD}'}
                echo 'Login successfully'
            }
        }
        stage('Build Docker Image')
        {
            steps
            {
                sh "sudo docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} . "
                echo "Docker image build successfully"
                sh "sudo docker images"
            }
        }
        stage("TRIVY"){
            steps{
                catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    sh "sudo trivy image --no-progress --exit-code 1 --severity MEDIUM,HIGH,CRITICAL --format table ${DOCKER_IMAGE}:${env.BUILD_ID}"
                 }   
            }
        }
        //     stage('Docker Push') {
        //         steps {
        //             script {
        //                 withDockerRegistry(credentialsId: 'docker-cred') {
        //                     sh "docker push ${DOCKER_IMAGE}:${env.BUILD_ID}"
        //                 }
        //             }
        //         }
        //     }
        // }
    
        // post {
        //     success {
        //         mail to: 'saiprakash0229@gmail.com',
        //              subject: "Build Successful: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
        //              body: "The build was successful! Check it out at ${env.BUILD_URL}"
        //     }
        //     failure {
        //         mail to: 'saiprakash0229@gmail.com',
        //              subject: "Build Failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
        //              body: "The build failed! Check it out at ${env.BUILD_URL}"
        //     }
        }
    }
