package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
//@AllArgsConstructor
public class Allocation {

    Long sgId;
    String satDate;
    String day;
    String time;
    String[] pathi;
    String preacher;
    String cdId;
    String createdDate;
    Boolean isCD = false;
    String satsangGharName;
    Boolean isStagePathiAlsoGround;
}
