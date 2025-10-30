#include <iostream>
using namespace std;

int main()
{
    int num = 10;

    if (num % 2 == 0)
    {
        cout << "Number is Even" << endl;
    }
    else
    {
        cout << "Number is Odd" << endl;
    }

    // Exercise: Print age groups: Child (< 20), Adult (>= 20 and < 60), Retired (>= 60)
    int age = 25;

    if (age < 20)
    {
        cout << "Child" << endl;
    }
    else if (age >= 20 && age < 60)
    {
        cout << "Adult" << endl;
    }
    else
    {
        cout << "Retired" << endl;
    }

    return 0;
}