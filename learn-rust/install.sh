#!/bin/bash

echo "========================================="
echo "Installing Rust Jupyter Kernel"
echo "========================================="

# Check if we're in a virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Warning: Not in a virtual environment!"
    echo "Recommended: source .venv/bin/activate (from root directory)"
fi

# Check if Rust is installed
if ! command -v cargo &> /dev/null; then
    echo "Rust is not installed. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "Rust version: $(rustc --version)"
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

# Install evcxr_jupyter (Rust kernel)
echo "Installing Rust kernel for Jupyter (this may take a while)..."
cargo install evcxr_jupyter

# Install the Rust kernel
echo "Configuring Rust kernel for Jupyter..."
evcxr_jupyter --install

echo ""
echo "========================================="
echo "Rust kernel installation complete!"
echo "========================================="
echo "Run 'bash run-tutorial.sh' to start Jupyter"
