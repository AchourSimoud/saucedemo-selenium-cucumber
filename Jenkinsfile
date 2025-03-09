pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir '.'
            args '-v /dev/shm:/dev/shm --shm-size=2g --entrypoint='''
        }
    }

    parameters {
        string(name: 'TAG', defaultValue: 'run_login_tests_chrome', description: 'Tag to execute')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', 
                url: 'https://github.com/AchourSimoud/saucedemo-selenium-cucumber.git'
            }
        }
        stage('Grant bash files permission') {
            steps {
                sh "chmod +x batch/*.sh"
            }
        }

        stage('Execute tests') {
            steps {
                sh "batch/${params.TAG}.sh"
            }
        }
    }
    post {
        always {
            cucumber buildStatus: 'UNSTABLE',
            failedFeaturesNumber: 1,
            failedScenariosNumber: 1,
            skippedStepsNumber: 1,
            failedStepsNumber: 1,
            classifications: [
                    [key: 'Commit', value: '<a href="${GERRIT_CHANGE_URL}">${GERRIT_PATCHSET_REVISION}</a>'],
                    [key: 'Submitter', value: '${GERRIT_PATCHSET_UPLOADER_NAME}']
            ],
            reportTitle: 'My report',
            fileIncludePattern: '**/*.cucumber.json',
            sortingMethod: 'ALPHABETICAL',
            trendsLimit: 100
         }
    }
}