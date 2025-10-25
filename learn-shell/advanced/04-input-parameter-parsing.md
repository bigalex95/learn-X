# Input Parameter Parsing

---

This tutorial covers various methods for parsing command-line arguments and handling user input in shell scripts, from basic parameter handling to advanced option parsing with validation.

## Basic Parameter Handling

### Positional Parameters

```bash
#!/bin/bash
# demo_params.sh - Basic parameter demonstration

echo "Script name: $0"
echo "First parameter: $1"
echo "Second parameter: $2"
echo "Third parameter: $3"
echo "Number of parameters: $#"
echo "All parameters: $@"
echo "All parameters as single string: $*"
echo "Last parameter: ${!#}"

# Example usage:
# ./demo_params.sh hello world 123
```

### Parameter Validation

```bash
#!/bin/bash
# validate_params.sh - Basic parameter validation

# Check if minimum number of parameters provided
if [ $# -lt 2 ]; then
    echo "Error: Insufficient parameters"
    echo "Usage: $0 <name> <age> [email]"
    exit 1
fi

name="$1"
age="$2"
email="${3:-not-provided}"

# Validate age is numeric
if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "Error: Age must be a number"
    exit 1
fi

# Validate age range
if [ "$age" -lt 0 ] || [ "$age" -gt 150 ]; then
    echo "Error: Age must be between 0 and 150"
    exit 1
fi

echo "Name: $name"
echo "Age: $age"
echo "Email: $email"
```

### Shifting Parameters

```bash
#!/bin/bash
# shift_demo.sh - Demonstrate parameter shifting

echo "Processing all parameters:"
while [ $# -gt 0 ]; do
    echo "Processing: $1"
    shift  # Move to next parameter
done

echo "All parameters processed"

# Alternative with counter
counter=1
for param in "$@"; do
    echo "Parameter $counter: $param"
    ((counter++))
done
```

## getopts - Standard Option Parsing

### Basic getopts Usage

```bash
#!/bin/bash
# getopts_basic.sh - Basic getopts demonstration

# Initialize variables
verbose=false
output=""
help=false

# Parse options
while getopts "vo:h" opt; do
    case $opt in
        v)
            verbose=true
            ;;
        o)
            output="$OPTARG"
            ;;
        h)
            help=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument" >&2
            exit 1
            ;;
    esac
done

# Shift processed options
shift $((OPTIND-1))

# Show help if requested
if [ "$help" = true ]; then
    echo "Usage: $0 [-v] [-o output_file] [-h] [files...]"
    echo "  -v: Verbose mode"
    echo "  -o: Output file"
    echo "  -h: Show this help"
    exit 0
fi

# Process remaining arguments
if [ "$verbose" = true ]; then
    echo "Verbose mode enabled"
    [ -n "$output" ] && echo "Output file: $output"
    echo "Remaining arguments: $@"
fi

# Example usage:
# ./getopts_basic.sh -v -o result.txt file1.txt file2.txt
# ./getopts_basic.sh -vo result.txt file1.txt
# ./getopts_basic.sh -h
```

### Advanced getopts with Validation

