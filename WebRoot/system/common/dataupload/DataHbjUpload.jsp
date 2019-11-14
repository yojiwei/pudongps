<%@ page language="java" import="java.util.ArrayList" pageEncoding="GBK"%>

<%@page import="com.util.XmlIntoTable"%>
<%@page import="java.util.StringTokenizer"%>
<%
//---------------------add by yanker 20060524  

	XmlIntoTable xml2table = null;
	//得到前一页面需要存入的数据
	String ctTitle = request.getParameter("CT_title");
	String ctContent = request.getParameter("CT_content");
	//String CT_content=CTools.unHtmlEncode(CTools.dealString(request.getParameter("CT_content")).trim());
	String ctCreateTime = request.getParameter("CT_create_time");
	String ctSource = request.getParameter("CT_source");
	String dt_id = request.getParameter("DT_id");
	String sj_id = request.getParameter("SJ_id");
	String at_content = request.getParameter("AT_content");
	String at_type = request.getParameter("at_type");
	// 初始化一个StringBuffer，用以放xml
	StringBuffer sf = new StringBuffer("");

	// 加入xml头
	sf.append("<?xml version=\"1.0\" encoding=\"GBK\"?>\n");
	sf.append("	<DEPTWEB>\n");
	
	// 加入内容节点的起始位
	sf.append("		<TB_CONTENT>\n");
	
	//加入标题
	if(!"".equals(ctTitle)){
		sf.append("			<CT_TITLE>");
		sf.append(ctTitle);
		sf.append("</CT_TITLE>\n");
	}else{
		sf.append("			<CT_TITLE/>\n");
	}
	
	//加入内容
	if(!"".equals(ctContent)){
		sf.append("			<CT_CONTENT>");
		sf.append(ctContent);
		sf.append("</CT_CONTENT>\n");
	}else{
		sf.append("			<CT_CONTENT/>\n");
	}
	
	//加入创建时间
	if(!"".equals(ctCreateTime)){
		sf.append("			<CT_CREATE_TIME>");
		sf.append(ctCreateTime);
		sf.append("</CT_CREATE_TIME>\n");
	}else{
		sf.append("			<CT_CREATE_TIME/>\n");
	}
	
	//加入来源
	if(!"".equals(ctSource)){
		sf.append("			<CT_SOURCE>");
		sf.append(ctSource);
		sf.append("</CT_SOURCE>\n");
	}else{
		sf.append("			<CT_SOURCE/>\n");
	}
	
	//加入所属部门
	if(!"".equals(dt_id)){
		sf.append("			<DT_ID>");
		sf.append(dt_id);
		sf.append("</DT_ID>\n");
	}else{
		sf.append("			<DT_ID/>\n");
	}
	
	//加入发布到的栏目
	if(!"".equals(sj_id)){
		sf.append("			<SJ_ID>");
		sf.append(sj_id);
		sf.append("</SJ_ID>\n");
	}else{
		sf.append("			<SJ_ID/>\n");
	}
	
	//加入附件
	if(!"".equals(at_content)){
		StringTokenizer tokenConent = new StringTokenizer(at_content,",");
		int lenConent = tokenConent.countTokens();
		String[] strConent = new String[lenConent];
		
		StringTokenizer tokenType = new StringTokenizer(at_type,",");
		int lenType = tokenType.countTokens();
		String[] strType = new String[lenType];
		
		sf.append("			<ATTACH>\n");
		for(int cnt = 0; cnt < lenConent; cnt++){
			strConent[cnt] = tokenConent.nextToken();
			strType[cnt] = tokenType.nextToken();
			
			sf.append("				<AT_CONTENT>\n");
			
			sf.append("					<CT_BASE>");
			sf.append(strConent[cnt]);
			sf.append("</CT_BASE>\n");
			
			sf.append("					<CT_TYPE>");
			sf.append(strType[cnt]);
			sf.append("</CT_TYPE>\n");
			
			sf.append("				</AT_CONTENT>\n");
		}
		sf.append("			</ATTACH>\n");
	}else{
		sf.append("		<ATTACH/>\n");
	}
	
	// 加入xml尾
	sf.append("		</TB_CONTENT>\n");
	sf.append("	</DEPTWEB>");

	String fileStr = sf.toString();
	System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" + fileStr);
	//将文件及附件信息插入数据库
	if(!"".equals(fileStr)){
		try {
			xml2table = new XmlIntoTable();					 
			boolean commitFlag = xml2table.doInsertTable2(fileStr);
			if(commitFlag){
			%>
				<script>
				//alert("信息报送成功！");
				window.close();
				</script>
			<%
			}else{
			%>
				<script>
				//alert("信息报送不成功！");
				window.close();
				</script>
			<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//-------------------------------
%>

