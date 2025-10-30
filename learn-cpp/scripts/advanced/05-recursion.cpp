#include <iostream>
using namespace std;

int factorial(int n)
{
    if (n <= 1)
        return 1;
    return n * factorial(n - 1);
}

int fibonacci(int n)
{
    if (n <= 1)
        return n; // base cases: fib(0)=0, fib(1)=1
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int sum(int n)
{
    if (n <= 0)
        return 0;
    return n + sum(n - 1);
}

int power(int x, int n)
{
    if (n == 0)
        return 1;
    return x * power(x, n - 1);
}

int gcd(int a, int b)
{
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

int main()
{
    cout << "Factorial of 5: " << factorial(5) << endl;
    cout << "Factorial of 7: " << factorial(7) << endl;

    cout << "First 10 Fibonacci numbers:" << endl;
    for (int i = 0; i < 10; i++)
    {
        cout << fibonacci(i) << " ";
    }
    cout << endl;

    cout << "Sum 1 to 10: " << sum(10) << endl;
    cout << "2^8: " << power(2, 8) << endl;
    cout << "GCD(48, 18): " << gcd(48, 18) << endl;

    return 0;
}