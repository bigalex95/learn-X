# Go Jupyter Tutorial

This folder contains Go programming tutorials using Jupyter Notebook.

## Prerequisites

- Go 1.16 or higher
- Python 3.7 or higher
- pip package manager

## Installation

Run the installation script to set up the Go kernel:

```bash
bash install.sh
```

This will install:

- Jupyter Notebook
- gophernotes (Go kernel for Jupyter)

## Running the Tutorial

Launch the Jupyter Notebook server:

```bash
bash run-tutorial.sh
```

Or manually:

```bash
source ../.venv/bin/activate
jupyter notebook
```

## Manual Installation

If you prefer manual installation:

```bash
# Install Go (if not already installed)
# Visit: https://golang.org/doc/install

# Install gophernotes
go install github.com/gopherdata/gophernotes@latest

# Create kernel directory
mkdir -p ~/.local/share/jupyter/kernels/gophernotes

# Copy kernel configuration
cp $(go env GOPATH)/pkg/mod/github.com/gopherdata/gophernotes@*/kernel/* ~/.local/share/jupyter/kernels/gophernotes/
```

## Tutorials Included

- Go basics and syntax
- Variables and data types
- Functions and packages
- Goroutines and channels
- Interfaces
- Error handling
- Standard library usage
- And more...

## Troubleshooting

If the Go kernel doesn't appear in Jupyter:

```bash
# Ensure GOPATH/bin is in PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Reinstall gophernotes
go install github.com/gopherdata/gophernotes@latest

# Check kernel installation
jupyter kernelspec list
```

If you see permission errors:

```bash
# Make sure gophernotes is executable
chmod +x $(go env GOPATH)/bin/gophernotes
```

## Features

- **Interactive Go REPL**: Test Go code interactively
- **Import packages**: Use any Go package in notebooks
- **Visualization**: Display results and plots
- **Documentation**: View Go documentation inline
