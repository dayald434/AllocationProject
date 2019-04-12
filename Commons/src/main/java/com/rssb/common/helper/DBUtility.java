package com.rssb.common.helper;

import com.rssb.common.entity.DB;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Postgres Connection and Query executions.
 * class may import AutoCloseable
 */
@Slf4j
public class DBUtility  {

    DB db;

    public DBUtility(DB db) {
        this.db = db;
    }

    public String get(String query) {
        List<String> records = getRecord(query);
        return (null != records) ? records.get(0) : null;
    }

    public int update(String... sqls) {

        int result = 0;
        long start;
        List<Statement> statementList = new ArrayList<>();
        Connection connection = null;
        try {
            connection = ConnectionManager.getConnection(db);
        } catch (Exception e) {
            log.error("Exception: ", e);
        }

        try {

            for (String sql : sqls) {
                System.out.println(sql);
                start = System.currentTimeMillis();
                Statement st = connection.createStatement();
                result = st.executeUpdate(sql);
                statementList.add(st);
                log.debug("{}ms - {} rows - {}", (System.currentTimeMillis() - start), result, sql);
            }
        } catch (Exception e) {
            log.error("Exception: ", e);
        } finally {
            for (Statement st : statementList) {
                ConnectionManager.closeStatement(st);
            }
            ConnectionManager.closeConnection(connection);
        }
        return result;
    }

    /**
     * Return multiple records with all column values
     *
     * @param query - SELECT sql query
     * @return - List of rows, each having list of columns
     */

    public List<List<String>> getRecords(String query) {

        List<List<String>> recordList = null;
        long start = System.currentTimeMillis();
        Connection connection = null;
        Statement st = null;

        try {
            connection = ConnectionManager.getConnection(db);
        } catch (Exception e) {
            log.error("Exception: ", e);
        }

        try {
            st = connection.createStatement();
            ResultSet rs = st.executeQuery(query);
            recordList = new ArrayList<>();
            int col = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                List<String> record = new ArrayList<>();
                for (int i = 1; i <= col; i++) {
                    record.add(rs.getString(i));
                }
                recordList.add(record);
            }
        } catch (Exception e) {
            log.error("Exception: ", e);
        } finally {
            ConnectionManager.closeStatement(st);
            ConnectionManager.closeConnection(connection);
            log.debug("{}ms - {}", (System.currentTimeMillis() - start), query);
        }
        return recordList;
    }

    public ResultSet getResultSet(String query) {
        long start = System.currentTimeMillis();

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            connection = ConnectionManager.getConnection(db);
        } catch (Exception e) {
            log.error("Exception: ", e);
        }

        try {
            st = connection.createStatement();
            rs = st.executeQuery(query);
        } catch (SQLException e) {
            log.error("Exception: ", e);
        } finally {
            ConnectionManager.closeConnection(connection);
            log.debug("{}ms - {}", (System.currentTimeMillis() - start), query);
        }

        return rs;
    }

    /**
     * Return single record with all column values
     *
     * @param query - SELECT sql query
     * @return - Single row with columns as List
     */

    public List<String> getRecord(String query) {

        List<List<String>> recordColumns = getRecords(query);
        return recordColumns.size() != 0 ? recordColumns.get(0) : null;
    }

    public static void main(String[] args) throws Exception {
        DBUtility dbUtility = new DBUtility(DB.APP_DB);
        String rs = dbUtility.get("Select * from preacher limit 5");
        System.out.println(rs);
    }
}
