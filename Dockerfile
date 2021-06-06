FROM  openjdk:8-jre as openjdk8
WORKDIR /app
COPY target/toDoAppWithLogin.jar toDoAppWithLogin.jar

FROM mysql:8.0 as mysql8
ENV MYSQL_ROOT_PASSWORD root
# ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--\
# my_sql.host=localhost", "--my_sql.port=3306"]

# Run app
# CMD ["-jar","/usr/local/lib/toDoAppWithLogin.jar"]
# ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--
# my_sql.host=your-database-link", "--my_sql.port=database-port"]