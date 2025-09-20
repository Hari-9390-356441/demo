pipeline {
    agent any

    environment {
        IMAGE_NAME = "photo-gallery"
        DOCKERHUB_USER = "harigopal118"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url=https://github.com/Hari-9390-356441/demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if running
                    sh "docker rm -f ${IMAGE_NAME} || true"
                    // Run new container
                    sh "docker run -d -p 8080:80 --name ${IMAGE_NAME} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Push to DockerHub') {
            when {
                expression { return env.DOCKERHUB_USER != null }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                    sh "docker tag ${IMAGE_NAME}:latest $DOCKERHUB_USER/${IMAGE_NAME}:latest"
                    sh "docker push $DOCKERHUB_USER/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}

