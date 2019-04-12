package com.rssb.api;

import java.util.LinkedList;
import java.util.Queue;

public class Graph {

    private int v;
    private LinkedList<Integer> adj[];

    public Graph(int n) {
        v = n;
        adj = new LinkedList[v];
        for (int i = 0; i < v; i++) {
            adj[i] = new LinkedList<>();
        }
    }

    public void addEdge(int m, int n) {
        adj[m].add(n);
    }

    public void BFS(int s) {

        boolean visited[] = new boolean[v];
        Queue<Integer> queue = new LinkedList<>();


    }
}
