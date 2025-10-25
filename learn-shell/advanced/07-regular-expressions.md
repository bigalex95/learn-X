# Regular Expressions

---

Regular expressions (regex) are powerful pattern-matching tools used extensively in shell scripting for text processing, validation, and data extraction.

## Basic Regular Expression Concepts

### Literal Characters

```bash
# Simple string matching
text="Hello World"

if [[ $text =~ Hello ]]; then
    echo "Found 'Hello' in the text"
fi

# Case-sensitive matching
if [[ $text =~ hello ]]; then
    echo "Found 'hello'"
else
    echo "Did not find 'hello' (case-sensitive)"
fi
```

### Character Classes

```bash
text="abc123XYZ"

# Match any digit
if [[ $text =~ [0-9] ]]; then
    echo "Contains digits"
fi

# Match any letter
if [[ $text =~ [a-zA-Z] ]]; then
    echo "Contains letters"
fi

# Match specific characters
if [[ $text =~ [aeiou] ]]; then
    echo "Contains vowels"
fi

# Negated character class
if [[ $text =~ [^0-9] ]]; then
    echo "Contains non-digit characters"
fi
```

### Predefined Character Classes

```bash
text="Hello123 World!"

# POSIX character classes
if [[ $text =~ [[:digit:]] ]]; then
    echo "Contains digits"
fi

if [[ $text =~ [[:alpha:]] ]]; then
    echo "Contains letters"
fi

if [[ $text =~ [[:alnum:]] ]]; then
    echo "Contains alphanumeric characters"
fi

if [[ $text =~ [[:space:]] ]]; then
    echo "Contains whitespace"
fi

if [[ $text =~ [[:punct:]] ]]; then
    echo "Contains punctuation"
fi
```

## Quantifiers

### Basic Quantifiers

```bash
# Zero or more (*)
text1="abc"
text2="abbbbc"
text3="ac"

pattern="ab*c"

for text in "$text1" "$text2" "$text3"; do
    if [[ $text =~ $pattern ]]; then
        echo "'$text' matches pattern '$pattern'"
    else
        echo "'$text' does not match pattern '$pattern'"
    fi
done
```

### One or More (+)

```bash
# One or more (+)
emails=("user@domain.com" "test@" "@domain.com" "valid.email@example.org")

email_pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"

for email in "${emails[@]}"; do
    if [[ $email =~ $email_pattern ]]; then
        echo "Valid email: $email"
    else
        echo "Invalid email: $email"
    fi
done
```

### Zero or One (?)

```bash
# Optional character
texts=("color" "colour" "colors" "colours")
pattern="colou?r"

for text in "${texts[@]}"; do
    if [[ $text =~ ^$pattern$ ]]; then
        echo "'$text' matches exactly"
    elif [[ $text =~ $pattern ]]; then
        echo "'$text' contains the pattern"
    else
        echo "'$text' does not match"
    fi
done
```

### Specific Quantities

```bash
# Exact count {n}
# Range {n,m}
# At least {n,}

phone_numbers=("123-456-7890" "12-34-567" "1234567890" "123-45-67890")
phone_pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"

for phone in "${phone_numbers[@]}"; do
    if [[ $phone =~ ^$phone_pattern$ ]]; then
        echo "Valid phone: $phone"
    else
        echo "Invalid phone: $phone"
    fi
done
```

## Anchors and Boundaries

### Start and End Anchors

```bash
text="The quick brown fox"

# Start of string (^)
if [[ $text =~ ^The ]]; then
    echo "Starts with 'The'"
fi

# End of string ($)
if [[ $text =~ fox$ ]]; then
    echo "Ends with 'fox'"
fi

# Exact match
if [[ $text =~ ^The.*fox$ ]]; then
    echo "Starts with 'The' and ends with 'fox'"
fi
```

### Word Boundaries

```bash
text="The cat in the cathedral"

# Word boundary (\b) - note: bash regex doesn't support \b directly
# Use [[:<:]] and [[:>:]] or alternatives

# Check for whole word "cat"
if [[ $text =~ (^|[^a-zA-Z])cat([^a-zA-Z]|$) ]]; then
    echo "Found whole word 'cat'"
fi
```

