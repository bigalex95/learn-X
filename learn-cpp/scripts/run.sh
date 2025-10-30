#!/bin/bash

# Quick run script for C++ tutorials
# Usage examples:
#   ./run.sh                           # Show help
#   ./run.sh list                      # List all tutorials
#   ./run.sh functions                 # Run functions tutorial (searches all categories)
#   ./run.sh basic functions           # Run functions tutorial from basic category
#   ./run.sh advanced recursion        # Run recursion tutorial from advanced category

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

show_help() {
    echo "==============================================="
    echo "     C++ Tutorial Quick Run Script"
    echo "==============================================="
    echo ""
    echo "Usage:"
    echo "  ./run.sh                           # Show this help"
    echo "  ./run.sh list                      # List all tutorials"
    echo "  ./run.sh TUTORIAL_NAME            # Run tutorial (searches all categories)"
    echo "  ./run.sh CATEGORY TUTORIAL_NAME   # Run specific tutorial from category"
    echo ""
    echo "Categories: basic, advanced, integrated"
    echo ""
    echo "Examples:"
    echo "  ./run.sh functions                 # Run 08-functions.cpp (auto-find)"
    echo "  ./run.sh recursion                 # Run 05-recursion.cpp (auto-find)"
    echo "  ./run.sh basic functions           # Run 08-functions.cpp from basic"
    echo "  ./run.sh advanced pointers         # Run 01-pointers.cpp from advanced"
    echo ""
}

# Function to find tutorial file by name pattern
find_tutorial() {
    local pattern="$1"
    local found=""
    
    # Search in all directories
    for dir in basic advanced integrated-and-spiral-programming; do
        for file in "$dir"/*"$pattern"*.cpp; do
            if [ -f "$file" ]; then
                if [ -n "$found" ]; then
                    echo "Multiple tutorials found matching '$pattern':"
                    echo "  $found"
                    echo "  $file"
                    echo ""
                    echo "Please be more specific or use category:"
                    echo "  ./run.sh $(dirname "$found") $(basename "$found")"
                    echo "  ./run.sh $(dirname "$file") $(basename "$file")"
                    return 1
                fi
                found="$file"
            fi
        done
    done
    
    if [ -n "$found" ]; then
        echo "$found"
        return 0
    else
        return 1
    fi
}

# Main logic
if [ $# -eq 0 ]; then
    show_help
elif [ "$1" = "list" ]; then
    ./build-and-run.sh list
elif [ $# -eq 1 ]; then
    # Try to find tutorial by pattern
    found_file=$(find_tutorial "$1")
    if [ $? -eq 0 ]; then
        category=$(dirname "$found_file")
        filename=$(basename "$found_file")
        print_status "Found: $found_file"
        ./build-and-run.sh "$category" "$filename"
    else
        print_error "No tutorial found matching: $1"
        echo ""
        echo "Available tutorials:"
        ./build-and-run.sh list
    fi
elif [ $# -eq 2 ]; then
    # Specific category and tutorial
    category="$1"
    pattern="$2"
    
    # Find file in specified category
    found=""
    for file in "$category"/*"$pattern"*.cpp; do
        if [ -f "$file" ]; then
            found="$(basename "$file")"
            break
        fi
    done
    
    if [ -n "$found" ]; then
        ./build-and-run.sh "$category" "$found"
    else
        print_error "No tutorial found matching '$pattern' in category '$category'"
        echo ""
        echo "Available tutorials in $category:"
        ls "$category"/*.cpp 2>/dev/null | xargs -n1 basename || echo "No .cpp files found"
    fi
else
    print_error "Too many arguments"
    show_help
fi