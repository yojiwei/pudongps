package com.website;

import com.component.database.CDataImpl;
import java.util.Hashtable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class CWebTools {
	
	public static String sperateFileUrl(String fileFlag, String baseUrl, String ctId, CDataImpl dImpl){		
		if(fileFlag.equals("0")) return baseUrl;
		else {
			String returnPath = dImpl.getInitParameter("info_http_path");
			Hashtable content = dImpl.getDataInfo("select * from tb_image where ct_id='" + ctId + "'");
			if(content!=null){
				returnPath += content.get("im_path").toString() + "/" + content.get("im_filename").toString();
			}
			return returnPath;
		}
	}
	
	
	/**
	 * 标注特别关注,截取字符串长度
	 * @param specialFlag 特别关注标示位
	 * @param title	特别关注目标对象
	 * @param length 截取字符串长度
	 * @return
	 */
	public static String sperateFontColor(String specialFlag, String title, int length){		
		return sperateFontColor(specialFlag, subString(title,length));		
	}
	
	/**
	 * 标注特别关注
	 * @param specialFlag
	 * @param title
	 * @return
	 */
	public static String sperateFontColor(String specialFlag, String title){
		String tit = title;
		if(specialFlag.equals("0")) return tit;
		else return "<font color='#FF0000'>" + tit + "</font>";	
	}
	
	/**
	 * 截取字符串长度
	 * @param str
	 * @param length
	 * @return
	 */
	public static String subString(String str, int length) {
		if(str.length()>length) return str.substring(0,length-1);
		else return str;
	}
	
	
	/**
	 * 去除字符串中相关html标记
	 * @param str
	 * @return
	 */
	public static String patternStr(String str){
		Pattern p = Pattern.compile("<[^>]*>",Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(str);
		StringBuffer sb = new StringBuffer();		
		boolean result = m.find();
		while(result) {   		
			m.appendReplacement(sb, "");		
			result = m.find();
		} //最后调用appendTail()方法将最后一次匹配后的剩余字符串加到sb里；
		m.appendTail(sb);
		return sb.toString();		
	}
	
	
	/**
	 * 去除字符串中相关html标记并返回特定长度
	 * @param str
	 * @param length
	 * @return
	 */
	public static String patternStr(String str, int length){		
		return subString(patternStr(str),length);
	}
	
	/**
	 * 填充页面行
	 * @param row 当前行
	 * @param cols	一行中列数
	 * @param allRows 行总数
	 * @param rowHeight 行高
	 * @return
	 */
	public static String addTr(int row, int cols, int allRows, int rowHeight){
		String trHtml = "<tr height='" + (allRows-row)*rowHeight + "'><td cols='" + cols + "'></td></tr>";
		return trHtml;
	}
	
	
	
	public static void main(String [] args){
		
		//System.out.print(CWebTools.addTr(3,2,10,22));
	}

}
