package com.rssb.common.helper;

public class MasterQueryLib {

    public static final String GET = "SELECT nextval('aa')";

    public static final String INSERT = "INSERT INTO ro_attribute(id,created_by) VALUES (%s,'test') ";

    public static final String GET1 = "SELECT shortName from ss WHERE shortName=%s";

    public static final String UPDATE_CMP_DB = "UPDATE tab "
            + " SET col=%s   WHERE id=%s";
    public static final String DEL_ = "DELETE FROM STR WHERE HELLo = %s";
}
