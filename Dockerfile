# Use the Rust official image as the base image
FROM rust:latest AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the dependency manifests
COPY . .

# # Build the application
# RUN cargo build --release

# Install the application
RUN cargo install --path .

# Start a new stage and use a lightweight image for the final runtime
FROM debian:buster-slim

# Set the working directory inside the container
# WORKDIR /usr/src/myapp

# Copy the built binary from the builder stage to the final stage
COPY --from=builder /usr/local/cargo/bin/hostless-rocket-app /usr/local/bin/hostless-rocket-app

# Set the environment variable to listen on all interfaces
ENV ROCKET_ADDRESS=0.0.0.0

# Expose the port your application listens on
EXPOSE 8000

# Command to run the application
CMD ["hostless-rocket-app"]