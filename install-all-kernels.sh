#!/bin/bash

echo "========================================="
echo "Installing All Jupyter Kernels"
echo "========================================="
echo ""

# Check if we're in a virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Warning: Not in a virtual environment!"
    echo "It's recommended to use a virtual environment."
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Please run: source .venv/bin/activate"
        echo "Or use: bash activate-and-install.sh"
        exit 1
    fi
fi

# Install Python requirements first
echo "Installing base requirements with uv..."
if command -v uv &> /dev/null; then
    uv pip install -r requirements.txt
else
    echo "UV not found, using pip..."
    pip install -r requirements.txt
fi
echo ""

# Install Python kernel
echo "========================================="
echo "1. Installing Python kernel..."
echo "========================================="
cd learn-python && bash install.sh
cd ..
echo ""

# Install Bash kernel
echo "========================================="
echo "2. Installing Bash kernel..."
echo "========================================="
cd learn-shell && bash install.sh
cd ..
echo ""

# Install Rust kernel
echo "========================================="
echo "3. Installing Rust kernel..."
echo "========================================="
cd learn-rust && bash install.sh
cd ..
echo ""

# Install C/C++ kernel
echo "========================================="
echo "4. Installing C/C++ kernel..."
echo "========================================="
cd learn-cpp && bash install.sh
cd ..
echo ""

# Install Go kernel
echo "========================================="
echo "5. Installing Go kernel..."
echo "========================================="
cd learn-go && bash install.sh
cd ..
echo ""

echo "========================================="
echo "All kernels installation complete!"
echo "========================================="
echo ""
echo "Installed kernels:"
jupyter kernelspec list
echo ""
echo "To start learning, navigate to any tutorial folder and run:"
echo "  bash run-tutorial.sh"
echo ""
echo "Or launch Jupyter from the root directory:"
echo "  jupyter notebook"
