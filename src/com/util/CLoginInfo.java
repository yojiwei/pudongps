package com.util;

public class CLoginInfo {
	//密码有效时间
	public static int passwordAvailDate = 15;
	//允许的密码错误次数
	public static int ErrorrtTime = 3;
	//是否打印DEBUG信息   
	public static boolean DEBUG = true;
	//XML存放路径及名字
	public static String xmlPath = "F:/file/pudingXML/";
	//XML文件的名字
	public static String xmlFileName = "pudongXML";
	
	//要存入附件表的字段
	public static String[] attatchName = {"FA_PATH","FA_FILENAME","FA_NAME","FA_CONTENT"};
	//要存入内容表的字段
	public static String[] contentName = 
				{"CT_TITLE","CT_FILEFLAG","CT_CONTENT","CT_SOURCE","DT_ID","CT_CREATE_TIME","SJ_NAME"};
}
