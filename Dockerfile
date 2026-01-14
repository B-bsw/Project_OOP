# Stage 1: Build the application
FROM eclipse-temurin:23-jdk AS build

WORKDIR /app

# Copy Gradle files for dependency caching
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY gradle.properties .

# Ensure the Gradle wrapper is executable
RUN chmod +x gradlew

# Download dependencies (optional step to improve caching, but ./gradlew jproRelease does it too)
# RUN ./gradlew dependencies --no-daemon

# Copy the source code
COPY src src

# Build the JPro release
# This usually creates a zip in build/distributions/ ending with -jpro.zip
RUN ./gradlew jproRelease --no-daemon

# Stage 2: Create the runtime image
FROM eclipse-temurin:23-jdk

# Install unzip to extract the distribution
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the built artifact from the build stage
# We use a wildcard to match the zip file name
COPY --from=build /app/build/distributions/*-jpro.zip /app/app.zip

# Extract the application
RUN unzip app.zip && \
    rm app.zip && \
    # Move the extracted directory (usually named <Project>-jpro) to a fixed name 'current'
    mv *-jpro current

WORKDIR /app/current

# Ensure the start script is executable
RUN chmod +x bin/start.sh

# Expose port 8080
EXPOSE 8080

# Define the entrypoint
# Render will map the exposed port.
# If JPro needs a specific port passed via arguments, you might need to adjust this.
# Default JPro behavior often respects standard configuration or runs on 8080.
CMD ["./bin/start.sh"]
