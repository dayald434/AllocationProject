package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Language {
    String lang;
    String local;
}
