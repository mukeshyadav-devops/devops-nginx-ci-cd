pipeline  {
    agent any

    environment {
        DOCKER_IMAGE = 'nginx-ci-cd'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t nginx-ci-cd .'
            }
        }

        
        stage('Trivy Image Scan') {
            steps {
                sh '''
                trivy image --exit-code 0 --severity LOW,MEDIUM $DOCKER_IMAGE:latest
                trivy image --exit-code 1 --severity HIGH,CRITICAL $DOCKER_IMAGE:latest
                '''
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    withCredentialsIds: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_HUB_USERNAME',
                    passwordvariable: 'DOCKER_HUB_PASSWORD'
                )]) {
                    sh 'echo $DOCKER_HUB_PASSWORD | docker login -u $DOCKER_HUB_USERNAME --password-stdin'
                }
            }
        }
        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }
        stage('Run Container') {
            steps {
                sh '''
                docker ps -aq --filter "name=nginx-app" | xargs -r docker rm -f
                docker run -d -p 8081:80 --name nginx-app nginx-ci-cd
                '''
            }
        }
    }
}

