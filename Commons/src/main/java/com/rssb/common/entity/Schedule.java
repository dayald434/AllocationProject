package com.rssb.common.entity;

import com.rssb.common.helper.Util;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class Schedule {
    Long id;
    String day;
    String time;
    String lang[] = {};

    public static void main(String[] args) {
        String w1Lang = "ddd";

        String lang[] = {w1Lang};
        System.out.println(lang[0]);
        System.out.println(Util.toStringArray(lang));
    }
}
