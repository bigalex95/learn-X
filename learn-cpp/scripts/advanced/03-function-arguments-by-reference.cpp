#include <iostream>
#include <string>
using namespace std;

void addone(int *n)
{
    (*n)++;
}

struct point
{
    int x;
    int y;
};

void move(point *p)
{
    p->x++;
    p->y++;
}

struct person
{
    string name;
    int age;
};

void birthday(person *p)
{
    p->age++;
}

int main()
{
    // Test addone function
    int n = 5;

    cout << "Before: " << n << endl;
    addone(&n);
    cout << "After: " << n << endl;

    // Test move function
    point p = {5, 10};

    cout << "Before: (" << p.x << ", " << p.y << ")" << endl;
    move(&p);
    cout << "After: (" << p.x << ", " << p.y << ")" << endl;

    // Test birthday function
    person alice = {"Alice", 25};

    cout << alice.name << " is " << alice.age << " years old" << endl;
    birthday(&alice);
    cout << "After birthday: " << alice.name << " is " << alice.age << " years old" << endl;

    return 0;
}