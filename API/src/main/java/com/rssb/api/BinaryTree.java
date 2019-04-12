package com.rssb.api;

import java.util.List;

public class BinaryTree {

    public static class Node {
        Node left;
        Node right;
        int data;

        Node(int newData) {
            left = null;
            right = null;
            data = newData;
        }
    }

    Node root;

    public BinaryTree() {
        root = null;
    }

    private boolean look(int d) {

        return look(root, d);
    }

    private boolean look(Node node, int d) {
        if (null == node)
            return false;
        if (d == node.data)
            return true;
        if (d < node.data)
            return look(node.left, d);
        else
            return look(node.right, d);
    }

    void insert(int d) {
        root = insert(root, d);
    }

    private Node insert(Node node, int d) {
        if (node == null) {
            node = new Node(d);
        } else if (d <= node.data)
            node.left = insert(node.left, d);
        else
            node.right = insert(node.right, d);
        return node;
    }

    void printInorder() {
        printInorder(root);
    }

    void printInorder(Node node) {
        if (node == null)
            return;
        printInorder(node.left);
        System.out.println(node.data);
        printInorder(node.right);
    }

    public boolean hasPathSum(int sum) {
        return (hasPathSum(root, sum));
    }

    public boolean hasPathSum(Node node, int sum) {
        if (node == null)
            return sum == 0;
        return hasPathSum(node.left, sum - node.data) || hasPathSum(node.right, sum - node.data);
    }

    public void printPaths() {
        int[] path = new int[1000];
        printPaths(root, path, 0);
    }

    private void printPaths(Node root, int[] path, int len) {

        if (root == null)
            return;

        path[len++] = root.data;

        if (root.left == null && root.right == null)
            printArray(path, len);
        printPaths(root.left, path, len);
        printPaths(root.right, path, len);
    }

    private void printArray(int[] path, int len) {
        for (int i = 0; i < len; i++) {

            System.out.println(path[i]);
        }
    }

    public void mirror() {
        mirror(root);
    }

    private void mirror(Node node) {
        if (node == null)
            return;
        mirror(node.left);
        mirror(node.right);
        Node left = node.left;
        node.left = node.right;
        node.right = left;
    }

    public void doubleT() {
        doubleT(root);
    }

    private void doubleT(Node node) {
        if (node == null)
            return;
        doubleT(node.left);
        doubleT(node.right);
        Node oldL = node.left;
        node.left = new Node(node.data);
        node.left.left = oldL;
    }

    public boolean sameTree(BinaryTree other) {
        return (sameTree(root, other.root));
    }

    private boolean sameTree(Node a, Node b) {

        if (a == null && b == null)
            return true;

        if (a != null && b != null) {
            return (a.data == b.data) && sameTree(a.left, b.left) && sameTree(a.right, b.right);
        } else
            return false;
    }

    public boolean isBST() {
        return (isBST(root, Integer.MIN_VALUE, Integer.MAX_VALUE));
    }

    private boolean isBST(Node node, int min, int max) {

        if (node.data > max)
            return false;
        if (node.data < min)
            return false;
        return isBST(node.left, min, node.data) && isBST(node.right, node.data + 1, max);
    }

//
//    public List<String> anagrams(char[] str) {
//
//
//
//
//
//    }
//

    public static void main(String[] args) {

        BinaryTree binaryTree = new BinaryTree();
        binaryTree.insert(10);
        binaryTree.insert(1);
        binaryTree.insert(7);
        binaryTree.insert(9);
        binaryTree.insert(4);

        System.out.println(binaryTree.look(1));
        binaryTree.printInorder();
    }
}
