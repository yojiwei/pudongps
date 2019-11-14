package com.app.rule;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东外事办</p>
 * <p>Module Name:专题搜索管理</p>
 * <p>Function:用搜索关键字在指定的栏目搜索出相应的记录用模版生成静态页面</p>
 * <p>Create Time: 2006-6-26 11:57:59</p>
 * @author: yanker
 * @version: 
 */
public class RuleResult {
	
	/**
	 * Description:得到满足条件的要求的记录条数
	 * @param srName 搜索关键字
	 * @param srRelation 搜索关键字间的关系，0 为全部满足，1 为部分满足
	 * @param srScope 搜索范围,栏目
	 * @param srNum 总记录数
	 * @return 满足条件的要求的记录条数
	 */
	public Vector getAllResult(HttpServletRequest request,String srName,String srRelation,String srScope,String srNum){
		Vector rtnVec = new Vector();
		String titleStr = getSrNameStr(srName,srRelation," ","ct_title");
		String keyWordStr = getSrNameStr(srName,srRelation," ","ct_keywords");
		srScope = getSubjectStr(srScope);
		String sql = "SELECT CT_ID,CT_TITLE,CT_CREATE_TIME,CT_SOURCE FROM TB_CONTENT WHERE SJ_ID IN (SELECT SJ_ID" +
				" FROM TB_SUBJECT WHERE SJ_NAME IN (" + srScope +"))";
		sql += " and " + titleStr + " or " + keyWordStr + " order by to_date(CT_CREATE_TIME,'yyyy-MM-DD') desc";
		CDataCn cDn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cDn);
		try{
			rtnVec = cImpl.splitPage(sql,request,Integer.parseInt(srNum));
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return rtnVec;
	}
	
	public String getSrNameStr(String srName,String srRelation,String separator,String srColumn){
		String srNameStr = "(";
		String[] str = getSearchName(srName,separator);
		int len = str.length;
		if("0".equals(srRelation))
			srRelation = "and";
		else if("1".equals(srRelation))
			srRelation = "or";
		for(int cnt = 0; cnt < len; cnt++){
			if(cnt == len - 1)
				srNameStr += srColumn + " like '%" + str[cnt] + "%' )";
			else
				srNameStr += srColumn + " like '%" + str[cnt] + "%' " + srRelation + " ";
		}
		return srNameStr;
	}
	
	/**
	 * Description:将关键字转化为数组
	 * @param srName 搜索关键字
	 * @param cos 关键字间的分割符
	 * @return 关键字数组
	 */
	public String[] getSearchName(String srName,String cos){
		StringTokenizer st = new StringTokenizer(srName,cos);
		String[] str = new String[st.countTokens()];
		for(int cnt = 0; cnt < str.length; cnt++){
			str[cnt] = st.nextToken();
		}
		return str;
	}
	
	/**
	 * Description:将搜索范围转化为用于在查询语句中用的字符串
	 * @param srScope 搜索范围,栏目
	 * @return 用于在查询语句中用的字符串
	 */
	public String getSubjectStr(String srScope){
		String rtnStr = "";
		StringTokenizer st = new StringTokenizer(srScope,",");
		int len = st.countTokens();
		for(int cnt = 0; cnt < len; cnt++){
			rtnStr = rtnStr + "'" + st.nextToken() + ",'" + ",";
		}
		rtnStr = rtnStr.substring(0,rtnStr.length()-1);
		return rtnStr;
	}
	
