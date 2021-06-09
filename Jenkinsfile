pipeline {
    agent any
    environment {
        docker_credentials = 'docker_creds'
        docker_image = ''
        ansible_credentials = 'ansible_creds'
    }
    tools {
        maven "maven-3.6.1"
    }
    stages {
        stage("mvn clean") {
            steps {
                sh "mvn clean"
            }
        }
        stage("mvn clean compile") {
            steps {
                sh "mvn clean compile"
            }
        }
        stage("mvn test") {
            steps {
                sh "mvn test"
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
        stage("mvn package") {
            steps {
                sh "mvn package"
            }
        }
        stage("Development branch") {
            when {
                branch 'dev'
            }
            stages {
                stage("Docker build dev jar image") {
                    steps {
                        sh "docker build -t pavlidin/java-app:devbuild$BUILD_NUMBER --target openjdk11 ."
                    }
                }
                stage("Docker push dev jar image") {
                    steps {
                        script {
                            docker.withRegistry('', docker_credentials) {
                                sh "docker push pavlidin/java-app:devbuild$BUILD_NUMBER"
                            }
                        }
                    }
                }
                stage("Deploy app & MySQL in dev using ansible") {
                    steps {
                        script {
                            ansiblePlaybook credentialsId: ansible_credentials, inventory: 'ansible/hosts',
                                playbook: 'ansible/deployment_playbook.yml', extraVars: [build_nr: "$BUILD_NUMBER", branch: "$BRANCH_NAME"]
                        }
                    }
                }
            }
        }
        stage("Production branch") {
            when {
                branch 'prod'
            }
            stages {
                stage("Docker build prod jar image") {
                    steps {
                        sh "docker build -t pavlidin/java-app:prodbuild$BUILD_NUMBER -t pavlidin/java-app:latest --target openjdk11 ."
                    }
                }
                stage("Docker push prod jar image") {
                    steps {
                        script {
                            docker.withRegistry('', docker_credentials) {
                                sh "docker push pavlidin/java-app:prodbuild$BUILD_NUMBER && docker push pavlidin/java-app:latest"
                            }
                        }
                    }
                    // post {
                    //     always {
                    //         mail to:  "fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
                    //         subject: "Ready to deploy application: ${currentBuild.fullDisplayName}",
                    //         body: "The application is ready to be deployed. Please confirm.\n More info at: ${env.BUILD_URL}"
                    //     }
                    // }
                }
                stage("Deploy app & MySQL in prod using ansible") {
                    // input{
                    //     message "Do you want to proceed to production deployment?"
                    // }
                    steps {
                        script {
                            ansiblePlaybook credentialsId: ansible_credentials, inventory: 'ansible/hosts',
                                playbook: 'ansible/deployment_playbook.yml', extraVars: [build_nr: "$BUILD_NUMBER", branch: "$BRANCH_NAME"]
                        }
                    }
                }

            }
        }
        stage("Cleanup docker images older than 1 week") {
            steps {
                sh "docker image prune -a -f --filter 'until=168h'"
            }
        }
    }
    // post {
    //     success {
    //         mail to: "fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
    //             subject: "SUCCESSFUL BUILD: $BUILD_TAG",
    //             body: "Link to JOB $BUILD_URL"
    //     }
    //     failure {
    //         mail to: "fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
    //             subject: "FAILURE BUILD: $BUILD_TAG",
    //             body: "Link to JOB $BUILD_URL"
    //     }
    // }
}