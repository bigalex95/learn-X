#!/bin/bash

# Build and Run Script for Advanced C++ Tutorials

echo "========================================"
echo "      ADVANCED C++ TUTORIALS"
echo "========================================"
echo ""

# List of tutorial files in order
tutorials=(
    "01-pointers.cpp"
    "02-structures.cpp"
    "03-function-arguments-by-reference.cpp"
    "04-dynamic-allocation.cpp"
    "05-recursion.cpp"
    "06-linked-lists.cpp"
    "07-binary-trees.cpp"
    "08-function-pointers.cpp"
    "09-template-metaprogramming.cpp"
)

# Get the directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

success_count=0
total_count=${#tutorials[@]}

for tutorial in "${tutorials[@]}"; do
    echo "Building and running: $tutorial"
    echo "----------------------------------------"
    
    # Compile
    if g++ -std=c++17 -Wall -Wextra -o "${tutorial%.cpp}" "$DIR/$tutorial"; then
        echo "✓ Compilation successful"
        
        # Run
        echo "Output:"
        if ./"${tutorial%.cpp}"; then
            echo "✓ Execution successful"
            ((success_count++))
        else
            echo "✗ Execution failed"
        fi
        
        # Cleanup
        rm -f "${tutorial%.cpp}"
    else
        echo "✗ Compilation failed"
    fi
    
    echo ""
    echo "========================================"
    echo ""
done

echo "Summary: $success_count/$total_count tutorials completed successfully"