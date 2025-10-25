#!/bin/bash

echo "========================================="
echo "Installing C/C++ Jupyter Kernel"
echo "========================================="

# Check if we're in a virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Warning: Not in a virtual environment!"
    echo "Recommended: source .venv/bin/activate (from root directory)"
fi

# Check if gcc is installed
if ! command -v gcc &> /dev/null; then
    echo "Warning: gcc is not installed. Please install gcc/g++ compiler."
    echo "On Ubuntu/Debian: sudo apt-get install build-essential"
    echo "On macOS: xcode-select --install"
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3.7 or higher."
    exit 1
fi

echo "Python version: $(python3 --version)"

# Install Jupyter
echo "Installing Jupyter Notebook..."
if command -v uv &> /dev/null && [ -n "$VIRTUAL_ENV" ]; then
    echo "Using uv for faster installation..."
    uv pip install notebook jupyter
else
    pip install --upgrade pip
    pip install notebook jupyter
fi

# Check if conda is installed
if command -v conda &> /dev/null; then
    echo "Installing xeus-cling (C++ kernel) via conda..."
    conda install -c conda-forge xeus-cling -y
    echo "C++ kernel (xeus-cling) installed successfully!"
elif command -v mamba &> /dev/null; then
    echo "Installing xeus-cling (C++ kernel) via mamba..."
    mamba install -c conda-forge xeus-cling -y
    echo "C++ kernel (xeus-cling) installed successfully!"
else
    echo ""
    echo "========================================="
    echo "WARNING: conda/mamba not found"
    echo "========================================="
    echo "The C++ kernel (xeus-cling) requires conda or mamba."
    echo "Please install conda from: https://docs.conda.io/en/latest/miniconda.html"
    echo ""
    echo "Alternative: Use Bash kernel to compile and run C/C++ code manually."
    echo "Installing Bash kernel as fallback..."
    if command -v uv &> /dev/null && [ -n "$VIRTUAL_ENV" ]; then
        uv pip install bash_kernel
    else
        pip install bash_kernel
    fi
    python3 -m bash_kernel.install
fi

echo ""
echo "========================================="
echo "C/C++ kernel installation complete!"
echo "========================================="
echo "Run 'bash run-tutorial.sh' to start Jupyter"
