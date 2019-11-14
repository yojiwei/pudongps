package com.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东统一报送</p>
 * <p>Module Name:信息采集</p>
 * <p>Function:信息自动采集，将其他网站特色信息自动抓取到对应的栏目，默认时间是每天早上七点</p>
 * <p>Create Time: 2006-4-27 14:36:27</p>
 * @author: yanker
 * @version: 
 */
public class BatchGetNews3 extends TimerTask {

	
	private final static long fONCE_PER_DAY = 1000*60*60*12;
	private final static int fONE_DAY = 1;
	private final static int fFOUR_AM = 7;
	private final static int fZERO_MINUTES = 0;
	private final static String startStr4Title = "target=\"_blank\"><b>";
	private final static String endStr4Title = "</b></a>";
	private final static String startStr4SubUrl = "valign=\"bottom\"><a href=\"";
	private final static String endStr4SubUrl = "\" target=\"_blank\"";
	private final static String startStr4Content = "</table> -->";
	private final static String endStr4Content = "<!-- <table";
	private final static String imgFullPath = "http://61.129.65.46/";
	private CDataCn dataCn = null;
	private CDataImpl dImpl= null;
	private ArrayList titleList= null;
	
	private ArrayList newTitleList = null;
	private ArrayList newContentList = null;
	private ArrayList newTimeList = null;
	private String sjId = "";
	private final static String pudongjuzhang = "http://61.129.65.46/Scontent.asp";
	  /**
	  * Construct and use a TimerTask and Timer.
	  */
	  public static void main (String[] arguments ) {
		  BatchGetNews3 batchgetnews  = new BatchGetNews3();
//		  batchgetnews.run();
	    
	     Timer timer = new Timer();
	     timer.scheduleAtFixedRate(batchgetnews,getTomorrowMorning7am(),fONCE_PER_DAY);
	     //timer.scheduleAtFixedRate(batchgetnews,new Date(),fONCE_PER_DAY);
	  }

	  public void getNewsNow(HttpServletRequest request){
		  String chkJZBG = request.getParameter("chkJZBG");
		  String chkBY1 = request.getParameter("chkBY1");
		  String chkBY2 = request.getParameter("chkBY2");
		  
		  if("Y".equals(chkJZBG)){
			  System.out.println("浦东新区网上办公会...");
			  
//			  sjId = getSjId("selectedColumn");
			  titleList = getAllTitle(Integer.parseInt(sjId));
			  getTitleList(pudongjuzhang,startStr4Content,endStr4Content,startStr4Title,
					  endStr4Title,startStr4SubUrl,endStr4SubUrl,imgFullPath);
//			  BatchInsertTable("4777");
		  }
		  if("Y".equals(chkBY1))
			  System.out.println("备用站点1...");
		  if("Y".equals(chkBY2))
			  System.out.println("备用站点2...");
	  }
	  
	  /**
	  * Implements TimerTask's abstract run method.
	  */
	  public void run(){
		 
		  System.out.println("浦东新区网上办公会...");
//		  sjId = getSjId("selectedColumn");
		  titleList = getAllTitle(2025);
		  getTitleList(pudongjuzhang,startStr4Content,endStr4Content,startStr4Title,
				  endStr4Title,startStr4SubUrl,endStr4SubUrl,imgFullPath);
//		  BatchInsertTable("4777");
		  
		  
		  
		  
	  }
	 
	  private static Date getTomorrowMorning7am(){
	    Calendar tomorrow = new GregorianCalendar();
	    tomorrow.add(Calendar.DATE, fONE_DAY);
	    Calendar result = new GregorianCalendar(
	      tomorrow.get(Calendar.YEAR),
	      tomorrow.get(Calendar.MONTH),
	      tomorrow.get(Calendar.DATE),
	      fFOUR_AM,
	      fZERO_MINUTES
	    );
	    return result.getTime();
	  }
	  
