FROM maven:3.8.6-openjdk-11-slim as BUILD
COPY . /src
WORKDIR /src
RUN mvn install -DskipTests

FROM openjdk:11-jdk-slim-bullseye
EXPOSE 8080
WORKDIR /app
ARG JAR=spring-petclinic-2.7.0-SNAPSHOT.jar

COPY --from=BUILD /src/target/$JAR /app.jar
ENTRYPOINT ["java","-XX:MaxRAMPercentage=75","-jar","/app.jar"]
