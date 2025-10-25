# Multi-stage build for learn-X: Interactive Programming Tutorials
FROM jupyter/base-notebook:latest AS base

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    pkg-config \
    libzmq3-dev \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# ============================================
# Python Kernel (already included in base image)
# ============================================
RUN pip install --no-cache-dir \
    ipykernel \
    numpy \
    pandas \
    matplotlib

# ============================================
# Go Kernel
# ============================================
USER root
RUN wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz && \
    rm go1.21.5.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/home/${NB_USER}/go"
ENV PATH="${GOPATH}/bin:${PATH}"

USER ${NB_UID}
RUN mkdir -p ${GOPATH} && \
    go install github.com/gopherdata/gophernotes@latest && \
    mkdir -p ~/.local/share/jupyter/kernels/gophernotes && \
    cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@*/kernel/* \
    ~/.local/share/jupyter/kernels/gophernotes/

# ============================================
# Rust Kernel
# ============================================
USER ${NB_UID}
# Install Rust as the jovyan user (not root)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/home/${NB_USER}/.cargo/bin:${PATH}"

# Install evcxr_jupyter kernel
RUN cargo install evcxr_jupyter && \
    evcxr_jupyter --install

# ============================================
# Bash Kernel
# ============================================
RUN pip install --no-cache-dir bash_kernel && \
    python -m bash_kernel.install

# ============================================
# C++ Kernel (Optional - xeus-cling via conda-forge)
# Note: This can take a while to install
# ============================================
USER root

# Install xeus-cling using conda (in base environment)
# This is the most reliable way for Jupyter base-notebook
RUN conda install -c conda-forge xeus-cling -y && \
    conda clean --all -f -y

USER ${NB_UID}

# ============================================
# Setup Jupyter Lab
# ============================================
USER ${NB_UID}

# Install JupyterLab extensions
RUN pip install --no-cache-dir \
    jupyterlab \
    jupyter-collaboration \
    jupyterlab-git

# Set working directory
WORKDIR /home/${NB_USER}/work

# Expose Jupyter port
EXPOSE 8888

# Default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
