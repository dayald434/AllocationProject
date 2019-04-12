package com.rssb.api.allocation;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SgQuery {
    private static final String[] SG_COLS = {"id", "name", "ctype", "parent_center_id", "address1", "address2", "city", "state", "pincode",
            "map_link", "landline1", "landline2", "mobile1", "mobile2", "secretary_name", "secretary_contact", "number_of_pathis" ,"is_Stage_Pathi_Also_Ground"};
    public static final String GET_SATSANG_GHAR = "Select " + getCols(SG_COLS, null) + " from satsang_ghar  where %s order by name";
    public static final String INSERT_SG = "INSERT INTO satsang_ghar( id, name, ctype, parent_center_id, address1, address2, city," +
            " state, pincode , map_link, landline1, landline2, mobile1, mobile2, secretary_name,  secretary_contact)" +
            "    VALUES (%d,'%s', '%s', %d, '%s', '%s', '%s', '%s', '%s','%s', '%s', '%s', %d, %d, '%s', %d  ) ";

    public static final String UPDATE_SATSANG_GHAR = "UPDATE satsang_ghar SET " +
            "    name='%s', ctype='%s', parent_center_id=%d, address1='%s', address2='%s', " +
            "       city='%s', state='%s',pincode='%s', map_link='%s', landline1='%s', landline2='%s', mobile1=%d, " +
            "       mobile2=%d, secretary_name='%s', secretary_contact=%d WHERE id=%d";
    public static final String DEL_SATSANG_GHAR = "DELETE from satsang_ghar where id=%s";
    public static final String DEL_SCHEDULE = "delete from satsang_schedule  where sat_ghar_id  = %s";

    public static final String GET_SG_SEQ_ID = "SELECT nextval('satsang_ghar_id_seq')";
    public static final String GET_SCHEDULE = "SELECT sat_day, sat_time, lang  FROM satsang_schedule " +
            " where sat_ghar_id='%d' ";

    public static final String INSERT_SCHEDULE = "INSERT INTO satsang_schedule(sat_ghar_id, sat_day, sat_time,lang) " +
            "VALUES (%d, '%s', '%s', '%s')";

    public static final String UPDATE_SCHEDULE = "UPDATE satsang_schedule   SET  sat_day='%s', sat_time='%s' , lang='%s'" +
            " WHERE sat_ghar_id=%d";

    private static String getCols(final String[] masterList, String[] exceptList) {
        String str = "";
        List<String> colList = new ArrayList<>();

        if (null != exceptList)
            colList = Arrays.asList(exceptList);

        for (String column : masterList) {

            if (colList.contains(column))
                continue;
            str += column + ",";
        }
        return str.substring(0, str.length() - 1);
    }
}
