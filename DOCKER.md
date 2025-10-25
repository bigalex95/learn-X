# Docker Setup Options

This directory contains multiple Dockerfile options for different use cases.

## Available Dockerfiles

### 1. `Dockerfile` (Default - With C++)

**Recommended for: Full experience with all kernels**

```bash
docker compose up
```

**Includes:**

- 🐍 Python 3
- 🐹 Go
- 🦀 Rust
- ⚙️ C++ (xeus-cling)
- 🐚 Bash

**Notes:**

- Build time: ~15-20 minutes
- Image size: ~3-4 GB
- C++ kernel via conda (can be slow)

---

### 2. `Dockerfile.minimal` (Fast Build - No C++)

**Recommended for: Quick start, if you don't need C++**

```bash
docker compose -f docker-compose.minimal.yml up
```

**Includes:**

- 🐍 Python 3
- 🐹 Go
- 🦀 Rust
- 🐚 Bash

**Notes:**

- Build time: ~5-10 minutes
- Image size: ~2 GB
- No C++ kernel (learn-cpp notebooks won't work)

---

### 3. `Dockerfile.ubuntu` (Full Control)

**Recommended for: Advanced users who want Ubuntu base**

```bash
docker build -f Dockerfile.ubuntu -t learn-x:ubuntu .
docker run -p 8888:8888 -v $(pwd):/home/learner/work learn-x:ubuntu
```

**Includes:**

- 🐍 Python 3
- 🐹 Go
- 🦀 Rust
- 🐚 Bash
- ⚙️ C++ (experimental)

**Notes:**

- Build time: ~20-25 minutes
- Image size: ~2.5 GB
- More control over system packages
- C++ kernel may need manual configuration

---

## Quick Comparison

| Feature    | Default               | Minimal               | Ubuntu            |
| ---------- | --------------------- | --------------------- | ----------------- |
| Base Image | jupyter/base-notebook | jupyter/base-notebook | ubuntu:22.04      |
| Build Time | ~15-20 min            | ~5-10 min             | ~20-25 min        |
| Image Size | ~3-4 GB               | ~2 GB                 | ~2.5 GB           |
| Python     | ✅                    | ✅                    | ✅                |
| Go         | ✅                    | ✅                    | ✅                |
| Rust       | ✅                    | ✅                    | ✅                |
| Bash       | ✅                    | ✅                    | ✅                |
| C++        | ✅ (conda)            | ❌                    | ⚠️ (experimental) |

---

## Recommendation

**For most users:**

1. Try `Dockerfile.minimal` first (faster, works well)
2. If you need C++, use default `Dockerfile`
3. Only use `Dockerfile.ubuntu` if you need Ubuntu-specific packages

---

## Building Manually

```bash
# Default (with C++)
docker build -t learn-x:latest .

# Minimal (no C++)
docker build -f Dockerfile.minimal -t learn-x:minimal .

# Ubuntu-based
docker build -f Dockerfile.ubuntu -t learn-x:ubuntu .
```

## Running Manually

```bash
docker run -it --rm \
  -p 8888:8888 \
  -v $(pwd)/learn-python:/home/jovyan/work/learn-python \
  -v $(pwd)/learn-go:/home/jovyan/work/learn-go \
  -v $(pwd)/learn-rust:/home/jovyan/work/learn-rust \
  -v $(pwd)/learn-shell:/home/jovyan/work/learn-shell \
  learn-x:latest
```
