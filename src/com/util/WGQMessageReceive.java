package com.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Calendar;
import java.util.List;
import java.util.TimerTask;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

/**
 * <p>
 * Program Name:工程名
 * </p>
 * <p>
 * Module Name:模块名
 * </p>
 * <p>
 * Function:投资资讯
 * </p>
 * <p>
 * Create Time: 2006-4-27 14:36:27
 * </p>
 * 
 * @author: Administrator
 * @version:
 */
public class WGQMessageReceive extends TimerTask {

	//调用webservice的urlName
	private static String urlName = "";

	//要解析的url地址
	public static String urlBase = "";

	/**
	 * Construct and use a TimerTask and Timer.
	 */
	public static void main(String[] arguments) {
		WGQMessageReceive fetchMail = new WGQMessageReceive("waigaoqiao");
//		fetchMail.receiveWGQ("20090306");
		String startStr = "";
		String endStr = "";
		arguments = new String[]{"20090306","20090410"};
		Calendar startDate = Calendar.getInstance();
		Calendar endDate = Calendar.getInstance();
		if(arguments != null){
			if(arguments.length == 2){
			startStr = arguments[0];
			endStr = arguments[1];
						  
			startDate.set(Calendar.YEAR,Integer.parseInt(startStr.substring(0,4)));
			startDate.set(Calendar.MONTH,Integer.parseInt(startStr.substring(4,6))-1);
			startDate.set(Calendar.DAY_OF_MONTH,Integer.parseInt(startStr.substring(6,8)));
						  
			endDate.set(Calendar.YEAR,Integer.parseInt(endStr.substring(0,4)));
			endDate.set(Calendar.MONTH,Integer.parseInt(endStr.substring(4,6))-1);
			endDate.set(Calendar.DAY_OF_MONTH,Integer.parseInt(endStr.substring(6,8)));
			}else if(arguments.length == 1){
				startStr = arguments[0];
			
			 startDate.set(Calendar.YEAR,Integer.parseInt(startStr.substring(0,4)));
			 startDate.set(Calendar.MONTH,Integer.parseInt(startStr.substring(4,6))-1);
			 startDate.set(Calendar.DAY_OF_MONTH,Integer.parseInt(startStr.substring(6,8)));
			 }
			 while(!startDate.after(endDate)){
				 fetchMail.receiveWGQ(startDate);
				 startDate.add(Calendar.DAY_OF_MONTH,1);
			 }
		 }else{
			 fetchMail.receiveWGQ();
		 }

	}

	public WGQMessageReceive() {
	}

	/**
	 * Description：初始化报送时的webservice的用户名、密码
	 * 
	 * @param urlName
	 *            要抓取的url的名字
	 */
	public WGQMessageReceive(String urlname) {
		WGQMessageReceive.urlName = urlname;
		ReadProperty pro = new ReadProperty();
		urlBase = pro.getPropertyValue(urlname + "_httpaddress");
	}

	/**
	 * getHtml 解析地址并返回对应页的HTML内容 parameter
	 * 
	 * @strUrl 完整的URL地址 return String 解析过后的HTML代码
	 */
	public String getHtml(String strUrl) {
		String strWebUrl = "";
		if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
			strWebUrl = urlBase + strUrl;
		else
			strWebUrl = strUrl;
		StringBuffer sb = new StringBuffer();
		try {
			URL url;
			url = new URL(strWebUrl);

			BufferedReader reader = new BufferedReader(new InputStreamReader(
					url.openStream()));
			if (reader.ready()) {
				String temp = reader.readLine();
				while (temp != null) {
					sb.append(temp);
					temp = reader.readLine();
				}
			}
		} catch (FileNotFoundException fne) {
			System.out.println("无效地址..." + fne.getMessage());
		} catch (MalformedURLException e) {
			System.out.println("地址不能读取..." + e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("IOException..." + e.getMessage());
		}

		return sb.toString();
	}

	public void run() {
		// TODO Auto-generated method stub
		ReadProperty pro = new ReadProperty();
		urlBase = pro.getPropertyValue(WGQMessageReceive.urlName + "_httpaddress");
		receiveWGQ();
	}

	/**
	 * Description：得到当天的日期的yyyyMMdd格式的字符串
	 * 
	 * @return str 得到当天的日期的yyyyMMdd格式的字符串
	 */
	private String getTodayStr() {
		Calendar calendar = Calendar.getInstance();
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
		String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		if (month.length() == 1)
			month = "0" + month;
		if (day.length() == 1)
			day = "0" + day;
		return year + month + day;
	}

	/**
	 * Description:用当天的日期初始化，并提取当天的新闻
	 * 
	 */
	public void receiveWGQ() {
		System.out.println("today...Initinal...");
		String todayStr = getTodayStr();
		receiveWGQ(todayStr);
	}

	/**
	 * Description:用给定的日期初始化，并提取当天的新闻
	 * 
	 * @param dayStr
	 *            yyyyMMdd格式的日期
	 */
	public void receiveWGQ(Calendar date) {
		String dayStr = date.get(Calendar.YEAR)
				+ (String.valueOf(date.get(Calendar.MONTH) + 1).length() == 1 ? "0"
						+ String.valueOf(date.get(Calendar.MONTH) + 1)
						: String.valueOf(date.get(Calendar.MONTH) + 1))
				+ (String.valueOf(date.get(Calendar.DAY_OF_MONTH)).length() == 1 ? "0"
						+ String.valueOf(date.get(Calendar.DAY_OF_MONTH))
						: String.valueOf(date.get(Calendar.DAY_OF_MONTH)));
		receiveWGQ(dayStr);
		
	}

	/**
	 * Description:用给定的日期初始化，并提取当天的新闻
	 * 
	 * @param dayStr
	 *            yyyyMMdd格式的日期
	 */
	public void receiveWGQ(String dayStr) {
		String url = urlBase + dayStr + ".xml";
		System.out.println("get waigaoqiao url xml...");
		String htmlStr = getHtml(url);
		if (!"".equals(htmlStr)) {
			Element rootEle = initEle(htmlStr);
			System.out.println("get waigaoqiao message xml...");
			getChildHtmlStr(rootEle);
			System.out.println("insert waigaoqiao message end...");
		}
	}

	/**
	 * Description：要报送的信息的xml格式的字符串
	 * @param fileStr 要报送的信息的xml格式的字符串
	 * @return xml的根元素
	 */
	public Element initEle(String fileStr) {
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try {
			sb = new SAXBuilder();
			InputStream inputStream = new ByteArrayInputStream(fileStr
					.getBytes("gb2312"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		} catch (Exception ex) {
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}

	/**
	 * Description：将xml元素传到调用webservice的类
	 * @param ele xml的根元素
	 */
	public void getChildHtmlStr(Element ele) {
		List list = ele.getChildren();
		// MsgIntoTable msgIntoTable = null;
		Element subEle = null;
		String eleValue = "";
		String htmlStr = "";
		String sourceUrl = urlBase;
		ParseWGQxml wgqXml = null;
		for (int cnt = 0; cnt < list.size(); cnt++) {
			sourceUrl = urlBase;

//			msgIntoTable = new MsgIntoTable();
			wgqXml = new ParseWGQxml(WGQMessageReceive.urlName);
			subEle = (Element) list.get(cnt);
			eleValue = subEle.getText();
			sourceUrl += eleValue;
			htmlStr = getHtml(sourceUrl);
			if(!"".equals(htmlStr))
				wgqXml.webService(htmlStr,eleValue);
			System.out.println("get waigaoqiao message xml continue...");
		}
	}
}
