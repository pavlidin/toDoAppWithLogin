FROM tomcat:8
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war

ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher", "--
my_sql.host=your-database-link", "--my_sql.port=database-port"]
