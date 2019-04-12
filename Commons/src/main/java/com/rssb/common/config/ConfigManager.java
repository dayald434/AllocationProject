package com.rssb.common.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Generic class to load Yaml config and and load in Map<String, Object> (Object can be a String or again be a Map)
 * It's Singleton
 */
public class ConfigManager {

    private static ConfigManager instance = null;
    private Properties configs = new Properties();

    private ConfigManager() {
    }

    private static void loadConfigFile(InputStream inputStream) {

        instance = new ConfigManager();
        try {
            instance.configs.load(inputStream);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static ConfigManager getInstance() {
        return getInstance(getConfigLocation());
    }

    private static ConfigManager getInstance(InputStream inputStream) {
        if (null == instance)
            synchronized (ConfigManager.class) {
                if (null == instance)
                    loadConfigFile(inputStream);
            }
        return instance;
    }

    private static InputStream getConfigLocation() {
        InputStream resource = ConfigManager.class.getClassLoader().getResourceAsStream("allocation.properties");
        if (null == resource)
            throw new RuntimeException("test-env.properties is not available in resources");
        return resource;
    }

    public String getConfig(String key) {
        return String.valueOf(configs.get(key));
    }

    public String getConfig(String key, String defaultValue) {
        return String.valueOf(null != configs.get(key) ? configs.get(key) : defaultValue);
    }

    public static void main(String[] args) throws Exception {
        ConfigManager configManager = getInstance();
        String h = configManager.getConfig("db.port");
    }
}
