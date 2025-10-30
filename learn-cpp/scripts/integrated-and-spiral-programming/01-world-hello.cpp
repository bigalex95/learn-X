#include <iostream>
#include <string>
using namespace std;

template <typename T>
void swap_values(T &a, T &b)
{
    T tmp = a;
    a = b;
    b = tmp;
}

int main()
{
    // Test with strings
    string s1 = "Hello";
    string s2 = "world!";

    cout << "Before swap: s1=\"" << s1 << "\", s2=\"" << s2 << "\"" << endl;
    swap_values(s1, s2);
    cout << "After swap: s1=\"" << s1 << "\", s2=\"" << s2 << "\"" << endl;

    // Print in the required order to get "world!, Hello"
    cout << "Output: " << s2 << ", " << s1 << endl;

    // Test with integers
    int a = 5, b = 11;

    cout << "\nBefore swap: a=" << a << " b=" << b << endl;
    swap_values(a, b);
    cout << "After swap: a=" << a << " b=" << b << endl;

    // Test with doubles
    double x = 3.14, y = 2.71;

    cout << "\nBefore swap: x=" << x << " y=" << y << endl;
    swap_values(x, y);
    cout << "After swap: x=" << x << " y=" << y << endl;

    return 0;
}