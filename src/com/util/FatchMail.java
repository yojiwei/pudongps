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

import org.apache.log4j.Logger;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;


/**
 * <p>Program Name:工程名</p>
 * <p>Module Name:模块名</p>
 * <p>Function:投资资讯</p>
 * <p>Create Time: 2006-4-27 14:36:27</p>
 * @author: Administrator
 * @version: 
 */
public class FatchMail extends TimerTask{

	
	private final static long fONCE_PER_DAY = 1000*60*30;
	private final static int fONE_DAY = 1;
	private final static int fFOUR_AM = 7;
	private final static int fZERO_MINUTES = 0;
	private final static String startStr4Title = "target=\"_blank\" >";
	private final static String endStr4Title = "</a>&nbsp;&nbsp;&nbsp;&nbsp;";
	private final static String startStr4SubUrl = "/website/common/content.jsp";
	private final static String endStr4SubUrl = "\" target=\"_blank";
	private final static String startStr4Content = "<FONT face=\"Times New Roman\">";
	private final static String endStr4Content = "</FONT></DIV>";
	private final static String startStr4Img = "<P align=center>";
	private final static String endStr4Img = "</P>";
	private final static String imgFullPath = "http://www.bizpro.gov.cn";
	private Logger logger;
	   
	private static ArrayList titleList= null;
	//时事财经
	private final static String sscjUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1" +
			"&sj_id=39&sj_name=时事财经&sj_parentid=271&sj_dir=InvestNews	";
	//经济数据
	private final static String jjsjUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=165" +
			"&sj_name=经济数据&sj_parentid=271&sj_dir=Data";
	//他山之石
	private final static String tszsUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=111" +
			"&sj_name=他山之石&sj_parentid=271&sj_dir=Foreign";
	//行政收费
	private final static String xzsfUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=308" +
			"&sj_name=行政收费&sj_parentid=275&sj_dir=";
	//浦东概况
	private final static String pdgkUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=242" +
			"&sj_name=浦东概况&sj_parentid=100&sj_dir=OverView";
	//区域动态
	private final static String qydtUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=313" +
			"&sj_name=区域动态&sj_parentid=100&sj_dir=Area-Info";
	//投资环境
	private final static String tzhjUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=134" +
			"&sj_name=投资环境&sj_parentid=101&sj_dir=Environment";
	//发展规划
	private final static String fzghUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=135" +
			"&sj_name=发展规划&sj_parentid=101&sj_dir=Plan";
	//产业集聚
	private final static String cyjjUrl= "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=136" +
			"&sj_name=产业集聚&sj_parentid=101&sj_dir=Focus";
	//外高桥保税区
	private final static String wgqbsqUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=209" +
			"&sj_name=外高桥保税区&sj_parentid=138&sj_dir=WaiGaoQiao";
	//陆家嘴金融贸易区
	private final static String ljzjjUrl= "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=210" +
			"&sj_name=陆家嘴金融贸易区&sj_parentid=138&sj_dir=LuJiaZui";
	//张江高科技园区
	private final static String zjgkUrl= "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=211" +
			"&sj_name=张江高科技园区&sj_parentid=138&sj_dir=ZhangJiang";
	//郊区经济园区
	private final static String jqjjyqUrl= "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=212" +
			"&sj_name=郊区经济园区&sj_parentid=138&sj_dir=OutSkirt";
	//中申保税工业仓储园区
	private final static String zsbsUrl= "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=255" +
			"&sj_name=中申保税工业仓储园区&sj_parentid=138&sj_dir=ZhongShen";
	//上海金桥出口加工区（南区）
	private final static String jqckUrl= "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=306" 
			+ "&sj_name=金桥出口加工区（南区）&sj_parentid=138&sj_dir=";
	
	private final static String tzzxUrl = "http://www.bizpro.gov.cn/website/common/preview.jsp?sj_display_flag=1&" +
			"sj_id=102&sj_name=招商引资&sj_parentid=94&sj_dir=AttractInfo";
	
	private final static String puxqUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=143" +
			"&sj_name=浦东新区政策法规&sj_parentid=103&sj_dir=Policy";
	
	private final static String shsUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=144" +
			"&sj_name=上海市政策法规&sj_parentid=103&sj_dir=ShangHai";
	
	private final static String gjUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=145" +
			"&sj_name=国家政策法规&sj_parentid=103&sj_dir=Country";
	