```bash
#!/bin/bash
# file_processor.sh - File processing with options

# Default values
mode="copy"
destination=""
recursive=false
force=false
verbose=false

usage() {
    cat << EOF
Usage: $0 [OPTIONS] source [source2...] destination

File processing utility

OPTIONS:
    -m MODE     Processing mode: copy, move, link (default: copy)
    -d DEST     Destination directory
    -r          Recursive processing
    -f          Force overwrite
    -v          Verbose output
    -h          Show this help

EXAMPLES:
    $0 -m copy -d /backup file1.txt file2.txt
    $0 -rvf -d /target directory/
    $0 -m link -d /shortcuts *.txt
EOF
}

# Parse options
while getopts "m:d:rfvh" opt; do
    case $opt in
        m)
            mode="$OPTARG"
            # Validate mode
            if [[ ! "$mode" =~ ^(copy|move|link)$ ]]; then
                echo "Error: Invalid mode '$mode'. Must be copy, move, or link." >&2
                exit 1
            fi
            ;;
        d)
            destination="$OPTARG"
            ;;
        r)
            recursive=true
            ;;
        f)
            force=true
            ;;
        v)
            verbose=true
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG" >&2
            usage >&2
            exit 1
            ;;
        :)
            echo "Error: Option -$OPTARG requires an argument" >&2
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

# Validation
if [ $# -eq 0 ]; then
    echo "Error: No source files specified" >&2
    usage >&2
    exit 1
fi

if [ -z "$destination" ]; then
    echo "Error: Destination directory required (-d option)" >&2
    exit 1
fi

if [ ! -d "$destination" ]; then
    echo "Error: Destination '$destination' is not a directory" >&2
    exit 1
fi

# Process files
log() {
    [ "$verbose" = true ] && echo "$@"
}

process_file() {
    local source="$1"
    local dest="$2"
    
    if [ ! -e "$source" ]; then
        echo "Warning: '$source' does not exist" >&2
        return 1
    fi
    
    local target="$dest/$(basename "$source")"
    
    # Check for overwrite
    if [ -e "$target" ] && [ "$force" = false ]; then
        echo "Error: '$target' exists. Use -f to force overwrite." >&2
        return 1
    fi
    
    case "$mode" in
        copy)
            if [ -d "$source" ] && [ "$recursive" = true ]; then
                log "Copying directory '$source' to '$target'"
                cp -r "$source" "$target"
            else
                log "Copying file '$source' to '$target'"
                cp "$source" "$target"
            fi
            ;;
        move)
            log "Moving '$source' to '$target'"
            mv "$source" "$target"
            ;;
        link)
            log "Creating link '$target' -> '$source'"
            ln -s "$(realpath "$source")" "$target"
            ;;
    esac
}

# Process all source files
for source in "$@"; do
    process_file "$source" "$destination"
done

log "Processing complete"
```

## Long Options (GNU-style)

### Manual Long Option Parsing

```bash
#!/bin/bash
# long_options.sh - Manual long option parsing

# Default values
config_file=""
log_level="info"
dry_run=false
help=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --config=*)
            config_file="${1#*=}"
            shift
            ;;
        --config)
            config_file="$2"
            shift 2
            ;;
        --log-level=*)
            log_level="${1#*=}"
            shift
            ;;
        --log-level)
            log_level="$2"
            shift 2
            ;;
        --dry-run)
            dry_run=true
            shift
            ;;
        --help|-h)
            help=true
            shift
            ;;
        --*)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
        *)
            # Positional argument
            break
            ;;
    esac
done

if [ "$help" = true ]; then
    cat << EOF
Usage: $0 [OPTIONS] [arguments...]

OPTIONS:
    --config=FILE         Configuration file
    --config FILE         Configuration file (alternative syntax)
    --log-level=LEVEL     Logging level (debug, info, warn, error)
    --log-level LEVEL     Logging level (alternative syntax)
    --dry-run             Don't actually perform actions
    --help, -h            Show this help

EXAMPLES:
    $0 --config=myapp.conf --log-level=debug
    $0 --config myapp.conf --dry-run
EOF
    exit 0
fi

# Validate log level
if [[ ! "$log_level" =~ ^(debug|info|warn|error)$ ]]; then
    echo "Error: Invalid log level '$log_level'" >&2
    exit 1
fi

echo "Configuration:"
echo "  Config file: ${config_file:-none}"
echo "  Log level: $log_level"
echo "  Dry run: $dry_run"
echo "  Remaining arguments: $@"
```

### Using getopt for Long Options

