package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class User {
    String name;
    String userName;
    String emailId;
}
