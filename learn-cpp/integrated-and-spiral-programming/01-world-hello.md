# World!, Hello

---

### Swapping Strings

You shall try and swap strings using `templates` (see [documentation](https://en.wikipedia.org/wiki/Generic_programming#Templates_in_C.2B.2B)).

### Our first program

## Exercise

This short lesson shows how to use a simple function template to swap two values (here: strings).

## Tutorial

In C++, templates let you write generic code that works for multiple types. A common example is a `swap` function that exchanges the values of two variables. The standard library provides `std::swap`, but implementing your own small template is a great way to learn how templates work.

The template signature for a simple swap looks like:

```cpp
template<typename T>
void swap_values(T& a, T& b) {
	// implementation
}
```

## Exercise

Change the program below so that it prints exactly:

```
world!, Hello
```

You should implement a template `swap_values` and use it to swap two `std::string` values. The starter program currently initializes two strings and prints them: modify it so the output matches the expected output.

## Tutorial Code

```cpp
#include <iostream>
#include <string>

// TODO: implement this template
template<typename T>
void swap_values(T& a, T& b) {
	// replace this with a correct swap implementation
}

int main() {
	std::string s1 = "Hello";
	std::string s2 = "world!";

	// swap s1 and s2 so that printing them produces the expected output

	std::cout << s1 << ", " << s2 << std::endl;
	return 0;
}
```

## Expected Output

```
world!, Hello
```

## Solution

Here is a minimal correct solution. It demonstrates a simple template-based swap and shows a small note about `std::swap`.

```cpp
#include <iostream>
#include <string>

template<typename T>
void swap_values(T& a, T& b) {
	T tmp = a;
	a = b;
	b = tmp;
}

int main() {
	std::string s1 = "Hello";
	std::string s2 = "world!";

	swap_values(s1, s2);

	// Note: we print s2 first to match the required output format
	std::cout << s2 << ", " << s1 << std::endl;
	return 0;
}
```

## Notes and Tips

- The `swap_values` template works for any copyable type. For types that are expensive to copy, prefer swapping via `std::move` or use `std::swap` from `<utility>` which is optimized for many standard types.
- Try modifying the program to swap integers or a small struct to see how templates generalize.
