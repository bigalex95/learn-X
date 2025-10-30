# Function Pointers

---

This section does not exist yet.

To contribute tutorials, simply fork the following repository:

[https://github.com/ronreiter/interactive-tutorials](https://github.com/ronreiter/interactive-tutorials)

Then you may add or edit tutorials, and then send me a pull request.

To write a tutorial, simply create a Markdown page under the relevant directory in the `tutorials` directory, and link it in the welcome screen in the relevant section. After adding it, please make sure that it linked correctly by running the Flask web server.

To link to the tutorial that you have created, create a link from the page you would like to link from (usually the `Welcome.md` page) using double brackets.

Each tutorial consists of a brief explanation of the subject, and a short exercise which will test the user. Once the user has finished modifying the code according to the exercise, it should execute to print out the expected output that you will provide.

Every tutorial must have the following structure:

### File name.md

````cpp
# Function Pointers

---

Tutorial
--------
Function pointers let you store the address of a function in a variable and call it later. They are useful for callbacks, dispatch tables, and simple strategy patterns. In modern C++ prefer `std::function` and lambdas for flexibility, but raw function pointers are small and fast.

Key points:
- Syntax: `return_type (*name)(arg_types)`.
- You can pass function pointers as arguments, return them, and store them in arrays.

Exercise
--------
Implement two functions and a small dispatcher:

- `int add_one(int x)` — returns x+1.
- `int times_two(int x)` — returns 2*x.
- `void apply_and_print(int (*f)(int), int value)` — calls `f(value)` and prints the result.

Use `apply_and_print` to call both functions for the value 5.

Tutorial Code
-------------
```cpp
#include <iostream>

// TODO: implement
int add_one(int x) {
	return 0; // replace
}

int times_two(int x) {
	return 0; // replace
}

void apply_and_print(int (*f)(int), int value) {
	// call f and print result
}

int main() {
	apply_and_print(add_one, 5);
	apply_and_print(times_two, 5);
	return 0;
}
````

## Expected Output

When implemented correctly:

```text
6
10
```

## Solution

```cpp
#include <iostream>

int add_one(int x) {
	return x + 1;
}

int times_two(int x) {
	return x * 2;
}

void apply_and_print(int (*f)(int), int value) {
	std::cout << f(value) << std::endl;
}

int main() {
	apply_and_print(add_one, 5);
	apply_and_print(times_two, 5);
	return 0;
}
```

Extensions:

- Store an array of function pointers and dispatch by index.
- Replace raw pointers with `std::function<int(int)>` to accept lambdas and member functions.
