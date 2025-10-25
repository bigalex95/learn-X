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

The `basic/` folder contains interactive tutorials covering:

- **01-hello-world** - Your first Go program
- **02-variables** - Variable declaration and types
- **03-arrays** - Fixed-size arrays
- **04-slices** - Dynamic slices
- **05-if-else** - Conditional statements
- **06-loops** - For loops and iterations
- **07-functions** - Function definitions and usage
- **08-fmt-module** - Formatted I/O operations

### Tutorial Formats

Each tutorial is available in two formats:

- **`.ipynb` (Notebooks)**: Simplified, interactive code examples perfect for hands-on learning and experimentation
- **`.md` (Markdown)**: Comprehensive tutorials with detailed explanations, theory, and exercises

**Recommendation**: Use notebooks for quick practice and experimentation. Refer to markdown files for in-depth understanding and exercises.

## Creating and Running Go Scripts

If you prefer working with standalone Go scripts instead of notebooks:

### 1. Create a Go File

Create a new file with `.go` extension:

```bash
# Create a new Go file
touch hello.go
```

### 2. Write Your Go Code

Every Go program needs a `package` declaration and a `main` function:

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

### 3. Run the Go Script

You have several options to run Go code:

**Option A: Run directly (no compilation)**

```bash
go run hello.go
```

**Option B: Build and execute**

```bash
# Compile to executable
go build hello.go

# Run the executable
./hello
```

**Option C: Install globally**

```bash
# Install to $GOPATH/bin
go install hello.go

# Run from anywhere
hello
```

### 4. Working with Modules

For larger projects, use Go modules:

```bash
# Initialize a new module
go mod init myproject

# Create your main.go file
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello from my module!")
}
EOF

# Run the module
go run .

# Or build it
go build -o myapp
./myapp
```

### 5. Multiple Files

For projects with multiple files:

```bash
# Run all .go files in current directory
go run .

# Or specify files
go run main.go helpers.go

# Build all files
go build .
```

### Example Project Structure

```
myproject/
├── go.mod
├── main.go
├── utils/
│   └── helpers.go
└── models/
    └── user.go
```

Run with:

```bash
cd myproject
go run .
```

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