	private final static String xgfgUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=239" +
			"&sj_name=相关文件&sj_parentid=103&sj_dir=Other";
	
	private final static String zcfgUrl = "http://www.bizpro.gov.cn/website/common/content.jsp?sj_display_flag=0&sj_id=289" +
			"&sj_dir=jiedu&sj_parentid=103&sj_name=%D5%FE%B2%DF%B7%A8%B9%E6%BD%E2%B6%C1";
	
	private final static String lyjtUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=157" +
			"&sj_name=旅游交通&sj_parentid=106&sj_dir=Biz&Tour";
	
	private final static String flyzUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=154" +
			"&sj_name=法律援助&sj_parentid=106&sj_dir=Law";
	
	private final static String ylbjUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=155" +
			"&sj_name=医疗保健&sj_parentid=106&sj_dir=Medicine";
	
	private final static String whjyUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=156" +
			"&sj_name=文化教育&sj_parentid=106&sj_dir=Education";
	
	private final static String jrbxUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=153" +
			"&sj_name=金融保险&sj_parentid=106&sj_dir=Finance";
	
	private final static String sqshUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=159" +
			"&sj_name=社区生活&sj_parentid=106&sj_dir=Life";
	
	private final static String cyrxUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=160" +
			"&sj_name=常用热线&sj_parentid=106&sj_dir=Hotline";
	
	private final static String tzggUrl = "http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=128" +
			"&sj_name=公告栏&sj_parentid=36&sj_dir=Notification";
	  /**
	  * Construct and use a TimerTask and Timer.
	  */
	  public static void main (String[] arguments ) {
		  FatchMail fetchMail  = new FatchMail();
		  fetchMail.run();
	    //perform the task once a day at 4 a.m., starting tomorrow morning
	    //(other styles are possible as well)
//	    Timer timer = new Timer();
//	    timer.scheduleAtFixedRate(fetchMail,getTomorrowMorning7am(), fONCE_PER_DAY);
	  }
	  
	  public FatchMail() {
	        logger = Logger.getLogger(AutoGetListener.class);
	    }

