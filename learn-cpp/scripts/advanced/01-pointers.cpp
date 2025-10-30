#include <iostream>
using namespace std;

int main()
{
    int a = 5;  // Declare and initialize a variable
    int *b = 0; // Create a pointer and initialize with 0

    cout << "b initially points to: " << b << endl
         << endl;

    b = &a; // b now points to the address of a

    cout << "a is stored at: " << &a << endl;
    cout << "b is stored at: " << &b << endl;
    cout << "b points to: " << b << endl
         << endl;

    cout << "Value of a: " << a << endl;
    cout << "Value at address b points to: " << *b << endl
         << endl;

    // Modify value through pointer
    *b = 10;

    cout << "After modification:" << endl;
    cout << "Value of a: " << a << endl;
    cout << "Value at address b points to: " << *b << endl;

    // Exercise: Indirectly access and modify the value of n
    int n = 10;
    void *p1;
    int *p2;

    p1 = &n;
    p2 = (int *)p1; // C++ requires explicit typecast

    (*p2)++; // Increase value indirectly

    cout << "Value of n: " << n << endl;

    return 0;
}