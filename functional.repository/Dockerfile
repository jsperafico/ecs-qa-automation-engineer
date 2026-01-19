FROM maven:3.9.12-sapmachine-21

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src
