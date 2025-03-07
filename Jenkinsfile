pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir 'Dockerfile'
        }
    }
    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/votre-repo/test-selenium.git'
            }
        }
        stage('Build and Test') {
            steps {
                sh 'mvn clean test'
            }
        }
    }
}