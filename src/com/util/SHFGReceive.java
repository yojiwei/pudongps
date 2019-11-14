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

import com.component.database.CDataCn;
import com.component.database.CDataImpl;


/**
 * <p>Program Name:信息抓取</p>
 * <p>Module Name:抓取上海法律法规</p>
 * <p>Function:抓取上海法律法规</p>
 * <p>Create Time: 2006-4-27 14:36:27</p>
 * @author: Administrator
 * @version: 
 */
public class SHFGReceive extends TimerTask{

	//标题的起始标识
	private final static String startStr4Title = ".html\">";
	
	//标题的结束标识
	private final static String endStr4Title = "</A> </TD>";
	
	//内容页面的url的起始标识
	private final static String startStr4SubUrl = "href=\"/shanghai/node2314/node3124/";
	
	//内容页面的url的结束标识
	private final static String endStr4SubUrl = ".html\">";
	
	//内容的起始标识
	private final static String startStr4Content = "<TD width=\"100%\" height=16>";
	
	//内容的结束标识
	private final static String endStr4Content = "</TR></TBODY></TABLE></TD></TR><BR>";
	
	//记录每个栏目的插入的总记录数
	private static int totalCnt = 0;
	
	//某一栏目下的记录的title的 list
	private static ArrayList titleList= null;
	  /**
	  * Construct and use a TimerTask and Timer.
	  */
	  public static void main (String[] arguments ) {
		  SHFGReceive receive  = new SHFGReceive();
		  receive.run();
	    //perform the task once a day at 4 a.m., starting tomorrow morning
	    //(other styles are possible as well)
//	    Timer timer = new Timer();
//	    timer.scheduleAtFixedRate(fetchMail,getTomorrowMorning7am(), fONCE_PER_DAY);
	  }
	  
