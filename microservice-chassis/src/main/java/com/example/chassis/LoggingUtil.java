package com.example.chassis;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingUtil {
    private static final Logger logger = LoggerFactory.getLogger(LoggingUtil.class);

    public static void log(String msg) {
        logger.info("CHASSIS LOG: {}", msg);
    }
}
