package com.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class AutoGetMsg extends TimerTask{

	private HttpClient httpclient;
	private Logger logger;
	
	public AutoGetMsg() {
		logger = Logger.getLogger(AutoGetMsg.class);
		logger.info("start initializing AutoGetMsg!");
		
		httpclient = new HttpClient();
	}
	
	public void run(){
		getDataForSend();
	}
	/**
	 * 从信息表中取出需要报送的信息
	 *
	 */
	public void getDataForSend(){
		Vector vec = null;
		CDataCn cDn = new CDataCn("sqlserver");
		CDataImpl cImpl = new CDataImpl(cDn);
		//fileflag 是否报送的标识，1-->要报送  0-->不报送
		String sql = "select documentId,title,unit,author from xxcb_documentlib where DelFlag = 0 and fileflag = 1";
		try{
			vec = cImpl.splitPage(sql,50,1);
			if(vec != null){
				Hashtable table = null;
				for(int cnt = 0; cnt < vec.size(); cnt++){
					table = (Hashtable) vec.get(cnt);
					ResultToXml(table);
				}
			}
		}catch(Exception e){
			logger.info(e.getMessage());
		}finally{
			cDn.closeCn();
			cImpl.closeStmt();;
		}
	}
	
	private HashMap getTextData(String id){
		ResultSet resultSet = null;
		HashMap map = new HashMap();
		CDataCn cDn = new CDataCn("sqlserver");
		CDataImpl cImpl = new CDataImpl(cDn);
		try{
			resultSet = cImpl.executeQuery("select sendDate,content from xxcb_documentlib where " +
					"documentid = '"+ id +"'");
			while(resultSet.next()){
				map.put("sendDate",resultSet.getDate("senddate"));
				map.put("content",resultSet.getString("content"));
			}
		}catch(Exception e){
			logger.info("getTextData " + e.getMessage());
		}finally{
			cDn.closeCn();
			cImpl.closeStmt();;
		}
		return map;
	}
	
	private String getGBKStr(String source){
		String target = "";
		try {
			target = new String(source.getBytes("GBK"),"gb2312");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return target;
	}
	
	/**
	 * 用包含信息主体的table生成固定格式的xml
	 * @param table 信息主体的table
	 */
	private void ResultToXml(Hashtable table){
		StringBuffer sf = new StringBuffer("");
		String id = table.get("documentid").toString();
		System.out.println("-------------documentid = " + id);
		String ctTitle = table.get("title") == null ? "" : getGBKStr(table.get("title").toString());
		String ctSource = table.get("unit") == null ? "" : getGBKStr(table.get("unit").toString());
		String dt_id = table.get("author") == null ? "" : getGBKStr(table.get("author").toString());
		String sj_id = "371";                    //页面增加的栏目选择,固定的值
		HashMap map = getTextData(id);
		//需要从map取出的值
		String ctCreateTime = "";
		String ctContent = "";
		
		

		try{
			if(map.get("sendDate") != null)
				ctCreateTime = getGBKStr(map.get("sendDate").toString());
			if(map.get("content") != null)
				ctContent = getGBKStr(map.get("content").toString());
		}catch(Exception e){
			logger.info(e.getMessage());
		}
//		 加入xml头
		sf.append("<?xml version=\"1.0\" encoding=\"gb2312\"?>");
		sf.append("<DEPTWEB>");
		
		// 加入内容节点的起始位
		sf.append("<TB_CONTENT>");
		//加入标题
		if(!"".equals(ctTitle)){
			sf.append("<CT_TITLE>");
			sf.append(ctTitle);
			sf.append("</CT_TITLE>");
		}else{
			sf.append("<CT_TITLE/>");
		}
		
		//加入内容
		if(!"".equals(ctContent)){
			sf.append("<CT_CONTENT>");
			sf.append(ctContent);
			sf.append("</CT_CONTENT>");
		}else{
			sf.append("<CT_CONTENT/>");
		}
		
		//加入创建时间
		if(!"".equals(ctCreateTime)){
			sf.append("<CT_CREATE_TIME>");
			sf.append(ctCreateTime);
			sf.append("</CT_CREATE_TIME>");
		}else{
			sf.append("<CT_CREATE_TIME/>");
		}
		
		//加入来源
		if(!"".equals(ctSource)){
			sf.append("<CT_SOURCE>");
			sf.append(ctSource);
			sf.append("</CT_SOURCE>");
		}else{
			sf.append("<CT_SOURCE/>");
		}
		
		//加入所属部门
		if(!"".equals(dt_id)){
			sf.append("<DT_ID>");
			sf.append(dt_id);
//			sf.append("201");
			sf.append("</DT_ID>");
		}else{
			sf.append("<DT_ID/>");
		}
		
		//加入发布到的栏目
		if(!"".equals(sj_id)){
			sf.append("<SJ_ID>");
			sf.append(sj_id);
//			sf.append("122,123");
			sf.append("</SJ_ID>");
		}else{
			sf.append("<SJ_ID/>");
		}
		//加入附件
		sf = addAttachment(id,sf);
		
		//加入xml尾
		sf.append("</TB_CONTENT>");
		sf.append("</DEPTWEB>");
		
		
		getBizXml(id,sf.toString());
	}
	
	/**
	 * 生成Biztalk 能识别的xml
	 * @param infoXml 包含信息内容和附件xml
	 */
	public  void getBizXml(String id,String infoXml){
        Document document = DocumentHelper.createDocument();
        Element booksElement = document.addElement("ns0:在线办事消息");
        booksElement.addAttribute("xmlns:ns0",
                  "http://POCBiztalkOnlineWorkSchema.OnlineWorkSchema");
        Element userinfoElem = booksElement.addElement("用户信息");
        userinfoElem.addAttribute("用户名", "");
        userinfoElem.addAttribute("电话", "");
        userinfoElem.addAttribute("邮编", "");
        userinfoElem.addAttribute("身份证", "");
        userinfoElem.addAttribute("地址", "");
        Element baninfoElem = booksElement.addElement("办事信息");
        baninfoElem.addAttribute("事项类型ID", "");
        baninfoElem.addAttribute("办事ID", "");
        baninfoElem.addAttribute("事项名称", "");
        baninfoElem.addAttribute("办事内容", infoXml);
        baninfoElem.addAttribute("申请时间", "");
        baninfoElem.addAttribute("状态", "0");
//        Element a= baninfoElem.addElement("回复意见");
//        a.setText("meiyou");
        Element luinfoElem = booksElement.addElement("路由信息");
        Element mubiaoElem = luinfoElem.addElement("目标");
        mubiaoElem.addAttribute("目标ID", "200001");
        
//        System.out.println("========= " + document.asXML());
        sendToBiztalk(id,document.asXML());

		
		
	}
	
	private void sendToBiztalk(String id,String bizXml){
		String url = "http://12.103.2.21:8018/BizTalkReceive/BTSHTTPReceive.dll";
		PostMethod post = new PostMethod(url);
        post.setRequestHeader("Content-type","text/xml; charset=UTF-8");
        post.setRequestBody(bizXml);
        
        try {
            logger.info("sending data to " + url);
            httpclient.executeMethod(post);
            logger.info("data sended");
            logger.info("updating database ...");
            doUpdateContent(id);
            logger.info("database updated");
        }
        catch (IOException ex) {
            logger.error(null, ex);
        }
	}
	
	private boolean doUpdateContent(String id){
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		boolean flag = false;
		try{
			cImpl.edit("xxcb_documentlib","documentId",id);
			cImpl.setValue("fileflag","2",CDataImpl.STRING);
			cImpl.update();
		}catch(Exception e){
			logger.info(e.getMessage());
		}finally{
			cDn.closeCn();
			cImpl.closeStmt();;
		}
		return flag;
	}
	
	/**
	 * 得到包含附件的名称，文件名，内容，附件类型的结果集
	 * @param id 信息对应的id
	 * @return 附件的结果集
	 */
	private StringBuffer addAttachment(String id,StringBuffer sf){
		ResultSet result = null;
		if(id.indexOf(".") != -1)
			id = id.substring(0,id.indexOf("."));
		String sql = "select content,fileextname from xxcb_documentattach where " +
				" tablename='xxcb_documentlib' and tableid = '"+ id +"'";
		String cntSql = "select count(id) as totalCnt from xxcb_documentattach where " +
				" tablename='xxcb_documentlib' and tableid = '"+ id +"' group by id";
		Hashtable table = null;
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		String attachContent = "";
		String fileExtName = "";
		try{
			table = cImpl.getDataInfo(cntSql);
			if(table != null){
				result = cImpl.executeQuery(sql);
				sf.append("<ATTACH>");
				while(result.next()){
					byte[] bytes = result.getBytes("content");
					fileExtName = result.getString("fileextname");
					
					attachContent = CBase64.getEncodeString(bytes);
//					CBase64.saveDecodeStringToFile(attachContent,"c:\\yk\\yuyu" + "." +fileExtName);
                    sf.append("<AT_CONTENT>");
					sf.append("<CT_BASE>");
					sf.append(attachContent);
					sf.append("</CT_BASE>");
					
					sf.append("<CT_TYPE>");
					sf.append(fileExtName);
					sf.append("</CT_TYPE>");
					
					sf.append("</AT_CONTENT>");
				}
				sf.append("</ATTACH>");
			}else{
				sf.append("<ATTACH/>");
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			cDn.closeCn();
			cImpl.closeStmt();;
		}
		return sf;
	}
	
	public static void main(String[] args){
		AutoGetMsg autoGetMsg = new AutoGetMsg();
		autoGetMsg.getDataForSend();
	}
	
}
