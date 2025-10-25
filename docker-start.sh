#!/bin/bash

# Quick Start Script for learn-X Docker Environment

set -e

echo "🚀 learn-X Quick Start"
echo "======================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    echo "Please install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker compose &> /dev/null && ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed!"
    echo "Please install Docker Compose from: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Build and start the container
echo "🐳 Building and starting Jupyter Lab container..."
echo "This may take a few minutes on first run..."
echo ""

docker compose up -d

echo ""
echo "✅ Container is starting!"
echo ""
echo "📚 Access Jupyter Lab at: http://localhost:8888"
echo ""
echo "Available kernels:"
echo "  🐍 Python 3"
echo "  🐹 Go"
echo "  🦀 Rust"
echo "  ⚙️  C++"
echo "  🐚 Bash"
echo ""
echo "Useful commands:"
echo "  docker compose logs -f    # View logs"
echo "  docker compose down       # Stop container"
echo "  docker compose restart    # Restart container"
echo ""
echo "Happy learning! 🎓"
