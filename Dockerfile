# Stage 1: Build the application using Maven and JDK 17
FROM eclipse-temurin:17-jdk-jammy as builder

# Set the working directory inside the container
WORKDIR /opt/app

# Copy the Maven wrapper files
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Make the Maven wrapper executable
RUN chmod +x ./mvnw

# Download Maven dependencies without running tests (to cache them)
RUN ./mvnw dependency:go-offline

# Copy the source code into the container
COPY ./src ./src

# Build the application
RUN ./mvnw clean install

# Stage 2: Use a minimal JRE to run the application
FROM eclipse-temurin:17-jre-jammy

# Set the working directory inside the container
WORKDIR /opt/app

# Expose the port (ensure this matches the port used by the application)
EXPOSE 8080

# Copy the built JAR file from the builder stage
COPY --from=builder /opt/app/target/*.jar /opt/app/app.jar

# Define the entry point to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]
