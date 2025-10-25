# Bash Jupyter Tutorial

This folder contains Bash/Shell scripting tutorials using Jupyter Notebook.

## Prerequisites

- Python 3.7 or higher
- Bash shell
- pip package manager

## Installation

Run the installation script to set up the Bash kernel:

```bash
bash install.sh
```

This will install:

- Jupyter Notebook
- Bash kernel for Jupyter

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
pip install notebook bash_kernel
python -m bash_kernel.install
```

## Tutorials Included

- Shell basics
- Variables and operators
- Control structures
- Functions
- File operations
- And more...

## Troubleshooting

If the Bash kernel doesn't appear in Jupyter:

```bash
python -m bash_kernel.install --user
jupyter kernelspec list
```
