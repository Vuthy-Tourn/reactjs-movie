pipeline {
    agent any

    tools {
        nodejs 'node20'  
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Vuthy-Tourn/reactjs-movie'
            }
        }

        stage('Install Dependencies') {
            steps {
                // 'node' and 'npm' are automatically in PATH when using tools { nodejs }
                sh 'npm ci'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Check Node') {
            steps {
                sh 'node -v'
                sh 'npm -v'
            }
        }

    }

    post {
        success {
            echo '✅ React CI Pipeline Successful'
        }
        failure {
            echo '❌ React CI Pipeline Failed'
        }
    }
}