	/**
	 * Description:生成列表页面的静态页面
	 * @param srId 搜索的id
	 * @param listPage 列表页面的名字
	 * @param headName 文件头的mingcheng
	 * @param tailName 文件尾的名称
	 * @param filePath 文件存放的位置
	 */
	public void doCreateListFile(String srId,String listPage,String srListTemp,String filePath){
		StringBuffer sf = new StringBuffer("");
		int location = srListTemp.indexOf("[listtable]");
		if(location > -1){
			//加入列表前的部分
			sf.append("<%@page contentType=\"text/html; charset=GBK\"%>");
			sf.append(srListTemp.substring(0,location));
			
			//加入列表部分
			sf.append("<%@page import=\"com.util.CTools\"%>");
			sf.append("<%");
			sf.append(" String srId = CTools.dealString(request.getParameter(\"srId\")).trim();");
			sf.append("%>");
			sf.append("<jsp:include flush=\"true\" page=\"/website/diss/dissList.jsp\">");
			sf.append("<jsp:param name=\"srId\" value=\"<%=srId%>\"/>");
			sf.append("</jsp:include>");
			
			//加入列表后的部分
			sf.append(srListTemp.substring(location + 11));
		}else{
			sf.append(srListTemp);
		}
		try{
			
			//生成静态页面
			FileWriter outfile = new FileWriter(filePath + "\\" + listPage , false);
			BufferedWriter outButter = new BufferedWriter(outfile);
			outButter.write(sf.toString());
			outButter.flush();
			outfile.close();
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void doCreateDetailFile(String detailPage,String srDetailTemp,String filePath){
		StringBuffer sf = new StringBuffer("");
		int location = srDetailTemp.indexOf("[detailtable]");
		if(location > -1){
			//加入内容体前的部分
			sf.append("<%@page contentType=\"text/html; charset=GBK\"%>");
			sf.append(srDetailTemp.substring(0,location));
			
			//加入内容部分
			sf.append("<%@page import=\"com.util.CTools\"%>");
			sf.append("<%");
			sf.append(" String ctId = CTools.dealString(request.getParameter(\"ct_id\")).trim();");
			sf.append("%>");
			sf.append("<jsp:include flush=\"true\" page=\"/website/diss/dissdetail.jsp\" > ");
			sf.append("	<jsp:param name=\"ct_id\" value=\"<%=ctId%>\" /> ");
			sf.append("</jsp:include>");
			
			//加入内容后的部分
			sf.append(srDetailTemp.substring(location + 13));
		}else{
			sf.append(srDetailTemp);
		}
		try{
			
			//生成静态页面
			FileWriter outfile = new FileWriter(filePath + "\\" + detailPage , false);
			BufferedWriter outButter = new BufferedWriter(outfile);
			outButter.write(sf.toString());
			outButter.flush();
			outfile.close();
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void doCreateFile(HttpServletRequest request,String srId){
		String srName = "";     		//搜索关键字
		String srScope = "";   			//搜索范围
		String srNum = "";       		//显示的记录条数
		String srTemplate = "";			//模版
		String srRelation = "";			//搜索关键字的关系
		String srfileName = "";			//保存模版的文件名称
		String srFolderName = "";		//专题文件夹名字
		String srListTemp = "";			//列表页面的模版
		String srDetailTemp = "";		//详细页面的模版
		String detailPage = "";			//内容页面
		String listPage = "";			//列表页面
		String filePath = request.getRealPath("/");
		filePath += "website2005/diss/";
		String more = "";
		String sql = "select SR_ID,SR_NAME,SR_SCOPE,SR_NUM,SR_TEMPLATE,SR_FILENAME,SR_RELATION,SR_FOLDERNAME,"
						+" SR_LISTTEMP,SR_DETAILTEMP from SEARCHRULE where SR_ID=" + srId;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		Hashtable content = dImpl.getDataInfo(sql);
		if(content != null){
			srName=content.get("sr_name") != null ? content.get("sr_name").toString() : "" ;
			srScope=content.get("sr_scope").toString() != null ? content.get("sr_scope").toString() : "" ;
			srNum=content.get("sr_num").toString() != null ? content.get("sr_num").toString() : "" ;
			srTemplate=content.get("sr_template").toString() != null ? content.get("sr_template").toString() : "" ;
			srRelation = content.get("sr_relation").toString() != null ? content.get("sr_relation").toString() : "" ;
			srfileName = content.get("sr_filename").toString() != null ? content.get("sr_filename").toString() : "" ;
			listPage = srfileName.substring(0,srfileName.indexOf(".")) + "list" + srfileName.substring(srfileName.indexOf("."));
			detailPage = srfileName.substring(0,srfileName.indexOf(".")) + "detail" + srfileName.substring(srfileName.indexOf("."));
			srFolderName=content.get("sr_foldername").toString() != null ? content.get("sr_foldername").toString() : "" ;
			srListTemp = content.get("sr_listtemp").toString() != null ? content.get("sr_listtemp").toString() : "" ;
			srDetailTemp = content.get("sr_detailtemp").toString() != null ? content.get("sr_detailtemp").toString() : "" ;
		}
		more = "?srId=" + srId;
		StringBuffer sf = new StringBuffer("");
		String contentStr = "";   
		//得到符合条件的记录
		Vector vector = getAllResult(request,srName,srRelation,srScope,srNum);
		//生成的文件的路径
		filePath += srFolderName;
		
		//根据模版生成静态页面
		
		try{  
			if(!"".equals(srTemplate)){
				int titleCnt = srTemplate.indexOf("[loop]");
				//加入循环前的部分
				sf.append("<%@page pageEncoding=\"GBK\"%>");
				sf.append(srTemplate.substring(0,titleCnt));
				
				//加入循环部分
				contentStr = srTemplate.substring(srTemplate.indexOf("[loop]") + 6,srTemplate.indexOf("[/loop]"));
				sf.append(getContentStr(vector,contentStr,detailPage));
				
				//加入循环后的部分
				srTemplate = srTemplate.substring((srTemplate.indexOf("[/loop]") + 7));
				srTemplate = srTemplate.replaceAll("\\[listpage\\]",listPage);
				srTemplate = srTemplate.replaceAll("\\[more\\]",more);
				sf.append(srTemplate);
				
				//生成文件夹
				File file = new File(filePath);
				if(!file.exists())
					file.mkdir();
				
				//输出静态页面
				FileWriter outfile = new FileWriter(filePath + "\\" + srfileName, false);
				BufferedWriter outButter = new BufferedWriter(outfile);
				outButter.write(sf.toString());
				outButter.flush();
				outfile.close();
				
				//生成列表页面的静态页面
				doCreateListFile(srId,listPage,srListTemp,filePath);
				
				//生成详细页面的静态页面
				doCreateDetailFile(detailPage,srDetailTemp,filePath);
			}else{
				System.out.println("模版为空，不能生成页面！");
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	/**
	 * Description：根据模版生成静态页面主体部分
	 * @param vector 符合条件的记录集
	 * @param contentStr //模版文件
	 * @return 生成的静态页面主体部分
	 */
	private String getContentStr(Vector vector,String contentStr,String detailPage){
		StringBuffer sf = new StringBuffer("");
		Hashtable table = null;
		String ctId = "";
		String ctTitle = "";
		String tempStr = "";
		String ctCreateTime = "";
		for(int cnt = 0; cnt < vector.size(); cnt++){
			tempStr = contentStr;
			table = (Hashtable)vector.get(cnt);
			ctId = table.get("ct_id").toString();
			
			if(table.get("ct_title") != null)
				ctTitle = table.get("ct_title").toString();
			
			if(table.get("ct_create_time") != null)
				ctCreateTime = table.get("ct_create_time").toString();
			tempStr = tempStr.replaceAll("\\[detailpage\\]",detailPage);
			tempStr = tempStr.replaceAll("\\[ctid\\]",ctId);
			tempStr = tempStr.replaceAll("\\[title\\]",ctTitle);
			tempStr = tempStr.replaceAll("\\[ctcreatetime\\]",ctCreateTime);
			sf.append(tempStr);
		}
		return sf.toString();
	}
}
