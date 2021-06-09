FROM openjdk:11-jre-slim as builder
WORKDIR /application
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:11-jre-slim as openjdk11
EXPOSE 8080
WORKDIR /application
ARG SQL_HOST
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/application/ ./
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--my_sql.host=$SQL_HOST", "--my_sql.port=3306"]