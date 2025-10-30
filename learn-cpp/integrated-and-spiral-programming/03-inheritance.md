# Inheritance

---

Let's extend the `class Point` from the previous tutorial to handle **Complex** numbers. The `real` and `imaginary` numbers will be defined as `private` integer `references` to coordinates of the Point `object`.

```cpp
#include <iostream>
using namespace std;

class Point;
std::ostream& operator<<(std::ostream& out, const Point& c);

template<typename T>
void Swap(T &a, T &b) { T temp = a; a = b; b = temp; }

class Point {
public:
    int x, y;

    Point (int c1, int c2) { x = c1; y = c2;}
    Point& operator=(Point rhs) {
        x = rhs.x; y = rhs.y;
        return *this;
    }
};

class Complex : public Point {
  private:
    int &real, &imag;
  public:
    Complex(int r, int i) : Point (r, i), real (x), imag (y)
    { cout << "Forming..." << *this; }

};

int main()
{

    Complex c1(15, 15), c2 (100, 100);
    return 0;
}

std::ostream& operator<<(std::ostream& out, const Point& c)
{
  out<< "x:" << c.x << " ";
  out<< "y:" << c.y << "\n";
  return out;
}
```

## Exercise

Form two `Complex` objects. Use the `Swap` function to swap the `Complex` objects as Point types. Reset the code area, and take the opportunity to write everything from scratch.

Print the swapped objects as `Point` objects. Subsequently, also print the swapped objects as `Complex` objects.
