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
                sh 'docker build -t myDockerHub/cicdproject:latest .'
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
                    sh ''' 
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker push myDockerHub/cicdproject:latest
                    '''
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
                sh '''
                export KUBECONFIG=/root/.kube/jenkins.yaml
                kubectl config view
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                '''
            }
            post {
                success {
                    echo 'Deployment successful'
                    sh '''
                    export KUBECONFIG=/root/.kube/jenkins.yaml
                    kubectl get pods -o wide
                    kubectl get services
                    '''
                }
                failure {
                    echo 'Deployment failed'
                }
            }
        }

    }
    
}