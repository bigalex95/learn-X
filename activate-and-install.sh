#!/bin/bash

echo "========================================="
echo "Activating venv and installing kernels"
echo "========================================="

# Setup venv if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Virtual environment not found. Setting up..."
    bash setup-venv.sh
fi

# Activate the virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate

# Install all kernels
echo ""
bash install-all-kernels.sh

echo ""
echo "========================================="
echo "Setup complete!"
echo "========================================="
echo "Virtual environment is now active."
echo ""
echo "To run Jupyter:"
echo "  jupyter notebook"
echo ""
echo "To deactivate when done:"
echo "  deactivate"
