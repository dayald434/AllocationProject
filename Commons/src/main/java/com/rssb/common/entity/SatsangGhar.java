package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

/**
 * Created by arun on 25/7/17.
 */
@Data
@Builder
public class SatsangGhar {
    Long id;
    String name;
    String centerType;
    Long parentCenterid;
    String address1;
    String address2;
    String city;
    String state;
    String pinCode;
    Long mobile1;
    Long mobile2;
    String landline1;
    String landline2;
    String map;
    String secName;
    Long secMobile;
    Integer numberOfPathis;
    Boolean isStagePathiAlsoGround;
}
