#!/bin/bash

echo "========================================="
echo "Installing Bash Jupyter Kernel"
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

# Install Jupyter and Bash kernel
echo "Installing Jupyter Notebook and Bash kernel..."
if command -v uv &> /dev/null && [ -n "$VIRTUAL_ENV" ]; then
    echo "Using uv for faster installation..."
    uv pip install notebook bash_kernel
else
    pip install --upgrade pip
    pip install notebook bash_kernel
fi

# Install the Bash kernel
echo "Installing Bash kernel for Jupyter..."
python3 -m bash_kernel.install

echo ""
echo "========================================="
echo "Bash kernel installation complete!"
echo "========================================="
echo "Run 'bash run-tutorial.sh' to start Jupyter"
