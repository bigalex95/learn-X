#include <iostream>
#include <functional>
#include <vector>
using namespace std;

int add_one(int x)
{
    return x + 1;
}

int times_two(int x)
{
    return x * 2;
}

void apply_and_print(int (*f)(int), int value)
{
    cout << f(value) << endl;
}

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }

// Calculator using function pointers
void calculator()
{
    cout << "=== Calculator using function pointers ===" << endl;
    int (*operations[3])(int, int) = {add, subtract, multiply};
    string operationNames[] = {"Add", "Subtract", "Multiply"};

    int a = 10, b = 5;

    for (int i = 0; i < 3; i++)
    {
        cout << operationNames[i] << ": " << operations[i](a, b) << endl;
    }
}

// Sorting with comparison function pointer
void bubbleSort(int arr[], int n, bool (*compare)(int, int))
{
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = 0; j < n - i - 1; j++)
        {
            if (compare(arr[j], arr[j + 1]))
            {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

bool ascending(int a, int b) { return a > b; }
bool descending(int a, int b) { return a < b; }

void sortingExample()
{
    cout << "\n=== Sorting with function pointers ===" << endl;
    int arr1[] = {64, 34, 25, 12, 22, 11, 90};
    int arr2[] = {64, 34, 25, 12, 22, 11, 90};
    int n = 7;

    cout << "Original array: ";
    for (int i = 0; i < n; i++)
        cout << arr1[i] << " ";
    cout << endl;

    bubbleSort(arr1, n, ascending);
    cout << "Ascending sort: ";
    for (int i = 0; i < n; i++)
        cout << arr1[i] << " ";
    cout << endl;

    bubbleSort(arr2, n, descending);
    cout << "Descending sort: ";
    for (int i = 0; i < n; i++)
        cout << arr2[i] << " ";
    cout << endl;
}

// Modern approach with std::function
void modernApproach()
{
    cout << "\n=== Modern approach with std::function ===" << endl;

    vector<function<int(int, int)>> operations = {
        [](int a, int b)
        { return a + b; },
        [](int a, int b)
        { return a - b; },
        [](int a, int b)
        { return a * b; },
        [](int a, int b)
        { return a / b; }};

    vector<string> names = {"Add", "Subtract", "Multiply", "Divide"};

    int a = 20, b = 4;

    for (size_t i = 0; i < operations.size(); i++)
    {
        cout << names[i] << ": " << operations[i](a, b) << endl;
    }
}

int main()
{
    cout << "=== Basic Function Pointers ===" << endl;
    apply_and_print(add_one, 5);   // prints 6
    apply_and_print(times_two, 5); // prints 10

    calculator();
    sortingExample();
    modernApproach();

    return 0;
}