# Special Variables

---

In last tutorial about shell function, you use "$1" represent the first argument passed to function_A. Moreover, here are some special variables in shell:

- `$0` - The filename of the current script.|
- `$n` - The Nth argument passed to script was invoked or function was called.|
- `$#` - The number of argument passed to script or function.|
- `$@` - All arguments passed to script or function.|
- `$*` - All arguments passed to script or function.|
- `$?` - The exit status of the last command executed.|
- `$$` - The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.|
- `$!` - The process number of the last background command.|

### Example:

```bash
#!/bin/bash
echo "Script Name: $0"
function func {
    for var in $*
    do
        let i=i+1
        echo "The \$${i} argument is: ${var}"
    done
    echo "Total count of arguments: $#"
}
func We are argument
```

`$@` and `$*` have different behavior when they were enclosed in double quotes.

```bash
#!/bin/bash
function func {
    echo "--- \"\$*\""
    for ARG in "$*"
    do
        echo $ARG
    done

    echo "--- \"\$@\""
    for ARG in "$@"
    do
        echo $ARG
    done
}
func We are argument
```

## Exercise

### Exercise 1: Script Info

Create a script that displays basic information:

```bash
#!/bin/bash
echo "Script: $0"
echo "PID: $$"
echo "Args: $# - $@"
```

### Exercise 2: Exit Codes

Test different command exit codes:

```bash
#!/bin/bash
ls /nonexistent 2>/dev/null
echo "Exit code: $?"
true; echo "true: $?"
false; echo "false: $?"
```

### Exercise 3: Background Process

Run a command in background and show its PID:

```bash
#!/bin/bash
sleep 3 &
echo "Background PID: $!"
wait
echo "Done"
```

### Exercise 4: Function vs Script Args

Show difference between function and script arguments:

```bash
#!/bin/bash
myfunc() {
    echo "Function args: $# - $@"
}
echo "Script args: $# - $@"
myfunc "hello" "world"
```