#
# Build stage
#

FROM maven:3.9.9-eclipse-temurin-21 as builder

WORKDIR /app

COPY . /app/

RUN mvn clean package -Pdocker

#
# Deploy stage
#

FROM openjdk:21-jdk-slim

RUN useradd -ms /bin/bash appuser && \
    apt update && \
    apt install curl -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

USER appuser

COPY --from=builder --chown=appuser:appuser /app/jnode-assembly/target/jnode-2.0.7-docker.dir /app/

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

VOLUME /data

EXPOSE 8080/tcp 24554/tcp

HEALTHCHECK --interval=60s --timeout=3s --retries=3 CMD curl -f http://localhost:8080/ || exit 1
