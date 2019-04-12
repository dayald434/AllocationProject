package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Leave {
    Long id;
    String shortName;
    String startDate;
    String endDate;

}
