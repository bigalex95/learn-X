#!/bin/bash

# Build and Run Script for Integrated and Spiral Programming C++ Tutorials

echo "========================================"
echo "  INTEGRATED AND SPIRAL PROGRAMMING"
echo "========================================"
echo ""

# List of tutorial files in order
tutorials=(
    "01-world-hello.cpp"
    "02-generic-programming.cpp"
    "03-inheritance.cpp"
)

# Get the directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

success_count=0
total_count=${#tutorials[@]}

for tutorial in "${tutorials[@]}"; do
    echo "Building and running: $tutorial"
    echo "----------------------------------------"
    
    # Compile (note: inheritance.cpp needs math library)
    if [[ "$tutorial" == "03-inheritance.cpp" ]]; then
        compile_cmd="g++ -std=c++17 -Wall -Wextra -lm -o ${tutorial%.cpp} $DIR/$tutorial"
    else
        compile_cmd="g++ -std=c++17 -Wall -Wextra -o ${tutorial%.cpp} $DIR/$tutorial"
    fi
    
    if eval $compile_cmd; then
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