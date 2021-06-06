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
<<<<<<< HEAD
                stage("Development branch") {
            when {
                branch 'dev'
            }
            stages {
                stage("Docker build jar image") {
=======
                stage("Docker build") {
>>>>>>> parent of a78c29c (add init mysql dev config)
                    steps {
                        script {
                            docker_image = docker.build "pavlidin/todoappwithlogin:devbuild-$BUILD_NUMBER"
                        }
                    }
<<<<<<< HEAD
                }
                stage("Docker push jar image") {
=======
                }  
                stage("Docker push") {
>>>>>>> parent of a78c29c (add init mysql dev config)
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                docker_image.push("devbuild-$BUILD_NUMBER")
                            }
                        }                 
                    }
                } 
<<<<<<< HEAD
                stage("Docker build mysql image") {
                    steps {
                        script {
                            docker_image = docker.build "pavlidin/java-mysql:devbuild-$BUILD_NUMBER"
                        }                 
                    }
                }
                
=======
>>>>>>> parent of a78c29c (add init mysql dev config)
             
            }
            stage("Docker prune dangling images") {
                    steps {
                        sh "docker image prune -f"               
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