pipeline{
    agent any
    stages{
        stage('checkout') {
            steps {
                echo 'Checking out the code...'
                git branch: 'main', url: 'https://github.com/MohammedOsamaHassan/CICD_Project.git'
            }
        }
        stage('build') {
            steps {
                echo 'Building image'
                sh 'docker build -t mohamedosama45/cicdproject:latest .'
            }
            post {
                success {
                    echo 'Build successful'
                }
                failure {
                    echo 'Build failed'
                }
            }
        }
        stage('push'){
            steps{
                echo 'Pushing image'
                withCredentials([usernamePassword(credentialsId: 'DockerHubCreditials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                    sh "docker push mohamedosama45/cicdproject:latest"   
                }
            }
            post {
                success {
                    echo 'Push successful'
                }
                failure {
                    echo 'Push failed'
                }
            }        
        }
        stage('deploy') {
            steps {
                echo 'Deploying to server'
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'

            }
            post {
                success {
                    echo 'Deployment successful'
                }
                failure {
                    echo 'Deployment failed'
                }
            }
        }

    }
    
}