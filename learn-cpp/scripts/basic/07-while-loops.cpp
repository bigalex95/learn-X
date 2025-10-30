#include <iostream>
using namespace std;

int main()
{
    int count = 1;

    cout << "Counting from 1 to 5:" << endl;
    while (count <= 5)
    {
        cout << count << endl;
        count++;
    }

    // Example with break and continue
    count = 200;
    int destination = 0;

    while (count > destination)
    {
        count--;

        if (count == 190)
        {
            cout << "Skipped 190..." << endl;
            continue;
        }

        if (count < 180)
        {
            cout << "Aborted at " << count << endl;
            break;
        }

        cout << count << endl;
    }

    // Exercise: Print all numbers from 1 to 20 in ascending order using a while loop
    int i = 1;

    while (i <= 20)
    {
        cout << i << " ";
        i++;
    }
    cout << endl;

    return 0;
}