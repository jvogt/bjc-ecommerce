pipeline {
    agent any
    stages {
        stage('Lint') {
            steps {
                parallel {
                    stage 'Foodcritic' {
                        steps {
                            powershell 'foodcritic .'
                        }
                    stage 'Cookstyle' {
                        steps {
                            powershell 'cookstyle'
                        }
                    }
                }
            }
        }
        stage('Test') {
            steps {
                powershell 'kitchen verify'
            }
        }
        stage('Deploy to dev') {
            steps {
                powershell 'knife cookbook upload .'
                powershell 'knife ssh "chef_environment:development" sudo chef-client'
            }
        }
        stage('Promote to stage')
            timeout(time:5, unit:'HOURS') {
                input message: 'Approve deployment to stage?'
            }
            steps {
                powershell 'knife spork promote stage . --remote'
                powershell 'knife ssh "chef_environment:stage" sudo chef-client'
            }
        }
        stage('Promote to prod')
            timeout(time:5, unit:'HOURS') {
                input message: 'Approve deployment to prod?'
            }
            steps {
                powershell 'knife spork promote production . --remote'
                powershell 'knife ssh "chef_environment:production" sudo chef-client'
            }
        }
    }
}

