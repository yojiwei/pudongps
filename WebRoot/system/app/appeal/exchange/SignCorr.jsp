<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../../skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
String de_id="";
String de_status="";
String co_id="";
String pr_id="";
String cw_id="";
String de_senddeptid="";
String selfdtid="";
String de_signerid="";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

CMySelf self = (CMySelf)session.getAttribute("mySelf");
//out.println(self.getDtId());
selfdtid = String.valueOf(self.getDtId());
de_signerid = String.valueOf(self.getMyID());


de_id = CTools.dealString(request.getParameter("de_id")).trim();
de_status = CTools.dealString(request.getParameter("de_status")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
de_senddeptid = CTools.dealString(request.getParameter("de_senddeptid")).trim();
dCn.beginTrans();

                dImpl.edit("tb_documentexchange","de_id",de_id);
		if(de_status.equals("1"))
		{
			dImpl.setValue("de_status","2",CDataImpl.STRING);
			dImpl.setValue("de_signtime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
			dImpl.setValue("de_signerid",de_signerid,CDataImpl.INT);
			dImpl.update();

 			dImpl.edit("tb_correspond","co_id",co_id);
			dImpl.setValue("co_status","1",CDataImpl.STRING);
			dImpl.update();
     		response.sendRedirect("CorrInfo.jsp?cw_id=" + cw_id + "&CorrType=sign");

		}
                if(de_status.equals("4"))
                {
                        dImpl.setValue("de_status","5",CDataImpl.STRING);
                        dImpl.setValue("de_feedbacksigntime",(new java.util.Date()).toLocaleString(),CDataImpl.DATE);
                        dImpl.update();

                        dImpl.edit("tb_connwork","cw_id",cw_id);
                        dImpl.setValue("cw_status","1",CDataImpl.STRING);
                        dImpl.update();
                        response.sendRedirect("CorrInfo.jsp?cw_id=" + cw_id + "&CorrType=see");
		}


dCn.commitTrans();

dImpl.closeStmt();
dCn.closeCn();
//out.println(co_id);
%>

<%@include file="../../skin/bottom.jsp"%>

<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
