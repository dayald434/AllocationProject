package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class City {
  String code;
  String name;
  String stateCode;
  String stateName;

}
