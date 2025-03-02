# Step 1: Build the Spring Boot app using Gradle
FROM gradle:7.5-jdk17 AS build

# Set the working directory for Gradle build
WORKDIR /app

# Copy the Gradle wrapper and build files first
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle settings.gradle ./

# Step 2: Copy the rest of the project files
COPY . .

# Step 3: Give execute permission to gradlew
RUN chmod +x gradlew

# Step 4: Download the Gradle dependencies
RUN ./gradlew --no-daemon dependencies

# Step 5: Build the Spring Boot jar file
RUN ./gradlew --no-daemon clean build -x test

# Step 6: Create a smaller runtime image to run the app
FROM openjdk:17-jdk-slim AS runtime

# Set the working directory for the runtime
WORKDIR /app

# Copy the Spring Boot jar from the build stage
COPY --from=build /app/build/libs/config-server-*-SNAPSHOT.jar /app/app.jar

ENV EUREKA_SERVER_URL="http://localhost:9999/eureka"

# Expose the port your Spring Boot application runs on
EXPOSE 8888

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
