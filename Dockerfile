#
# Package stage
#
FROM openjre:11
EXPOSE 8080

COPY /var/lib/jenkins/workspace/ToDoApp_dev/target/toDoAppWithLogin.jar /usr/local/lib/toDoAppWithLogin.jar

# Run app
CMD ["-jar","/usr/local/lib/toDoAppWithLogin.jar"]
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--
my_sql.host=your-database-link", "--my_sql.port=database-port"]


