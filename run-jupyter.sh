#!/bin/bash

echo "========================================="
echo "Starting Jupyter Notebook"
echo "========================================="

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo "Virtual environment not found."
    echo "Please run: bash setup-venv.sh"
    exit 1
fi

# Activate the virtual environment
source .venv/bin/activate

# Check if Jupyter is installed
if ! command -v jupyter &> /dev/null; then
    echo "Jupyter is not installed in the virtual environment."
    echo "Installing Jupyter..."
    uv pip install notebook jupyter
fi

echo "Launching Jupyter Notebook..."
echo "The notebook will open in your default browser."
echo "Press Ctrl+C to stop the server."
echo ""

jupyter notebook
