#!/bin/bash

# Build and Run Script for Basic C++ Tutorials

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

compile_and_run() {
    local cpp_file="$1"
    local basename_file="$(basename "$cpp_file")"
    local executable="${basename_file%.cpp}"
    
    echo "Building and running: $basename_file"
    echo "----------------------------------------"
    
    if g++ -std=c++17 -Wall -Wextra -o "$executable" "$cpp_file"; then
        echo "✓ Compilation successful"
        echo "Output:"
        if ./"$executable"; then
            echo "✓ Execution successful"
        else
            print_error "Execution failed"
            return 1
        fi
        rm -f "$executable"
    else
        print_error "Compilation failed"
        return 1
    fi
    echo ""
}

if [ -n "$1" ]; then
    # Run specific file
    if [ -f "$1" ]; then
        compile_and_run "$1"
    else
        print_error "File not found: $1"
        echo ""
        echo "Available files:"
        ls *.cpp 2>/dev/null || echo "No .cpp files found"
    fi
else
    # Run all files
    echo "========================================"
    echo "       BASIC C++ TUTORIALS"
    echo "========================================"
    echo ""

    # List of tutorial files in order
    tutorials=(
        "01-hello-world.cpp"
        "02-variables-and-types.cpp"
        "03-arrays.cpp"
        "04-strings.cpp"
        "05-if-else.cpp"
        "06-for-loops.cpp"
        "07-while-loops.cpp"
        "08-functions.cpp"
    )

    # Get the directory of this script
    DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    success_count=0
    total_count=${#tutorials[@]}

    for tutorial in "${tutorials[@]}"; do
        compile_and_run "$DIR/$tutorial"
        if [ $? -eq 0 ]; then
            ((success_count++))
        fi
        echo "========================================"
        echo ""
    done

    echo "Summary: $success_count/$total_count tutorials completed successfully"
fi