package com.rssb.common;

import com.rssb.common.config.ConfigManager;
import lombok.extern.slf4j.Slf4j;

/**
 * Created by arun on 25/7/17.
 */


@Slf4j
public class App {

    public static void main(String[] args) {

        ConfigManager configManager = ConfigManager.getInstance();
        String s = configManager.getConfig("conf");
        System.out.println(s);

        log.debug("Arun");



    }
}
