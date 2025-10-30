#include <iostream>
#include <cmath>
using namespace std;

class Point;
ostream &operator<<(ostream &out, const Point &c);

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

    Point(int c1, int c2) : x(c1), y(c2) {}

    Point &operator=(Point rhs)
    {
        x = rhs.x;
        y = rhs.y;
        return *this;
    }
};

// Complex inherits from Point
class Complex : public Point
{
public:
    Complex(int r, int i) : Point(r, i)
    {
        cout << "Forming Complex: " << *this;
    }

    void printComplex() const
    {
        cout << "Complex: real=" << x << " imag=" << y << endl;
    }

    // Additional complex number operations
    Complex operator+(const Complex &other) const
    {
        return Complex(x + other.x, y + other.y);
    }

    Complex operator*(const Complex &other) const
    {
        // (a + bi) * (c + di) = (ac - bd) + (ad + bc)i
        int newReal = x * other.x - y * other.y;
        int newImag = x * other.y + y * other.x;
        return Complex(newReal, newImag);
    }

    double magnitude() const
    {
        return sqrt(x * x + y * y);
    }
};

ostream &operator<<(ostream &out, const Point &c)
{
    out << "x:" << c.x << " y:" << c.y << "\n";
    return out;
}

int main()
{
    cout << "=== Basic Inheritance Example ===" << endl;
    Complex c1(15, 15), c2(100, 100);

    cout << "\nBefore swap:" << endl;
    cout << "c1 as Point: " << c1;
    cout << "c2 as Point: " << c2;

    Swap(c1, c2);

    cout << "\nAfter swap:" << endl;
    cout << "c1 as Point: " << c1;
    cout << "c2 as Point: " << c2;

    c1.printComplex();
    c2.printComplex();

    cout << "\n=== Complex Number Operations ===" << endl;
    Complex a(3, 4);
    Complex b(1, 2);

    cout << "a: ";
    a.printComplex();
    cout << "b: ";
    b.printComplex();

    Complex sum = a + b;
    cout << "a + b: ";
    sum.printComplex();

    Complex product = a * b;
    cout << "a * b: ";
    product.printComplex();

    cout << "Magnitude of a: " << a.magnitude() << endl;
    cout << "Magnitude of b: " << b.magnitude() << endl;

    cout << "\n=== Inheritance Benefits ===" << endl;
    cout << "- Complex inherits public members (x, y) from Point" << endl;
    cout << "- References (real, imag) are bound to base class members" << endl;
    cout << "- Swap works because Complex is-a Point" << endl;
    cout << "- Inheritance enables code reuse and polymorphism" << endl;

    return 0;
}