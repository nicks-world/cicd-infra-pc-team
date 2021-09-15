FROM adoptopenjdk:11-jre-hotspot

VOLUME /tmp

USER root

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

EXPOSE 8080

USER 1001 

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom --spring.config.location=file:/application.properties","-jar","/app.jar"]