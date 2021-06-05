pipeline {
    agent any
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
                    steps{
                        sh "mvn clean"
                    }
                }
                stage("Compile"){
                    steps{
                        sh "mvn clean compile"
                    }
                }
                stage("Testing"){
                    steps{
                        sh "mvn test"
                    }
                    post{
                        always{
                            junit '**/target/surefire-reports/*.xml'
                        }
                    }
                } 
                stage("Package"){
                    steps{
                        sh "mvn package"
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
                    steps{
                        sh "mvn clean"
                    }
                }
                stage("Compile"){
                    steps{
                        sh "mvn clean compile"
                    }
                }
                stage("Testing"){
                    steps{
                        sh "mvn test"
                    }
                    post{
                        always{
                            junit '**/target/surefire-reports/*.xml'
                        }
                    }
                } 
                stage("Package"){
                    steps{
                        sh "mvn package"
                    }
                } 
             
            }
        }
    }
    post{
        success{
            mail to:"fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
            subject:"SUCCESSFUL BUILD: $BUILD_TAG",
            body:"Link to JOB $BUILD_URL"
        }
        failure{
            mail to:"fanouria.ath@gmail.com, nikospavlidismail@gmail.com",
            subject:"FAILURE BUILD: $BUILD_TAG",
            body:"Link to JOB $BUILD_URL"
        }
    }
}
