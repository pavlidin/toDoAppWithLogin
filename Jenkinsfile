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
                stage("Docker build dev mysql image") {
                    steps {
                        sh "docker build -t pavlidin/dev-java-mysql:8.0 --target mysql8 ."
                    }
                }
                stage("Docker build dev jar image") {
                    steps {
                        sh "docker build -t pavlidin/todoappwithlogin:devbuild-$BUILD_NUMBER --target openjdk11 ."
                    }
                }
                stage("Docker push dev jar image") {
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                sh "docker push pavlidin/todoappwithlogin:devbuild-$BUILD_NUMBER"
                            }
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
                stage("Docker build prod mysql image") {
                    steps {
                        sh "docker build -t pavlidin/prod-java-mysql:8.0 --target mysql8 ."
                    }
                }
                stage("Docker build prod jar image") {
                    steps {
                        sh "docker build -t pavlidin/todoappwithlogin:prodbuild-$BUILD_NUMBER --target openjdk11 ."
                    }
                }
                stage("Docker push prod jar image") {
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                sh "docker push pavlidin/todoappwithlogin:prodbuild-$BUILD_NUMBER"
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
