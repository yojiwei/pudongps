package com.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
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
public class BatchGetNews2 extends TimerTask {

	
	private final static String startStr4Title = "target=\"_blank\"><b>";
	private final static String endStr4Title = "</b></a>";
	private final static String startStr4SubUrl = "valign=\"bottom\"><a href=\"";
	private final static String endStr4SubUrl = "\" target=\"_blank\"";
	private final static String startStr4Content = "</table> -->";
	private final static String endStr4Content = "<!-- <table";
	private final static String imgFullPath = "http://61.129.65.46/";
	private ArrayList titleList= null;
	
	private ArrayList newTitleList = null;
	private ArrayList newContentList = null;
	private ArrayList timeList = null;
	private final static String pudongquzhang = "http://61.129.65.46/Scontent.asp";
	
	private static int totalCnt = 0;
	  /**
	  * Construct and use a TimerTask and Timer.
	  */
	  public static void main (String[] arguments ) {
		  BatchGetNews2 batchgetnews  = new BatchGetNews2();
		  batchgetnews.run();
	    
//	     Timer timer = new Timer();
//	     timer.scheduleAtFixedRate(batchgetnews,getTomorrowMorning7am(),fONCE_PER_DAY);
//	     timer.scheduleAtFixedRate(batchgetnews,new Date(),fONCE_PER_DAY);
	  }

	 
	  public void getNewsNow(HttpServletRequest request,String ct_id){
		  String chkJZBG = request.getParameter("chkJZBG");
		  String chkBY1 = request.getParameter("chkBY1");
		  String chkBY2 = request.getParameter("chkBY2");
		  
		  if("Y".equals(chkJZBG)){
			  System.out.println("浦东新区网上办公会...");
			  titleList = getAllTitle(ct_id);
			  doCircleGet(pudongquzhang,startStr4Content,endStr4Content,startStr4Title,
					  endStr4Title,startStr4SubUrl,endStr4SubUrl,imgFullPath,1,2,"2025",0);
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
		 
		  //浦东新区网上办公会
//		  System.out.println("浦东新区网上办公会...");
//		  sjId = getSjId("selectedColumn");
//		 doCircleGet(pudongquzhang,startStr4Content,endStr4Content,startStr4Title,
//				  endStr4Title,startStr4SubUrl,endStr4SubUrl,imgFullPath,1,2,"2025",0);
		  
		 
		  //政府采购信息--货物
		  doCircleGet("http://www.shpd-procurement.gov.cn/new/web/PopWindow/MoreInfoKindAll.asp?Code=StockInfomation&KindID=15",
				  "</b></font><br><br></div>","</iframe-->",")\"> 上海","</a>","javascript:WinOpenMoreKind(",")\">",
				  "http://www.shpd-procurement.gov.cn/new/web",1,1,"351",2);
		  
		  //政府采购信息--工程
		  doCircleGet("http://www.shpd-procurement.gov.cn/new/web/PopWindow/MoreInfoKindAll.asp?Code=StockInfomation&KindID=64",
				  "</b></font><br><br></div>","</iframe-->",")\"> 上海","</a>","javascript:WinOpenMoreKind(",")\">",
				  "http://www.shpd-procurement.gov.cn/new/web",1,1,"351",2);
		  
		  //政府采购信息--服务
		  doCircleGet("http://www.shpd-procurement.gov.cn/new/web/PopWindow/MoreInfoKindAll.asp?Code=StockInfomation&KindID=65",
				  "</b></font><br><br></div>","</iframe-->",")\"> 上海","</a>","javascript:WinOpenMoreKind(",")\">",
				  "http://www.shpd-procurement.gov.cn/new/web",1,1,"351",2);
		  
//		  //中介组织\投资促进
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_id=199&sj_name=投资促进&sj_parentid=105" +
//		  		"&sj_dir=Advance&sj_display_flag=1",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"359",3);
//		  
//		  //中介组织\咨询代理
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_id=150&sj_name=咨询代理&sj_parentid=105" +
//		  		"&sj_dir=Refer&sj_display_flag=1",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"360",3);
//		  
//		  //中介组织\行业协会
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=149&sj_name=行业协会" +
//		  		"&sj_parentid=105&sj_dir=Union",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"361",3);
//		  
//		  //中介组织\人力资源
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=151&sj_name=人力资源" +
//		  		"&sj_parentid=105&sj_dir=Resource",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,2,"362",3);//14
//		 
//		  //中介组织\其它组织? 
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=152&sj_name=其它组织" +
//		  		"&sj_parentid=105&sj_dir=OtherOrg",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"363",3);
//		  
//		  //投资实用信息\旅游交通
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_id=157&sj_name=旅游交通&sj_parentid=106" +
//		  		"&sj_dir=Biz&Tour&sj_display_flag=1",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"364",3);//2
//		  
//		  //投资实用信息\法律援助
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=154&sj_name=法律援助" +
//		  		"&sj_parentid=106&sj_dir=Law",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"365",3);
//		  
//		  //投资实用信息\医疗保健
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=155&sj_name=医疗保健" +
//		  		"&sj_parentid=106&sj_dir=Medicine",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"366",3);
//		  
//		  //投资实用信息\文化教育
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=156&sj_name=文化教育" +
//		  		"&sj_parentid=106&sj_dir=Education",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"367",3);//2
//		  
//		  //投资实用信息\金融保险
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=153&sj_name=金融保险" +
//		  		"&sj_parentid=106&sj_dir=Finance",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"368",3);//2
//		  
//		  //投资实用信息\社区生活
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=159&sj_name=社区生活" +
//		  		"&sj_parentid=106&sj_dir=Life",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"369",3);//2
//		  
//		  //投资实用信息\常用热线
//		  doCircleGet("http://www.bizpro.gov.cn/website/common/list.jsp?sj_display_flag=1&sj_id=160&sj_name=常用热线" +
//		  		"&sj_parentid=106&sj_dir=Hotline",
//				  "height=\"410\">","</table></td>","target=\"_blank\" >","</a>&nbsp;&nbsp;&nbsp;","tdunderVLine01\"><a href=\"",
//				  "\" target=\"_blank\" >","http://www.bizpro.gov.cn/",1,1,"370",3);//2
		  
		  System.out.println("-------------finished---------------");
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
				System.out.println(e.getMessage());
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

		private ArrayList getAllTitle(String sj_id){
			ArrayList list = new ArrayList();
			String sql = " SELECT CT_TITLE FROM TB_CONTENT where ct_id in (select ct_id from tb_contentpublish where "
						+ " sj_id in (select sj_id from tb_subject connect by prior sj_id=sj_parentid start with sj_id"
						+ " = '"+sj_id+"')) ";
			String title = "";
			CDataCn dataCn = null;
			CDataImpl dImpl= null;
			ResultSet rs= null;
			try{
				dataCn = new CDataCn();
				dImpl = new CDataImpl(dataCn);
				rs = dImpl.executeQuery(sql);
				while(rs.next()){
					title = rs.getString("CT_TITLE");
					list.add(title);
				}
			}catch (Exception ex) {
				System.out.println(" Exception: " + ex.getMessage());
			}finally{
				dataCn.closeCn();
				dImpl.closeStmt();
			}
			return list;
		}
		
		public void doCircleGet(String strUrl,String sStr4Content,String eStr4Content,String sStr4Title,String eStr4Title,
				String sStr4SubUrl,String eStr4SubUrl,String imgPath,int startPage,int endPage,String sjId,int type){
			startPage = startPage == 0 ? 1 : startPage;
			endPage = endPage == 0 ? 5 : endPage;
			String url = "";
			try{
				if(type ==0 || type ==2){
					getTitleList(strUrl,sStr4Content,eStr4Content,sStr4Title,
							  eStr4Title,sStr4SubUrl,eStr4SubUrl,imgPath,type,sjId);
//					batchInsertTable(sjId);
				}else{
					for(int cnt = startPage;cnt <= endPage;cnt++){
						url = strUrl + "&strPage=" + cnt;
						
						try{
							getTitleList(url,sStr4Content,eStr4Content,sStr4Title,
									  eStr4Title,sStr4SubUrl,eStr4SubUrl,imgPath,type,sjId);
						} catch (Exception e) {
							System.out.println(e.getMessage());
							continue;
						}
//						batchInsertTable(sjId);
						
					}
				}
				System.out.println("totalCnt = " + totalCnt);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}

		
		
		public void batchInsertTable(String sjId){
			int len = newTitleList.size();
//			System.out.println("---------len = " + len);
			try{
				String ctTitle = "";
				String ctContent = "";
				String createTime = "";
				for(int k = len;k > 0;k--){
					ctTitle = (String)newTitleList.get(k-1);
					if(newContentList.size() > k)
						ctContent = (String)newContentList.get(k-1);
					if(timeList.size() > k)
						createTime = (String)timeList.get(k-1);
					doInsertTable("1",ctTitle,createTime,ctContent,sjId,"20000");
				}
			}catch(Exception ex){
				System.out.println(" SQLException: " + ex.getMessage());
			}
		}
		
		private boolean doInsertTable(String inCategory,String ctTitle,String createTime,String ctContent,String sjId,String dtId){
			boolean flag = false;
			CDataCn cdn = new CDataCn();
			CDataImpl cImpl = new CDataImpl(cdn);
			try{
				//执行插入操作  TB_CONTENT
				cImpl.addNew("tb_content","CT_ID");
				cImpl.setValue("CT_TITLE",ctTitle,CDataImpl.STRING);
				cImpl.setValue("CT_CREATE_TIME",createTime,CDataImpl.STRING);
				cImpl.setValue("CT_CONTENT",ctContent,CDataImpl.SLONG);
				cImpl.setValue("IN_CATEGORY",inCategory,CDataImpl.STRING);
				cImpl.setValue("SJ_ID",sjId+",",CDataImpl.STRING);
				cImpl.setValue("DT_ID",dtId,CDataImpl.INT);
				flag = cImpl.update();
				//执行插入操作 TB_CONTENTPUBLISH
				if(flag){
					//插入记录到导入成功记录表
					totalCnt ++;
					int newCtId = getMaxID("tb_content");
//					System.out.println("ctId = " + newCtId);
					cImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_content','CT_ID'," + newCtId + ",'Yes','26')");
					
					cImpl.addNew("tb_contentpublish","CP_ID");
					cImpl.setValue("SJ_ID",sjId,CDataImpl.INT);
					cImpl.setValue("CT_ID",String.valueOf(newCtId),CDataImpl.INT);
					cImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
					flag = cImpl.update();
					if(flag){
						//插入记录到导入成功记录表
						int newCpId = getMaxID("tb_contentpublish");
						cImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes','26')");
					}
				}
			}catch(Exception ex){
				System.out.println(" SQLException: " + ex.getMessage());
			}finally{
				cImpl.closeStmt();
				cdn.closeCn();
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
				String startTitle,String endTitle,String startSubUrl,String endSubUrl,
				String imgPath,int type,String sj_id) throws IOException{
			String strTitle = "";
			String subUrl = "";
			String strWebUrl = "";
			String createTime = "";
			String dtId = "20000";
			int messageCnt = 0;
			newTitleList = new ArrayList();
			newContentList = new ArrayList();
			timeList = new ArrayList();
			StringBuffer sb = new StringBuffer();
			titleList = getAllTitle(sj_id);
			//内容字符串
			String contentStr = "";
			if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
				strWebUrl = "http://61.129.65.46/" + strUrl;
			else
				strWebUrl = strUrl;
//			System.out.println("strWebUrl = " + strWebUrl);
			try{
				URL url;
				url = new URL(strWebUrl);
				
				BufferedReader reader = new BufferedReader(new InputStreamReader(
						url.openStream()));
				if (reader.ready()) {
					String temp = reader.readLine();
					int cnt = 0;
					while (temp != null) {
						
						sb.append(temp);
						if(type == 2){
							sb = new StringBuffer(sb.toString().replaceAll("\">上","\"> 上"));
							sb = new StringBuffer(sb.toString().replaceAll("\">  上","\"> 上"));
						}
						strTitle = getContentStr(sb.toString(),startTitle,endTitle);
						if(!"".equals(strTitle))
							messageCnt++;
						
						////每天更新的记录应该不会超过20 条，所以20条以后的记录不读取
						if(messageCnt <= 20 && !titleList.contains(strTitle)){
							subUrl = getContentStr(sb.toString(),startSubUrl,endSubUrl);
							createTime = getContentStr(sb.toString(),"<font color=\"#136565\">","</font>)");
							if(!"".equals(subUrl)){
								if(type == 0){
									subUrl = "http://61.129.65.46/" + subUrl;
								}else if(type == 1){
									subUrl = "http://www.pudong.gov.cn:7001/website/govopen/" +
											"GovOpenOtherInfoDetail.jsp?info="+subUrl;
									createTime = getContentStr(sb.toString(),"(<font color=\"#333333\">","</font>)");
								}else if(type == 2){
									subUrl = "http://www.shpd-procurement.gov.cn/new/web/PopWindow" +
											"/PopWindow.asp?id="+subUrl;
									createTime = getHtml(subUrl,"发布日期：","日&nbsp;&nbsp;(浏览次数");
									createTime = getSampleDate(createTime);
								}else if(type == 3){
									dtId = "57";
									subUrl = "http://www.bizpro.gov.cn"+subUrl;
									createTime = getContentStr(sb.toString(),"<font color=\"#999999\">","</font></td>");
								}
								
								contentStr = fullImgPath(getHtml(subUrl,startStr,endStr),imgPath);
								
								if(titleList != null && !"".equals(strTitle) && !"".equals(createTime)){
	//								newTitleList.add(strTitle);
	//								newContentList.add(contentStr);
	//								timeList.add(createTime);
									// for 部门信息公开
									doInsertTable("1",strTitle,createTime,contentStr,sj_id,dtId);
								}
							}
						}
						if(!"".equals(strTitle)){
							sb = new StringBuffer();
							cnt++;
//							if(cnt > 14)break;
						}
						temp = reader.readLine();
					}
				}
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				System.out.println("MalformedURLException " + e.getMessage());
				throw new MalformedURLException();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("IOException " + e.getMessage());
				throw new IOException();
			}
		}
		
		private String getSampleDate(String sourceStr){
			String targetStr = "";
			int yearCnt = sourceStr.indexOf("年");
			int monthCnt = sourceStr.indexOf("月");
			String year = "";
			String month = "";
			String day = "";
			if(!"".equals(sourceStr)){
				year = sourceStr.substring(0,yearCnt);
				month = sourceStr.substring(yearCnt+1,monthCnt);
				month = month.length() == 1 ? "0" + month : month;
				day = sourceStr.substring(monthCnt+1);
				day = day.length() == 1 ? "0" + day : day;
			}
			targetStr = year + "-" + month + "-" + day;
			return targetStr;
		}
		
		public String getSjId(String sjDir){
			String sjId = "0";
			String sql = " SELECT SJ_ID FROM TB_SUBJECT WHERE SJ_DIR = '"+ sjDir +"'";
			ResultSet rs = null;
			CDataCn dataCn = null;
			CDataImpl dImpl= null;
			try {
				dataCn = new CDataCn();
				dImpl=new CDataImpl(dataCn);
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


	
