<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String tt_id = CTools.dealString(request.getParameter("tt_id"));
	String tt_type = CTools.dealString(request.getParameter("tt_type"));
	String display = CTools.dealString(request.getParameter("display"));
	String deptids = CTools.dealString(request.getParameter("deptids"));
	
	String thisUrl = "deptCountSel.jsp?tt_id=" + tt_id + "&tt_type=" + tt_type + "&display=" + display;
	String alert = "信息修改完成！";
		
	CDataCn dCn = null;
  	CDataImpl dImpl = null;
  
  	try {
   		dCn = new CDataCn();
	 	dImpl = new CDataImpl(dCn);
  
        dImpl.setTableName("tb_totdept");
        dImpl.setPrimaryFieldName("tt_id");
    	dImpl.edit(tt_id);
        
		dImpl.setValue("tt_dtids",deptids,CDataImpl.STRING);//统计部门id
		
		dImpl.update();
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
