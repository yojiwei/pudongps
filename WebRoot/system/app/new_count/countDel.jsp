<%@ page language="java" pageEncoding="GBK"%> 
<%@include file="/website/include/import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<body>
<%
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
%>

<%
	String co_name=CTools.dealString(request.getParameter("co_name"));
	String sql="delete  from tb_count where co_name='"+co_name+"'";
	Vector vectorPage = dImpl.splitPage(sql,request,1);
%>




<%
	}catch(Exception ex)
	{
		out.print("<br>"+ex);
	}
	finally
	{
		if(dImpl!=null)
		{
			dImpl.closeStmt();
		}
		if(dCn!=null)
		{
			dCn.closeCn();
		}
		
	}
	response.sendRedirect("countList.jsp");
%>
</body>