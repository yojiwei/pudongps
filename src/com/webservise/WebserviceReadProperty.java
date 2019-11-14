package com.webservise;

import java.io.*;
import java.net.URLDecoder;

import java.util.Properties;

import com.util.CTools;

public class WebserviceReadProperty {

	private Properties p ;
	private String fileName = "webservice";
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPropertyValue(String name){
		if(fileName.lastIndexOf(".properties")==-1)fileName+=".properties";//如没后缀名则添加
		String filePath="";
		filePath = this.getClass().getResource(fileName).getPath();
		filePath = URLDecoder.decode(filePath);//转换编码 如空格
		System.out.println("filepath======================"+filePath);
		p = new Properties();
		try {
			FileInputStream in = new FileInputStream(filePath); // 构造文件的输入流
			p.load(in); // 读入属性
			in.close();
		}catch (Exception e) {
			System.out.println("Error of create input stream");
		}
		return CTools.dealString(p.getProperty(name));//转换中文字符
	}
	
	public static void main(String[] args) {
		WebserviceReadProperty pro = new WebserviceReadProperty();
		pro.setFileName("webservice.properties");
		String p=pro.getPropertyValue("indexBackupPath");
		System.out.println(p+"要");
	}
}
