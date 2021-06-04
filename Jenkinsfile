pipeline {
    agent any
    tools {
        maven "maven-3.6.1"
    }
    environment {
        DOCKER_TAG = "getVersion()"
    }
    stages {
        stage("Dev branch") {
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
                stage("Docker Package"){
                    steps{
                        echo "This is a test message from prod branch!"
                        
                    }
                                
            }
        }
        stage("Prod branch") {
            when {
                branch 'prod'
            }
            stages {
                stage("Test message from prod branch") {
                    steps {
                        echo "This is a test message from prod branch!"
                    }
                }
            }
        }
    }
    post{
        success{
            mail to:"fanouria.ath@gmail.com",
            subject:"SUCCESSFUL BUILD: $BUILD_TAG",
            body:"Link to JOB $BUILD_URL"
        }
        failure{
            mail to:"fanouria.ath@gmail.com",
            subject:"FAILURE BUILD: $BUILD_TAG",
            body:"Link to JOB $BUILD_URL"
        }
    }
}
def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHASH
}
