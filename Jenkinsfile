pipeline {
    agent any
    stages {
        stage('Lint') {
            parallel {
                stage('Foodcritic') {
                    steps {
                        powershell 'foodcritic . -t ~FC008 -t ~FC066 -t ~FC067 -t ~FC069 -t ~FC071 -t ~FC078 -t ~FC093'
                    }
                }
                stage('Cookstyle') {
                    steps {
                        powershell 'cookstyle'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                bat 'kitchen test --destroy always'
            }
        }
        stage('Deploy to dev') {
            steps {
                powershell 'berks upload'

                powershell 'knife ssh "chef_environment:development" sudo chef-client'
            }
        }
        stage('Promote to stage') {

            steps {
                script {
                    input message: 'Approve deployment to stage?'
                }
                powershell 'knife spork promote staging bjc-ecommerce'
                powershell 'knife ssh "chef_environment:staging" sudo chef-client'
            }
        }
        stage('Promote to prod') {

            steps {
                script {
                    input message: 'Approve deployment to prod?'
                }
                powershell 'knife spork promote staging bjc-ecommerce'
                powershell 'knife ssh "chef_environment:production" sudo chef-client'
            }
        }
    }
    post {
        always {
            powershell 'kitchen destroy'
        }
  }
}

