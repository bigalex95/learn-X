#include <iostream>
#include <string>
using namespace std;

template <typename T>
void Swap(T &a, T &b)
{
    T temp = a;
    a = b;
    b = temp;
}

class Point
{
public:
    int x, y;

    Point(int x_val = 0, int y_val = 0) : x(x_val), y(y_val) {}

    // Operator overloading for assignment
    Point &operator=(const Point &rhs)
    {
        x = rhs.x;
        y = rhs.y;
        return *this;
    }

    void print() const
    {
        cout << "(" << x << ", " << y << ")";
    }
};

int main()
{
    // Test with built-in types
    string hello = "world!", world = "Hello, ";
    Swap(world, hello);
    cout << hello << world << endl;

    int a = 5, b = 11;
    Swap(a, b);
    cout << "a:" << a << " b:" << b << endl;

    // Test with custom classes
    cout << "\n=== Testing with custom Point class ===" << endl;
    Point p1(10, 20), p2(30, 40);

    cout << "Before swap: ";
    p1.print();
    cout << " and ";
    p2.print();
    cout << endl;

    Swap(p1, p2);

    cout << "After swap: ";
    p1.print();
    cout << " and ";
    p2.print();
    cout << endl;

    // Additional tests with different types
    cout << "\n=== Additional type tests ===" << endl;

    double d1 = 3.14, d2 = 2.71;
    cout << "Before swap: d1=" << d1 << " d2=" << d2 << endl;
    Swap(d1, d2);
    cout << "After swap: d1=" << d1 << " d2=" << d2 << endl;

    char c1 = 'A', c2 = 'Z';
    cout << "Before swap: c1=" << c1 << " c2=" << c2 << endl;
    Swap(c1, c2);
    cout << "After swap: c1=" << c1 << " c2=" << c2 << endl;

    return 0;
}