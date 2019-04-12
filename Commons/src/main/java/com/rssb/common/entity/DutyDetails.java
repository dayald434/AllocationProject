package com.rssb.common.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class DutyDetails {

    Duty duty;
    Integer number;

    @Override
    public String toString() {
        if (duty == Duty.STAGE)
            return "Stage";
        else
            return "Ground" + number;
    }
}
