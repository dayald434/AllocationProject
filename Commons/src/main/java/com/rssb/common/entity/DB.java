package com.rssb.common.entity;

import com.rssb.common.config.ConfigManager;

public enum DB {
    APP_DB("app_db");

    public final String user;
    public final String password;
    private final String name;
    private final String host;
    private final String port;

    DB(String dbName) {
        ConfigManager configManager = ConfigManager.getInstance();
        String base = "db." + dbName;
        String key = "db." + dbName + ".name"; //db.budget.name
        this.name = configManager.getConfig(key);
        key = base + ".host";
        this.host = System.getenv(key) != null ? System.getenv(key) :
                configManager.getConfig(key, configManager.getConfig("db.host"));
        key = base + ".port";
        this.port = System.getenv(key) != null ? System.getenv(key) :
                configManager.getConfig(key, configManager.getConfig("db.port", "5499"));
        key = base + ".user";
        this.user = System.getenv(key) != null ? System.getenv(key) :
                configManager.getConfig(key, configManager.getConfig("db.user"));
        key = base + ".password";
        this.password = System.getenv(key) != null ? System.getenv(key) :
                configManager.getConfig(key, configManager.getConfig("db.password"));
    }

    public String getDbURL() {
        return "jdbc:postgresql://" + host + ":" + port + "/" + name;
    }
}
