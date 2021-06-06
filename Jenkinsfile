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
        stage("Development branch") {
            when {
                branch 'dev'
            }
            stages {
                stage("Clean old mvn output.") {
                    steps {
                        sh "mvn clean"
                    }
                }
                stage("Compile") {
                    steps {
                        sh "mvn clean compile"
                    }
                }
                stage("Testing") {
                    steps {
                        sh "mvn test"
                    }
                    post {
                        always {
                            junit '**/target/surefire-reports/*.xml'
                        }
                    }
                } 
                stage("Package") {
                    steps {
                        sh "mvn package"
                    }
                }
                stage("Docker build jar image") {
                    steps {
                        script {
                            docker_image = docker.build "pavlidin/todoappwithlogin:devbuild-$BUILD_NUMBER"
                        }            
                    }
                }  
                stage("Docker push jar image") {
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                docker_image.push("devbuild-$BUILD_NUMBER")
                            }
                        }                 
                    }
                } 
                stage("Docker build mysql image") {
                    steps {
                        script {
                            docker_image = docker.build "pavlidin/java-mysql:devbuild-$BUILD_NUMBER"
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
                stage("Clean old mvn output."){
                    steps {
                        sh "mvn clean"
                    }
                }
                stage("Compile") {
                    steps {
                        sh "mvn clean compile"
                    }
                }
                stage("Testing") {
                    steps {
                        sh "mvn test"
                    }
                    post {
                        always {
                            junit '**/target/surefire-reports/*.xml'
                        }
                    }
                } 
                stage("Package") {
                    steps {
                        sh "mvn package"
                    }
                }
                stage("Docker build") {
                    steps {
                        script {
                            docker_image = docker.build "pavlidin/todoappwithlogin:prodbuild-$BUILD_NUMBER"
                        }            
                    }
                }  
                stage("Docker push") {
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                docker_image.push("prodbuild-$BUILD_NUMBER")
                            }
                        }                 
                    }
                } 
             
            }
        }
    }
    post {
        success {
            mail to:"fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
            subject:"SUCCESSFUL BUILD: $BUILD_TAG",
            body:"Link to JOB $BUILD_URL"
        }
        failure {
            mail to:"fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
            subject:"FAILURE BUILD: $BUILD_TAG",
            body:"Link to JOB $BUILD_URL"
        }
    }
}