```bash
#!/bin/bash
# getopt_long.sh - Using getopt for long options (GNU getopt required)

# Check if GNU getopt is available
if ! getopt --version >/dev/null 2>&1; then
    echo "Error: GNU getopt is required for long options" >&2
    exit 1
fi

# Default values
input_file=""
output_file=""
format="text"
compress=false
verbose=false

# Parse options using getopt
TEMP=$(getopt -o 'i:o:f:cvh' --long 'input:,output:,format:,compress,verbose,help' -n "$0" -- "$@")

if [ $? != 0 ]; then
    echo "Error parsing options" >&2
    exit 1
fi

eval set -- "$TEMP"

while true; do
    case "$1" in
        -i|--input)
            input_file="$2"
            shift 2
            ;;
        -o|--output)
            output_file="$2"
            shift 2
            ;;
        -f|--format)
            format="$2"
            shift 2
            ;;
        -c|--compress)
            compress=true
            shift
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        -h|--help)
            cat << EOF
Usage: $0 [OPTIONS]

Process files with various options

OPTIONS:
    -i, --input FILE      Input file
    -o, --output FILE     Output file
    -f, --format FORMAT   Output format (text, json, xml)
    -c, --compress        Compress output
    -v, --verbose         Verbose mode
    -h, --help            Show this help

EXAMPLES:
    $0 --input data.txt --output result.json --format json
    $0 -i data.txt -o result.txt.gz --compress --verbose
EOF
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!" >&2
            exit 1
            ;;
    esac
done

# Validate format
if [[ ! "$format" =~ ^(text|json|xml)$ ]]; then
    echo "Error: Invalid format '$format'" >&2
    exit 1
fi

# Validate input file
if [ -n "$input_file" ] && [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found" >&2
    exit 1
fi

echo "Processing with options:"
echo "  Input: ${input_file:-stdin}"
echo "  Output: ${output_file:-stdout}"
echo "  Format: $format"
echo "  Compress: $compress"
echo "  Verbose: $verbose"

# Process remaining positional arguments
if [ $# -gt 0 ]; then
    echo "  Additional arguments: $@"
fi
```

## Interactive Input

### Basic User Input

```bash
#!/bin/bash
# interactive_input.sh - Various input methods

# Simple input
echo -n "Enter your name: "
read name
echo "Hello, $name!"

# Input with prompt
read -p "Enter your age: " age

# Silent input (for passwords)
read -s -p "Enter password: " password
echo  # New line after silent input
echo "Password length: ${#password}"

# Input with timeout
echo "Quick! Enter something within 5 seconds:"
if read -t 5 response; then
    echo "You entered: $response"
else
    echo "Timeout! No input received."
fi

# Input with default value
read -p "Enter country [USA]: " country
country=${country:-USA}
echo "Country: $country"
```

### Advanced Input Validation

```bash
#!/bin/bash
# input_validation.sh - Input validation functions

# Validate email address
validate_email() {
    local email="$1"
    local email_regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if [[ "$email" =~ $email_regex ]]; then
        return 0
    else
        return 1
    fi
}

# Validate phone number
validate_phone() {
    local phone="$1"
    # Remove all non-digits
    local digits_only="${phone//[^0-9]/}"
    
    # Check if it has 10 digits
    if [ ${#digits_only} -eq 10 ]; then
        return 0
    else
        return 1
    fi
}

# Get validated input
get_validated_input() {
    local prompt="$1"
    local validator="$2"
    local error_msg="$3"
    local input
    
    while true; do
        read -p "$prompt" input
        
        if [ -z "$input" ]; then
            echo "Error: Input cannot be empty"
            continue
        fi
        
        if $validator "$input"; then
            echo "$input"
            return 0
        else
            echo "Error: $error_msg"
        fi
    done
}

# Menu selection
show_menu() {
    echo "Please select an option:"
    echo "1) Create new user"
    echo "2) Update existing user"
    echo "3) Delete user"
    echo "4) List all users"
    echo "5) Exit"
    echo
}

get_menu_choice() {
    local choice
    while true; do
        show_menu
        read -p "Enter your choice (1-5): " choice
        
        case $choice in
            [1-5])
                echo "$choice"
                return 0
                ;;
            *)
                echo "Error: Please enter a number between 1 and 5"
                echo
                ;;
        esac
    done
}

# Confirmation prompt
confirm() {
    local prompt="$1"
    local response
    
    while true; do
        read -p "$prompt (y/n): " response
        case $response in
            [Yy]*)
                return 0
                ;;
            [Nn]*)
                return 1
                ;;
            *)
                echo "Please answer y or n"
                ;;
        esac
    done
}

# Usage examples
echo "=== Input Validation Demo ==="

# Get validated email
email=$(get_validated_input "Enter email address: " validate_email "Invalid email format")
echo "Valid email: $email"

# Get validated phone
phone=$(get_validated_input "Enter phone number: " validate_phone "Phone must be 10 digits")
echo "Valid phone: $phone"

# Menu selection
choice=$(get_menu_choice)
echo "You selected option: $choice"

# Confirmation
if confirm "Do you want to save this information?"; then
    echo "Information saved!"
else
    echo "Information discarded."
fi
```

