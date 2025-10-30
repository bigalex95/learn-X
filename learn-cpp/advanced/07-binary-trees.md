# Binary trees

---

## Tutorial

This lesson introduces a simple binary search tree (BST): node structure, insertion, and inorder traversal. We'll keep the implementation minimal and focused on clarity.

Key points:

- A BST stores keys such that left subtree < node < right subtree.
- Inorder traversal of a BST visits nodes in sorted order.
- Basic operations: node creation, insertion, traversal, and destruction.

## Exercise

Implement a `insert` function that inserts integers into a BST and an `inorder_print` function that prints the values in order. Use the provided skeleton to build a tree from the list {4, 2, 6, 1, 3, 5, 7} and print the inorder traversal.

## Tutorial Code

```cpp
#include <iostream>

struct Node {
	int value;
	Node* left;
	Node* right;
	Node(int v): value(v), left(nullptr), right(nullptr) {}
};

// TODO: implement insert
Node* insert(Node* root, int value) {
	return nullptr; // replace
}

// TODO: implement inorder traversal
void inorder_print(Node* root) {
}

void destroy(Node* root) {
	if (!root) return;
	destroy(root->left);
	destroy(root->right);
	delete root;
}

int main() {
	int values[] = {4,2,6,1,3,5,7};
	Node* root = nullptr;
	for (int v : values) root = insert(root, v);
	inorder_print(root);
	std::cout << std::endl;
	destroy(root);
	return 0;
}
```

## Expected Output

Correct inorder traversal prints the numbers in sorted order:

```text
1 2 3 4 5 6 7
```

## Solution

```cpp
#include <iostream>

struct Node {
	int value;
	Node* left;
	Node* right;
	Node(int v): value(v), left(nullptr), right(nullptr) {}
};

Node* insert(Node* root, int value) {
	if (!root) return new Node(value);
	if (value < root->value) root->left = insert(root->left, value);
	else root->right = insert(root->right, value);
	return root;
}

void inorder_print(Node* root) {
	if (!root) return;
	inorder_print(root->left);
	std::cout << root->value << ' ';
	inorder_print(root->right);
}

void destroy(Node* root) {
	if (!root) return;
	destroy(root->left);
	destroy(root->right);
	delete root;
}

int main() {
	int values[] = {4,2,6,1,3,5,7};
	Node* root = nullptr;
	for (int v : values) root = insert(root, v);
	inorder_print(root);
	std::cout << std::endl;
	destroy(root);
	return 0;
}
```

Notes / Extensions:

- Try adding `find` or `remove` operations.
- For production code, prefer balanced trees (AVL, red-black) to avoid degeneration.