	  /**
	  * Implements TimerTask's abstract run method.
	  */
	  public void run(){
		  System.out.println("综合经济...");
		  //物价
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3142/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //质量技术监督
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3143/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //标准化
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3144/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //农业
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3145/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //渔业
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3146/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //畜牧
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3147/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //工业
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3148/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //商业
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3149/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //安全生产
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3150/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //市场秩序
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3151/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //财政
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3152/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //金融
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3153/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //期货市场
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3154/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //投资
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3155/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //国有资产
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3156/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //外商投资
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3157/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //对外经贸
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3158/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //内联协作
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3159/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //审计
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3160/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  //统计
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3141/node3161/index.html",
				  startStr4Content,endStr4Content,0,1,18604);
		  System.out.println("综合经济 totalCnt = " + totalCnt);
		  
		  
		  System.out.println("科教文化...");
		  totalCnt = 0;
		  //科技  
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3165/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //教育
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3166/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //文化
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3167/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //信息
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3168/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //档案
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3169/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //体育
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3170/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //旅游
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3171/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //知识产权
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3172/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //新闻出版
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3173/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //广播电影电视
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3174/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //文物
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3175/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  //宗教
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3164/node3176/index.html",
				  startStr4Content,endStr4Content,0,1,18609);
		  System.out.println("科教文化 totalCnt = " + totalCnt);
		  
		  System.out.println("社会保障...");
		  totalCnt = 0;
		  //卫生
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3126/index.html",
				  startStr4Content,endStr4Content,0,1,18605);
		  //医疗卫生
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3127/index.html",
				  startStr4Content,endStr4Content,0,2,18605);
		  //民政
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3128/index.html",
				  startStr4Content,endStr4Content,0,1,18605);
		  //劳动
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3129/index.html",
				  startStr4Content,endStr4Content,0,2,18605);
		  //人事
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3130/index.html",
				  startStr4Content,endStr4Content,0,1,18605);
		  //社会保障
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3131/index.html",
				  startStr4Content,endStr4Content,0,2,18605);
		  //社会福利
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3132/index.html",
				  startStr4Content,endStr4Content,0,1,18605);
		  //特殊群体权益保护
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3125/node3133/index.html",
				  startStr4Content,endStr4Content,0,1,18605);
		  System.out.println("社会保障 totalCnt = " + totalCnt);
		  
		  System.out.println("城市建设...");
		  totalCnt = 0;
		  //民防
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3178/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //综合管理
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3179/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //房地产
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3180/index.html",
				  startStr4Content,endStr4Content,0,2,18608);
		  //建筑
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3181/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //建材
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3182/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //市容
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3183/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //环卫
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3184/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //环保
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3185/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //绿化
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3186/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //浦东开放开发
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3187/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //能源
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3188/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //水资源
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3189/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //水利
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3190/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //市政
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3191/index.html",
				  startStr4Content,endStr4Content,0,2,18608);
		  //规划
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3192/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //地名
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3193/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //交通
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3194/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //交通秩序管理
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3195/index.html",
				  startStr4Content,endStr4Content,0,2,18608);
		  //港口
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3196/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  //电信
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3177/node3197/index.html",
				  startStr4Content,endStr4Content,0,1,18608);
		  System.out.println("城市建设 totalCnt = " + totalCnt);
		  
		  System.out.println("公安司法...");
		  totalCnt = 0;
		  //司法行政
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3199/node3200/index.html",
				  startStr4Content,endStr4Content,0,1,18607);
		  //公安
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3199/node3201/index.html",
				  startStr4Content,endStr4Content,0,2,18607);
		  //消防
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3199/node3202/index.html",
				  startStr4Content,endStr4Content,0,1,18607);
		  //监察
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3199/node3203/index.html",
				  startStr4Content,endStr4Content,0,1,18607);
		  //廉政
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3199/node3204/index.html",
				  startStr4Content,endStr4Content,0,1,18607);
		  System.out.println("公安司法 totalCnt = " + totalCnt);
		  
		  System.out.println("其他...");
		  totalCnt = 0;
		  //动植物检疫
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node3135/index.html",
				  startStr4Content,endStr4Content,0,1,18606);
		  //计划生育
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node3136/index.html",
				  startStr4Content,endStr4Content,0,1,18606);
		  //气象
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node3137/index.html",
				  startStr4Content,endStr4Content,0,1,18606);
		  //侨务
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node3138/index.html",
				  startStr4Content,endStr4Content,0,1,18606);
		  //机构编制
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node3139/index.html",
				  startStr4Content,endStr4Content,0,1,18606);
		  //综合管理
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node5620/index.html",
				  startStr4Content,endStr4Content,0,1,18606);
		  //其他
		  doCircleGet("http://www.sh.gov.cn/shanghai/node2314/node3124/node3134/node3140/index.html",
				  startStr4Content,endStr4Content,0,3,18606);
		  System.out.println("其他 totalCnt = " + totalCnt);
		  
		  BatchGetNews2 batchGetNews2 = new BatchGetNews2();
		  batchGetNews2.run();
	  }

	  /**
		 *   Description：getHtml 解析地址并返回对应页的HTML内容
		 *   @parameter
		 *       @strUrl         完整的URL地址
		 *   @param  startStr 截取的起始标识
		 *   @param endStr 截取的结束标识
		 *   @return
		 *       String          解析过后的HTML代码
		 */
		public String getHtml(String strUrl, String startStr, String endStr) {
			String strReturn = "";
			String strWebUrl = "";
			int iBodyStart = -1;
			int iBodyEnd = -1;
			if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
				strWebUrl = "http://www.sh.gov.cn/shanghai/node2314/node3124/" + strUrl;
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
					if (iBodyStart > 0 && iBodyStart < iBodyEnd) {
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
				System.out.println(" Exception:getContentStr " + ex.getMessage());
			}
			return rtnStr;
		}

		/**
		 * Description：得到某一栏目下的所有信息的标题
		 * @param sjId 栏目ID
		 * @return 栏目下的所有信息的标题
		 */
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
				System.out.println(" Exception:getAllTitle " + ex.getMessage());
			}finally{
				cImpl.closeStmt();
				cDn.closeCn();
			}
			return list;
		}
		
		/**
		 * Description：循环读取页面
		 * @param strUrl 供解析的url地址
		 * @param startStr 解析地址是的起始标识
		 * @param endStr 解析地址时的结束标识
		 * @param startPage 地址的起始序号
		 * @param endPage 地址的结束序号
		 * @param sjId 记录要插入到的栏目ID
		 */
		public void doCircleGet(String strUrl,String startStr,String endStr,int startPage,int endPage,int sjId){
			startPage = startPage == 0 ? 0 : startPage;
			endPage = endPage == 0 ? 0 : endPage;
			String beforeStr = strUrl.substring(0,strUrl.lastIndexOf("."));
			String url = "";
			for(int cnt = startPage;cnt < endPage;cnt++){
				url = beforeStr + (cnt > 0 ? String.valueOf(cnt) : "") + ".html";
				try{
					getTitleList(url,startStr,endStr,sjId);
				}catch(Exception e){
					System.out.println("Exception : " + e.getMessage());
					continue;
				}
			}
		}
		
		/**
		 * Description：取得某一表的最大记录数
		 * @param tablename 要查询的表名
		 * @return 总记录数
		 */
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
		
		/**
		 * Description：将记录插入数据库
		 * @param ctTitle 信息标题
		 * @param ct_create_time 信息创建时间
		 * @param ctContent 信息内容
		 * @param sjId 信息关联的栏目ID
		 * @return 插入操作是否成功 成功返回true，失败返回false
		 */
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
					totalCnt++;
					int ctId = getMaxID("tb_content");
					doInsertContentPublish(sjId,ctId,88);
				}
			}catch(Exception ex){
			    System.out.println(" Exception:doInsertTable " + ex.getMessage());
			}
			return flag;
		}
		
		/**
		 * Description：插入信息与栏目关联表
		 * @param sjId 栏目ID
		 * @param contentId 信息ID
		 * @param number 操作批次
		 * @return
		 */
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
		
		/**
		 * Description：取得信息标题，内容，插入时间插入数据库
		 * @param strUrl 供解析的url地址
		 * @param startStr 解析的起始标识
		 * @param endStr 解析的结束标识
		 * @param sjId 信息插入的栏目ID
		 * @throws IOException 读取页面源文件或取得页面时抛出的错误
		 */
		public void getTitleList(String strUrl,String startStr,String endStr,int sjId) throws IOException {
			String strTitle = "";
			String ct_create_time = "";
			String subUrl = "";
			String strWebUrl = "";
			String strUrlAndTitle = "";
			StringBuffer sb = new StringBuffer();
			titleList = getAllTitle(sjId);
			int cnt = 0;
			//内容字符串
			String contentStr = "";
			if (strUrl.toUpperCase().indexOf("HTTP://") < 0)
				strWebUrl = "http://www.sh.gov.cn/shanghai/node2314/node3124/" + strUrl;
			else
				strWebUrl = strUrl;
			
			
			URL url;
			try {
				url = new URL(strWebUrl);
			
				BufferedReader reader = new BufferedReader(new InputStreamReader(
						url.openStream()));
				if (reader.ready()) {
					String temp = reader.readLine();
					while (temp != null) {
						
						sb.append(temp);
						strUrlAndTitle = getContentStr(sb.toString(),startStr4SubUrl,endStr4Title) + endStr4Title;
						strTitle = getContentStr(strUrlAndTitle,startStr4Title,endStr4Title).trim();
						subUrl = getContentStr(strUrlAndTitle,startStr4SubUrl,endStr4SubUrl);
						if(!"".equals(strTitle))
							cnt++;
						//每天更新的记录应该不会超过5 条，所以5条以后的记录不读取
						if(cnt <= 5){
							if(!"".equals(subUrl)){
								subUrl = "http://www.sh.gov.cn/shanghai/node2314/node3124/" + subUrl + ".html";
								contentStr = getHtml(subUrl,startStr,endStr);
								//进行数据库操作
								if(!"".equals(strTitle) && !titleList.contains(strTitle))
									doInsertTable(strTitle,ct_create_time,contentStr,sjId);
							}
						}
						
						
						if(!"".equals(strTitle)){
							sb = new StringBuffer();
						}
						temp = reader.readLine();
					}
				}
			} catch (MalformedURLException e) {
				System.out.println("MalformedURLException :" +e.getMessage());
				throw new MalformedURLException();
			} catch (IOException e) {
				System.out.println("IOException :" +e.getMessage());
				throw new IOException();
			}
		}
}


	
