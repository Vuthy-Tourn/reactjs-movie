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
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                // sh 'npm run build'
                sh """
                    docker build -t jenkins-react-pipeline . 
                """
            }
        }

       stage("Deploy"){
            steps{
                sh"""
                docker stop reactjs-cont || true 
                docker rm reactjs-cont || true 


                docker run -dp 3000:80 \
                    --name reactjs-cont \
                    jenkins-react-pipeline
                """

            }
        }

        // stage("Add Domain Name"){
        //     steps{
        //         sh """

        //         which certbot
        //         certbot --version 
        //         # write reverse proxy config 
        //         # sudo nginx -s reload 
        //         """ 
        //     }
        // }

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
