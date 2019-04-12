package com.rssb.api;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class QueryLib {

    private static final String[] PR_COLS = {"Short_Name", "name", "initiation_Date", "sex", "sat_ghar_id", "ptype", "mobile1", "mobile2", "lang"};

    public static final String GET_ALL_PREACHER = "SELECT short_name, name, to_char(initiation_Date,'dd-Mon-YYYY'), sex," +
            " sat_ghar_id, ptype, mobile1, mobile2, address, " +
            "city, avail_days, lang, transport_profile from preacher where %s order by name  ";

    public static final String GET_LV_SEQ_ID = "SELECT nextval('unavailability_id_seq')";

    public static final String INSERT_PR1 = "INSERT INTO preacher( short_name, name,  dob, " +
            "initiation_date, sex, sat_ghar_id," +
            "            ptype, mobile1, mobile2,address,city,lang,avail_days, transport_profile)" +
            " VALUES ('%s','%s','%s','%s','%s',%d,'%s', %d, %d , '%s','%s','%s','%s','%s')";

    public static final String GET_PR = "SELECT short_name, name, to_char(initiation_Date,'dd-Mon-YYYY'), sex," +
            " sat_ghar_id, ptype, mobile1, mobile2, address, " +
            "city, avail_days, lang, transport_profile from preacher where %s order by name  ";

    public static final String UPDATE_PR = "UPDATE preacher" +
            " set short_name='%s', name='%s',city='%s', dob='%s',initiation_date='%s', sex='%s', sat_ghar_id=%s, " +
            "ptype='%s', mobile1='%s', mobile2='%s', lang='%s' ,transport_profile='%s' , address='%s' , avail_days='%s'   WHERE short_name='%s'";


    
    
    public static final String GET_SG_ID = "SELECT id from satsang_ghar where trim(lower(name))=trim(lower('%s'))";
    public static final String GET_SAT_DAY = "SELECT sat_day from satsang_schedule WHERE sat_ghar_id=%d  ";

    public static final String GET_LANG = "SELECT lang,local  FROM lang order by lang ";
    public static final String GET_PREACHER = "select sat_ghar_id, to_char(sat_date,'dd-Mon-YYYY'), pathi_short_code, preacher_short_code, created_date" +
            "from allocation where pathi_short_code=%s OR preacher_short_code=%s ";
    public static final String INSERT_LEAVE = "INSERT INTO unavailability(id,short_name, start_date, end_date)    VALUES (%d, '%s', '%s', '%s')";

    public static final String UPDATE_LEAVE = "UPDATE unavailability set short_name='%s', start_date='%s', end_date='%s' " +
            "where id=%d";

    public static final String DEL_LEAVE = "DELETE from unavailability  where id=%d";

    public static final String GET_LEAVES = "SELECT id, short_name, start_date, end_date  FROM unavailability \n" +
            "where short_name='%s' and  end_date>='%s' and start_date<='%s' order by start_date";

    public static final String GET_LEAVES_BY_DATE = "select short_name,  to_char(start_date,'dd-Mon-YYYY') ," +
            " to_char(end_date,'dd-Mon-YYYY')  from unavailability " +
            " where  end_date>='%s' and start_date<='%s' ";
    public static final String GET_STATES = "SELECT code, name from state";
    public static final String GET_CITIES = "SELECT code, name, state_code from city where %s";
    public static final String INSERT_CITY = "INSERT INTO city(code,name,state_code)  VALUES ( '%s', '%s', '%s');";
    public static final String GET_CD = "Select id, desc1,desc2 from CD where id='%s'";
    public static final String INSERT_CD = "insert into CD (id,desc1,desc2) values('%s','%s','%s') ";
    public static final String UPDATE_CD = "Update cd set desc1='%s', desc2='%s' CD where id='%s'";
    public static String DEL_CITY = "Delete from city where %s";
    public static final String GET_ALL_CD = "Select id, desc1,desc2 from CD ";
    public static final String GET_USER = "Select name,user_name, email_id from users where user_name='%s' and password='%s' ";


}
