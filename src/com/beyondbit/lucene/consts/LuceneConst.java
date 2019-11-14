/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.beyondbit.lucene.consts;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description:lucene中的常用字段
 */
public class LuceneConst {
	public static String INDEX_DATADIR = "";
	//追加
	public static boolean INDEX_APPEND = false;
	//重新建立
	public static boolean INDEX_BESTROW = true;
	// 获得用户自己定义的索引空间
	public static String INDEX_INDEXDIR = "";
	static {
		Properties pro = new Properties();
		System.getProperty("user.dir");
		try {
			pro.load(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream("index.properties"));
			System.out.println("加载配置文件成功"+pro.size());
			Enumeration eum = pro.propertyNames();
			while(eum.hasMoreElements()){
				System.out.println(eum.nextElement());
			}
			LuceneConst.INDEX_DATADIR = pro.getProperty("datadir");
			LuceneConst.INDEX_INDEXDIR = pro.getProperty("indexerdir");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	};
}
