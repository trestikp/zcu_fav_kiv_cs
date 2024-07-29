# Stage 1: Build the Spring Boot application
FROM maven:3.8.8-eclipse-temurin-17 AS builder

WORKDIR /app

COPY wait-for-mysql.sh .
COPY pom.xml .
COPY src ./src

RUN mvn clean package

# Stage 2: Create the final image
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=builder /app/wait-for-mysql.sh /app/wait-for-mysql.sh
COPY --from=builder /app/target/bikesharing-backend.jar /app/app.jar

RUN chmod +x /app/wait-for-mysql.sh

EXPOSE 8080

CMD ["./wait-for-mysql.sh", "mysql", "3306", "java -jar app.jar"]
