# learn-X

Personal notes and exercises while following the [learn-x.org](https://www.learn-x.org) interactive tutorials (learn-cpp, learn-go, learn-shell, ...), as Jupyter notebooks plus a Docker setup to run them. Learning repo, not maintained.

## What's inside

| Folder | Content |
|---|---|
| `learn-cpp/` | Notebooks and `.cpp` examples: basics, advanced (pointers, structs, recursion, linked lists, trees, templates), generic programming and inheritance |
| `learn-go/` | Basic notebooks |
| `learn-shell/` | Basic and advanced notebooks and notes, one exercise script |
| `learn-python/`, `learn-rust/` | Only a README and install/run scripts so far; no notes yet |

Also in the root: `Dockerfile*` and `docker-compose*.yml` (Jupyter Lab with Python, Go, Rust, C++ and Bash kernels), `.devcontainer/`, helper scripts (`setup-venv.sh`, `install-all-kernels.sh`, `run-jupyter.sh`, `docker-start.sh`), and [DOCKER.md](DOCKER.md) / [SETUP.md](SETUP.md).

## Run

With Docker:

```bash
docker compose up
# Jupyter Lab on http://localhost:8888
```

Note: the compose command starts Jupyter without a token or password, so use it only on your own machine.

Without Docker:

```bash
./setup-venv.sh
./install-all-kernels.sh
./run-jupyter.sh
```

I did not re-run these setups for this cleanup.

## Status

Unfinished: several languages are empty and the notes are incomplete. Notebook outputs are not stripped.

## Credits

The tutorial content, exercises and structure come from the learn-x.org sites ([Interactive Tutorials](https://github.com/ronreiter/interactive-tutorials) by Ron Reiter and contributors). Copies of their text remain the property of the original authors; the repo license (MIT, see `LICENSE`) covers only my own code and notes.