### Reading from Files and Pipes

```bash
#!/bin/bash
# file_input.sh - Reading from various sources

# Read from file line by line
read_file_lines() {
    local file="$1"
    local line_number=1
    
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' not found" >&2
        return 1
    fi
    
    while IFS= read -r line; do
        echo "Line $line_number: $line"
        ((line_number++))
    done < "$file"
}

# Read from stdin with pipe detection
read_stdin() {
    if [ -t 0 ]; then
        echo "Reading from terminal (type 'exit' to stop):"
        while true; do
            read -p "> " input
            [ "$input" = "exit" ] && break
            echo "You entered: $input"
        done
    else
        echo "Reading from pipe/redirection:"
        while IFS= read -r line; do
            echo "Processed: $line"
        done
    fi
}

# Process CSV input
process_csv() {
    local line_number=0
    local IFS=','
    
    echo "Processing CSV data:"
    while read -r field1 field2 field3; do
        ((line_number++))
        
        # Skip header
        if [ $line_number -eq 1 ]; then
            echo "Header: $field1 | $field2 | $field3"
            continue
        fi
        
        echo "Record $((line_number-1)): Name=$field1, Age=$field2, City=$field3"
    done
}

# Example usage
echo "=== File Input Demo ==="

# Create sample files
cat << 'EOF' > sample.txt
Hello World
This is line 2
Final line
EOF

cat << 'EOF' > sample.csv
Name,Age,City
John,30,New York
Jane,25,Boston
Bob,35,Chicago
EOF

echo "Reading text file:"
read_file_lines sample.txt

echo
echo "Processing CSV file:"
process_csv < sample.csv

echo
echo "Testing stdin (try: echo 'test' | ./script.sh):"
read_stdin

# Cleanup
rm sample.txt sample.csv
```

## Configuration File Parsing

### Simple Configuration Parser

