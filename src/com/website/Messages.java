/*
 * 创建日期 2005-6-15
 *
 * TODO 要更改此生成的文件的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
package com.website;

import java.util.MissingResourceException;
import java.util.ResourceBundle;

/**
 * @author Administrator
 *
 * 
 * 窗口 － 首选	项 － Java － 代码样式 － 代码模板
 */
public class Messages {
	private static final String BUNDLE_NAME = "com.website.messages";//$NON-NLS-1$

	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle
			.getBundle(BUNDLE_NAME);

	private Messages() {
	}

	public static String getString(String key) {
		// 
		try {
			return RESOURCE_BUNDLE.getString(key);
		} catch (MissingResourceException e) {
			return "";
		}
	}
}