# Special Commands sed,awk,grep,sort

---

This tutorial covers four essential command-line tools that are fundamental for text processing in shell scripting: sed, awk, grep, and sort.

## grep - Pattern Searching

### Basic grep Usage

```bash
# Create sample data
cat << 'EOF' > employees.txt
John Doe,Sales,50000,New York
Jane Smith,Engineering,75000,San Francisco
Bob Johnson,Marketing,45000,Chicago
Alice Brown,Engineering,80000,San Francisco
Charlie Wilson,Sales,52000,New York
Diana Davis,HR,48000,Boston
EOF

# Basic pattern search
echo "Employees in Engineering:"
grep "Engineering" employees.txt

# Case-insensitive search
echo "Employees with 'john' in name (case-insensitive):"
grep -i "john" employees.txt

# Count matches
echo "Number of Sales employees:"
grep -c "Sales" employees.txt
```

### Advanced grep Options

```bash
# Multiple patterns
echo "Employees in Sales or HR:"
grep -E "Sales|HR" employees.txt

# Invert match (lines NOT containing pattern)
echo "Non-Engineering employees:"
grep -v "Engineering" employees.txt

# Show line numbers
echo "Employees with line numbers:"
grep -n "San Francisco" employees.txt

# Show only matching part
echo "Extract salary information:"
grep -o "[0-9]\{5\}" employees.txt

# Show context (lines before/after)
echo "Sales employees with context:"
grep -C 1 "Sales" employees.txt
```

### grep with Regular Expressions

```bash
# Match patterns at beginning/end of line
echo "Employees whose names start with 'A':"
grep "^A" employees.txt

# Match salary ranges
echo "Employees earning 50000 or more:"
grep "[5-9][0-9][0-9][0-9][0-9]" employees.txt

# Word boundaries
echo "Exact word match for 'Sales':"
grep "\bSales\b" employees.txt
```

## sed - Stream Editor

### Basic sed Operations

```bash
# Substitute/replace text
echo "Replace 'Engineering' with 'Development':"
sed 's/Engineering/Development/' employees.txt

# Replace all occurrences in each line
echo "Replace all commas with pipes:"
sed 's/,/|/g' employees.txt

# Replace only on specific lines
echo "Replace on lines 2-4:"
sed '2,4s/Sales/Marketing/' employees.txt

# Delete lines
echo "Remove HR employees:"
sed '/HR/d' employees.txt
```

### Advanced sed Usage

```bash
# Multiple commands
echo "Multiple operations:"
sed -e 's/Engineering/Tech/' -e 's/Sales/Business/' employees.txt

# Insert and append lines
echo "Add header and footer:"
sed '1i\Name,Department,Salary,Location' employees.txt | sed '$a\--- End of Data ---'

# Print specific lines
echo "Print only lines 2-4:"
sed -n '2,4p' employees.txt

# Address ranges and patterns
echo "From first Sales to last Engineering:"
sed -n '/Sales/,/Engineering/p' employees.txt
```

### sed for Data Transformation

```bash
# Extract specific fields (similar to cut)
echo "Extract names only:"
sed 's/^\([^,]*\).*/\1/' employees.txt

# Reorder columns
echo "Reorder: Name, Location, Department, Salary:"
sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\1,\4,\2,\3/' employees.txt

# Format numbers
echo "Add dollar signs to salaries:"
sed 's/\([0-9]\{5\}\)/$\1/' employees.txt

# Conditional replacement
echo "Update San Francisco to SF:"
sed '/San Francisco/s/San Francisco/SF/' employees.txt
```

## awk - Pattern Processing Language

### Basic awk Concepts

```bash
# Print specific fields
echo "Print names and salaries:"
awk -F',' '{print $1, $3}' employees.txt

# Print with custom formatting
echo "Formatted output:"
awk -F',' '{printf "Name: %-15s Salary: $%s\n", $1, $3}' employees.txt

# Print lines based on conditions
echo "High earners (>60000):"
awk -F',' '$3 > 60000' employees.txt

# Count and sum
echo "Count and average salary:"
awk -F',' '{count++; sum+=$3} END {print "Employees:", count, "Average:", sum/count}' employees.txt
```

### Advanced awk Programming