```bash
#!/bin/bash
# config_parser.sh - Parse configuration files

# Default configuration
declare -A config=(
    ["database_host"]="localhost"
    ["database_port"]="5432"
    ["database_name"]="myapp"
    ["log_level"]="info"
    ["max_connections"]="100"
    ["debug"]="false"
)

# Parse configuration file
parse_config() {
    local config_file="$1"
    
    if [ ! -f "$config_file" ]; then
        echo "Warning: Config file '$config_file' not found. Using defaults." >&2
        return 1
    fi
    
    local line_number=0
    while IFS= read -r line || [ -n "$line" ]; do
        ((line_number++))
        
        # Skip empty lines and comments
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        
        # Parse key=value pairs
        if [[ "$line" =~ ^[[:space:]]*([a-zA-Z_][a-zA-Z0-9_]*)[[:space:]]*=[[:space:]]*(.*)[[:space:]]*$ ]]; then
            local key="${BASH_REMATCH[1]}"
            local value="${BASH_REMATCH[2]}"
            
            # Remove quotes if present
            if [[ "$value" =~ ^[\"\'](.*)[\"\']*$ ]]; then
                value="${BASH_REMATCH[1]}"
            fi
            
            config["$key"]="$value"
            echo "Loaded: $key = $value"
        else
            echo "Warning: Invalid syntax on line $line_number: $line" >&2
        fi
    done < "$config_file"
}

# Validate configuration
validate_config() {
    local errors=0
    
    # Validate database port
    if ! [[ "${config[database_port]}" =~ ^[0-9]+$ ]]; then
        echo "Error: database_port must be numeric" >&2
        ((errors++))
    fi
    
    # Validate max_connections
    if ! [[ "${config[max_connections]}" =~ ^[0-9]+$ ]] || [ "${config[max_connections]}" -le 0 ]; then
        echo "Error: max_connections must be a positive number" >&2
        ((errors++))
    fi
    
    # Validate log_level
    if [[ ! "${config[log_level]}" =~ ^(debug|info|warn|error)$ ]]; then
        echo "Error: log_level must be debug, info, warn, or error" >&2
        ((errors++))
    fi
    
    # Validate debug flag
    if [[ ! "${config[debug]}" =~ ^(true|false)$ ]]; then
        echo "Error: debug must be true or false" >&2
        ((errors++))
    fi
    
    return $errors
}

# Print configuration
print_config() {
    echo "Current configuration:"
    for key in "${!config[@]}"; do
        printf "  %-20s = %s\n" "$key" "${config[$key]}"
    done
}

# Create sample configuration file
create_sample_config() {
    cat << 'EOF' > app.conf
# Application Configuration File
# Lines starting with # are comments

database_host = localhost
database_port = 5432
database_name = "production_db"

# Logging configuration
log_level = debug
debug = true

# Connection settings
max_connections = 50

# This line has invalid syntax - no equals sign
invalid line

# Empty value
empty_setting =
EOF
    echo "Created sample configuration file: app.conf"
}

# Main execution
if [ ! -f "app.conf" ]; then
    create_sample_config
fi

echo "=== Configuration Parser Demo ==="
echo

echo "Parsing configuration file..."
parse_config "app.conf"
echo

echo "Validating configuration..."
if validate_config; then
    echo "Configuration is valid!"
else
    echo "Configuration has errors!"
fi
echo

print_config

# Cleanup
rm -f app.conf
```

### Advanced Configuration with Sections

```bash
#!/bin/bash
# advanced_config.sh - Parse INI-style configuration

declare -A config
current_section=""

# Parse INI-style configuration
parse_ini_config() {
    local config_file="$1"
    local line_number=0
    
    while IFS= read -r line || [ -n "$line" ]; do
        ((line_number++))
        
        # Remove leading/trailing whitespace
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"
        
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[#;] ]] && continue
        
        # Parse section headers [section]
        if [[ "$line" =~ ^\[([^\]]+)\]$ ]]; then
            current_section="${BASH_REMATCH[1]}"
            echo "Found section: [$current_section]"
            continue
        fi
        
        # Parse key=value pairs
        if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
            local key="${BASH_REMATCH[1]}"
            local value="${BASH_REMATCH[2]}"
            
            # Remove whitespace from key and value
            key="${key#"${key%%[![:space:]]*}"}"
            key="${key%"${key##*[![:space:]]}"}"
            value="${value#"${value%%[![:space:]]*}"}"
            value="${value%"${value##*[![:space:]]}"}"
            
            # Remove quotes from value
            if [[ "$value" =~ ^[\"\'](.*)[\"\']*$ ]]; then
                value="${BASH_REMATCH[1]}"
            fi
            
            # Store with section prefix
            local full_key="${current_section:+${current_section}.}${key}"
            config["$full_key"]="$value"
            echo "  $full_key = $value"
        else
            echo "Warning: Invalid syntax on line $line_number: $line" >&2
        fi
    done < "$config_file"
}

# Get configuration value with default
get_config() {
    local key="$1"
    local default_value="$2"
    echo "${config[$key]:-$default_value}"
}

# Create sample INI file
create_sample_ini() {
    cat << 'EOF' > config.ini
# Global settings
global_setting = "Global Value"
debug = true

[database]
host = localhost
port = 5432
name = myapp
user = dbuser
password = "secret123"

[logging]
level = info
file = "/var/log/app.log"
max_size = 10MB
rotate = true

[features]
enable_cache = true
cache_timeout = 3600
enable_ssl = false

[notifications]
email_server = smtp.example.com
email_port = 587
email_user = "notify@example.com"
email_password = "email_secret"
EOF
    echo "Created sample INI file: config.ini"
}

# Print configuration by sections
print_config_by_sections() {
    local current_section=""
    
    echo "Configuration by sections:"
    echo
    
    # Print global settings first
    echo "[GLOBAL]"
    for key in "${!config[@]}"; do
        if [[ ! "$key" =~ \. ]]; then
            printf "  %-20s = %s\n" "$key" "${config[$key]}"
        fi
    done
    echo
    
    # Get all sections
    local sections=()
    for key in "${!config[@]}"; do
        if [[ "$key" =~ ^([^.]+)\. ]]; then
            local section="${BASH_REMATCH[1]}"
            if [[ ! " ${sections[@]} " =~ " ${section} " ]]; then
                sections+=("$section")
            fi
        fi
    done
    
    # Sort sections
    IFS=$'\n' sections=($(sort <<<"${sections[*]}"))
    
    # Print each section
    for section in "${sections[@]}"; do
        echo "[$section]"
        for key in "${!config[@]}"; do
            if [[ "$key" =~ ^${section}\.(.+)$ ]]; then
                local setting="${BASH_REMATCH[1]}"
                printf "  %-20s = %s\n" "$setting" "${config[$key]}"
            fi
        done
        echo
    done
}

# Main execution
if [ ! -f "config.ini" ]; then
    create_sample_ini
fi

echo "=== Advanced Configuration Parser Demo ==="
echo

echo "Parsing INI configuration file..."
parse_ini_config "config.ini"
echo

print_config_by_sections

echo "Testing configuration access:"
echo "Database host: $(get_config "database.host" "default_host")"
echo "Database port: $(get_config "database.port" "3306")"
echo "Log level: $(get_config "logging.level" "warn")"
echo "Unknown setting: $(get_config "unknown.setting" "default_value")"

# Cleanup
rm -f config.ini
```

