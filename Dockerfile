# Stage 1: Build the application using Maven and JDK 17
FROM eclipse-temurin:17-jdk-jammy as builder

# Set the working directory inside the container
WORKDIR /opt/app

# Copy the Maven wrapper files and make them executable
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x ./mvnw

# Download Maven dependencies without running tests (cache dependencies for faster builds)
RUN ./mvnw dependency:go-offline

# Copy the source code into the container
COPY ./src ./src

# Build the application
RUN ./mvnw clean install

# Stage 2: Use a minimal JRE to run the application
FROM eclipse-temurin:17-jre-jammy

# Set the working directory inside the container
WORKDIR /opt/app

# Expose the port (Cloud Run will dynamically set the port via an environment variable)
EXPOSE 8080

# Copy the built JAR file from the builder stage
COPY --from=builder /opt/app/target/*.jar /opt/app/app.jar

# Set the PORT environment variable to use the port provided by Cloud Run (default to 8080 if not set)
ENV PORT=8080

# Optional: Add JVM options for better memory management in Cloud Run environments
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+ExitOnOutOfMemoryError"

# Run the Spring Boot application, using the dynamically set port from Cloud Run
ENTRYPOINT ["java", "-jar", "/opt/app/app.jar", "--server.port=${PORT}"]
