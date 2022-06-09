# First stage
FROM golang:1.14-alpine as builder

# The working directory is /app
WORKDIR /app

# Copy and download dependency using go mod
COPY go.mod .
RUN go mod download

# Copy the code into the builder
COPY . .

# Build the application
RUN go build -o /simple-golang

# Second stage
FROM alpine:latest as release

# Arguments values of service
ARG NAME

# Environment values of service
ENV NAME=$NAME

# The working directory is /app
WORKDIR /app

# Import from builder
COPY --from=builder /simple-golang /app/simple-golang
COPY index.html ./

# Expose the service port
EXPOSE 8080

ENTRYPOINT [ "/app/simple-golang" ]