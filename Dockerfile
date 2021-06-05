#
# Package stage
#
FROM  java:openjdk-11-jre
EXPOSE 8080

WORKDIR /app
COPY /var/lib/jenkins/workspace/ToDoApp_dev/target/toDoAppWithLogin.jar .

# # Run app
# CMD ["-jar","toDoAppWithLogin.jar"]
# ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--
# my_sql.host=your-database-link", "--my_sql.port=database-port"]


