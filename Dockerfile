FROM  openjdk:8-jre
EXPOSE 8080

WORKDIR /app
COPY target/toDoAppWithLogin.jar toDoAppWithLogin.jar

# Run app
# CMD ["-jar","/usr/local/lib/toDoAppWithLogin.jar"]
# ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--
# my_sql.host=your-database-link", "--my_sql.port=database-port"]