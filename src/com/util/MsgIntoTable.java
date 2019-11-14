package com.util;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class MsgIntoTable {

	
	/**
	 * Description：初始化变量
	 * @param fileStr 一段xml的字符串
	 */
	public Element initEle(String fileStr){
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try{
			sb = new SAXBuilder();
			InputStream inputStream = new  ByteArrayInputStream(fileStr.getBytes("gb2312"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		}catch(Exception ex){
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}
	
	/**
	 * 将传入的字符串转化插入相应的数据表
	 * @param fileStr 转化成base64的文件源
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	public synchronized boolean doInsertTable2(String fileStr){
		Element ele = initEle(fileStr);
		return getContent(ele);
	}
	
	/**
	 * 将传入的字符串转化插入相应的数据表
	 * @param element 跟目录元素
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean getContent(Element element){
		Element content = null;
		String ctName = "";
		List list = element.getChildren();
		boolean flag = false;
		for(int cnt = 0; cnt < list.size(); cnt++){
			content = (Element)list.get(cnt);
			ctName = content.getName().toString();
			
			if("TB_CONTENT".equals(ctName))
				flag = getContentInfo(content);
		}
		return flag;
	}
	
	/**
	 * 
	 * @param contentMap 包含内容主体的HashMap
	 * @param list 包含附件的 List
	 * @return  boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean insertAttach(HashMap contentMap,ArrayList list){
		boolean flag = true;
		HashMap map = null;
		long ctId = doInsertContent(contentMap);
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		String newDir = getNewDir(cImpl.getInitParameter("info_save_path"));
		//----------todo
		//newDir = getNewDir("E:\\programImg\\");
		String newFileName = "";
		String atContent = "";
		String atType = "";
		int size = list.size();
		if(ctId != -1){
			for(int cnt = 0; cnt < size; cnt++){
				map = (HashMap) list.get(cnt);
				atContent = map.get("CT_BASE").toString();
				atType = map.get("CT_TYPE").toString();
				if(!"".equals(atContent)){
					newFileName = CDate.getThisTime() + cnt + "." + atType;
					CBase64.saveDecodeStringToFile(atContent,newFileName);
					flag = doInsertAttach(ctId,newDir,newFileName);
				}
			}
		}
		return flag;
	}
	
	/**
	 * 插入附件表
	 * @param ctId ct_id
	 * @param newDir 附件存放的路径
	 * @param newFileName 附件名
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean doInsertAttach(long ctId,String newDir,String newFileName){
		//System.out.println("-=-=-=-==-=-=-=-=");
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		try{
			cImpl.addNew("tb_image","IM_ID");
			cImpl.setValue("IM_PATH",newDir,CDataImpl.STRING);
			cImpl.setValue("IM_FILENAME",newFileName,CDataImpl.STRING);
//			cImpl.setValue("IM_CONTENT",atContent,CDataImpl.SLONG);
			cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.STRING);
			flag = cImpl.update();
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
			//cDn.closeCn();
			//cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return flag;
	}
	
	/**
	 * 插入tb_content 表
	 * @param map 包含内容主体的HashMap
	 * @return ctId 插入的记录的主键值
	 */
	private long doInsertContent(HashMap map){
		//System.out.println("------------------");
		boolean flag = false;
		long ctId = -1;
		CDataCn cDn = null;
		CDataImpl cImpl = null;
		String ctTitle = map.get("CT_TITLE") == null ? "" : map.get("CT_TITLE").toString();
		String ctContent = map.get("CT_CONTENT") == null ? "" : map.get("CT_CONTENT").toString();
		String ctCreateTime = map.get("CT_CREATE_TIME") == null ? "" : map.get("CT_CREATE_TIME").toString();
		String ctSource = map.get("CT_SOURCE") == null ? "" : map.get("CT_SOURCE").toString();
		String dtId = map.get("DT_ID") == null ? "" : map.get("DT_ID").toString();
		String sjId = map.get("SJ_ID") == null ? "" : map.get("SJ_ID").toString();
		//ctTitle=CTools.htmlEncode(ctTitle);

		if(!hasMessage(ctTitle,ctCreateTime)){
			try{
				System.out.println("--------ctTitle----------" + ctTitle);
				cDn = new CDataCn();
				cImpl = new CDataImpl(cDn);
				
				cDn.beginTrans();
				ctId = cImpl.addNew("tb_content","CT_ID");
				cImpl.setValue("CT_TITLE",ctTitle,CDataImpl.STRING);
				//cImpl.setValue("CT_CONTENT",ctContent,CDataImpl.SLONG);
				cImpl.setValue("CT_CREATE_TIME",ctCreateTime,CDataImpl.STRING);
				cImpl.setValue("CT_SOURCE",ctSource,CDataImpl.STRING);
				cImpl.setValue("DT_ID",dtId,CDataImpl.STRING);
				cImpl.setValue("SJ_ID",sjId,CDataImpl.STRING);
				flag = cImpl.update();
				
				if(flag){
					cImpl.addNew("tb_contentdetail","cd_id");
					cImpl.setValue("ct_id",String.valueOf(ctId),CDataImpl.INT);
					cImpl.update();
					cImpl.setClobValue("ct_content",ctContent);
					cDn.commitTrans();
					
					doInsertContentPublish(sjId,ctId,dtId);
				}else{
					cDn.rollbackTrans();
				}
			}catch(Exception ex){
				System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
				//cDn.closeCn();
				//cImpl.closeStmt();
			}finally{
				cImpl.closeStmt();
				cDn.closeCn();
			}
		}
		return ctId;
	}
	
	/*
	private boolean hasMessageEx(String title,String time){
		String sql = "select ct_id from tb_content where ct_title = '"+ title +"' and ct_create_time = '"+ time +"'";
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		Hashtable table = null;
		try{
			table = cImpl.getDataInfo(sql);
		}catch(Exception ex){
			System.out.println("SQLEXception::hasMessage " + ex.getMessage());
			cDn.closeCn();
			cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		System.out.println("------------hasMessage = " + sql + ":\n" +(table != null ? true : false));
		return table != null ? true : false;
	}
	*/
	
	
	//由王小平2007-5-28日修改，解决了重复导入信息的问题，判断了信息表和日志表，查询审核退回或者删除的信息
	private boolean hasMessage(String title,String time){
		boolean bRes=false;
		boolean bRes1=false;
		boolean bRes2=false;
		
		title=CTools.replace(title,"'","''"); //防止标题包含单引号查询出错
		
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		Hashtable table = null;
		Hashtable table2 = null;
		try{
			String sql = "select ct_id from tb_content where ct_title = '"+ title +"'";
			table = cImpl.getDataInfo(sql); //判断信息表
			bRes1 = table != null ? true : false;
			cImpl.closeStmt();
 
			String sql2="select lg_id from tb_log where lg_type = 4 and  lg_content='"+ title +"'";
			cImpl = new CDataImpl(cDn); //判断日志表，查询退回或者删除的信息，这些信息不能被再次导入
			table2 = cImpl.getDataInfo(sql2);
			bRes2 = table2 != null ? true : false;
			
			//System.out.println("------------hasMessage = " + sql + ":\n" + bRes1);
			//System.out.println("------------hasMessage = " + sql2 + ":\n" + bRes2);
			 
		}catch(Exception ex){
			System.out.println("SQLEXception::hasMessage " + ex.getMessage());
			//cDn.closeCn();
			//cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
				
		bRes= ((bRes1==true) || (bRes2==true));

		//System.out.println("------------title = " + title + ":\n" + bRes);
		
		return bRes;
	}
	
	/**
	 * 插入tb_contentpublish 表  
	 * @param sjId sj_id
	 * @param ctId ct_id
	 * @param dtId dt_id
	 * @return boolean 提交成功返回 true ,失败返回 false 
	 */
	private boolean doInsertContentPublish(String sjId,long ctId,String dtId){
		boolean flag = true;
		CDataCn cDn = null;
		CDataImpl cImpl = null;
		StringTokenizer token = new StringTokenizer(sjId,",");
		
		String check_status = "";//isNewsItem(sjId) ? "0" : "1";
		int len = token.countTokens();
		String[] str = new String[len];
		try{
			cDn = new CDataCn();
			cImpl = new CDataImpl(cDn);
			cDn.beginTrans();
			for(int cnt = 0; cnt < len; cnt++){
				str[cnt] = 	token.nextToken();
				
				check_status = isNewsItem(str[cnt]) ? "0" : "1";
				
				long cpId = cImpl.addNew("tb_contentpublish","CP_ID");
				cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
				cImpl.setValue("SJ_ID",str[cnt],CDataImpl.INT);
				cImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
				cImpl.setValue("AUDIT_STATUS","1",CDataImpl.INT);
				cImpl.setValue("check_status",check_status,CDataImpl.INT);
				
				flag = cImpl.update();
				
				//插入积分表
				doInsertScore(ctId,str[cnt],dtId);
			}
			cDn.commitTrans();
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			//cDn.closeCn();
			//cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return flag;
	}
	
	/**
	 * 判断栏目是否是浦东新闻下的栏目
	 * @param sj_id 栏目ID
	 * @return 是浦东新闻的栏目返回true，否则返回false
	 */
	private boolean isNewsItem(String sj_id){
		String sqlStr = "select sj_id from tb_subject where sj_id = any (select sj_id from tb_subject" +
				" connect by prior sj_id=sj_parentid start with sj_dir='pudongNews') and sj_id = '" + sj_id + "'";
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		Vector vec = null;
		try{
			vec = cImpl.splitPage(sqlStr,10,1);
		}catch(Exception ex){
			System.out.println("SQLEXception::isNewsItem " + ex.getMessage());
			//cDn.closeCn();
			//cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return vec != null ? true : false;
	}
	
	/**
	 * 
	 * @param content 包含内容主体的 HashMap
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean getContentInfo(Element content){
		List subList = null;
		Element subEle = null;
		HashMap map = new HashMap();
		subList = content.getChildren();
		String innerName = "";
		String innerValue = "";
		ArrayList attachList = null;
		boolean flag = false;
		for(int len = 0; len < subList.size(); len++){
			subEle = (Element)subList.get(len);
			innerName = subEle.getName();
			
			innerValue = subEle.getText();
			if("CT_TITLE".equals(innerName))
				map.put("CT_TITLE",innerValue);
			else if("CT_CONTENT".equals(innerName))
				map.put("CT_CONTENT",innerValue);
			else if("CT_CREATE_TIME".equals(innerName))
				map.put("CT_CREATE_TIME",innerValue);
			else if("CT_SOURCE".equals(innerName))
				map.put("CT_SOURCE",innerValue);
			else if("SJ_ID".equals(innerName))
				map.put("SJ_ID",innerValue);
			else if("DT_ID".equals(innerName))
				map.put("DT_ID",innerValue);
			else if("ATTACH".equals(innerName)){
				attachList = getAttachInfo(subEle);
				//System.out.println("----- " + attachList);
				if(attachList != null)
					flag = insertAttach(map,attachList);
			}
		}
		return flag;
	}
	
	/**
	 * 将附件信息存放在List中返回
	 * @param attach 包含附件信息的元素
	 * @return 存放附件的List
	 */
	private ArrayList getAttachInfo(Element attach){
		List subList = null;
		ArrayList list = new ArrayList();
		Element subEle = null;
		Element innerEle = null;
		List innerList = null;
		HashMap map = null;
		subList = attach.getChildren();
		String innerName = "";
		String innerValue = "";
		for(int len = 0; len < subList.size(); len++){
			subEle = (Element)subList.get(len);
			innerList = subEle.getChildren();
			map = new HashMap();
			
			for(int cnt = 0; cnt < innerList.size(); cnt++){
				innerEle = (Element) innerList.get(cnt);
				innerName = innerEle.getName();
				innerValue = innerEle.getTextTrim();
				if(!"".equals(innerName)){
					if("CT_BASE".equals(innerName))
						map.put("CT_BASE",innerValue);
					else if("CT_TYPE".equals(innerName))
						map.put("CT_TYPE",innerValue);
				}
			}
			list.add(map);
		}
		return list;
	}
	
	
	

	/**
	 * Description：积分表插入数据
	 * @param ctId 信息ID
	 * @param sjId 栏目ID
	 * @return 插入成功返回1
	 */
	private boolean doInsertScore(long ctId,String sjId,String dtId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		
		//执行插入操作
		try{
			//信息有对应的栏目
			if("0".endsWith(sjId)){
				cImpl.addNew("tb_score","SC_ID");
				cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
				cImpl.setValue("DT_ID",dtId,CDataImpl.INT);
				flag = cImpl.update();
			}
			
			//信息没有对应的栏目
			else{
				cImpl.addNew("tb_score","SC_ID");
				cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
				cImpl.setValue("DT_ID",dtId,CDataImpl.INT);
				cImpl.setValue("SC_SCORE","1",CDataImpl.INT);
				cImpl.setValue("SC_STATUS","1",CDataImpl.INT);
				flag = cImpl.update();
			}
			cImpl.executeUpdate("insert into tb_infostatic (addnum,PUBNUM,UPDATENUM,OPERTIME,DEPTID," +
					"SCORE,INFOID,TYPE,addtime) values(1,0,0,sysdate,"+ dtId +",1,"+ ctId +",0,sysdate)");			
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertScore " + ex.getMessage());
			//cDn.closeCn();
			//cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return flag;
	}
	
	/**
	 * Description：在指定目录下为每个附件生成一个独立的子目录
	 * @param pa_path 指定目录
	 * @return 带子目录的完整目录结构
	 */
	public static String getNewDir(String pa_path){
		String newDir = "";
		String thisDay = CDate.getThisday();
		int randomNum = 0;
		randomNum = (int)(Math.random()*100000);
		newDir = thisDay + Integer.toString(randomNum);
		pa_path.replaceAll("/","\\");
		
		File fileDir = new File(pa_path + newDir);
		if(!fileDir.exists()){
			fileDir.mkdirs();
			newDir = pa_path + newDir;
		}else{
			newDir = getNewDir(pa_path);
		}
		newDir += "\\";
		return newDir ;
	}
	
	
	
	
	
	/**
	 * 取得给出的表的最大值
	 * 
	 * @param tableName
	 *            表名
	 * @return int 主键的最大值
	 */
	/*
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
	*/
	
	public static void main(String[] args){
		//XmlIntoTable xmlintoTable = new XmlIntoTable();
		MsgIntoTable msgintitable = new MsgIntoTable();
		String fileStr = "";
		fileStr = "<?xml version=\"1.0\" encoding=\"gb2312\"?><DEPTWEB><TB_CONTENT><CT_TITLE>yanker测试</CT_TITLE><CT_CONTENT>Enter InstallAllHookGetAppDirectory OKEnter InitRegKeylRes == ERROR_SUCCESSExit InitRegKeyOnInitDialog-Start EVERYDAY_INTERVAL Timer...Start Update Progress!PostInsInfo2Server-统计服务器已经接受到!GetReg_PostOS = false ,call postmessage2server(2)OnButtonHide-Start NewsTimer...下载文件cdnnews.dat失败</CT_CONTENT><CT_CREATE_TIME>2006-06-07</CT_CREATE_TIME><CT_SOURCE>publiccc</CT_SOURCE><DT_ID>24</DT_ID><SJ_ID>111,222</SJ_ID><ATTACH/></TB_CONTENT></DEPTWEB>";
		System.out.println(msgintitable.doInsertTable2(fileStr));
	}
}