## Real-world Example

Here's a comprehensive script that demonstrates multiple parameter parsing techniques:

```bash
#!/bin/bash
# backup_tool.sh - Comprehensive backup utility

# Default configuration
declare -A config=(
    ["source"]=""
    ["destination"]=""
    ["compression"]="gzip"
    ["exclude_patterns"]=""
    ["log_file"]="/var/log/backup.log"
    ["dry_run"]="false"
    ["verbose"]="false"
    ["config_file"]=""
    ["email_notify"]=""
    ["retention_days"]="30"
)

# Usage information
usage() {
    cat << EOF
BACKUP UTILITY v1.0

USAGE:
    $0 [OPTIONS] [source] [destination]

DESCRIPTION:
    Advanced backup utility with multiple configuration options

OPTIONS:
    -s, --source DIR          Source directory to backup
    -d, --destination DIR     Destination directory
    -c, --compression TYPE    Compression: gzip, bzip2, xz, none (default: gzip)
    -e, --exclude PATTERNS    Exclude patterns (comma-separated)
    -l, --log-file FILE       Log file location (default: /var/log/backup.log)
    -f, --config FILE         Configuration file
    -n, --dry-run             Show what would be done without executing
    -v, --verbose             Verbose output
    -r, --retention DAYS      Retention period in days (default: 30)
        --email EMAIL         Email notification address
        --help                Show this help
        --version             Show version information

CONFIGURATION FILE FORMAT:
    source=/path/to/source
    destination=/path/to/destination
    compression=gzip
    exclude_patterns=*.tmp,*.log,*.cache
    retention_days=30
    email_notify=admin@example.com

EXAMPLES:
    $0 --source /home/user --destination /backup --verbose
    $0 -s /var/www -d /backup -c bzip2 -e "*.log,*.tmp"
    $0 --config backup.conf --dry-run
    $0 /home/user /backup    # Positional arguments

EXIT CODES:
    0    Success
    1    General error
    2    Invalid arguments
    3    Source directory not found
    4    Destination not accessible
EOF
}

# Version information
version() {
    echo "Backup Utility v1.0"
    echo "Copyright (c) 2023 - Licensed under MIT"
}

# Logging function
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" | tee -a "${config[log_file]}"
    
    if [ "${config[verbose]}" = "true" ]; then
        echo "[$level] $message" >&2
    fi
}

# Parse configuration file
parse_config_file() {
    local config_file="$1"
    
    if [ ! -f "$config_file" ]; then
        log "ERROR" "Configuration file '$config_file' not found"
        return 1
    fi
    
    log "INFO" "Loading configuration from $config_file"
    
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ "$key" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$key" ]] && continue
        
        # Remove whitespace
        key="${key//[[:space:]]/}"
        value="${value#"${value%%[![:space:]]*}"}"
        value="${value%"${value##*[![:space:]]}"}"
        
        # Remove quotes
        if [[ "$value" =~ ^[\"\'](.*)[\"\']*$ ]]; then
            value="${BASH_REMATCH[1]}"
        fi
        
        if [[ -n "${config[$key]+x}" ]]; then
            config["$key"]="$value"
            log "DEBUG" "Config: $key = $value"
        else
            log "WARN" "Unknown configuration key: $key"
        fi
    done < "$config_file"
}

# Validate configuration
validate_config() {
    local errors=0
    
    # Check source directory
    if [ -z "${config[source]}" ]; then
        log "ERROR" "Source directory not specified"
        ((errors++))
    elif [ ! -d "${config[source]}" ]; then
        log "ERROR" "Source directory '${config[source]}' does not exist"
        ((errors++))
    fi
    
    # Check destination
    if [ -z "${config[destination]}" ]; then
        log "ERROR" "Destination directory not specified"
        ((errors++))
    elif [ ! -d "${config[destination]}" ]; then
        log "WARN" "Destination directory '${config[destination]}' does not exist, will create"
        if [ "${config[dry_run]}" = "false" ]; then
            mkdir -p "${config[destination]}" || {
                log "ERROR" "Cannot create destination directory"
                ((errors++))
            }
        fi
    fi
    
    # Validate compression type
    if [[ ! "${config[compression]}" =~ ^(gzip|bzip2|xz|none)$ ]]; then
        log "ERROR" "Invalid compression type: ${config[compression]}"
        ((errors++))
    fi
    
    # Validate retention days
    if ! [[ "${config[retention_days]}" =~ ^[0-9]+$ ]]; then
        log "ERROR" "Retention days must be numeric"
        ((errors++))
    fi
    
    # Validate email if provided
    if [ -n "${config[email_notify]}" ]; then
        local email_regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
        if [[ ! "${config[email_notify]}" =~ $email_regex ]]; then
            log "ERROR" "Invalid email address: ${config[email_notify]}"
            ((errors++))
        fi
    fi
    
    return $errors
}

# Parse command line arguments
parse_arguments() {
    # Use getopt for mixed short/long options
    local temp
    temp=$(getopt -o 's:d:c:e:l:f:nvr:h' \
                  --long 'source:,destination:,compression:,exclude:,log-file:,config:,dry-run,verbose,retention:,email:,help,version' \
                  -n "$0" -- "$@")
    
    if [ $? != 0 ]; then
        log "ERROR" "Invalid command line arguments"
        return 2
    fi
    
    eval set -- "$temp"
    
    while true; do
        case "$1" in
            -s|--source)
                config["source"]="$2"
                shift 2
                ;;
            -d|--destination)
                config["destination"]="$2"
                shift 2
                ;;
            -c|--compression)
                config["compression"]="$2"
                shift 2
                ;;
            -e|--exclude)
                config["exclude_patterns"]="$2"
                shift 2
                ;;
            -l|--log-file)
                config["log_file"]="$2"
                shift 2
                ;;
            -f|--config)
                config["config_file"]="$2"
                shift 2
                ;;
            -n|--dry-run)
                config["dry_run"]="true"
                shift
                ;;
            -v|--verbose)
                config["verbose"]="true"
                shift
                ;;
            -r|--retention)
                config["retention_days"]="$2"
                shift 2
                ;;
            --email)
                config["email_notify"]="$2"
                shift 2
                ;;
            --help)
                usage
                exit 0
                ;;
            --version)
                version
                exit 0
                ;;
            --)
                shift
                break
                ;;
            *)
                log "ERROR" "Internal error in argument parsing"
                return 1
                ;;
        esac
    done
    
    # Handle positional arguments
    if [ $# -eq 2 ]; then
        config["source"]="$1"
        config["destination"]="$2"
    elif [ $# -eq 1 ]; then
        if [ -z "${config[source]}" ]; then
            config["source"]="$1"
        else
            config["destination"]="$1"
        fi
    elif [ $# -gt 2 ]; then
        log "ERROR" "Too many positional arguments"
        return 2
    fi
    
    return 0
}

# Perform backup operation
perform_backup() {
    local source="${config[source]}"
    local destination="${config[destination]}"
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local backup_name="backup_${timestamp}"
    
    log "INFO" "Starting backup operation"
    log "INFO" "Source: $source"
    log "INFO" "Destination: $destination"
    log "INFO" "Compression: ${config[compression]}"
    
    if [ "${config[dry_run]}" = "true" ]; then
        log "INFO" "DRY RUN MODE - No actual backup will be performed"
        echo "Would create backup: $destination/$backup_name"
        return 0
    fi
    
    # Create backup with appropriate compression
    case "${config[compression]}" in
        gzip)
            tar -czf "$destination/${backup_name}.tar.gz" -C "$(dirname "$source")" "$(basename "$source")"
            ;;
        bzip2)
            tar -cjf "$destination/${backup_name}.tar.bz2" -C "$(dirname "$source")" "$(basename "$source")"
            ;;
        xz)
            tar -cJf "$destination/${backup_name}.tar.xz" -C "$(dirname "$source")" "$(basename "$source")"
            ;;
        none)
            tar -cf "$destination/${backup_name}.tar" -C "$(dirname "$source")" "$(basename "$source")"
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        log "INFO" "Backup completed successfully"
        
        # Send email notification if configured
        if [ -n "${config[email_notify]}" ]; then
            echo "Backup completed successfully at $(date)" | \
                mail -s "Backup Success: $source" "${config[email_notify]}"
        fi
    else
        log "ERROR" "Backup failed"
        return 1
    fi
}

# Main function
main() {
    # Parse command line arguments
    if ! parse_arguments "$@"; then
        usage >&2
        exit 2
    fi
    
    # Load configuration file if specified
    if [ -n "${config[config_file]}" ]; then
        if ! parse_config_file "${config[config_file]}"; then
            exit 1
        fi
    fi
    
    # Validate configuration
    if ! validate_config; then
        log "ERROR" "Configuration validation failed"
        exit 3
    fi
    
    # Perform backup
    if ! perform_backup; then
        exit 4
    fi
    
    log "INFO" "Backup utility completed successfully"
    exit 0
}

# Run main function with all arguments
main "$@"
```

