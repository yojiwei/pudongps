package com.util;

import java.util.TimerTask;

import javax.servlet.ServletContextEvent;

import org.apache.log4j.Logger;

public class CreateIndex extends TimerTask{
 
	/**
	 * @param args
	 */
	//改成10个小时生成一次　modify by shiweijun 2010-4-12
    protected int CYCLETIME = 1000*60*60*10; 
    private Logger logger;
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public CreateIndex(ServletContextEvent sce) {
	      logger = Logger.getLogger(CreateIndex.class);
	      logger.info("start initializing CreateIndex!");
	}
	public void run() {
		// TODO Auto-generated method stub
		 CUrl myurl = new CUrl();
		 String newfile="index.html";
		 String fromfile = "http://61.129.65.86:8229/qlgk/index.jsp";
		 myurl.createHtml(fromfile, "D:/pdqlgk/WebRoot/qlgk/", newfile);//外网
	}

}
