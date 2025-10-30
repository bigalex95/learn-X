#include <iostream>
#include <memory>
using namespace std;

int *create_array_raw(int n)
{
    int *a = new int[n];
    for (int i = 0; i < n; ++i)
        a[i] = i;
    return a;
}

unique_ptr<int[]> create_array_smart(int n)
{
    unique_ptr<int[]> a(new int[n]);
    for (int i = 0; i < n; ++i)
        a[i] = i;
    return a;
}

int sum_array(const int *arr, int n)
{
    int s = 0;
    for (int i = 0; i < n; ++i)
        s += arr[i];
    return s;
}

int main()
{
    const int n = 10;

    int *raw = create_array_raw(n);
    cout << "sum raw: " << sum_array(raw, n) << endl;
    delete[] raw; // Must free manually

    auto smart = create_array_smart(n);
    cout << "sum smart: " << sum_array(smart.get(), n) << endl;
    // Automatically freed when smart goes out of scope

    return 0;
}