package com.rssb.api.allocation;

public class AllocationQuery {
    public static final String GET_ALLOCATION = "SELECT sat_ghar_id, to_char(sat_date,'dd-Mon-YYYY'), sat_time, pathi_short_code," +
            " preacher_short_code,  is_cd, cd_id, created_date   FROM allocation\n" +
            " where sat_ghar_id =%d  and sat_date>='%s' and sat_date<='%s'";

    public static final String INSERT_ALLOCATION = "INSERT INTO allocation(sat_ghar_id, sat_date, sat_time, pathi_short_code, preacher_short_code, is_cd, cd_id) " +
            "VALUES (%d, '%s','%s', '%s', '%s','%s','%s')";

    
    public static final String INSERT_ATTENDANCE="INSERT INTO satsang_attendance("+
	"sgid, date, pathi, preacher, book, saint, gents, ladies, children, four_wheeler, two_wheeler, shabad)"+
	"VALUES (%s, '%s', '%s','%s', '%s','%s', %s, %s, %s, %s, %s,'%s');";
    
    public static final String UPDATE_ATTENDANCE="UPDATE satsang_attendance"+
	"SET sgid='%s', date='%s', pathi='%s', preacher='%s', book='%s', saint='%s', gents='%s', ladies='%s', children='%s', four_wheeler='%s', two_wheeler='%s', shabad='%s'"+
	"WHERE sgid=%s and date='%s';";
    public static final String GET_ATTENDANCE = "SELECT sgid, date, pathi, preacher," +
            " book, saint, gents, ladies, children," +
            "four_wheeler, two_wheeler,shabad from satsang_attendance "+
            "WHERE sgid=%s and date='%s';";
    
    public static final String UPDATE_ALLOCATION = "UPDATE allocation SET  pathi_short_code='%s', " +
            "preacher_short_code='%s',  is_cd='%s', cd_id='%s', created_date=now() " +
            " WHERE sat_ghar_id=%d AND sat_date='%s'";

    public static final String UPDATE_CD_ALLOCATION = "UPDATE allocation SET  is_cd='true', cd_id='%s' " +
            " WHERE sat_ghar_id=%d AND sat_date='%s'";

    public static final String UPDATE_CONT_ALLOCATION = "UPDATE allocation SET  pathi_short_code='%s', preacher_short_code='%s', " +
            " is_cd='%s' WHERE sat_ghar_id=%d AND sat_date='%s'";

//    TODO

    public static final String GET_ALLOCATED_PREACHER = "select to_char(sat_date,'dd-Mon-YYYY')," +
            "sat_time,preacher_short_code from allocation where  sat_ghar_id!=%d And sat_date >='%s' and sat_date <='%s' " +
            "and preacher_short_code!=''\n";

    public static final String GET_ALLOCATED_PATHIS = "select to_char(sat_date,'dd-Mon-YYYY')," +
            "sat_time,pathi_short_code from allocation where  sat_ghar_id!=%d And sat_date >='%s' and sat_date <='%s' " +
            "and pathi_short_code!='{}'\n";

    public static final String GET_ALLOCATION_BY_PREAHER = " select * from ( select sat_ghar_id,sg.name,to_char(sat_date,'dd-Mon-YYYY'),to_char(sat_date,'day'), to_char(sat_time,'HH:MI') ,\n" +
            "pathi_short_code, preacher_short_code, is_stage_pathi_also_ground,  sat_date " +
            " from allocation al, satsang_ghar sg where sg.id= al.sat_ghar_id " +
            "and '%s' = ANY (al.pathi_short_code) and sat_date>='%s' and sat_date<='%s'\n" +
            "union\n" +
            "select sat_ghar_id,sg.name,to_char(sat_date,'dd-Mon-YYYY'),to_char(sat_date,'day'), to_char(sat_time,'HH:MI') ,\n" +
            "pathi_short_code, preacher_short_code,is_stage_pathi_also_ground,sat_date  from allocation al, satsang_ghar sg where sg.id= al.sat_ghar_id \n" +
            "and al.preacher_short_code='%s' and sat_date>='%s' and sat_date<='%s') as result order by sat_date";

    public static void main(String[] args) {

        System.out.println(GET_ALLOCATION_BY_PREAHER);
    }
}
