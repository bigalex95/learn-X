# Bash trap command

---

It often comes the situations that you want to catch a special signal/interruption/user input in your script to prevent the unpredictables.

Trap is your command to try:

- `trap <arg/function> <signal>`

### Example

```bash
#!/bin/bash
# traptest.sh
# notice you cannot make Ctrl-C work in this shell,
# try with your local one, also remeber to chmod +x
# your local .sh file so you can execute it!

trap "echo Booh!" SIGINT SIGTERM
echo "it's going to run until you hit Ctrl+Z"
echo "hit Ctrl+C to be blown away!"

while true
do
    sleep 60
done
```

Surely you can substitute the `"echo Booh!"` with a function:

```bash
function booh {
    echo "booh!"
}
```

and call it in trap:

```bash
trap booh SIGINT SIGTERM
```

Some of the common signal types you can trap:

- `SIGINT`: user sends an interrupt signal (Ctrl + C)
- `SIGQUIT`: user sends a quit signal (Ctrl + D)
- `SIGFPE`: attempted an illegal mathematical operation

You can check out all signal types by entering the following command:

```bash
kill -l
```

Notice the numbers before each signal name, you can use that number to avoid typing long strings in trap:

```bash
#2 corresponds to SIGINT and 15 corresponds to SIGTERM
trap booh 2 15
```

one of the common usage of trap is to do cleanup temporary files:

```bash
trap "rm -f folder; exit" 2
```

## Exercise

### Exercise 1: Basic Cleanup

Create a script with cleanup on exit:

```bash
#!/bin/bash
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/test$$
}
trap cleanup EXIT

echo "Working..." > /tmp/test$$
sleep 5
echo "Done"
```

### Exercise 2: Handle Interrupts

Create a script that handles Ctrl+C gracefully:

```bash
#!/bin/bash
interrupted() {
    echo "Script interrupted!"
    exit 1
}
trap interrupted SIGINT

while true; do
    echo "Running... (Ctrl+C to stop)"
    sleep 2
done
```

### Exercise 3: Multiple Signals

Handle different signals with different actions:

```bash
#!/bin/bash
handle_int() { echo "Got SIGINT"; }
handle_term() { echo "Got SIGTERM"; exit; }

trap handle_int SIGINT
trap handle_term SIGTERM

while true; do
    echo "Running..."
    sleep 3
done
```

### Exercise 4: Temp File Cleanup

Create a script that always cleans up temporary files:

```bash
#!/bin/bash
TMPFILE=$(mktemp)
cleanup() {
    echo "Removing $TMPFILE"
    rm -f "$TMPFILE"
}
trap cleanup EXIT SIGINT SIGTERM

echo "Using temp file: $TMPFILE"
echo "data" > "$TMPFILE"
sleep 10
```