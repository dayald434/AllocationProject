package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class PreacherAllocation {
    String date;
    String time;
    String shortName;
}
