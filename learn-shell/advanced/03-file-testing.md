# File Testing

---

Often you will want to do some file tests on the file system you are running. In this case, shell will provide you with several useful commands to achieve it.

The command looks like the following

- `-<command> [filename]`
- `[filename1] -<command> [filename2]`

We will briefly introduce some common commands you might encounter in your daily life.

## Example

**use "-e" to test if file exist**

```bash
#!/bin/bash
filename="sample.md"
if [ -e "$filename" ]; then
    echo "$filename exists as a file"
fi
```

**use "-d" to test if directory exists**

```bash
#!/bin/bash
directory_name="test_directory"
if [ -d "$directory_name" ]; then
    echo "$directory_name exists as a directory"
fi
```

**use "-r" to test if file has read permission for the user running the script/test**

```bash
#!/bin/bash
filename="sample.md"
if [ ! -f "$filename" ]; then
    touch "$filename"
fi
if [ -r "$filename" ]; then
    echo "you are allowed to read $filename"
else
    echo "you are not allowed to read $filename"
fi
```

## Exercise

### Exercise 1: File Existence

Check if files exist and what type they are:

```bash
#!/bin/bash
for file in "$@"; do
    if [ -e "$file" ]; then
        if [ -f "$file" ]; then
            echo "$file is a regular file"
        elif [ -d "$file" ]; then
            echo "$file is a directory"
        fi
    else
        echo "$file does not exist"
    fi
done
```

### Exercise 2: Permissions Check

Test file permissions:

```bash
#!/bin/bash
file="$1"
[ -r "$file" ] && echo "Readable" || echo "Not readable"
[ -w "$file" ] && echo "Writable" || echo "Not writable"
[ -x "$file" ] && echo "Executable" || echo "Not executable"
```

### Exercise 3: File Size

Check if files are empty or have content:

```bash
#!/bin/bash
for file in *.txt; do
    if [ -f "$file" ]; then
        if [ -s "$file" ]; then
            echo "$file has content"
        else
            echo "$file is empty"
        fi
    fi
done
```

### Exercise 4: Backup Check

Compare file modification times:

```bash
#!/bin/bash
source="$1"
backup="$2"

if [ "$source" -nt "$backup" ]; then
    echo "Source is newer than backup"
elif [ "$source" -ot "$backup" ]; then
    echo "Backup is newer than source"
else
    echo "Files have same modification time"
fi
```