## Groups and Capturing

### Basic Grouping

```bash
# Grouping with parentheses
dates=("2023-12-25" "12/25/2023" "25-12-2023" "2023/12/25")

# ISO date format
iso_pattern="([0-9]{4})-([0-9]{2})-([0-9]{2})"

for date in "${dates[@]}"; do
    if [[ $date =~ $iso_pattern ]]; then
        echo "ISO date: $date"
        echo "  Year: ${BASH_REMATCH[1]}"
        echo "  Month: ${BASH_REMATCH[2]}"
        echo "  Day: ${BASH_REMATCH[3]}"
    fi
done
```

### Extracting Data

```bash
# Extract information from log entries
log_entries=(
    "2023-10-26 14:30:22 ERROR Failed to connect to database"
    "2023-10-26 14:31:15 INFO User login successful"
    "2023-10-26 14:32:01 WARN Memory usage high"
)

log_pattern="([0-9-]+) ([0-9:]+) ([A-Z]+) (.*)"

for entry in "${log_entries[@]}"; do
    if [[ $entry =~ $log_pattern ]]; then
        echo "Log entry parsed:"
        echo "  Date: ${BASH_REMATCH[1]}"
        echo "  Time: ${BASH_REMATCH[2]}"
        echo "  Level: ${BASH_REMATCH[3]}"
        echo "  Message: ${BASH_REMATCH[4]}"
        echo
    fi
done
```

## Alternation and Special Characters

### OR Operator (|)

```bash
# Match multiple alternatives
files=("document.txt" "image.jpg" "script.sh" "data.csv" "readme.md")

document_pattern=".*\.(txt|doc|pdf|md)$"

for file in "${files[@]}"; do
    if [[ $file =~ $document_pattern ]]; then
        echo "Document file: $file"
    else
        echo "Not a document: $file"
    fi
done
```

### Escaping Special Characters

```bash
# Special characters need escaping
text="Price: $19.99 (on sale!)"

# Match literal dollar sign and parentheses
price_pattern="\$[0-9]+\.[0-9]{2}"
sale_pattern="\(on sale!\)"

if [[ $text =~ $price_pattern ]]; then
    echo "Found price in text"
fi

if [[ $text =~ $sale_pattern ]]; then
    echo "Found sale notice"
fi
```

## Practical Examples

### Email Validation

```bash
validate_email() {
    local email=$1
    local pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if [[ $email =~ $pattern ]]; then
        return 0
    else
        return 1
    fi
}

emails=("user@example.com" "invalid.email" "test@domain" "valid.user+tag@example.org")

for email in "${emails[@]}"; do
    if validate_email "$email"; then
        echo "✓ Valid: $email"
    else
        echo "✗ Invalid: $email"
    fi
done
```

### URL Parsing

```bash
parse_url() {
    local url=$1
    local pattern="^(https?)://([^/]+)(/.*)?\??(.*)$"
    
    if [[ $url =~ $pattern ]]; then
        echo "URL: $url"
        echo "  Protocol: ${BASH_REMATCH[1]}"
        echo "  Host: ${BASH_REMATCH[2]}"
        echo "  Path: ${BASH_REMATCH[3]:-/}"
        echo "  Query: ${BASH_REMATCH[4]:-none}"
    else
        echo "Invalid URL: $url"
    fi
}

urls=(
    "https://www.example.com/path/to/resource?param=value"
    "http://localhost:8080/"
    "ftp://files.example.com/file.txt"
)

for url in "${urls[@]}"; do
    parse_url "$url"
    echo
done
```

### Phone Number Formatting

```bash
format_phone() {
    local phone=$1
    # Remove all non-digits
    local digits_only=$(echo "$phone" | sed 's/[^0-9]//g')
    
    # Check if it's a valid US phone number
    if [[ $digits_only =~ ^1?([0-9]{3})([0-9]{3})([0-9]{4})$ ]]; then
        local area_code=${BASH_REMATCH[1]}
        local exchange=${BASH_REMATCH[2]}
        local number=${BASH_REMATCH[3]}
        
        echo "($area_code) $exchange-$number"
    else
        echo "Invalid phone number: $phone"
    fi
}

phones=(
    "1234567890"
    "123-456-7890"
    "(123) 456-7890"
    "1-123-456-7890"
    "12345"
)

for phone in "${phones[@]}"; do
    formatted=$(format_phone "$phone")
    echo "$phone -> $formatted"
done
```