## Exercise

Create a script called `system_monitor.sh` that accepts various input parameters and configuration options to monitor system resources. The script should support:

1. **Command-line options:**
   - `-i, --interval SECONDS`: Monitoring interval (default: 5)
   - `-d, --duration MINUTES`: Total monitoring duration (default: 60)
   - `-o, --output FILE`: Output file for results
   - `-f, --format FORMAT`: Output format (text, json, csv)
   - `-t, --thresholds FILE`: Thresholds configuration file
   - `-a, --alerts EMAIL`: Email for alerts
   - `--cpu-only`, `--memory-only`, `--disk-only`: Monitor specific resources
   - `-v, --verbose`: Verbose output
   - `-h, --help`: Show help

2. **Configuration file support** (INI format):
   ```ini
   [monitoring]
   interval = 10
   duration = 120
   output_format = json
   
   [thresholds]
   cpu_warning = 70
   cpu_critical = 90
   memory_warning = 80
   memory_critical = 95
   
   [alerts]
   email = admin@example.com
   ```

3. **Interactive mode** when no parameters provided:
   - Prompt for monitoring preferences
   - Validate user input
   - Confirm settings before starting

4. **Input validation:**
   - Numeric ranges for intervals and thresholds
   - Email format validation
   - File path validation
   - Format options validation

The script should demonstrate all the parameter parsing techniques covered in this tutorial.