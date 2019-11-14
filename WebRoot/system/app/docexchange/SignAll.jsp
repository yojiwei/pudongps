<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


CMySelf self = (CMySelf)session.getAttribute("mySelf");
String dt_id="";
dt_id = String.valueOf(self.getDtId());
String my_id = String.valueOf(self.getMyID());

String sqlCorr="";
String de_id="";
String de_status="";
sqlCorr = " select de_id,de_status from tb_documentexchange where de_receiverdeptid="+dt_id+" and (de_status='4' or de_status='1') and de_type='1'";
out.println(sqlCorr);
Vector vectorCorr = dImpl.splitPage(sqlCorr,request,20);

if(vectorCorr!=null)
{
	for(int i=0;i<vectorCorr.size();i++)
	{
		Hashtable contCorr = (Hashtable)vectorCorr.get(i);
		de_id = contCorr.get("de_id").toString();
		//out.println(de_id);
		de_status = contCorr.get("de_status").toString();
		dImpl.edit("tb_documentexchange","de_id",de_id);
		//out.println(i);
		if(de_status.equals("1"))
		{
			dImpl.setValue("de_status","2",CDataImpl.STRING);
			dImpl.setValue("de_signtime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
			dImpl.setValue("de_signerid",my_id,CDataImpl.INT);
		}
		else if(de_status.equals("4"))
		{   out.println(de_status);
			dImpl.setValue("de_status","5",CDataImpl.STRING);
			dImpl.setValue("de_feedbacksigntime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
			dImpl.setValue("de_fbsignerid",my_id,CDataImpl.INT);
		}
	dImpl.update();

	}
}


dImpl.closeStmt();
dCn.closeCn();
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
response.sendRedirect("DocList.jsp");
%>

<%@include file="../skin/bottom.jsp"%>

