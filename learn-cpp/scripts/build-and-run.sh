#!/bin/bash

# Build and Run Script for C++ Learn Tutorials
# This script compiles and runs all C++ tutorial files

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to compile and run a C++ file
compile_and_run() {
    local cpp_file="$1"
    local executable="${cpp_file%.cpp}"
    
    print_status "Compiling $cpp_file..."
    
    # Compile with g++
    if g++ -std=c++17 -Wall -Wextra -o "$executable" "$cpp_file"; then
        print_success "Compilation successful for $cpp_file"
        
        print_status "Running $executable..."
        echo "========================================"
        if "$executable"; then
            print_success "Execution completed for $executable"
        else
            print_error "Execution failed for $executable"
            return 1
        fi
        echo "========================================"
        
        # Clean up executable
        rm -f "$executable"
        
    else
        print_error "Compilation failed for $cpp_file"
        return 1
    fi
    
    echo ""
}

# Function to process all files in a directory
process_directory() {
    local dir="$1"
    local title="$2"
    
    echo ""
    echo "========================================"
    echo "          $title"
    echo "========================================"
    echo ""
    
    if [ ! -d "$dir" ]; then
        print_warning "Directory $dir does not exist"
        return 0
    fi
    
    # Find all .cpp files and sort them
    local cpp_files=($(find "$dir" -name "*.cpp" -type f | sort))
    
    if [ ${#cpp_files[@]} -eq 0 ]; then
        print_warning "No .cpp files found in $dir"
        return 0
    fi
    
    local success_count=0
    local total_count=${#cpp_files[@]}
    
    for cpp_file in "${cpp_files[@]}"; do
        echo "Processing: $(basename "$cpp_file")"
        if compile_and_run "$cpp_file"; then
            ((success_count++))
        fi
        echo "----------------------------------------"
    done
    
    echo ""
    print_status "Summary for $title: $success_count/$total_count files processed successfully"
}

# Main execution
main() {
    echo "========================================"
    echo "     C++ Tutorial Build and Run Script"
    echo "========================================"
    echo ""
    
    # Check if g++ is available
    if ! command -v g++ &> /dev/null; then
        print_error "g++ compiler not found. Please install g++."
        exit 1
    fi
    
    print_status "Using compiler: $(g++ --version | head -n1)"
    echo ""
    
    # Get the script directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Process each tutorial category
    process_directory "$SCRIPT_DIR/basic" "BASIC TUTORIALS"
    process_directory "$SCRIPT_DIR/advanced" "ADVANCED TUTORIALS"
    process_directory "$SCRIPT_DIR/integrated-and-spiral-programming" "INTEGRATED AND SPIRAL PROGRAMMING"
    
    echo ""
    echo "========================================"
    echo "     All tutorials processed!"
    echo "========================================"
}

# Function to run a specific tutorial file
run_specific_file() {
    local category="$1"
    local filename="$2"
    local script_dir="$(dirname "$0")"
    local full_path="$script_dir/$category/$filename"
    
    if [ ! -f "$full_path" ]; then
        print_error "File not found: $full_path"
        echo ""
        echo "Available files in $category:"
        ls "$script_dir/$category"/*.cpp 2>/dev/null | xargs -n1 basename || echo "No .cpp files found"
        return 1
    fi
    
    echo "========================================"
    echo "     Running specific tutorial: $filename"
    echo "========================================"
    echo ""
    
    compile_and_run "$full_path"
}

# Function to list available tutorials
list_tutorials() {
    local script_dir="$(dirname "$0")"
    
    echo "========================================"
    echo "     Available C++ Tutorials"
    echo "========================================"
    echo ""
    
    echo "BASIC TUTORIALS:"
    for file in "$script_dir/basic"/*.cpp; do
        [ -f "$file" ] && echo "  $(basename "$file")"
    done
    echo ""
    
    echo "ADVANCED TUTORIALS:"
    for file in "$script_dir/advanced"/*.cpp; do
        [ -f "$file" ] && echo "  $(basename "$file")"
    done
    echo ""
    
    echo "INTEGRATED AND SPIRAL PROGRAMMING:"
    for file in "$script_dir/integrated-and-spiral-programming"/*.cpp; do
        [ -f "$file" ] && echo "  $(basename "$file")"
    done
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTION] [FILE]"
    echo ""
    echo "Options:"
    echo "  basic                    - Run all basic tutorials"
    echo "  advanced                 - Run all advanced tutorials"
    echo "  integrated               - Run all integrated programming tutorials"
    echo "  basic FILENAME.cpp       - Run specific basic tutorial"
    echo "  advanced FILENAME.cpp    - Run specific advanced tutorial"
    echo "  integrated FILENAME.cpp  - Run specific integrated tutorial"
    echo "  list                     - List all available tutorials"
    echo "  help                     - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                              # Run all tutorials"
    echo "  $0 basic                        # Run all basic tutorials"
    echo "  $0 basic 08-functions.cpp       # Run only the functions tutorial"
    echo "  $0 advanced 05-recursion.cpp    # Run only the recursion tutorial"
    echo "  $0 list                         # Show all available tutorials"
}

# Handle command line arguments
case "$1" in
    "basic")
        if [ -n "$2" ]; then
            run_specific_file "basic" "$2"
        else
            process_directory "$(dirname "$0")/basic" "BASIC TUTORIALS"
        fi
        ;;
    "advanced")
        if [ -n "$2" ]; then
            run_specific_file "advanced" "$2"
        else
            process_directory "$(dirname "$0")/advanced" "ADVANCED TUTORIALS"
        fi
        ;;
    "integrated")
        if [ -n "$2" ]; then
            run_specific_file "integrated-and-spiral-programming" "$2"
        else
            process_directory "$(dirname "$0")/integrated-and-spiral-programming" "INTEGRATED AND SPIRAL PROGRAMMING"
        fi
        ;;
    "list")
        list_tutorials
        ;;
    "help"|"-h"|"--help")
        show_usage
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        echo ""
        show_usage
        ;;
esac