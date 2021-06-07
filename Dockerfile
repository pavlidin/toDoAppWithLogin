FROM openjdk:11-jre-slim as builder
WORKDIR /application
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

#change to jre
FROM openjdk:11-jre-slim as openjdk11 
WORKDIR /application
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/application/ ./
#VOLUME var/lib/sql
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--my_sql.host=mysql", "--my_sql.port=3306"]

FROM mysql:8.0 as mysql8
ENV MYSQL_ROOT_PASSWORD root

