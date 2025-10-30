#include <iostream>
using namespace std;

int main()
{
    // Declare and initialize array
    int marks[] = {96, 92, 78, 54, 86};

    // Print array elements using a loop
    cout << "Marks: " << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << marks[i] << endl;
    }

    // Exercise: Initialize a keys array with values 'b', 'c', 'd', 'a', 'b', 'b' and print the third element
    char keys[6] = {'b', 'c', 'd', 'a', 'b', 'b'};

    cout << "Third element: " << keys[2] << endl;

    return 0;
}