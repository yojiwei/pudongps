<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String type = CTools.dealString(request.getParameter("type"));						 	//添加 add，修改 edit
	String tt_id = CTools.dealString(request.getParameter("tt_id"));
	String thisUrl = "deptCountList.jsp";
	String alert = "信息删除成功！";
	String sqlStr = "";
	if (!"".equals(tt_id))
		sqlStr = "update tb_totdept set tt_flag = 1 where tt_id = " + tt_id;
	CDataCn dCn = null;
  	CDataImpl dImpl = null;
  	
	try {
   		dCn = new CDataCn();
	 	dImpl = new CDataImpl(dCn);
  		dImpl.executeUpdate(sqlStr);
	}
	catch(Exception ex) {
		out.print(ex.toString());
	}
	finally {     
		dImpl.closeStmt();
		dCn.closeCn();
		//反馈信息
		
		out.print("<script language='javascript'>");
		out.print("alert('" + alert + "');");
		out.print("window.location='"+thisUrl+"';");
		out.print("</script>");	 
		
  }//finally  
%>
