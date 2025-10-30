#include <iostream>
using namespace std;

struct Node
{
    int value;
    Node *left;
    Node *right;
    Node(int v) : value(v), left(nullptr), right(nullptr) {}
};

Node *insert(Node *root, int value)
{
    if (!root)
        return new Node(value);
    if (value < root->value)
        root->left = insert(root->left, value);
    else
        root->right = insert(root->right, value);
    return root;
}

void inorder_print(Node *root)
{
    if (!root)
        return;
    inorder_print(root->left);
    cout << root->value << ' ';
    inorder_print(root->right);
}

bool find(Node *root, int value)
{
    if (!root)
        return false;
    if (root->value == value)
        return true;
    if (value < root->value)
        return find(root->left, value);
    return find(root->right, value);
}

Node *findMin(Node *root)
{
    if (!root)
        return nullptr;
    while (root->left)
        root = root->left;
    return root;
}

Node *remove(Node *root, int value)
{
    if (!root)
        return root;

    if (value < root->value)
    {
        root->left = remove(root->left, value);
    }
    else if (value > root->value)
    {
        root->right = remove(root->right, value);
    }
    else
    {
        // Node to be deleted found
        if (!root->left)
        {
            Node *temp = root->right;
            delete root;
            return temp;
        }
        else if (!root->right)
        {
            Node *temp = root->left;
            delete root;
            return temp;
        }

        // Node with two children
        Node *temp = findMin(root->right);
        root->value = temp->value;
        root->right = remove(root->right, temp->value);
    }
    return root;
}

void destroy(Node *root)
{
    if (!root)
        return;
    destroy(root->left);
    destroy(root->right);
    delete root;
}

int main()
{
    int values[] = {4, 2, 6, 1, 3, 5, 7};
    Node *root = nullptr;

    cout << "Inserting values: ";
    for (int v : values)
    {
        cout << v << " ";
        root = insert(root, v);
    }
    cout << endl;

    cout << "Inorder traversal (sorted): ";
    inorder_print(root);
    cout << endl;

    cout << "Finding value 5: " << (find(root, 5) ? "Found" : "Not found") << endl;
    cout << "Finding value 8: " << (find(root, 8) ? "Found" : "Not found") << endl;

    cout << "Removing value 2" << endl;
    root = remove(root, 2);

    cout << "Inorder traversal after removal: ";
    inorder_print(root);
    cout << endl;

    destroy(root);
    return 0;
}