	  /**
		 *   getHtml
		 *   解析地址并返回对应页的HTML内容
		 *   parameter
		 *       @strUrl         完整的URL地址
		 *   return
		 *       String          解析过后的HTML代码
		 */
		public String getHtml(String strUrl, String startStr, String endStr) {
			String strReturn = "";
			String strWebUrl = "";
			int iBodyStart = -1;
			int iBodyEnd = -1;
			if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
				strWebUrl = "http://61.129.65.46/" + strUrl;
			else
				strWebUrl = strUrl;
			//System.out.println("subUrl = " + strWebUrl);
			StringBuffer sb = new StringBuffer();
			try {
				URL url = new URL(strWebUrl);
				BufferedReader reader = new BufferedReader(new InputStreamReader(
						url.openStream()));
				if (reader.ready()) {
					String temp = reader.readLine();
					while (temp != null) {
						sb.append(temp);
						temp = reader.readLine();
					}
					if(iBodyStart > 0)
						iBodyStart = iBodyStart > sb.toString().indexOf(startStr) 
							? sb.toString().indexOf(startStr) : iBodyStart;
					iBodyStart = sb.toString().indexOf(startStr);
					iBodyEnd = sb.toString().lastIndexOf(endStr);
					if (iBodyStart > 0) {
						strReturn = sb.substring(iBodyStart + startStr.length(),
								iBodyEnd);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			return strReturn;
		}

		/**
		 * Description: 得到字符串中需要的内容
		 * @param sourceStr 供提取的字符串
		 * @param startStr 开始字符串
		 * @param endStr 结束字符串
		 * @return 取得的字符串
		 */
		public String getContentStr(String sourceStr, String startStr, String endStr) {
			String rtnStr = "";
			int startNum = -1;
			int endNum = -1;
			try {
				startNum = sourceStr.indexOf(startStr);
				if(startNum > 0)
					sourceStr = sourceStr.substring(startNum + startStr.length());
				endNum = sourceStr.indexOf(endStr);
				if (endNum > 0 ) {
					rtnStr = sourceStr.substring(0,endNum);
				}
			} catch (Exception ex) {
				System.out.println(" Exception: " + ex.getMessage());
			}
			return rtnStr;
		}

		private ArrayList getAllTitle(int sjId){
			ArrayList list = new ArrayList();
			String sql = "SELECT CT_TITLE FROM TB_CONTENT where ct_id in (select ct_id from tb_contentpublish  " +
					"where sj_id  in ( select sj_id from tb_subject connect by prior sj_id = sj_parentid " +
					" start with sj_id =" + sjId + "))";
			String title = "";
			
			Vector vector= null;
			Hashtable table = null;
			try{
				dataCn = new CDataCn();
				dImpl = new CDataImpl(dataCn);
				vector = dImpl.splitPage(sql,100,1);
				if(vector != null){
					for(int cnt = 0; cnt < vector.size(); cnt ++){
						table = (Hashtable)vector.get(cnt);
						title = table.get("ct_title").toString();
						list.add(title);
					}
				}
			}catch (Exception ex) {
				System.out.println(" Exception: " + ex.getMessage());
			}finally{
				dataCn.closeCn();
				dImpl.closeStmt();
			}
			return list;
		}
		
		public void doCircleGet(String strUrl,String startStr,String endStr,int startPage,int endPage,int sjId){
//			startPage = startPage == 0 ? 1 : startPage;
//			endPage = endPage == 0 ? 5 : endPage;
//			String url = "";
			try{
//				for(int cnt = startPage;cnt <= endPage;cnt++){
//					url = strUrl + "&strPage=" + cnt;
					//System.out.println("--- " + url);
					getTitleList(pudongjuzhang,startStr4Content,endStr4Content,startStr4Title,
							endStr4Title,startStr4SubUrl,endStr4SubUrl,imgFullPath);
//				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		
		
		public void BatchInsertTable(String sjId){
			int len = newTitleList.size();
			String ctTitle = "";
			String ctContent = "";
			String ctCreateTime = "";
			for(int k = len;k > 0;k--){
				ctTitle = (String)newTitleList.get(k-1);
				if(newContentList.size() > k)
					ctContent = (String)newContentList.get(k);
				if(newTimeList.size() > k)
					ctCreateTime = (String)newTimeList.get(k);
				doInsertTable(ctTitle,ctCreateTime,ctContent,sjId);
			}
			
		}
		
		private boolean doInsertTable(String ctTitle,String ct_create_time,String ctContent,String sjId){
			boolean flag = false;
			dataCn = new CDataCn();
			dImpl = new CDataImpl(dataCn);
			try{
				//执行插入操作  TB_CONTENT
				dImpl.addNew("tb_content","CT_ID");
				dImpl.setValue("CT_TITLE",ctTitle,CDataImpl.STRING);
				dImpl.setValue("CT_CONTENT",ctContent,CDataImpl.SLONG);
				dImpl.setValue("ct_create_time",ct_create_time,CDataImpl.STRING);
				dImpl.setValue("SJ_ID",sjId,CDataImpl.STRING);
				dImpl.setValue("DT_ID","20000",CDataImpl.INT);
				
				flag = dImpl.update();
				//执行插入操作 TB_CONTENTPUBLISH
				if(flag){
					dImpl.addNew("TB_CONTENTPUBLISH","CP_ID");
					dImpl.setValue("SJ_ID",sjId,CDataImpl.STRING);
					String ctId = String.valueOf(getMaxID("tb_content"));
					dImpl.setValue("CT_ID",ctId,CDataImpl.STRING);
					dImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
//					System.out.println("sjId = " + sjId + " ctId = " + ctId);
					dImpl.update();
				}
			}catch(Exception ex){
				System.out.println(" SQLException: " + ex.getMessage());
			}finally{
				dImpl.closeStmt();
				dataCn.closeCn();
			}
			return flag;
		}
		
		private int getMaxID(String tablename){
			int maxId = 1;
			CDataCn cDn = new CDataCn();
			CDataImpl dImpl = new CDataImpl(cDn);
			Vector vector = null;
			try{
				vector = dImpl.splitPage("select rc_maxid from tb_rowcount where rc_tablename = '"+ tablename +"'",5,1);
				if(vector != null){
					maxId = Integer.parseInt(((Hashtable)vector.get(0)).get("rc_maxid").toString());
				}
			}catch(Exception ex){
				System.out.println("SQLEXception::getMaxID " + ex.getMessage());
				cDn.closeCn();
				dImpl.closeStmt();
			}finally{
				cDn.closeCn();
				dImpl.closeStmt();
			}
			return maxId;
		}
		
		public void getTitleList(String strUrl,String startStr,String endStr,
				String startTitle,String endTitle,String startSubUrl,String endSubUrl,String imgPath) {
			String strTitle = "";
			String subUrl = "";
			String timeStr = "";
			String strWebUrl = "";
			newTitleList = new ArrayList();
			newContentList = new ArrayList();
			newTimeList = new ArrayList();
			StringBuffer sb = new StringBuffer();
			//内容字符串
			String contentStr = "";
			if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
				strWebUrl = "http://61.129.65.46/" + strUrl;
			else
				strWebUrl = strUrl;
			
			try {
				URL url = new URL(strWebUrl);
				BufferedReader reader = new BufferedReader(new InputStreamReader(
						url.openStream()));
				if (reader.ready()) {
					String temp = reader.readLine();
					int cnt = 0;
					while (temp != null) {
						sb.append(temp);
						strTitle = getContentStr(sb.toString(),startTitle,endTitle);
						subUrl = getContentStr(sb.toString(),startSubUrl,endSubUrl);
						timeStr = getContentStr(sb.toString(),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","]</font></td>");
						
						if(!"".equals(subUrl)){
							subUrl = "http://61.129.65.46/" + subUrl;
							contentStr = fullImgPath(getHtml(subUrl,startStr,endStr),imgPath);
							
							if(!titleList.contains(strTitle)){
//								newContentList.add(contentStr);
								timeStr = getSampleTimeStr(timeStr);
//								newTimeList.add(timeStr);
								doInsertTable(strTitle,timeStr,contentStr,"2025");
							}
							
						}
						
						if(!"".equals(strTitle)){
							sb = new StringBuffer();
							cnt++;
							if(cnt > 14)break;
						}
						temp = reader.readLine();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		private String getSampleTimeStr(String str){
			String sampleTimeStr = "";
			if(str != null && !"".equals(str)){
				String year = "";
				String month = "";
				String day = "";
				int yearCnt = str.indexOf("年");
				int monthCnt = str.indexOf("月");
				int dayCnt = str.indexOf("日");
				if(yearCnt == -1){
					year = "2006";
					month = str.substring(0,monthCnt);
					month = month.length() == 1 ? "0" + month : month;
					day = str.substring(monthCnt+1,dayCnt);
					day = day.length() == 1 ? "0" + day : day;
				}else{
					year = str.substring(0,yearCnt);
					month = str.substring(yearCnt+1,monthCnt);
					month = month.length() == 1 ? "0" + month : month;
					day = str.substring(monthCnt+1,dayCnt);
					day = day.length() == 1 ? "0" + day : day;
				}
				sampleTimeStr = year + "-" + month + "-" + day;
			}
			return sampleTimeStr;
		}
		public String getSjId(String sjDir){
			String sjId = "0";
			String sql = " SELECT SJ_ID FROM TB_SUBJECT WHERE SJ_DIR = '"+ sjDir +"'";
			ResultSet rs = null;
			try {
				dataCn = new CDataCn();
				dImpl=new CDataImpl(this.dataCn);
				rs = dImpl.executeQuery(sql);
				while (rs.next())
					sjId = rs.getString("SJ_ID");
			} catch (Exception ex) {
				System.out.println(ex.getMessage());
				dataCn.raise(ex, "执行SQL语句的时候出错", sql); // "executeQuery(String
				// sql)");
				return "0";
			}finally{
				dataCn.closeCn();
				dImpl.closeStmt();
			}
			return sjId;
		}
		private String fullImgPath(String sourceStr,String url){
			return sourceStr.replaceAll("<img src='","<img src='" + url);
		}
		
	}


	
