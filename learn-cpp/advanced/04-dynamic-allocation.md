# Dynamic allocation

---

## Tutorial

This tutorial covers dynamic memory allocation in C++ using raw pointers (`new`/`delete`) and modern alternatives (`std::unique_ptr` and `std::vector`). We'll show simple use-cases, common pitfalls (memory leaks, double-free), and a small exercise to practice.

Key points:

- `new` allocates memory and returns a pointer; `delete` frees a single object.
- `new[]` / `delete[]` for arrays.
- Prefer RAII (e.g., `std::unique_ptr`, `std::vector`) to avoid leaks.

## Exercise

Write two functions:

1. `int* create_array_raw(int n)` — allocate an array of `n` integers on the heap using `new[]`, initialize the elements to `0..n-1`, and return the raw pointer.
2. `std::unique_ptr<int[]> create_array_smart(int n)` — do the same but return a `std::unique_ptr<int[]>`.

Then write a `sum_array` function that takes a pointer and size and returns the sum. Use it to print the sums from both arrays. Make sure you free the raw array after use.

## Tutorial Code

```cpp
#include <iostream>
#include <memory>

// TODO: implement
int* create_array_raw(int n) {
	// allocate and initialize
	return nullptr; // replace
}

std::unique_ptr<int[]> create_array_smart(int n) {
	// allocate and initialize
	return nullptr; // replace
}

int sum_array(const int* arr, int n) {
	int s = 0;
	for (int i = 0; i < n; ++i) s += arr[i];
	return s;
}

int main() {
	const int n = 10;

	int* raw = create_array_raw(n);
	std::cout << "sum raw: " << sum_array(raw, n) << std::endl;
	// remember to free raw

	auto smart = create_array_smart(n);
	std::cout << "sum smart: " << sum_array(smart.get(), n) << std::endl;

	return 0;
}
```

## Expected Output

When implemented correctly, the program should print the same sum for both arrays (sum of 0..n-1). For n=10:

```text
sum raw: 45
sum smart: 45
```

## Solution

```cpp
#include <iostream>
#include <memory>

int* create_array_raw(int n) {
	int* a = new int[n];
	for (int i = 0; i < n; ++i) a[i] = i;
	return a;
}

std::unique_ptr<int[]> create_array_smart(int n) {
	std::unique_ptr<int[]> a(new int[n]);
	for (int i = 0; i < n; ++i) a[i] = i;
	return a;
}

int sum_array(const int* arr, int n) {
	int s = 0;
	for (int i = 0; i < n; ++i) s += arr[i];
	return s;
}

int main() {
	const int n = 10;

	int* raw = create_array_raw(n);
	std::cout << "sum raw: " << sum_array(raw, n) << std::endl;
	delete[] raw; // free raw memory

	auto smart = create_array_smart(n);
	std::cout << "sum smart: " << sum_array(smart.get(), n) << std::endl;

	return 0;
}
```

Notes / Tips:

- Always match `new[]` with `delete[]`.
- Prefer `std::vector<int>` or `std::unique_ptr<int[]>` to manage arrays automatically.
- Avoid raw owning pointers in modern C++ unless interfacing with C APIs or for educational purposes.
