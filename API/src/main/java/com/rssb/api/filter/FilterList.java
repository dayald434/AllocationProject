package com.rssb.api.filter;

import com.rssb.api.helper.DatabaseHelper;
import com.rssb.api.satsangGhar.ApiHelper;
import com.rssb.common.entity.Leave;
import com.rssb.common.entity.Preacher;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class FilterList {

    public static DatabaseHelper databaseHelper = DatabaseHelper.getInstance();

    public synchronized static List<Preacher> filterPreacherBasedOnAttendance(String date, List<Preacher> inputList, Map<String, List<Leave>> leaveMap) {
        List<Preacher> preacherList = new ArrayList<>();
        for (Preacher preacher : inputList) {
            System.out.println("Testing Preacher : "+preacher);
            List<Leave> leaveList = leaveMap.get(preacher.getShortName());
            if (null == leaveList)
                preacherList.add(preacher);
            else if (isAvailable(leaveList, date))
                preacherList.add(preacher);
        }

        return preacherList;
    }

    private synchronized static boolean isAvailable(List<Leave> leaveList, String dateStr) {
        Date date = new Date(dateStr);
        for (Leave leave : leaveList) {
            System.out.println(leave.getStartDate());
            Date startDate = new Date(leave.getStartDate());
            Date endDate = new Date(leave.getEndDate());

            if ((date.compareTo(startDate) >= 0) && date.compareTo(endDate) <= 0)
                return false;
        }

        return true;
    }

    public static void main(String[] args) throws Exception {

        Map<String, List<Leave>> map = getLeaveMap("2017/08/24", "2017/08/25");

        ApiHelper apiHelper = new ApiHelper();
        List<Preacher> list = apiHelper.getPreacher("true");
        System.out.println("-------------");
        System.out.println(list);
        List<Preacher> out = filterPreacherBasedOnAttendance("25-Aug-2017", list, map);
        System.out.println("-------------");
        System.out.println(out);
    }

    public static synchronized Map<String, List<Leave>> getLeaveMap(String startDate, String endDate) {

        return databaseHelper.getLeaveMap(startDate, endDate);
    }
}
