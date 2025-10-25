# Python Jupyter Tutorial

This folder contains Python Jupyter Notebook tutorials for learning Python programming.

## Prerequisites

- Python 3.7 or higher
- pip package manager

## Installation

Run the installation script to set up the Python kernel:

```bash
bash install.sh
```

This will install:

- Jupyter Notebook
- IPython kernel
- Common Python libraries

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
pip install notebook ipykernel jupyter
python -m ipykernel install --user --name=python3
```

## Tutorials Included

- Python basics
- Data structures
- Functions and modules
- Object-oriented programming
- And more...

## Troubleshooting

If the kernel doesn't appear in Jupyter:

```bash
python -m ipykernel install --user --name=python3 --display-name "Python 3"
```
