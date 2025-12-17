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
                docker rm -f nginx-app || true
                docker run -d -p 8081:80 --name nginx-app nginx-ci-cd
                '''
            }
        }
    }
}
