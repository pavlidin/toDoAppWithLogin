FROM  openjdk:8-jre as openjdk8
WORKDIR /app
COPY target/toDoAppWithLogin.jar toDoAppWithLogin.jar

FROM mysql:8.0 as mysql8
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--\
my_sql.host=java-mysql", "--my_sql.port=3306"]

# Run app
# CMD ["-jar","/usr/local/lib/toDoAppWithLogin.jar"]
# ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--
# my_sql.host=your-database-link", "--my_sql.port=database-port"]