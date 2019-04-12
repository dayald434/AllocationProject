package com.rssb.api.filter;

import com.rssb.api.satsangGhar.ApiHelper;
import com.rssb.common.entity.Preacher;
import com.rssb.common.helper.Util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class DayAvailFilter {

    public  synchronized  static List<Preacher> filter(List<Preacher> inputList, Map<String, Object> context) {
        List<Preacher> outputList = new ArrayList<>();
        String dateString = (String) context.get("DateString");
        String day = Util.dateToDayMap.get(dateString);
        for (Preacher preacher : inputList) {
            if (Util.contains(preacher.getAvailableDays(), day)) {
                outputList.add(preacher);
            }
        }
        return outputList;
    }

    public static void main(String[] args) throws Exception {
        ApiHelper apiHelper = new ApiHelper();
        List<Preacher> list = apiHelper.getAllPreacher();
        System.out.println("count= " + list.size());
        Map<String, Object> context = new ConcurrentHashMap<>();
        context.put("DateString", "10-Mar-2017");
        Util.dateToDayMap.put("10-Mar-2017", "MOn");
        DayAvailFilter dayAvailFilter = new DayAvailFilter();
        List<Preacher> o = dayAvailFilter.filter(list, context);


    }
}
