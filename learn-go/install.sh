#!/bin/bash

echo "========================================="
echo "Installing Go Jupyter Kernel"
echo "========================================="

# Check if we're in a virtual environment
if [ -z "$VIRTUAL_ENV" ]; then
    echo "Warning: Not in a virtual environment!"
    echo "Recommended: source .venv/bin/activate (from root directory)"
fi

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo "Go is not installed. Please install Go 1.16 or higher."
    echo "Visit: https://golang.org/doc/install"
    echo ""
    echo "Quick install commands:"
    echo "  wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz"
    echo "  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz"
    echo "  export PATH=\$PATH:/usr/local/go/bin"
    exit 1
fi

echo "Go version: $(go version)"

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

# Install gophernotes (Go kernel)
echo ""
echo "Installing gophernotes (Go kernel for Jupyter)..."
echo "This may take a few minutes..."

# Set GOPATH if not set
if [ -z "$GOPATH" ]; then
    export GOPATH=$HOME/go
    echo "GOPATH set to: $GOPATH"
fi

# Ensure GOPATH/bin is in PATH
export PATH=$PATH:$GOPATH/bin

# Install gophernotes
go install github.com/gopherdata/gophernotes@latest

# Check if installation was successful
if [ ! -f "$GOPATH/bin/gophernotes" ]; then
    echo "Error: gophernotes installation failed."
    exit 1
fi

# Make it executable
chmod +x $GOPATH/bin/gophernotes

# Create kernel directory
echo "Configuring Go kernel for Jupyter..."
KERNEL_DIR=$HOME/.local/share/jupyter/kernels/gophernotes
mkdir -p $KERNEL_DIR

# Create kernel.json
cat > $KERNEL_DIR/kernel.json << EOF
{
    "argv": [
        "$GOPATH/bin/gophernotes",
        "{connection_file}"
    ],
    "display_name": "Go",
    "language": "go",
    "name": "go"
}
EOF

# Create logo files (optional, using base64 encoded Go gopher logos)
cat > $KERNEL_DIR/logo-32x32.png << 'EOF'
EOF

cat > $KERNEL_DIR/logo-64x64.png << 'EOF'
EOF

echo ""
echo "========================================="
echo "Go kernel installation complete!"
echo "========================================="
echo ""
echo "GOPATH: $GOPATH"
echo "gophernotes location: $GOPATH/bin/gophernotes"
echo ""
echo "To ensure Go binaries are always in PATH, add to your ~/.zshrc:"
echo "  export GOPATH=\$HOME/go"
echo "  export PATH=\$PATH:\$GOPATH/bin:/usr/local/go/bin"
echo ""
echo "Run 'bash run-tutorial.sh' to start Jupyter"
