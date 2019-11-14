/*
 * Created on 2004-10-14
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.beyondbit.soft2.utils;

import java.util.Iterator;

import org.apache.log4j.Logger;

/**
 * @author along
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class CLogger {
	private Logger logger;

	/**
	 * 构造方法 初始化logger
	 */
	public CLogger() {
		logger = Logger.getLogger(CLogger.class);

		// TODO Auto-generated constructor stub
	}

	/**
	 * 调试信息
	 * 
	 * @param message
	 */
	public void debug(String message) {
		logger.debug(message);
	}

	/**
	 * 提示信息
	 * 
	 * @param message
	 */
	public void info(String message) {
		logger.info(message);
	}

	/**
	 * 警告信息
	 * 
	 * @param message
	 */
	public void warn(String message) {
		logger.warn(message);
	}

	/**
	 * 错误信息
	 * 
	 * @param message
	 */
	public void error(String message) {
		logger.error(message);
	}

}
