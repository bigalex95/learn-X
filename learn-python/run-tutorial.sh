#!/bin/bash

echo "========================================="
echo "Starting Python Jupyter Tutorial"
echo "========================================="

# Navigate to root directory
cd "$(dirname "$0")/.." || exit

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo "Virtual environment not found."
    echo "Please run from root directory: bash setup-venv.sh"
    exit 1
fi

# Activate the virtual environment
source .venv/bin/activate

# Check if Jupyter is installed
if ! command -v jupyter &> /dev/null; then
    echo "Jupyter is not installed. Running installation script..."
    cd learn-python
    bash install.sh
    cd ..
fi

echo "Launching Jupyter Notebook..."
echo "The notebook will open in your default browser."
echo "Press Ctrl+C to stop the server."
echo ""

# Start in the python tutorial directory
cd learn-python
jupyter notebook
