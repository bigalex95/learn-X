# Variables

---

Shell variables are created once they are assigned a value. A variable can contain a number, a character or a string of characters. Variable name is case sensitive and can consist of a combination of letters and the underscore "\_". Value assignment is done using the "=" sign. Note that no space permitted on either side of = sign when initializing variables.

```bash
PRICE_PER_APPLE=5
MyFirstLetters=ABC
greeting='Hello        world!'
```

Referencing the variables

A backslash "\" is used to escape special character meaning

```bash
PRICE_PER_APPLE=5
echo "The price of an Apple today is: \$HK $PRICE_PER_APPLE"
```

Encapsulating the variable name with ${} is used to avoid ambiguity

```bash
MyFirstLetters=ABC
echo "The first 10 letters in the alphabet are: ${MyFirstLetters}DEFGHIJ"
```

Encapsulating the variable name with "" will preserve any white space values

```bash
greeting='Hello        world!'
echo $greeting" now with spaces: $greeting"
```

Variables can be assigned with the value of a command output. This is referred to as substitution. Substitution can be done by encapsulating the command with `` (known as back-ticks) or with $()

```bash
FILELIST=`ls`
FileWithTimeStamp=/tmp/my-dir/file_$(/bin/date +%Y-%m-%d).txt
```

Note that when the script runs, it will run the command inside the $() parenthesis and capture its output.

## Exercise

The target of this exercise is to create a string, an integer, and a complex variable using command substitution. The string should be named BIRTHDATE and should contain the text "Jan 1, 2000". The integer should be named Presents and should contain the number 10. The complex variable should be named BIRTHDAY and should contain the full weekday name of the day matching the date in variable BIRTHDATE e.g. Saturday. Note that the 'date' command can be used to convert a date format into a different date format. For example, to convert date value, $date1, to day of the week of date1, use:

```bash
date -d "$date1" +%A
```
