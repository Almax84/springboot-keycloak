from openjdk:11 as builder




COPY . /app/src
WORKDIR /app/src
RUN ./mvnw -B dependency:go-offline

FROM openjdk:11

COPY --from=builder /app/src/target/*.jar /app/
COPY --from=builder /app/src/src/main/resources/ /app


RUN ls -la /app/


WORKDIR /app/

EXPOSE 8080
EXPOSE 8443

CMD ["java","-jar","-Dspring.profiles.active=container", "/app/product-app-0.0.1-SNAPSHOT.jar"]

