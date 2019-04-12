package com.rssb.api.satsangGhar;

import com.rssb.api.helper.DatabaseHelper;
import com.rssb.common.config.ConfigManager;
import com.rssb.common.entity.*;
import com.rssb.common.helper.Util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by arun on 25/7/17.
 */
public class ApiHelper {

    public static DatabaseHelper dataBaseHelper = DatabaseHelper.getInstance();

    public User verifyUser(String userName, String password) throws Exception {
        return dataBaseHelper.verifyUser(userName, password);
    }

    public Long addSatsangGhar(SatsangGhar satsangGhar, List<Schedule> scheduleList) throws Exception {
        return dataBaseHelper.persisitSatsangGhar(satsangGhar, scheduleList);
    }

    public List<SatsangGhar> getAllSatsangGhar() throws Exception {
        return dataBaseHelper.searchSatsangGhar("true");
    }

    public SatsangGhar getSatsangGharById(String id) throws Exception {
        List<SatsangGhar> list = dataBaseHelper.searchSatsangGhar(" id = " + id);
        if (list.size() == 0)
            return null;
        return list.get(0);
    }

    public List<Preacher> getAllPreacher() throws Exception {
        return dataBaseHelper.searchPreacher("true");
    }

    public boolean isSGUnique(String name) throws Exception {
        List<SatsangGhar> result = searchSatsangGharByName(name);
        return result.size() == 0 ? true : false;
    }

    public boolean isShortNameUnique(String name) throws Exception {
        List<Preacher> result = getPreacher("upper(short_name)=upper('" + name + "')  ");
        return result.size() == 0 ? true : false;
    }

    public List<SatsangGhar> searchSatsangGharByPredicate(String whereClause) throws Exception {
        return dataBaseHelper.searchSatsangGhar(whereClause);
    }

    public SatsangGhar searchSatsangGharByid(Long id) throws Exception {
        return dataBaseHelper.searchSatsangGhar("id=" + id).get(0);
    }

    public List<SatsangGhar> searchSatsangGharByName(String name) throws Exception {
        String searchName = name.toLowerCase().trim();

        return dataBaseHelper.searchSatsangGhar("trim(lower(name))='" + searchName + "'");
    }

    public void addPreacher(Preacher preacher) throws Exception {
        dataBaseHelper.persistPreacher(preacher);
    }

    public void updatePreacher(Preacher preacher, String oldShortName) throws Exception {
        dataBaseHelper.updatePreacher(preacher, oldShortName);
    }

    public Map<String, String> getShortNameMap() throws Exception {
        List<Preacher> list = dataBaseHelper.getPreacher("true");
        Map<String, String> map = new ConcurrentHashMap<>();
        for (Preacher preacher : list) {
            map.put(preacher.getShortName(), preacher.getName());
        }
        return map;
    }

    public Map<String, Long> getSgNameMap() throws Exception {
        List<SatsangGhar> list = dataBaseHelper.searchSatsangGhar("true");
        Map<String, Long> map = new ConcurrentHashMap<>();
        for (SatsangGhar satsangGhar : list) {
            map.put(satsangGhar.getName().trim().toLowerCase(), satsangGhar.getId());
        }
        return map;
    }

    public List<Preacher> getPreacher(String whereClause) throws Exception {
        return dataBaseHelper.getPreacher(whereClause);
    }

    public Preacher getPreacherByShortName(String shortName) throws Exception {
        return dataBaseHelper.getPreacher("short_name='" + shortName + "'").get(0);
    }

    public List<Preacher> getPreacherByType(PreacherType type, boolean isAttachedToSG, Long sgId) throws Exception {
        if (isAttachedToSG)
            return getPreacher("ptype='" + type + "' AND sat_ghar_id=" + sgId);
        return getPreacher("ptype='" + type + "'");
    }

    public List<Date> getDates(Long sgId, String startDateS, String endDateS) throws Exception {

        List<String> dayList = dataBaseHelper.getDayList(sgId);
        System.out.println("Day List: " + dayList);
        return Util.getDates(startDateS, endDateS, dayList);
    }

    public Map<String, Schedule> getScheduleMap(Long sgId) throws Exception {
        return dataBaseHelper.getSchedules(sgId);
    }

    public List<Allocation> getAllocation(Long satsangGharId, String startDate, String endDate) {
        return dataBaseHelper.getAllocation(satsangGharId, startDate, endDate);
    }

    public List<Allocation> getAllocation(String shortName, String startDate, String endDate) {
        return dataBaseHelper.getAllocation(shortName, startDate, endDate);
    }

