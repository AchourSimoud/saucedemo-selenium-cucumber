pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir 'Dockerfile'
        }
    }

    parameters {
        string(name: 'TAG', defaultValue: 'run_login_tests_chrome', description: 'Tag to execute')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/AchourSimoud/saucedemo-selenium-cucumber.git'
            }
        }
        stage('Grant bash files permission') {
            steps {
                sh 'chmod +x batch/*.sh'
            }
        }

        stage('Execute tests') {
            steps {
                sh '${params.TAG}.sh'
            }
        }
    }
}