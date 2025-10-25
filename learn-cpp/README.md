# C/C++ Jupyter Tutorial

This folder contains C and C++ programming tutorials using Jupyter Notebook.

## Prerequisites

- C/C++ compiler (gcc/g++)
- Python 3.7 or higher
- Conda or Mamba (recommended for xeus-cling installation)
- pip package manager

## Installation

Run the installation script to set up the C++ kernel:

```bash
bash install.sh
```

This will install:

- Jupyter Notebook
- xeus-cling (C++ kernel via conda)

**Note:** C++ kernel installation requires conda/mamba. For C programs, you can use Bash kernel to compile and run C code.

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

### C++ Kernel (xeus-cling)

Using conda:

```bash
conda install -c conda-forge xeus-cling
```

Or using mamba (faster):

```bash
mamba install -c conda-forge xeus-cling
```

### C Programs

For C programs, you can:

1. Use Bash kernel to compile and run C code
2. Write code in cells and compile with gcc

Example:

```bash
%%bash
cat > hello.c << 'EOF'
#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}
EOF
gcc hello.c -o hello
./hello
```

## Tutorials Included

- C basics
- C++ basics
- Pointers and memory management
- Object-oriented programming (C++)
- STL containers and algorithms
- And more...

## Troubleshooting

If the C++ kernel doesn't appear:

```bash
conda install -c conda-forge xeus-cling
jupyter kernelspec list
```

For C programs without a dedicated kernel, use the Bash kernel to compile and run.
