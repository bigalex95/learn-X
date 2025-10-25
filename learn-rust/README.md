# Rust Jupyter Tutorial

This folder contains Rust programming tutorials using Jupyter Notebook.

## Prerequisites

- Rust (rustc and cargo)
- Python 3.7 or higher
- pip package manager

## Installation

Run the installation script to set up the Rust kernel:

```bash
bash install.sh
```

This will install:

- Jupyter Notebook
- evcxr_jupyter (Rust kernel)

## Running the Tutorial

Launch the Jupyter Notebook server:

```bash
bash run-tutorial.sh
```

Or manually:

```bash
jupyter notebook
```

## Manual Installation

If you prefer manual installation:

```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install evcxr_jupyter
cargo install evcxr_jupyter
evcxr_jupyter --install
```

## Tutorials Included

- Rust basics
- Ownership and borrowing
- Structs and enums
- Error handling
- Traits and generics
- And more...

## Troubleshooting

If the Rust kernel doesn't appear in Jupyter:

```bash
evcxr_jupyter --install
jupyter kernelspec list
```

If cargo is not found, restart your terminal or run:

```bash
source $HOME/.cargo/env
```
