#include <iostream>
using namespace std;

int main()
{
    // Define and initialize variables
    int a = 0, b = 1, c = 2, d = 3, e = 4;

    // Perform arithmetic
    a = b - c + d * e;

    cout << "Result: " << a << endl; // will print 1-2+3*4 = 11

    // Exercise: Create a program which prints out the sum of numbers a, b, and c
    int x = 5, y = 10, z = 15;
    int sum = x + y + z;

    cout << "Sum: " << sum << endl;

    return 0;
}