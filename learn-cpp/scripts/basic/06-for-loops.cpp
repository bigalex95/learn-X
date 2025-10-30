#include <iostream>
using namespace std;

int main()
{
    // Print numbers 0 to 9
    for (int i = 0; i < 10; i++)
    {
        cout << i << endl;
    }

    // Modern C++ foreach loop
    int arr[] = {1, 2, 3, 4, 5, 6};

    cout << "Array elements: " << endl;
    for (const int &n : arr)
    {
        cout << n << " ";
    }
    cout << endl;

    // Exercise: Print all even numbers below 20 in ascending order
    cout << "Even numbers below 20:" << endl;
    for (int i = 0; i < 20; i += 2)
    {
        cout << i << " ";
    }
    cout << endl;

    return 0;
}