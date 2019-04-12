package com.rssb.common.helper;

public enum Day {

    Sun(0),
    Mon(1),
    Tue(2),
    Wed(3),
    Thu(4),
    Fri(5),
    Sat(6);

    int dayId;

    Day(int day) {
        this.dayId = day;
    }

    public int getDayId() {
        return dayId;
    }
}
