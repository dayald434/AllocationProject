package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class State {
    String code;
    String name;
}