### Log Analysis

```bash
analyze_access_log() {
    local log_line=$1
    # Common log format pattern
    local pattern='^([0-9.]+) - - \[([^\]]+)\] "([A-Z]+) ([^"]+)" ([0-9]+) ([0-9]+|-)'
    
    if [[ $log_line =~ $pattern ]]; then
        local ip=${BASH_REMATCH[1]}
        local timestamp=${BASH_REMATCH[2]}
        local method=${BASH_REMATCH[3]}
        local url=${BASH_REMATCH[4]}
        local status=${BASH_REMATCH[5]}
        local size=${BASH_REMATCH[6]}
        
        echo "Access Log Entry:"
        echo "  IP: $ip"
        echo "  Time: $timestamp"
        echo "  Method: $method"
        echo "  URL: $url"
        echo "  Status: $status"
        echo "  Size: $size"
        
        # Classify status
        if [[ $status =~ ^2 ]]; then
            echo "  Result: Success"
        elif [[ $status =~ ^4 ]]; then
            echo "  Result: Client Error"
        elif [[ $status =~ ^5 ]]; then
            echo "  Result: Server Error"
        fi
    else
        echo "Invalid log format: $log_line"
    fi
}

# Sample log entries
log_entries=(
    '192.168.1.100 - - [26/Oct/2023:14:32:10 +0000] "GET /index.html" 200 1024'
    '10.0.0.5 - - [26/Oct/2023:14:33:15 +0000] "POST /api/login" 401 -'
    '203.0.113.1 - - [26/Oct/2023:14:34:22 +0000] "GET /nonexistent" 404 512'
)

for entry in "${log_entries[@]}"; do
    analyze_access_log "$entry"
    echo
done
```

## Using grep with Regular Expressions

### Basic grep Patterns

```bash
# Create sample data
cat << 'EOF' > sample.txt
John Doe, john@example.com, 555-123-4567
Jane Smith, jane.smith@company.org, 555-987-6543
Bob Johnson, bob@invalid, 123-456
Alice Brown, alice.brown@university.edu, 555-111-2222
EOF

echo "All email addresses:"
grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' sample.txt

echo
echo "Phone numbers:"
grep -oE '[0-9]{3}-[0-9]{3}-[0-9]{4}' sample.txt

echo
echo "Lines with .com domains:"
grep '\.com' sample.txt

# Clean up
rm sample.txt
```

### Advanced grep Usage

```bash
# Create log file
cat << 'EOF' > server.log
2023-10-26 08:15:22 INFO Server started
2023-10-26 08:15:23 INFO Loading configuration
2023-10-26 08:16:10 WARN Connection timeout for user123
2023-10-26 08:16:15 ERROR Database connection failed
2023-10-26 08:16:16 ERROR Retry attempt 1 failed
2023-10-26 08:16:20 INFO Database connection restored
2023-10-26 08:17:05 WARN High memory usage detected
EOF

echo "ERROR entries:"
grep "ERROR" server.log

echo
echo "Entries with timestamps after 08:16:"
grep "08:1[6-9]:" server.log

echo
echo "Extract just the messages:"
grep -oE '[A-Z]+ .*$' server.log | sed 's/^[A-Z]* //'

# Clean up
rm server.log
```

## Exercise

Create a script called `data_validator.sh` that validates and extracts information from the following data formats:

1. **Email addresses** - Extract valid email addresses from text
2. **Phone numbers** - Format US phone numbers consistently  
3. **URLs** - Parse and validate URLs
4. **Credit card numbers** - Validate format (without verification)

**Test data:**
```
Contact: john.doe@example.com, phone: (555) 123-4567
Website: https://www.example.com/path?query=value
Payment: 4532-1234-5678-9012
Invalid email: notanemail.com
Invalid phone: 12345
```

**Expected output:**
- Extract and validate each type of data
- Format phone numbers as (XXX) XXX-XXXX
- Show URL components
- Validate credit card format (should be 16 digits)