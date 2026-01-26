FROM eclipse-temurin:21-jre-alpine

ARG APP_NAME
ARG APP_VERSION

RUN test -n "$APP_NAME" || (echo "APP_NAME  not set" && false)
RUN test -n "$APP_VERSION" || (echo "APP_VERSION  not set" && false)

RUN adduser -D appuser

WORKDIR /app
COPY --chown=appuser:appuser target/${APP_NAME}-${APP_VERSION}.jar /app/

USER appuser

EXPOSE 8090/tcp
ENV JAR_FILE_PATH="/app/${APP_NAME}-${APP_VERSION}.jar"
ENTRYPOINT ["sh", "-c", "java -jar ${JAR_FILE_PATH}"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=5 CMD curl -f http://localhost:8090