    public Map<String, Allocation> getAllocationMap(Long satsangGharId, String startDate, String endDate) {

        List<Allocation> allocationList = getAllocation(satsangGharId, startDate, endDate);
        Map<String, Allocation> map = new HashMap<>();
        for (Allocation allocation : allocationList) {
            map.put(allocation.getSatDate(), allocation);
        }
        return map;
    }

    private boolean search(String[] lang, String lang1) {

        return Arrays.stream(lang).anyMatch(language -> language.trim().equalsIgnoreCase(lang1.trim()));
    }

    public Map<String, List<PreacherAllocation>> getAllotedPreacherMap(Long sgId, String startDate, String endDate) {
        return dataBaseHelper.getAllocatedPreacherMap(sgId, startDate, endDate);
    }

    public List<Preacher> getFilteredPreacherByLangAndAlloc(List<Preacher> list, String lang, String date, String time,
                                                            Map<String, List<PreacherAllocation>> existingAllocationMap) throws Exception {
        List<Preacher> list1 = getFilterUsingLanguage(list, lang);
        List<Preacher> list2 = getFilteredPreacherByAllocation(list1, date, time, existingAllocationMap);
        return list2;
    }

    public List<Preacher> getFilteredPreacherByAllocation(List<Preacher> inputList, String date, String time,
                                                          Map<String, List<PreacherAllocation>> existingAllocationMap)
            throws Exception {
        ConfigManager configManager = ConfigManager.getInstance();

        List<Preacher> preacherList = new ArrayList<>();
        List<PreacherAllocation> busyPreacherList = existingAllocationMap.get(date);

        if (busyPreacherList == null)
            return inputList;

        for (Preacher preacher : inputList) {
            List<PreacherAllocation> preacherAllocations = searchPreacher(busyPreacherList, preacher.getShortName());
            if (preacherAllocations.size() >= 2) {
                continue;
            }
            if (preacherAllocations.size() == 0) {
                preacherList.add(preacher);
            }

            if (preacherAllocations.size() == 1) {
                long diff = timeDiff(preacherAllocations.get(0).getTime(), time);
                String requiredDiff = configManager.getConfig("hoursDiff");
                System.out.println("Diff  " + diff + "    " + requiredDiff);
                if (diff >= Integer.parseInt(requiredDiff) * 3600000) {
                    preacherList.add(preacher);
                }
            }
        }

        return preacherList;
    }

    private long timeDiff(String time1, String time2) throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
        Date date1 = format.parse(time1);
        Date date2 = format.parse(time2);
        return Math.abs(date2.getTime() - date1.getTime());
    }

    private List<PreacherAllocation> searchPreacher(List<PreacherAllocation> inputList, String shortName) {

        List<PreacherAllocation> list = new ArrayList<>();

        for (PreacherAllocation preacherAllocation : inputList) {
            if (preacherAllocation.getShortName().equalsIgnoreCase(shortName)) {
                list.add(preacherAllocation);
            }
        }
        return list;
    }

    public List<Preacher> getFilterUsingLanguage(List<Preacher> list, String lang) {
        List<Preacher> resList = new ArrayList<>();
        for (Preacher preacher : list) {

            if (search(preacher.getLang(), lang)) {
                resList.add(preacher);
            }
        }
        return resList;
    }

    public void addAllocation(Allocation allocation, boolean isCdUpdate) {
        dataBaseHelper.addAllocation(allocation, isCdUpdate);
    }
    public void addAttendance(Attendance attendance) {
        dataBaseHelper.addAttendance(attendance);
    }
    public Attendance getAttendance(Long sgId, String date) {
       return dataBaseHelper.getAttedance(sgId,date);
    }
    
    
    public void addLeaves(Leave leave) {
        dataBaseHelper.addLeaves(leave);
    }

    public List<Leave> getLeaves(String shortName, String startDate, String endDate) {
        return dataBaseHelper.getLeaves(shortName, startDate, endDate);
    }

    public void addCD(CD cd) {
        dataBaseHelper.addCD(cd);
    }

    public static void main(String[] args) throws Exception {

        String time2 = "00:30:00";
        String time1 = "01:30:00";

        ApiHelper apiHelper = new ApiHelper();
        System.out.println(apiHelper.timeDiff(time1, time2));
        String[] lan = {"Hindi", "English", "PUNjaBI"};
        System.out.println(apiHelper.search(lan, " PUNjaBI"));
    }

    public void addCity(City city) {

        dataBaseHelper.addCity(city);
    }

    public List<CD> getAllCD() {
        return dataBaseHelper.getAllCd();
    }

    public Map<String, CD> cdDescMap() {
        Map<String, CD> map = new ConcurrentHashMap<>();
        List<CD> cdList = getAllCD();
        for (CD cd : cdList) {
            map.put(cd.getId(), cd);
        }
        return map;
    }
}
