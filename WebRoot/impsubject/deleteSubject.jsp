<%@ page language="java" pageEncoding="GBK"%> 
<%@include file="/website/include/import.jsp"%>
<%
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
	String sj_parent_id1 = request.getParameter("sj_id1");
	String sj_parent_id2 = request.getParameter("sj_id2");
	dImpl.executeUpdate("delete from tb_subject where sj_id in(select sj_id from tb_subject  connect by prior sj_id = sj_parentid start with sj_id ='"+sj_parent_id1+"')");
	dImpl.update();
		dImpl.executeUpdate("delete from tb_subject where sj_id in(select sj_id from tb_subject  connect by prior sj_id = sj_parentid start with sj_id ='"+sj_parent_id2+"')");
	dImpl.update();
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
%>