# Generic Programming

---

Templates in C++ help implement generic programming in C++. The `Swap` function from the previous tutorial is powerful enough to support any other data type that needs to be swapped. In the code below, `Swap` can be used as-is to swap two integers.

```cpp
#include <iostream>
using namespace std;

template<typename T>
void Swap(T &a, T&b)
{
    T temp = a;
    a = b;
    b = temp;
}

int main()
{
    string hello = "world!", world = "Hello, ";
    Swap(world, hello);
    cout << hello << world << endl;

    int a = 5, b = 11;
    Swap(a, b);
    cout << "a:" << a << " b:" << b << endl;
    return 0;
}
```

### Templates, Classes and Operator Overloading

## Exercise

The Swap function will also work with user-defined data types. To demonstrate this, implement a C++ `class Point` which has coordinates x and y. Create two objects of the type `Point` and swap them. Operator overloading for the operator `=` also has to be implemented.