```bash
# Using variables and conditions
echo "Department summary:"
awk -F',' '
{
    dept[$2]++
    total[$2] += $3
}
END {
    for (d in dept) {
        printf "%s: %d employees, avg salary: $%.0f\n", d, dept[d], total[d]/dept[d]
    }
}' employees.txt

# Pattern matching and actions
echo "Engineering department details:"
awk -F',' '
BEGIN { print "Engineering Employees:" }
$2 == "Engineering" { print "  " $1 " - $" $3 " (" $4 ")" }
END { print "--- End ---" }
' employees.txt

# String manipulation
echo "Employee initials and location codes:"
awk -F',' '{
    split($1, name, " ")
    initials = substr(name[1], 1, 1) substr(name[2], 1, 1)
    location_code = substr($4, 1, 2)
    print initials, location_code
}' employees.txt
```

### awk Built-in Variables and Functions

```bash
# Using built-in variables
echo "Line numbers and field counts:"
awk -F',' '{print "Line " NR ": " NF " fields - " $0}' employees.txt

# String functions
echo "Name lengths and uppercase departments:"
awk -F',' '{
    print $1 " (length: " length($1) "), Department: " toupper($2)
}' employees.txt

# Mathematical functions
echo "Salary statistics:"
awk -F',' '
{
    salaries[NR] = $3
    sum += $3
    if ($3 > max || max == "") max = $3
    if ($3 < min || min == "") min = $3
}
END {
    avg = sum / NR
    print "Min: $" min ", Max: $" max ", Average: $" avg

    # Calculate median
    for (i = 1; i <= NR; i++) {
        for (j = i + 1; j <= NR; j++) {
            if (salaries[i] > salaries[j]) {
                temp = salaries[i]
                salaries[i] = salaries[j]
                salaries[j] = temp
            }
        }
    }
    median_pos = int((NR + 1) / 2)
    print "Median: $" salaries[median_pos]
}' employees.txt
```

## sort - Sorting Text

### Basic Sorting

```bash
# Simple alphabetical sort
echo "Employees sorted by name:"
sort employees.txt

# Reverse sort
echo "Reverse alphabetical sort:"
sort -r employees.txt

# Numeric sort
echo "Sort by salary (numeric):"
sort -t',' -k3 -n employees.txt

# Sort by multiple fields
echo "Sort by department, then by salary:"
sort -t',' -k2,2 -k3,3n employees.txt
```

### Advanced Sorting Options

```bash
# Sort by specific field and order
echo "Sort by salary (highest first):"
sort -t',' -k3 -nr employees.txt

# Stable sort (preserve original order for equal elements)
echo "Stable sort by department:"
sort -t',' -k2 -s employees.txt

# Unique sort (remove duplicates)
echo "Unique departments:"
sort -t',' -k2 employees.txt | cut -d',' -f2 | sort -u

# Check if file is sorted
if sort -t',' -k3 -n employees.txt -c 2>/dev/null; then
    echo "File is sorted by salary"
else
    echo "File is not sorted by salary"
fi
```

## Combining Commands

### Pipeline Examples

```bash
# Complex data processing pipeline
echo "Top earning employees by department:"
awk -F',' 'NR>1{dept[$2]++; if($3>max[$2] || max[$2]=="") {max[$2]=$3; top[$2]=$1}} END{for(d in dept) print d","top[d]","max[d]}' employees.txt | sort -t',' -k3 -nr

# Text processing chain
echo "Employee count by location (sorted):"
grep -v "^$" employees.txt | cut -d',' -f4 | sort | uniq -c | sort -nr

# Data cleaning and formatting
echo "Clean and format employee data:"
sed 's/  */ /g' employees.txt | awk -F',' '{printf "%-20s %-15s %8s %-15s\n", $1, $2, "$"$3, $4}'
```

### Real-world Examples

```bash
# Log analysis
cat << 'EOF' > access.log
192.168.1.100 - - [26/Oct/2023:14:32:10] "GET /index.html" 200 1024
192.168.1.101 - - [26/Oct/2023:14:32:15] "GET /about.html" 200 2048
192.168.1.100 - - [26/Oct/2023:14:32:20] "POST /login" 401 512
192.168.1.102 - - [26/Oct/2023:14:32:25] "GET /index.html" 200 1024
192.168.1.101 - - [26/Oct/2023:14:32:30] "GET /products" 404 256
EOF

echo "Top IP addresses by request count:"
awk '{print $1}' access.log | sort | uniq -c | sort -nr

echo "HTTP status code distribution:"
awk '{print $9}' access.log | sort | uniq -c | sort -nr

echo "Most requested pages:"
awk '{print $7}' access.log | sort | uniq -c | sort -nr

# CSV processing
echo "Generate summary report:"
awk -F',' '
BEGIN {
    print "Department Summary Report"
    print "========================"
}
{
    if (NR == 1) next  # Skip header if exists
    dept[$2]++
    total_salary[$2] += $3
    if ($3 > max_salary[$2]) {
        max_salary[$2] = $3
        highest_paid[$2] = $1
    }
}
END {
    for (d in dept) {
        avg = total_salary[d] / dept[d]
        printf "Department: %s\n", d
        printf "  Employees: %d\n", dept[d]
        printf "  Total Salary: $%d\n", total_salary[d]
        printf "  Average Salary: $%.0f\n", avg
        printf "  Highest Paid: %s ($%d)\n", highest_paid[d], max_salary[d]
        print ""
    }
}' employees.txt

# Clean up
rm employees.txt access.log
```

