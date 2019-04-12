package com.rssb.common.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Attendance {

	Long sgId;
	String date;
	String pathi;
	String preacher;
	String book;
	String saint;
	Long gents;
	Long ladies;
	Long children;
	Long four_wheeler;
	Long two_wheeler;
	String shabad;
}



