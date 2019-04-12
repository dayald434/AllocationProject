package com.rssb.common.helper;

import com.jolbox.bonecp.BoneCP;
import com.jolbox.bonecp.BoneCPConfig;
import com.rssb.common.config.ConfigManager;
import com.rssb.common.entity.DB;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

@Slf4j
public class ConnectionManager {



    private static final ConfigManager configManager;
    private static final int partitionCount;
    private static final int maxConnectionsPerPartition;

    static {
        configManager = ConfigManager.getInstance();
        partitionCount = Integer.parseInt(configManager.getConfig("db.partitionCount"));
        maxConnectionsPerPartition = Integer.parseInt(configManager.getConfig("db.maxConnectionsPerPartition"));
    }

    private static Map<DB, BoneCP> connectionPoolMap = new ConcurrentHashMap<>();

    public static void configureConnPool(DB db) throws Exception {
        Class.forName("org.postgresql.Driver");
        BoneCPConfig config = new BoneCPConfig();
        config.setJdbcUrl(db.getDbURL());
        config.setUsername(db.user);
        config.setPassword(db.password);
        config.setMinConnectionsPerPartition(1);
        config.setMaxConnectionsPerPartition(maxConnectionsPerPartition);
        config.setIdleMaxAge(10, TimeUnit.MINUTES);
        config.setPartitionCount(partitionCount);
        BoneCP connectionPool = new BoneCP(config);
        connectionPoolMap.put(db, connectionPool);
        log.debug("Connection Pooling is configured for {}", db.name());
    }

    public static void shutdownConnPool(DB db) {

        try {
            BoneCP connectionPool = connectionPoolMap.get(db);
            if (connectionPool != null) {
                connectionPool.shutdown();
            }
        } catch (Exception e) {
            log.error("Exception", e);
        }
    }

    public static Connection getConnection(DB db) throws Exception {

        if (null == connectionPoolMap.get(db)) {
            configureConnPool(db);
        }
        /*will get a thread-safe connection from the BoneCP connection pool. synchronization of the method will be done inside BoneCP source*/
        return connectionPoolMap.get(db).getConnection();
    }

    public static void closeStatement(Statement stmt) {
        try {
            if (stmt != null)
                stmt.close();
        } catch (Exception e) {
            log.error("Exception", e);
        }
    }

    public static void closeResultSet(ResultSet rSet) {
        try {
            if (rSet != null)
                rSet.close();
        } catch (Exception e) {
            log.error("Exception", e);
        }
    }

    //release the connection back to pool
    public static void closeConnection(Connection conn) {
        try {
            if (conn != null)
                conn.close(); //release the connection - the name is tricky but connection is not closed it is released and it will stay in pool
        } catch (SQLException e) {
            log.error("Exception", e);
        }
    }
}