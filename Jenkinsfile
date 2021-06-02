pipeline {
    agent any
    tools {
        maven "maven-3.8.1"
    }
    stages {
        stage("Dev branch") {
            when {
                branch 'dev'
            }
            stages {
                stage("Test message from dev branch") {
                    steps {
                        echo "This is a test message from dev branch! test1234"
                    }
                }
                stage("Clean old mvn output."){
                    steps{
                        bat "mvn clean"
                    }
                }
                stage("Compile"){
                    steps{
                        bat "mvn clean compile"
                    }
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