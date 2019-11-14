package com.timer.confige;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import triones.xml.XMLComment;

public class XMLConfigeLoader implements IConfigeLoader {
	private java.util.Map config = null;
	private static XMLConfigeLoader instance = null;
	private void load(){
		BufferedInputStream in = null;
		try {
			in = new BufferedInputStream(getClass().getResourceAsStream(
					"/pp.xml"));
			Document xmlconfig = DocumentBuilderFactory.newInstance()
					.newDocumentBuilder().parse(in);
			String xpath = "/pagesToParse";
			try{
				XMLComment xmlcomment = new XMLComment(xmlconfig);
				Element[] pages = xmlcomment.getElementsByXpath(xpath);
				if (pages!=null && pages.length>0){
					String url = "";
					String savepath = "";
					String filename = "";
					config = new HashMap();
					for(int i=0;i<pages.length;i++){
						url = pages[i].getAttribute("url");
						savepath = pages[i].getAttribute("savepath");
						filename = pages[i].getAttribute("filename");
						Map pagemap = new HashMap();
						pagemap.put("url", url);
						pagemap.put("savepath", savepath);
						pagemap.put("filename", filename);
						config.put(url, pagemap);
					}
				}
			}catch(Exception ex){
				
			}

		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FactoryConfigurationError e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 在构造函数体内读取配置文件，解析完成后存放在config变量中
	 * 存放结构为：
	 * url：需要生成静态页面的网页地址
	 * savepath：静态页面存放路径
	 * filename：静态页面的文件名称
	 *
	 */
	private XMLConfigeLoader() {
		load();
	}
	
	/**
	 * 重置配置信息
	 *
	 */
	public void reset(){
		config = null;
	}
	
	public static synchronized IConfigeLoader getInstance(){
		if (instance==null){
			instance = new XMLConfigeLoader();
		}
		return instance;
	}
	/**
	 * 获得配置信息
	 * @return
	 */
	public synchronized Map getConfig() {
		if (config == null){
			load();
		}
		return config;
	}
}
