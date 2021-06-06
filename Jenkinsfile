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
                            docker_image = docker.build "pavlidin/todoappwithlogin:XEXE"
                        }            
                    }
                }  
                stage("Docker push") {
                    steps {
                        script {
                            docker.withRegistry('',docker_credentials) {
                                docker_image.push('XD')
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
                stage("Docker build") {
                    steps {
                        script {
                            docker_image = docker.build "pavlidin/todoappwithlogin"
                        }            
                    }
                }  
                stage("Docker push") {
                    steps{
                        script {
                            docker.withRegistry('',docker_credentials) {
                                docker_image.push('latest')
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