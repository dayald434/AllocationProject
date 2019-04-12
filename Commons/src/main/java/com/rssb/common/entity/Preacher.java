package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Builder
@Data
public class Preacher {
    String shortName;
    String name;
    String iniDate;
    String dob;
    String sgName;
    Long sgId;
    String type;
    String sex;
    Long mobile1;
    Long mobile2;
    String address;
    String tp;
    String city;
    String[] availableDays = {};
    String[] lang = {};
}
