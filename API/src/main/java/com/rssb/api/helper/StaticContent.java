package com.rssb.api.helper;

import com.google.common.base.Strings;
import com.rssb.common.entity.CD;
import com.rssb.common.entity.City;
import com.rssb.common.entity.Language;
import com.rssb.common.entity.State;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class StaticContent {

    public static List<City> cityList;
    public static List<CD> cdList;

    private static List<State> stateList;
    private static List<Language> languages = null;
    private static Map<String, String> stateCodeToStateName;
    public static Map<String, String> stateNameToStateCode;
    public static Map<String, String> cityNameToCityCode;
    public static Map<String, CD> cdMap;

    static DatabaseHelper databaseHelper = DatabaseHelper.getInstance();

    static {
        languages = databaseHelper.getLang();
        stateList = databaseHelper.getStateList();
        cityList = databaseHelper.getCityList();
        cdList = databaseHelper.getAllCd();
        stateCodeToStateName = new ConcurrentHashMap<>();
        stateNameToStateCode = new ConcurrentHashMap<>();
        cityNameToCityCode = new ConcurrentHashMap<>();
        cdMap = new ConcurrentHashMap<>();

        for (State state : stateList) {
            stateCodeToStateName.put(state.getCode(), state.getName());
            stateNameToStateCode.put(state.getName().toUpperCase(), state.getCode().toUpperCase());
        }

        for (City city : cityList) {
            cityNameToCityCode.put(city.getName().toUpperCase(), city.getCode().toUpperCase());
        }

        for (CD cd : cdList) {
            cdMap.put(cd.getId(), cd);
        }
    }

    public synchronized static void reloadData() {
        languages = databaseHelper.getLang();
        stateList = databaseHelper.getStateList();
        cityList = databaseHelper.getCityList();
        stateCodeToStateName = new ConcurrentHashMap<>();
        stateNameToStateCode = new ConcurrentHashMap<>();

        cityNameToCityCode = new ConcurrentHashMap<>();

        for (State state : stateList) {
            stateCodeToStateName.put(state.getCode(), state.getName());
            stateNameToStateCode.put(state.getName().toUpperCase(), state.getCode().toUpperCase());
        }

        for (City city : cityList) {
            cityNameToCityCode.put(city.getName().toUpperCase(), city.getCode().toUpperCase());
        }
    }

    public synchronized static List<Language> getLanguages() {
        return languages;
    }

    public static synchronized List<City> getCities(String stateCode) {
        List<City> list = new ArrayList<>();
        for (City city : cityList) {
            if (city.getStateCode().equalsIgnoreCase(stateCode))
                list.add(city);
        }
        return list;
    }

    public static List<State> getStates() {
        return stateList;
    }

    public synchronized static City getCityObjectFromName(String cityName) {
        if (Strings.isNullOrEmpty(cityName))
            return City.builder().build();
        return getCityObject(cityNameToCityCode.get(cityName.toUpperCase()));
    }

    public synchronized static City getCityObject(String cityCode) {

        if (cityCode == null)
            return City.builder().build();

        for (City city : cityList) {
            if (city.getCode().equalsIgnoreCase(cityCode)) {

                String stateName = stateCodeToStateName.get(city.getStateCode());
                city.setStateName(stateName);
                return city;
            }
        }

        return City.builder().build();
    }

    public synchronized static List<CD> getCDs() {
        return cdList;
    }

    public synchronized static Map<String, CD> getCdMap() {
        return cdMap;
    }
}
