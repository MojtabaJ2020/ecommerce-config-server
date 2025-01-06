# Step 1: Build the Spring Boot app using Gradle
FROM gradle:7.5-jdk17 AS build

# Set the working directory for Gradle build
WORKDIR /app

# Copy the Gradle wrapper and build files
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle settings.gradle ./

# Give execute permission to gradlew
RUN chmod +x gradlew

# Download the Gradle dependencies
RUN ./gradlew --no-daemon dependencies

# Copy the rest of the project
COPY . .

# Build the Spring Boot jar file
RUN ./gradlew --no-daemon clean build -x test

# Step 2: Create a smaller runtime image to run the app
FROM openjdk:17-jdk-slim AS runtime

# Set the working directory for the runtime
WORKDIR /app

# Copy the Spring Boot jar from the build stage
COPY --from=build /app/build/libs/config-server-*-SNAPSHOT.jar /app/app.jar

# Expose the port your Spring Boot application runs on
EXPOSE 8888

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
