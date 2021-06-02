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
                stage("Test") {
                    steps {
                        mvn test
                    }
                }
                stage("Compile code") {
                    steps {
                        mvn compile
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
}