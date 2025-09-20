pipeline {
    agent any

    environment {
        IMAGE_NAME = "photo-gallery"
        DOCKERHUB_USER = "harigopal118"
        CONTAINER_NAME = "photo-gallery-container"
        APP_PORT = "9111"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Hari-9390-356441/demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                    sh "docker tag ${IMAGE_NAME}:latest $DOCKERHUB_USER/${IMAGE_NAME}:latest"
                    sh "docker push $DOCKERHUB_USER/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop and remove old container if running
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Run new container from pushed image
                    sh "docker run -d -p ${APP_PORT}:80 --name ${CONTAINER_NAME} $DOCKERHUB_USER/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
