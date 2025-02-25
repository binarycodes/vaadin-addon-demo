FROM eclipse-temurin:21-jre-alpine

WORKDIR /app
COPY target/*.jar /app/

EXPOSE 8090
ENTRYPOINT ["sh", "-c", "java -jar /app/*.jar"]