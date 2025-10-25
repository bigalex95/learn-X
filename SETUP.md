# Setup Guide for Learn-X Jupyter Tutorials

This guide explains how to set up and use the Jupyter Notebook tutorials with a virtual environment managed by `uv`.

## Prerequisites

- Python 3.7 or higher
- For Rust: cargo (Rust package manager)
- For C/C++: gcc/g++ compiler and conda/mamba (optional)
- For Go: Go 1.16 or higher

## Quick Start (Recommended)

### 1. Setup Virtual Environment and Install Everything

```bash
# This will setup uv, create venv, and install all kernels
bash setup-venv.sh
bash activate-and-install.sh
```

### 2. Run Jupyter

```bash
# From root directory
bash run-jupyter.sh

# Or manually
source .venv/bin/activate
jupyter notebook
```

## Detailed Steps

### Step 1: Install UV (if not already installed)

UV will be automatically installed when you run `setup-venv.sh`, or install manually:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Step 2: Create Virtual Environment

```bash
bash setup-venv.sh
```

This creates a `.venv` directory in the project root.

### Step 3: Activate Virtual Environment

```bash
source .venv/bin/activate
```

You should see `(.venv)` in your terminal prompt.

### Step 4: Install Jupyter Kernels

#### Option A: Install All Kernels at Once

```bash
bash install-all-kernels.sh
```

#### Option B: Install Individual Kernels

```bash
# Python
cd learn-python && bash install.sh && cd ..

# Bash/Shell
cd learn-shell && bash install.sh && cd ..

# Rust
cd learn-rust && bash install.sh && cd ..

# C/C++
cd learn-cpp && bash install.sh && cd ..

# Go
cd learn-go && bash install.sh && cd ..
```

### Step 5: Verify Installation

```bash
jupyter kernelspec list
```

You should see the installed kernels (Python 3, Bash, Rust, C++, Go).

## Running Tutorials

### Option 1: From Root Directory

```bash
source .venv/bin/activate
jupyter notebook
```

Then navigate to the tutorial folder you want.

### Option 2: Using Convenience Scripts

```bash
# From root directory
bash run-jupyter.sh

# Or from individual tutorial folders
cd learn-python
bash run-tutorial.sh
```

### Option 3: Individual Tutorial Folders

```bash
cd learn-python  # or any tutorial folder
source ../.venv/bin/activate
jupyter notebook
```

## Working with the Virtual Environment

### Activate Virtual Environment

```bash
source .venv/bin/activate
```

### Deactivate Virtual Environment

```bash
deactivate
```

### Install Additional Packages

```bash
# With uv (faster)
uv pip install package-name

# Or with regular pip
pip install package-name
```

### Update Dependencies

```bash
uv pip install -r requirements.txt --upgrade
```

## Troubleshooting

### UV Command Not Found

```bash
# Add to your PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Or install manually
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Kernel Not Appearing in Jupyter

```bash
# Reinstall the kernel
source .venv/bin/activate
cd learn-python  # or relevant folder
bash install.sh
```

### Virtual Environment Issues

```bash
# Remove and recreate
rm -rf .venv
bash setup-venv.sh
bash activate-and-install.sh
```

### Rust Kernel Issues

```bash
# Make sure cargo is in PATH
source $HOME/.cargo/env

# Reinstall evcxr_jupyter
cargo install evcxr_jupyter --force
evcxr_jupyter --install
```

### C++ Kernel Issues

The C++ kernel requires conda or mamba. If you don't have it:

```bash
# Install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# Then install xeus-cling
conda install -c conda-forge xeus-cling
```

### Go Kernel Issues

```bash
# Make sure Go is installed
go version

# Make sure GOPATH/bin is in PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Reinstall gophernotes
go install github.com/gopherdata/gophernotes@latest

# Check kernel installation
jupyter kernelspec list
```

## Benefits of Using UV

- **Faster installations**: UV is 10-100x faster than pip
- **Better dependency resolution**: More reliable dependency handling
- **Unified tool**: Works with pip-compatible packages
- **No conflicts**: Virtual environment isolation

## Project Structure

```
learn-X/
├── .venv/                      # Virtual environment (created by setup)
├── setup-venv.sh              # Setup virtual environment with uv
├── activate-and-install.sh    # Activate venv and install all kernels
├── run-jupyter.sh             # Run Jupyter from venv
├── install-all-kernels.sh     # Install all language kernels
├── requirements.txt           # Python dependencies
├── SETUP.md                   # This file
│
├── learn-python/
│   ├── install.sh            # Install Python kernel
│   ├── run-tutorial.sh       # Run Python tutorials
│   └── README.md
│
├── learn-shell/
│   ├── install.sh            # Install Bash kernel
│   ├── run-tutorial.sh       # Run Bash tutorials
│   └── README.md
│
├── learn-rust/
│   ├── install.sh            # Install Rust kernel
│   ├── run-tutorial.sh       # Run Rust tutorials
│   └── README.md
│
├── learn-go/
│   ├── install.sh            # Install Go kernel
│   ├── run-tutorial.sh       # Run Go tutorials
│   └── README.md
│
└── learn-cpp/
    ├── install.sh            # Install C++ kernel
    ├── run-tutorial.sh       # Run C++ tutorials
    └── README.md
```

## Next Steps

1. Complete the setup with `bash setup-venv.sh && bash activate-and-install.sh`
2. Run `bash run-jupyter.sh` to start learning
3. Choose a tutorial folder and start coding!
4. Check individual tutorial README files for language-specific guides

Happy Learning! 🎓