### Data Validation and Cleaning

```bash
# Create sample data with issues
cat << 'EOF' > messy_data.txt
John  Doe  ,Sales, 50000,  New York
Jane Smith,Engineering,75000,San Francisco
   Bob Johnson,Marketing,45000,Chicago
Alice Brown,Engineering,80000,San Francisco
Charlie Wilson,Sales,52000,New York

Diana Davis,HR,48000,Boston
EOF

echo "Original messy data:"
cat messy_data.txt

echo
echo "Cleaned data:"
# Remove empty lines, trim whitespace, standardize format
sed '/^$/d' messy_data.txt | \
sed 's/^[ \t]*//;s/[ \t]*$//' | \
sed 's/[ \t]*,[ \t]*/,/g' | \
awk -F',' '{printf "%-20s %-15s %8s %-15s\n", $1, $2, $3, $4}'

# Data validation
echo
echo "Data validation:"
echo "Invalid salary entries:"
awk -F',' '$3 !~ /^[0-9]+$/ {print "Line " NR ": " $0}' messy_data.txt

echo "Missing fields:"
awk -F',' 'NF != 4 {print "Line " NR ": " $0 " (has " NF " fields)"}' messy_data.txt

rm messy_data.txt
```

## Performance Tips

### Efficient Text Processing

```bash
# Create large dataset for performance testing
echo "Generating test data..."
for i in {1..1000}; do
    name="User$i"
    dept=$((RANDOM % 4))
    case $dept in
        0) department="Engineering" ;;
        1) department="Sales" ;;
        2) department="Marketing" ;;
        3) department="HR" ;;
    esac
    salary=$((40000 + RANDOM % 60000))
    location=$((RANDOM % 3))
    case $location in
        0) city="New York" ;;
        1) city="San Francisco" ;;
        2) city="Chicago" ;;
    esac
    echo "$name,$department,$salary,$city"
done > large_data.txt

echo "Testing performance..."

# Time different approaches
echo "Using awk for filtering:"
time awk -F',' '$2 == "Engineering" && $3 > 70000' large_data.txt > /dev/null

echo "Using grep and awk:"
time grep "Engineering" large_data.txt | awk -F',' '$3 > 70000' > /dev/null

# Memory-efficient processing
echo "Processing large files efficiently:"
# Use awk for single-pass processing instead of multiple commands
awk -F',' '
$2 == "Engineering" && $3 > 70000 {
    high_earners++
    total += $3
}
END {
    if (high_earners > 0) {
        print "High-earning engineers:", high_earners
        print "Average salary: $" int(total/high_earners)
    }
}' large_data.txt

rm large_data.txt
```

## Exercise

Create a script called `log_analyzer.sh` that processes web server log files and generates a comprehensive report. The script should:

1. **Extract** the top 10 IP addresses by request count
2. **Identify** the most popular pages (excluding static resources like .css, .js, .png)
3. **Calculate** response time statistics (if available in logs)
4. **Generate** an hourly request distribution
5. **Find** error rates by status code
6. **Format** the output as a readable report

**Sample log format:**

```
192.168.1.100 - - [26/Oct/2023:14:32:10] "GET /index.html" 200 1024 0.123
192.168.1.101 - - [26/Oct/2023:14:32:15] "GET /styles.css" 200 2048 0.045
192.168.1.100 - - [26/Oct/2023:14:32:20] "POST /api/login" 401 512 0.234
```

**Expected output sections:**

- Top IP addresses with request counts
- Most popular pages (excluding static resources)
- HTTP status code distribution
- Hourly request pattern
- Response time statistics (min, max, average)

Use combinations of `grep`, `sed`, `awk`, and `sort` to achieve this analysis.
