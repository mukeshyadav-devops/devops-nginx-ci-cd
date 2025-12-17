pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t nginx-ci-cd .'
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
