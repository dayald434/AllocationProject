package com.rssb.common.helper;

import com.google.common.base.Strings;
import com.rssb.common.entity.Allocation;
import com.rssb.common.entity.CD;
import com.rssb.common.entity.Duty;
import com.rssb.common.entity.DutyDetails;
import org.apache.commons.lang.WordUtils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class Util {

    //Format
    public static Map<String, String> dateToDayMap = new ConcurrentHashMap<>();
    public static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    public static final SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MMM-yyyy");

//    public static String[] languages = {"Hindi", "Kannada", "English", "Malayalam", "Punjabi", "Sans", "Telgu"};

    public synchronized static List<Date> getDates(String startDateS, String endDateS, List<String> dayList) throws Exception {

        Set<String> set = new HashSet<>();
        set.addAll(dayList);
        dayList = new ArrayList(set);
        Date startDate = sdf.parse(startDateS);
        Date endDate = sdf.parse(endDateS);
        int startDay = startDate.getDay();
        List<Date> dateList = new ArrayList<>();

        for (String dayS : dayList) {
            Day day = Day.valueOf(dayS);
            int diff = day.getDayId() - startDay;
            if (diff < 0)
                diff += 7;
            Calendar calendar = Calendar.getInstance();
            Calendar endcalendar = Calendar.getInstance();
            endcalendar.setTime(endDate);
            calendar.setTime(startDate);
            calendar.add(Calendar.DATE, diff);
            String firtsDateS = sdf.format(calendar.getTime());
            List<Date> dateList1 = new ArrayList();
            if (calendar.compareTo(endcalendar) <= 0) {
                dateList1.add(sdf.parse(firtsDateS));
                dateToDayMap.put(outputFormat.format(sdf.parse(firtsDateS)), dayS);
                System.out.println(diff + "   " + firtsDateS);
            }
            while (calendar.compareTo(endcalendar) <= 0) {
                calendar.add(Calendar.DATE, 7);
                String nextDate = sdf.format(calendar.getTime());
                if (calendar.compareTo(endcalendar) > 0)
                    break;
                dateList1.add(sdf.parse(nextDate));
                dateToDayMap.put(outputFormat.format(sdf.parse(nextDate)), dayS);
            }
            dateList.addAll(dateList1);
        }
        Collections.sort(dateList);

        return dateList;
    }

    public synchronized static String toStringArray(String[] param) {
        if (null == param)
            return "{}";
        if (param.length == 0)
            return "{}";
        String s = "{";

        for (int i = 0; i < param.length; i++) {
            s += "\"" + param[i] + "\",";
        }
        return s.substring(0, s.length() - 1) + "}";
    }

    public Long getLong(String parameter) {
        System.out.println("Paramer is : " + parameter);
        if (Strings.isNullOrEmpty(parameter))
            return null;
        else
            return Long.parseLong(parameter);
    }

    public static synchronized int getWeek(int dd) {
        return (dd - 1) / 7 + 1;
    }

    public static synchronized String[] getLangArray(String str) {
        if (null == str)
            return null;
        str = str.replace("{", "").replace("}", "");
        return str.split(",");
    }

    public static synchronized Map<String, String> getWeekLanMap(String str) {

        str = str.replace("{", "").replace("}", "");
        String arr[] = str.split(",");
        Map<String, String> weekLangMap = new ConcurrentHashMap<>();
        for (int i = 0; i < arr.length; i++) {
            int w = i + 1;
            weekLangMap.put("" + w, arr[i]);
        }
        return weekLangMap;
    }

    public static synchronized String truncateTime(String time) {

        String token[] = time.split(":");
        return token[0] + ":" + token[1];
    }

    public static synchronized boolean contains(String[] array, String value) {

        for (int i = 0; i < array.length; i++) {
            if (array[i].equalsIgnoreCase(value))
                return true;
        }
        return false;
    }

    public static synchronized String getPathi(int pathiNumber, String[] pathiArray) {

        if (pathiArray == null)
            return "";
        int allowedIndex = pathiArray.length - 1;

        if (pathiNumber > allowedIndex)
            return "";
        if (pathiArray[pathiNumber] == null)
            return "";
        String sn = pathiArray[pathiNumber];
        if ("\"\"".equalsIgnoreCase(sn))
            return "";
        return sn;
    }

    public static synchronized String getPathi(int pathiNumber, Allocation allocation) {
        if (allocation == null)
            return "";
        return getPathi(pathiNumber, allocation.getPathi());
    }

    public static synchronized String getPathiName(int pathiNumber, Allocation allocation, Map<String, String> contrMap) {
        if (allocation == null)
            return "";
        String sn = getPathi(pathiNumber, allocation.getPathi());
        if (Strings.isNullOrEmpty(sn))
            return "";
        String name = contrMap.get(sn.trim());
        if (!Strings.isNullOrEmpty(name))
            return WordUtils.capitalize(name);
        return "";
    }

    public static synchronized String getPreacherName(Allocation allocation, Map<String, String> contrMap) {
        if (allocation == null)
            return "";
        String sn = allocation.getPreacher();
        if (Strings.isNullOrEmpty(sn))
            return "";

        String name = contrMap.get(sn.trim());
        if (!Strings.isNullOrEmpty(name))
            return WordUtils.capitalize(name);
        return "";
    }

    public static CD getCD(Allocation allocation, Map<String, CD> cdMap) {
        if (allocation == null)
            return null;
        String id = allocation.getCdId();
        if (Strings.isNullOrEmpty(id))
            return null;
        return cdMap.get(id);
    }

    public static void main(String[] args) throws Exception {

//        String[] name = {"hello", "India"};
//
//        System.out.println(toStringArray(name));
//
//        String str = "{Hindi,Kannada,Malayalam,Kannada,CD}";
//        str = str.replace("{", "").replace("}", "");
//        String arr[] = str.split(",");
//        Map<String, String> weekLangMap = new ConcurrentHashMap<>();
//        for (int i = 0; i < arr.length; i++) {
//            int w = i + 1;
//            weekLangMap.put("" + w, arr[i]);
//        }
//
//        System.out.println(weekLangMap);

//        Calendar calendar = new GregorianCalendar();

        Date date = new Date("24-Mar-2017");
        System.out.println(date);
        System.out.println(date.getDate());

//
    }

    public static List<DutyDetails> getDutyList(String shortName, Allocation allocation) {

        List<DutyDetails> duties = new ArrayList<>();

        if (null == allocation)
            return duties;
        String pathiArray[] = allocation.getPathi();

        if (pathiArray == null)
            return duties;

        if (pathiArray.length == 0)
            return duties;

        if (pathiArray[0].equalsIgnoreCase(shortName)) {
            if (allocation.getIsStagePathiAlsoGround()) {
                duties.add(new DutyDetails(Duty.STAGE, 0));
                duties.add(new DutyDetails(Duty.GROUND, 1));
            } else {
                duties.add(new DutyDetails(Duty.STAGE, 0));
            }
        }

        int indOffset = 0;
        if (allocation.getIsStagePathiAlsoGround())
            indOffset = 1;

        for (int i = 1; i < pathiArray.length; i++) {
            if (pathiArray[i].equalsIgnoreCase(shortName))
                duties.add(new DutyDetails(Duty.GROUND, i + indOffset));
        }
        return duties;
    }
}
