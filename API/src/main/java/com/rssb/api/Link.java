package com.rssb.api;

public class Link {

    public static class Node {
        Node next;
        int data;

        public Node(int val) {
            next = null;
            data = val;
        }

        @Override
        public String toString() {
            return "" + data;
        }
    }

    Node root = null;

    public void print() {
        System.out.println("------------------------");
        Node ptr = root;
        while (ptr != null) {
            System.out.println(ptr.data);
            ptr = ptr.next;
        }
    }

    public void append(int val) {
        Node newNode = new Node(val);
        if (root == null) {
            root = newNode;
            return;
        }
        Node ptr = root;
        while (ptr.next != null) {
            ptr = ptr.next;
        }
        ptr.next = newNode;
    }

    public void addAtBegin(int val) {
        Node newNode = new Node(val);
        if (root == null) {
            root = newNode;
            return;
        }
        newNode.next = root;
        root = newNode;
    }

    public void reverse() {

        Node prv = null;
        Node curr = root;
        Node nxt;
        while (curr != null) {
            nxt = curr.next;
            curr.next = prv;
            prv = curr;
            curr = nxt;
        }

        root = prv;
    }

    public void reverse(int k) {
        root = reverse(root, k);
    }

    private Node reverse(Node node, int k) {
        Node prv = null;
        Node curr = node;
        Node nxt = null;
        int count = 1;
        while (curr != null && count <= k) {
            nxt = curr.next;
            curr.next = prv;
            prv = curr;
            curr = nxt;
            count++;
        }

        if (nxt != null) {
            node.next = reverse(nxt, k);
        }

        return prv;
    }

    public void recursiveReverse() {
        root = recursiveReverse(root);
    }

    private Node recursiveReverse(Node node) {
        if (null == node || node.next == null)
            return node;

        Node first = node; //1
        Node rest = node.next; //2
        Node reversedList = recursiveReverse(rest); //10
        first.next.next = first;
        first.next = null;
        return reversedList;
    }

    public static void main(String[] args) {
        Link link = new Link();
//        link.print();
        link.append(1);
        link.append(2);
        link.append(3);
        link.append(4);
//
//        link.append(1);
//        link.append(2);
//        link.append(3);
//        link.append(4);
        link.append(5);
        link.append(6);
        link.append(7);
        link.append(8);

//        link.print();

//        link.reverse(3);
        link.recursiveReverse();
        link.print();
    }
}
