#include <iostream>
#include <string>
#include <vector>
#include <functional>
using namespace std;

// Regular function definitions
int squareNumber(int x)
{
    return x * x;
}

void helloThere(string name)
{
    cout << "Hello, " << name << endl;
}

void printSum(int a, int b, int c)
{
    cout << "Sum: " << (a + b + c) << endl;
}

// Complex function examples
int factorial(int n)
{
    if (n <= 1)
        return 1;
    int result = 1;
    for (int i = 2; i <= n; i++)
    {
        result *= i;
    }
    return result;
}

double calculateArea(double length, double width, string shape)
{
    if (shape == "rectangle")
    {
        return length * width;
    }
    else if (shape == "triangle")
    {
        return 0.5 * length * width;
    }
    else if (shape == "circle")
    {
        return 3.14159 * length * length;
    }
    return 0.0;
}

int findMax(vector<int> arr)
{
    int max = arr[0];
    for (int i = 1; i < arr.size(); i++)
    {
        if (arr[i] > max)
        {
            max = arr[i];
        }
    }
    return max;
}

void calculateStats(vector<int> arr)
{
    int sum = 0, max = arr[0], min = arr[0];
    for (int num : arr)
    {
        sum += num;
        if (num > max)
            max = num;
        if (num < min)
            min = num;
    }
    double average = (double)sum / arr.size();

    cout << "Statistics for array: ";
    for (int num : arr)
        cout << num << " ";
    cout << endl;
    cout << "Sum: " << sum << ", Average: " << average << endl;
    cout << "Max: " << max << ", Min: " << min << endl;
}

// Advanced example with structs
struct Student
{
    string name;
    vector<int> grades;
    double gpa;
};

double calculateGPA(const vector<int> &grades)
{
    if (grades.empty())
        return 0.0;
    int sum = 0;
    for (int grade : grades)
    {
        sum += grade;
    }
    return (double)sum / grades.size();
}

void processStudents(vector<Student> &students)
{
    cout << "Processing student data..." << endl;
    for (auto &student : students)
    {
        student.gpa = calculateGPA(student.grades);
        cout << "Student: " << student.name
             << ", GPA: " << student.gpa << endl;
    }
}

string findTopStudent(const vector<Student> &students)
{
    if (students.empty())
        return "No students";
    string topStudent = students[0].name;
    double highestGPA = students[0].gpa;

    for (const auto &student : students)
    {
        if (student.gpa > highestGPA)
        {
            highestGPA = student.gpa;
            topStudent = student.name;
        }
    }
    return topStudent;
}

int main()
{
    // Test basic functions
    cout << "=== Basic Functions ===" << endl;
    int input = 9;
    int output = squareNumber(input);
    cout << input << " squared is " << output << endl;

    helloThere("Celina");
    helloThere("World");

    printSum(5, 10, 15);
    printSum(1, 2, 3);

    // Test complex functions
    cout << "\n=== Complex Functions ===" << endl;
    cout << "Factorial of 5: " << factorial(5) << endl;
    cout << "Factorial of 7: " << factorial(7) << endl;

    cout << "Rectangle area (5x3): " << calculateArea(5.0, 3.0, "rectangle") << endl;
    cout << "Triangle area (5x3): " << calculateArea(5.0, 3.0, "triangle") << endl;
    cout << "Circle area (radius=3): " << calculateArea(3.0, 0, "circle") << endl;

    vector<int> numbers = {3, 7, 2, 9, 1, 5, 8};
    cout << "Maximum in array: " << findMax(numbers) << endl;
    calculateStats(numbers);

    // Test advanced example with structs
    cout << "\n=== Advanced Functions with Structs ===" << endl;
    vector<Student> students = {
        {"Alice", {95, 87, 92, 89}, 0.0},
        {"Bob", {78, 85, 90, 76}, 0.0},
        {"Charlie", {88, 92, 85, 94}, 0.0}};

    processStudents(students);
    cout << "Top student: " << findTopStudent(students) << endl;

    return 0;
}