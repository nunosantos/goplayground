# Use the official Golang image to create a build artifact.
FROM golang:latest as builder

# Copy local code to the container image.
WORKDIR /app
COPY . .

# Build the command inside the container.
RUN go build -o helloworld

# Use a minimal image to run the binary
FROM gcr.io/distroless/base-debian10

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/helloworld /helloworld

# Run the web service on container startup.
CMD ["/helloworld"]