	  /**
	  * Implements TimerTask's abstract run method.
	  */
	  public void run(){
//		  System.out.println("时事财经...");
//		  doCircleGet(sscjUrl,startStr4Content,endStr4Content,0,4,438);//2
//		  
//		  System.out.println("经济数据...");
//		  doCircleGet(jjsjUrl,startStr4Content,endStr4Content,0,2,439);//11
//		  
//		  System.out.println("他山之石...");
//		  doCircleGet(tszsUrl,startStr4Content,endStr4Content,0,4,440);//81
//		  
//		  System.out.println("行政收费...");
//		  doCircleGet(xzsfUrl,startStr4Img,endStr4Img,0,1,441);//2
//		  
//		  System.out.println("浦东概况...");
//		  doCircleGet(pdgkUrl,"<FONT color=#ff3366 size=2>","</FONT></DIV></FONT>",0,1,446);
//		  
//		  System.out.println("区域动态...");
//		  doCircleGet(qydtUrl,startStr4Content,endStr4Content,0,1,442);
//		  
//		  System.out.println("投资环境...");
//		  doCircleGet(tzhjUrl,startStr4Content,endStr4Content,0,2,448);//20
//		  
//		  System.out.println("发展规划...");
//		  doCircleGet(fzghUrl,"<td><DIV>","</DIV></td>",0,1,449);
//		  
//		  System.out.println("产业集聚...");
//		  doCircleGet(cyjjUrl,startStr4Content,endStr4Content,0,1,450);//2
//		  
//		  System.out.println("外高桥保税区...");
//		  doCircleGet(wgqbsqUrl,startStr4Content,endStr4Content,0,1,452);
//		  
//		  System.out.println("陆家嘴金融贸易区...");
//		  doCircleGet(ljzjjUrl,startStr4Content,endStr4Content,0,1,453);
//		  
//		  System.out.println("张江高科技园区...");
//		  doCircleGet(zjgkUrl,startStr4Content,endStr4Content,0,1,454);
//		  
//		  System.out.println("郊区经济园区...");
//		  doCircleGet(jqjjyqUrl,startStr4Content,endStr4Content,0,1,455);
//		  
//		  System.out.println("中申保税工业仓储园区...");
//		  doCircleGet(zsbsUrl,startStr4Content,endStr4Content,0,1,456);
//		  
//		  System.out.println("上海金桥出口加工区（南区）...");
//		  doCircleGet(jqckUrl,startStr4Content,endStr4Content,0,1,457);
//	    
//		  System.out.println("招商引资...");
//		  doCircleGet(jqckUrl,startStr4Content,endStr4Content,0,1,444);
//		  
//		  System.out.println("浦东新区政策法规...");
//		  doCircleGet(puxqUrl,startStr4Content,endStr4Content,0,1,458);//4
//		  
//		  System.out.println("上海市政策法规...");
//		  doCircleGet(shsUrl,startStr4Content,endStr4Content,0,1,459);//10
//		  
//		  System.out.println("国家政策法规...");
//		  doCircleGet(gjUrl,startStr4Content,endStr4Content,0,2,460);//23
//		  
//		  System.out.println("相关文件...");
//		  doCircleGet(xgfgUrl,startStr4Content,endStr4Content,0,1,461);//4
//		  
//		  System.out.println("政策法规解读...");
//		  doCircleGet(zcfgUrl,startStr4Content,endStr4Content,0,1,462);
//		  
//		  System.out.println("旅游交通...");
//		  doCircleGet(lyjtUrl,startStr4Content,endStr4Content,0,1,364);//2
//		  
//		  System.out.println("法律援助...");
//		  doCircleGet(flyzUrl,startStr4Content,endStr4Content,0,1,365);
//		  
//		  System.out.println("医疗保健...");
//		  doCircleGet(ylbjUrl,startStr4Content,endStr4Content,0,1,366);
//		  
//		  System.out.println("文化教育...");
//		  doCircleGet(whjyUrl,startStr4Content,endStr4Content,0,1,367);//2
//		  
//		  System.out.println("金融保险...");
//		  doCircleGet(jrbxUrl,startStr4Content,endStr4Content,0,1,368);//2
//		  
//		  System.out.println("社区生活...");
//		  doCircleGet(sqshUrl,startStr4Content,endStr4Content,0,1,369);//2
//		  
//		  System.out.println("常用热线...");
//		  doCircleGet(cyrxUrl,startStr4Content,endStr4Content,0,1,370);
//		  
//		  System.out.println("投资公告...");
//		  doCircleGet(tzggUrl,"</B></DIV> <DIV align=center><B>","</DIV> <DIV></DIV></td>",0,3,2197);//30
//		  logger.info("finish initializing FatchMail!");
		  
		  BatchGetNews3 batchgetnews3  = new BatchGetNews3();
		  batchgetnews3.run();
		  logger.info("finish initializing BatchGetNews3!");
		  
		  BatchGetNews2 batchgetnews2  = new BatchGetNews2();
		  batchgetnews2.run();
		  logger.info("finish initializing BatchGetNews2!");
	  }

	  // PRIVATE ////

	  //expressed in milliseconds
	  
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
				strWebUrl = "http://www.bizpro.gov.cn/" + strUrl;
			else
				strWebUrl = strUrl;
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

					iBodyStart = sb.toString().indexOf(startStr);
					iBodyEnd = sb.toString().indexOf(endStr);
					if(iBodyStart < 0){
						iBodyStart = sb.toString().indexOf("<td><DIV>");
						iBodyEnd = sb.toString().indexOf("</DIV></td>");
					}
					if (iBodyStart > 0) {
						strReturn = sb.substring(iBodyStart + startStr.length(),
								iBodyEnd);
						//System.out.println(strReturn);
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
			String sql = " SELECT CT_TITLE FROM TB_CONTENT where ct_id in (select ct_id from tb_contentpublish " 
					+ " where sj_id in (select sj_id from tb_subject connect by prior sj_id = sj_parentid start "
					+ " with sj_id = " + sjId +  "))";
			String title = "";
			ResultSet rs= null;
			CDataCn cDn = new CDataCn();
			CDataImpl cImpl = new CDataImpl(cDn);
			try{
				rs = cImpl.executeQuery(sql);
				while(rs.next()){
					title = rs.getString("CT_TITLE");
					list.add(title);
				}
			}catch (Exception ex) {
				System.out.println(" Exception: " + ex.getMessage());
			}finally{
				cImpl.closeStmt();
				cDn.closeCn();
			}
			return list;
		}
		
