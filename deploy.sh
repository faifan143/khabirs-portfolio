#!/bin/bash

# Khabir Portfolio Deployment Script
# This script builds and deploys the portfolio website using Docker

set -e  # Exit on any error

echo "🚀 Starting Khabir Portfolio deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Stop and remove existing container if it exists
print_status "Stopping existing container..."
docker-compose down 2>/dev/null || true

# Build the Docker image
print_status "Building Docker image..."
docker-compose build --no-cache

# Start the container
print_status "Starting container..."
docker-compose up -d

# Wait for container to be healthy
print_status "Waiting for container to be healthy..."
sleep 10

# Check if container is running
if docker-compose ps | grep -q "Up"; then
    print_success "Portfolio deployed successfully!"
    print_status "Website is available at: http://localhost:8080"
    print_status "Health check: http://localhost:8080/health"
    
    # Show container status
    echo ""
    print_status "Container status:"
    docker-compose ps
    
    # Show logs
    echo ""
    print_status "Recent logs:"
    docker-compose logs --tail=20
else
    print_error "Failed to start container. Check logs:"
    docker-compose logs
    exit 1
fi

print_success "Deployment completed! 🎉"
