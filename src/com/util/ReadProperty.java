package com.util;

import java.io.*;

import java.util.Properties;

public class ReadProperty {

	private Properties p ;
	private String fileName = "";
	
	public ReadProperty(){
		//一种方式
		fileName = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "database.properties"; // 构造文件名
		//如果不行的话，可以将database.properties文件放到C:\WINDOWS\system32下面就可以了。
		//二种方式
		//fileName = "D:\\pudongps\\Tomcat 5.0_28\\bin\\database.properties";
		System.out.println("------------------"+fileName);
		p = new Properties();
		try { 
			FileInputStream in = new FileInputStream(fileName); // 构造文件的输入流
			p.load(in); // 读入属性
			in.close();
		}catch (Exception e) {
			System.out.println("Error of create input stream");
		}
	}
	
	public String getPropertyValue(String name){
		return p.getProperty(name);
	}
	
	public static void main(String[] args) {
		ReadProperty pro = new ReadProperty();
		System.out.println(pro.getPropertyValue("dbip"));
		System.out.println(pro.getPropertyValue("webserviceUrl"));
	}
}
