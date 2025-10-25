#!/bin/bash

echo "========================================="
echo "Installing Python Jupyter Kernel"
echo "========================================="

# Check if we're in a virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Warning: Not in a virtual environment!"
    echo "Recommended: source .venv/bin/activate (from root directory)"
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3.7 or higher."
    exit 1
fi

echo "Python version: $(python3 --version)"

# Install Jupyter and IPython kernel
echo "Installing Jupyter Notebook and IPython kernel..."
if command -v uv &> /dev/null && [ -n "$VIRTUAL_ENV" ]; then
    echo "Using uv for faster installation..."
    uv pip install notebook ipykernel jupyter
else
    pip install --upgrade pip
    pip install notebook ipykernel jupyter
fi

# Install the Python kernel
echo "Installing Python kernel for Jupyter..."
python3 -m ipykernel install --user --name=python3 --display-name "Python 3"

echo ""
echo "========================================="
echo "Python kernel installation complete!"
echo "========================================="
echo "Run 'bash run-tutorial.sh' to start Jupyter"