		public void doCircleGet(String strUrl,String startStr,String endStr,int startPage,int endPage,int sjId){
			startPage = startPage == 0 ? 1 : startPage;
			endPage = endPage == 0 ? 5 : endPage;
			String url = "";
			try{
				for(int cnt = startPage;cnt <= endPage;cnt++){
					url = strUrl + "&strPage=" + cnt;
//					System.out.println("--- " + url);
					getTitleList(url,startStr,endStr,sjId);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
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
		
		private boolean doInsertTable(String ctTitle,String ct_create_time,String ctContent,int sjId){
			boolean flag = false;
			CDataCn dCn = new CDataCn();
			CDataImpl dImpl = new CDataImpl(dCn);
			
			//执行插入操作
			try{
				//flag = executeUpdate(sql);
				dImpl.addNew("tb_content","ct_id");
				dImpl.setValue("CT_TITLE",ctTitle,CDataImpl.STRING);
				dImpl.setValue("CT_CREATE_TIME",ct_create_time,CDataImpl.STRING);
				dImpl.setValue("CT_CONTENT",ctContent,CDataImpl.SLONG);
				dImpl.setValue("SJ_ID",String.valueOf(sjId),CDataImpl.STRING);
				dImpl.setValue("DT_ID","57",CDataImpl.INT);
				flag = dImpl.update();
				if(flag){
					int ctId = getMaxID("tb_content");
					doInsertContentPublish(sjId,ctId,88);
				}
			}catch(Exception ex){
			    System.out.println(ex.getMessage());
			}
			return flag;
		}
		
		private boolean doInsertContentPublish(int sjId,int contentId,int number){
			boolean flag = false;
			CDataCn cDn = new CDataCn();
			CDataImpl dImpl = new CDataImpl(cDn);
			try{
				dImpl.addNew("tb_contentpublish","CP_ID");
				dImpl.setValue("CT_ID",String.valueOf(contentId),CDataImpl.INT);
				dImpl.setValue("SJ_ID",String.valueOf(sjId),CDataImpl.INT);
				dImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
				dImpl.update();
				int newCpId = getMaxID("tb_contentpublish");
//				System.out.println("-sjId = " + sjId + "   contentId = " + contentId);
				if(flag){
					dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes'," + number +")");
					
				}else{
					dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_contentpublish','CP_ID'," + newCpId + ",'No'," + number +")");
				}
			}catch(Exception ex){
				System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
				cDn.closeCn();
				dImpl.closeStmt();
			}finally{
				cDn.closeCn();
				dImpl.closeStmt();
			}
			return flag;
		}
		
		public void getTitleList(String strUrl,String startStr,String endStr,int sjId) {
			String strTitle = "";
			String ct_create_time = "";
			String subUrl = "";
			String strWebUrl = "";
			StringBuffer sb = new StringBuffer();
			titleList = getAllTitle(sjId);
			//内容字符串
			String contentStr = "";
			if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
				strWebUrl = "http://www.bizpro.gov.cn/" + strUrl;
			else
				strWebUrl = strUrl;
			
			try {
				URL url = new URL(strWebUrl);
				BufferedReader reader = new BufferedReader(new InputStreamReader(
						url.openStream()));
				if (reader.ready()) {
					String temp = reader.readLine();
					while (temp != null) {
						
						sb.append(temp);
						strTitle = getContentStr(sb.toString(),startStr4Title,endStr4Title);
						ct_create_time = getContentStr(sb.toString(),"color=\"#999999\">","</font></td>");
						subUrl = getContentStr(sb.toString(),startStr4SubUrl,endStr4SubUrl);
						if(!"".equals(subUrl)){
							
							subUrl = "http://www.bizpro.gov.cn/website/common/content.jsp" + subUrl;
							if("浦东发展规划".equals(strTitle))
								endStr = "</P></td>";
							contentStr = fullImgPath(getHtml(subUrl,startStr,endStr),imgFullPath);
							
//							System.out.println("----1  " + strTitle);
//							System.out.println("----2  " + contentStr);
//							System.out.println();
							
							//进行数据库操作
							if(!titleList.contains(strTitle))
								doInsertTable(strTitle,ct_create_time,contentStr,sjId);
						}
						
						if(!"".equals(strTitle)){
							sb = new StringBuffer();
						}
						temp = reader.readLine();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		private String fullImgPath(String sourceStr,String url){
			return sourceStr.replaceAll("src=\"/","src=\"" + url +"/");
		}
		
		
	}


	
