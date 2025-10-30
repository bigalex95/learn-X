#include <iostream>
using namespace std;

// Template metaprogramming factorial
template <unsigned int n>
struct factorial
{
    enum
    {
        value = n * factorial<n - 1>::value
    };
};

// Template specialization for base case
template <>
struct factorial<0>
{
    enum
    {
        value = 1
    };
};

// Template for computing 2^n at compile time
template <unsigned int n>
struct power_of_2
{
    enum
    {
        value = 2 * power_of_2<n - 1>::value
    };
};

// Base case: 2^0 = 1
template <>
struct power_of_2<0>
{
    enum
    {
        value = 1
    };
};

// Template for computing Fibonacci numbers at compile time
template <unsigned int n>
struct fibonacci
{
    enum
    {
        value = fibonacci<n - 1>::value + fibonacci<n - 2>::value
    };
};

template <>
struct fibonacci<0>
{
    enum
    {
        value = 0
    };
};

template <>
struct fibonacci<1>
{
    enum
    {
        value = 1
    };
};

// Modern C++11 constexpr approach (alternative to template metaprogramming)
constexpr int constexpr_factorial(int n)
{
    return (n <= 1) ? 1 : n * constexpr_factorial(n - 1);
}

constexpr int constexpr_power_of_2(int n)
{
    return (n == 0) ? 1 : 2 * constexpr_power_of_2(n - 1);
}

// Template function for type-generic operations
template <typename T>
T max_value(T a, T b)
{
    return (a > b) ? a : b;
}

template <typename T, int size>
void print_array(T (&arr)[size])
{
    cout << "Array of size " << size << ": ";
    for (int i = 0; i < size; i++)
    {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main()
{
    cout << "=== Template Metaprogramming ===" << endl;

    // These values are calculated at compile time!
    cout << "factorial<0>: " << factorial<0>::value << endl;
    cout << "factorial<5>: " << factorial<5>::value << endl;
    cout << "factorial<10>: " << factorial<10>::value << endl;

    cout << "\n=== Powers of 2 ===" << endl;
    cout << "2^0 = " << power_of_2<0>::value << endl;
    cout << "2^5 = " << power_of_2<5>::value << endl;
    cout << "2^10 = " << power_of_2<10>::value << endl;
    cout << "2^16 = " << power_of_2<16>::value << endl;

    cout << "\n=== Fibonacci Numbers ===" << endl;
    cout << "fib(0) = " << fibonacci<0>::value << endl;
    cout << "fib(1) = " << fibonacci<1>::value << endl;
    cout << "fib(10) = " << fibonacci<10>::value << endl;
    cout << "fib(15) = " << fibonacci<15>::value << endl;

    cout << "\n=== Modern constexpr approach ===" << endl;
    cout << "constexpr_factorial(5) = " << constexpr_factorial(5) << endl;
    cout << "constexpr_power_of_2(8) = " << constexpr_power_of_2(8) << endl;

    cout << "\n=== Template Functions ===" << endl;
    cout << "max(10, 20) = " << max_value(10, 20) << endl;
    cout << "max(3.14, 2.71) = " << max_value(3.14, 2.71) << endl;
    cout << "max('a', 'z') = " << max_value('a', 'z') << endl;

    int int_arr[] = {1, 2, 3, 4, 5};
    double double_arr[] = {1.1, 2.2, 3.3};

    print_array(int_arr);
    print_array(double_arr);

    return 0;
}