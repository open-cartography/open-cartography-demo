FROM golang:1.19

# Set destination for COPY
WORKDIR /storyteller

# Debugging - List files in build context
RUN ls -la

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY *.go ./
COPY *.png ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /main

# Expose port
EXPOSE 8082
RUN chmod +x /main

# Run
CMD ["/main"]
