FROM eclipse-temurin:21.0.5_11-jdk-jammy

LABEL description="Sample JDK 21 (based on Eclipse Temurin)"

RUN apt-get update && \
    apt-get install -y procps curl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ../ext.d
