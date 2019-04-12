package com.rssb.api.helper;

import com.google.common.base.Strings;
import com.google.common.collect.ImmutableMap;
import com.google.gson.Gson;
import com.rssb.common.entity.City;
import com.rssb.common.entity.Language;
import com.rssb.common.entity.Schedule;
import com.rssb.common.entity.State;

import java.util.List;
import java.util.Map;

public class HtmlGenerator {

    public static final Map<String, Integer> weekMap = ImmutableMap.of(
            "W1", 0,
            "W2", 1,
            "W3", 2,
            "W4", 3,
            "W5", 4
    );

    public static synchronized String getweeklyLanguage(String day, String cl, String week) {
        List<Language> languages = StaticContent.getLanguages();

        String start = "<select class=\"" + cl + "\" name=\"%s%s\"  id=\"%s%s\"  >\n" +
                "  <option value=\"\">Select Lang</option>\n" +
                "  <option value=\"CD\">CD/Video</option>\n";

        String option = "  <option value=\"%s\">%s</option>\n";
        String end = "</select> ";
        String output = String.format(start, day, week, day, week);
        for (int i = 0; i < languages.size(); i++) {

            output = output + String.format(option, languages.get(i).getLang(), languages.get(i).getLang());
        }
        return output + end;
    }

    public static synchronized String getweeklyLanguage(String day, String cl, String week, Map<String, Schedule> scheduleMap) {

        int index = weekMap.get(week);
        Schedule schedule = scheduleMap.get(day);
        String oldLang = "";
        String disable = "disabled";
        if (null != schedule) {
            String[] lang = schedule.getLang();
            oldLang = lang[index];
            disable = "";
        }

        List<Language> languages = StaticContent.getLanguages();

        String start = "<select " + disable + " class=\"" + cl + "\" name=\"%s%s\"  id=\"%s%s\"  >\n" +
                "  <option value=\"\">Select Lang</option>\n" +
                "  <option value=\"CD\">CD/Video</option>\n";

        if (oldLang.equalsIgnoreCase("CD")) {
            start = "<select " + disable + " class=\"" + cl + "\" name=\"%s%s\"  id=\"%s%s\"  >\n" +
                    "  <option value=\"\">Select Lang</option>\n" +
                    "  <option selected value=\"CD\">CD/Video</option>\n";
        }

        String option = "  <option %s value=\"%s\">%s</option>\n";
        String end = "</select> ";
        String output = String.format(start, day, week, day, week);
        for (int i = 0; i < languages.size(); i++) {
            String selected = "";
            if (languages.get(i).getLang().equalsIgnoreCase(oldLang))
                selected = "selected";

            output = output + String.format(option, selected, languages.get(i).getLang(), languages.get(i).getLang());
        }
        return output + end;
    }

    public static synchronized String getweeklyLanguageToDisplay(String day, String cl, String week, Map<String, Schedule> scheduleMap) {
        int index = weekMap.get(week);
        Schedule schedule = scheduleMap.get(day);
        String oldLang = "";
        if (null != schedule) {
            String[] lang = schedule.getLang();
            oldLang = lang[index];
            return oldLang;
        }
        return "-";
    }

    public static synchronized String getStates(String exisState) {

        String selected = "selected=\"selected\"";

        List<State> states = StaticContent.getStates();

        String option = "  <option value=\"%s\" %s >%s</option>\n";
        String end = "</select> ";
        String output = "";
        for (State state : states) {

            String sel = "";
            if (!Strings.isNullOrEmpty(exisState) && (exisState.equalsIgnoreCase(state.getCode()))) {
                sel = selected;
            }
            output = output + String.format(option, state.getCode(), sel, state.getName());
        }
        return output;
    }

    public static synchronized String getCities(City existingCity) {

        String selected = "selected=\"selected\"";

        List<City> cityList = StaticContent.getCities(existingCity.getStateCode());

        String option = "  <option value=\"%s\" %s >%s</option>\n";
        String end = "</select> ";
        String output = "";
        for (City city : cityList) {

            String sel = "";
            if ((null != existingCity) && (existingCity.getCode().equalsIgnoreCase(city.getCode()))) {
                sel = selected;
            }
            output = output + String.format(option, city.getCode(), sel, city.getName());
        }
        return output;
    }

    public static synchronized String getLanguage() {
        return getLanguage("");
    }

    public static synchronized String getLanguage(String existLang) {

        String selected = "selected=\"selected\"";

        List<Language> languages = StaticContent.getLanguages();

        String option = "  <option value=\"%s\" %s >%s</option>\n";
        String end = "</select> ";
        String output = "";
        for (int i = 0; i < languages.size(); i++) {

            String sel = "";
            if (!Strings.isNullOrEmpty(existLang) && (existLang.equalsIgnoreCase(languages.get(i).getLang()))) {
                sel = selected;
            }
            output = output + String.format(option, languages.get(i).getLang(), sel, languages.get(i).getLang() + "(" + languages.get(i).getLocal() + ")");
        }
        return output;
    }

    public static void main(String[] args) {
        List<City> cityList = StaticContent.getCities("KA");

        Gson gson = new Gson();
        String res = gson.toJson(cityList);
        System.out.println(res);

        String json = "[{\"code\":\"BLR\",\"name\":\"Bangalore\",\"stateCode\":\"KA\"},{\"code\":\"MYS\",\"name\":\"MYSURU\",\"stateCode\":\"KA\"},{\"code\":\"TUM\",\"name\":\"TUMKUR\",\"stateCode\":\"KA\"}]";
    }
}
