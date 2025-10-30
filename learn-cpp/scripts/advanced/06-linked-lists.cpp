#include <iostream>
using namespace std;

struct Node
{
    int data;
    Node *next;
    Node(int value) : data(value), next(nullptr) {}
};

class LinkedList
{
private:
    Node *head;

public:
    LinkedList() : head(nullptr) {}

    ~LinkedList()
    {
        while (head)
        {
            Node *temp = head;
            head = head->next;
            delete temp;
        }
    }

    void insert(int value)
    {
        Node *newNode = new Node(value);
        newNode->next = head;
        head = newNode;
    }

    void display()
    {
        Node *current = head;
        while (current)
        {
            cout << current->data << " -> ";
            current = current->next;
        }
        cout << "NULL" << endl;
    }

    bool search(int value)
    {
        Node *current = head;
        while (current)
        {
            if (current->data == value)
            {
                return true;
            }
            current = current->next;
        }
        return false;
    }

    void remove(int value)
    {
        if (!head)
            return;

        if (head->data == value)
        {
            Node *temp = head;
            head = head->next;
            delete temp;
            return;
        }

        Node *current = head;
        while (current->next && current->next->data != value)
        {
            current = current->next;
        }

        if (current->next)
        {
            Node *temp = current->next;
            current->next = current->next->next;
            delete temp;
        }
    }
};

int main()
{
    LinkedList list;

    cout << "Inserting elements: 1, 2, 3, 4, 5" << endl;
    list.insert(1);
    list.insert(2);
    list.insert(3);
    list.insert(4);
    list.insert(5);

    cout << "List contents: ";
    list.display();

    cout << "Searching for 3: " << (list.search(3) ? "Found" : "Not found") << endl;
    cout << "Searching for 6: " << (list.search(6) ? "Found" : "Not found") << endl;

    cout << "Removing element 3" << endl;
    list.remove(3);

    cout << "List contents after removal: ";
    list.display();

    return 0;
}