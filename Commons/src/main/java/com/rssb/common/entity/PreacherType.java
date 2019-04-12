package com.rssb.common.entity;

public enum PreacherType {
    Pathi("Pathi"),
    Karta("Karta"),
    Reader("Reader");
    String id;

    PreacherType(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }
}
