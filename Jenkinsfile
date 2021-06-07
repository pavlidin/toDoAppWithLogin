pipeline {
    agent any
    environment {
        docker_credentials = 'docker_creds'
        docker_image = ''
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
                            docker.withRegistry('',docker_credentials) {
                                sh "docker push pavlidin/java-app:devbuild$BUILD_NUMBER"
                            }
                        }
                    }
                }
                stage("Deploy Containers through Ansible") {
                    steps {
                        sh "ansible-playbook /etc/ansible/playbooks/app-deploy.yml -i /etc/ansible/hosts "
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
                        sh "docker build -t pavlidin/java-app:prodbuild$BUILD_NUMBER --target openjdk11 ."
                    }
                }
                stage("Docker push prod jar image") {
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                sh "docker push pavlidin/java-app:prodbuild$BUILD_NUMBER"
                            }
                        }
                    }
                }
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
