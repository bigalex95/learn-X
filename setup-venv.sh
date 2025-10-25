#!/bin/bash

echo "========================================="
echo "Setting up Virtual Environment with UV"
echo "========================================="

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "UV is not installed. Installing UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    # Source the cargo env to get uv in PATH
    export PATH="$HOME/.cargo/bin:$PATH"
    
    # Check again
    if ! command -v uv &> /dev/null; then
        echo "Error: UV installation failed. Please install manually from https://docs.astral.sh/uv/"
        exit 1
    fi
fi

echo "UV version: $(uv --version)"

# Create virtual environment using uv
VENV_DIR=".venv"

if [ -d "$VENV_DIR" ]; then
    echo "Virtual environment already exists at $VENV_DIR"
    read -p "Do you want to recreate it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Removing existing virtual environment..."
        rm -rf "$VENV_DIR"
    else
        echo "Using existing virtual environment."
    fi
fi

if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment with uv..."
    uv venv "$VENV_DIR"
fi

echo ""
echo "========================================="
echo "Virtual environment setup complete!"
echo "========================================="
echo ""
echo "To activate the virtual environment:"
echo "  source .venv/bin/activate"
echo ""
echo "To install all kernels:"
echo "  source .venv/bin/activate"
echo "  bash install-all-kernels.sh"
echo ""
echo "Or use the convenience script:"
echo "  bash activate-and-install.sh"
