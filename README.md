# Learn-X Tutorials Collection

A comprehensive collection of interactive programming tutorials and practice scripts from the learn-X.org family of websites. Each folder contains tutorial notes, code examples, and practice exercises for learning different programming languages and technologies.

## 📚 About

This repository serves as a structured learning path through various programming languages, organized by topic and difficulty. All tutorials are based on the excellent resources from the [learn-X.org](https://www.learn-x.org) network of interactive learning platforms.

## 🗂️ Available Tutorials

### Programming Languages

#### [Python](./learn-python/)

**Source:** [learnpython.org](https://www.learnpython.org)

Learn Python programming from basics to advanced topics including data structures, object-oriented programming, and Python-specific features.

- ✅ Variables and types
- ✅ Lists, dictionaries, and data structures
- ✅ Functions and modules
- ✅ Object-oriented programming
- ✅ Decorators, generators, and more

---

#### [C](./learn-c/) (In Progress...)

**Source:** [learn-c.org](https://www.learn-c.org)

Master the fundamentals of C programming, including memory management, pointers, and system-level programming.

- ✅ Basic syntax and data types
- ✅ Pointers and arrays
- ✅ Strings and structures
- ✅ Memory management
- ✅ Function pointers and dynamic allocation

---

#### [C++](./learn-cpp/) (In Progress...)

**Source:** [learn-cpp.org](https://www.learn-cpp.org)

Explore C++ programming with object-oriented concepts, templates, and modern C++ features.

- ✅ Classes and objects
- ✅ Inheritance and polymorphism
- ✅ Templates and STL
- ✅ Memory management
- ✅ Modern C++ features

---

#### [Java](./learn-java/) (In Progress...)

**Source:** [learnjavaonline.org](https://www.learnjavaonline.org)

Comprehensive Java programming tutorials covering core Java concepts and object-oriented design.

- ✅ Java basics and syntax
- ✅ Object-oriented programming
- ✅ Collections framework
- ✅ Exception handling
- ✅ Multithreading

---

#### [JavaScript](./learn-js/) (In Progress...)

**Source:** [learn-js.org](https://www.learn-js.org)

Learn JavaScript for web development, from basics to advanced concepts like closures and async programming.

- ✅ JavaScript fundamentals
- ✅ DOM manipulation
- ✅ Events and callbacks
- ✅ Promises and async/await
- ✅ ES6+ features

---

#### [PHP](./learn-php/) (In Progress...)

**Source:** [learn-php.org](https://www.learn-php.org)

Master PHP for web development and server-side scripting.

- ✅ PHP basics and syntax
- ✅ Arrays and strings
- ✅ Functions and OOP
- ✅ Form handling
- ✅ Database integration

---

#### [Ruby](./learn-ruby/) (In Progress...)

**Source:** [learnrubyonline.org](https://www.learnrubyonline.org)

Explore Ruby programming with its elegant syntax and powerful features.

- ✅ Ruby basics
- ✅ Arrays and hashes
- ✅ Blocks and iterators
- ✅ Object-oriented Ruby
- ✅ Modules and mixins

---

#### [Go](./learn-go/) (In Progress...)

**Source:** [learn-go.org](https://www.learn-go.org)

Learn Go programming language with focus on concurrency and systems programming.

- ✅ Go basics and syntax
- ✅ Functions and packages
- ✅ Goroutines and channels
- ✅ Interfaces
- ✅ Error handling

---

#### [Rust](./learn-rust/) (In Progress...)

**Source:** [learnrust.org](https://www.learnrust.org)

Dive into Rust programming with its unique ownership model and memory safety features.

- ✅ Rust basics
- ✅ Ownership and borrowing
- ✅ Structs and enums
- ✅ Error handling
- ✅ Traits and generics

---

#### [Perl](./learn-perl/) (In Progress...)

**Source:** [learn-perl.org](https://www.learn-perl.org)

Learn Perl for text processing, system administration, and web development.

- ✅ Perl basics
- ✅ Regular expressions
- ✅ Arrays and hashes
- ✅ File handling
- ✅ Modules and packages

---

### Shell Scripting

#### [Shell/Bash](./learn-shell/)

**Source:** [learnshell.org](https://www.learnshell.org)

Master shell scripting for automation and system administration tasks.

- ✅ Basic shell commands
- ✅ Variables and parameters
- ✅ Conditional statements and loops
- ✅ Functions
- ✅ File operations and text processing

---

### Web & Markup

#### [HTML](./learn-html/) (In Progress...)

**Source:** [learn-html.org](https://www.learn-html.org)

Learn HTML for creating web pages and structuring web content.

- ✅ HTML basics and structure
- ✅ Text and formatting
- ✅ Links and images
- ✅ Forms and input
- ✅ Semantic HTML5

---

### Query Languages

#### [SQL](./learn-sql/) (In Progress...)

**Source:** [learnsqlonline.org](https://www.learnsqlonline.org)

Master SQL for database queries and data manipulation.

- ✅ SELECT statements
- ✅ Filtering and sorting
- ✅ Joins and aggregations
- ✅ Subqueries
- ✅ Data modification

---

## 📁 Folder Structure

Each tutorial folder follows this structure:

```
learn-<language>/
├── README.md           # Overview and table of contents
├── basics/            # Basic concepts and syntax
├── intermediate/      # Intermediate topics
├── advanced/          # Advanced topics
├── exercises/         # Practice problems
└── projects/          # Small projects and examples
```

## 🚀 Getting Started

### Option 1: Docker (Recommended) 🐳

The easiest way to get started is using Docker. All programming languages and Jupyter kernels are pre-configured!

**Prerequisites:**

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

**Quick Start:**

```bash
# Clone the repository
git clone https://github.com/yourusername/learn-X.git
cd learn-X

# Start Jupyter Lab with all kernels
docker compose up

# Open your browser to http://localhost:8888
```

**What's Included:**

- 🐍 Python 3 + Jupyter Lab
- 🐹 Go (gophernotes kernel)
- 🦀 Rust (evcxr_jupyter kernel)
- ⚙️ C++ (xeus-cling kernel)
- 🐚 Bash (bash_kernel)
- 📦 All tutorial notebooks pre-loaded

**Docker Commands:**

```bash
# Start in background
docker compose up -d

# Stop the container
docker compose down

# Rebuild after changes
docker compose up --build

# View logs
docker compose logs -f
```

### Option 2: Local Installation

If you prefer to install everything locally:

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/learn-X.git
   cd learn-X
   ```

2. Set up the environment:

   ```bash
   # Create Python virtual environment
   ./setup-venv.sh

   # Install all Jupyter kernels
   ./install-all-kernels.sh

   # Start Jupyter
   ./run-jupyter.sh
   ```

3. Navigate to the tutorial you want to learn:

   ```bash
   cd learn-python  # or any other language
   ```

4. Follow the README in each folder for language-specific setup and instructions.

### Option 3: VS Code Dev Container / GitHub Codespaces

Open this repository in:

- **VS Code**: Click "Reopen in Container" when prompted
- **GitHub Codespaces**: Click "Code" → "Open with Codespaces"

All dependencies will be automatically configured!

## 🎯 Learning Path Recommendations

### For Complete Beginners

1. **Python** - Easy syntax, great for beginners
2. **JavaScript** - Essential for web development
3. **Shell** - Useful for automation

### For Systems Programming

1. **C** - Foundation of systems programming
2. **Rust** - Modern systems programming
3. **Go** - Concurrent systems and networking

### For Web Development

1. **HTML** - Structure of web pages
2. **JavaScript** - Client-side interactivity
3. **PHP** - Server-side scripting
4. **SQL** - Database management

## 📖 How to Use This Repository

1. **Read the tutorial notes** - Each section has detailed explanations
2. **Run the example code** - Practice with provided examples
3. **Complete exercises** - Reinforce learning with practice problems
4. **Build projects** - Apply knowledge to real-world scenarios

## 🤝 Contributing

Contributions are welcome! If you'd like to add more tutorials, improve existing content, or fix errors:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-tutorial`)
3. Commit your changes (`git commit -m 'Add new tutorial'`)
4. Push to the branch (`git push origin feature/new-tutorial`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- All tutorials are based on content from the [Interactive Tutorials](https://github.com/ronreiter/interactive-tutorials) family of websites
- Thanks to the creators and maintainers of these excellent learning platforms

## 📧 Contact

For questions or suggestions, please open an issue or contact the repository maintainer.

---

**Happy Learning! 🎓**
