# stage 1: BUILDER
FROM maven:3.9.11-eclipse-temurin-17 AS builder
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY . .
RUN mvn clean package

# stage 2: RUNTIME
FROM tomcat:10.1-jdk17-temurin
COPY --from=builder /app/target/onlinebookstore.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
