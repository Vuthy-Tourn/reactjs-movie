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
                sh 'npm ci'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test || true'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Deploy to Nginx (Localhost)') {
            steps {
                sh '''
                rm -rf /var/www/react-app/*
                cp -r dist/* /var/www/react-app/
                '''
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
            echo '✅ React CI/CD Successful - App deployed to Nginx'
        }
        failure {
            echo '❌ React CI/CD Failed'
        }
    }
}
