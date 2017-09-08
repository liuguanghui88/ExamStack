package com.examstack.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 配置文件读取
 *
 */
public class ConfigUtil {
	private static Properties prop = new Properties();

	private static Logger logger = Logger.getLogger(ConfigUtil.class);

	static {
		try {
			InputStream is = ConfigUtil.class.getClassLoader().getResourceAsStream("config.properties");
			prop.load(is);
		} catch (IOException e) {
			logger.error(e);
		}
	}
	
	public static String getConfig(String key){
		return prop.getProperty(key);
	}
}
