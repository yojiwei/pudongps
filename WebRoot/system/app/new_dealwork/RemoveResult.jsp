<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../skin/import.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="com.app.*"%>
<%
String co_id="";
String wo_id="";
co_id = CTools.dealString(request.getParameter("co_id")).trim();
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sqlRemove="";
String de_id="";
sqlRemove = " select x.de_id from tb_documentexchange x,tb_correspond y where y.co_id='"+co_id+"' and y.co_id=x.de_primaryid ";

Hashtable contRemove = (Hashtable)dImpl.getDataInfo(sqlRemove);
if(contRemove!=null)
{
	de_id=contRemove.get("de_id").toString();
	//out.println(de_id);
}

dCn.beginTrans();

dImpl.delete("tb_correspond","co_id",co_id);

dImpl.delete("tb_documentexchange","de_id",de_id);

String sqlCount="";
sqlCount = " select count(co_id) countcoid from tb_correspond where wo_id='"+wo_id+"' and (co_status='1' or co_status='2')";
//out.println(sqlCount);out.close();
Hashtable contCount = (Hashtable)dImpl.getDataInfo(sqlCount);
if(contCount!=null)
{
	String itemCount = contCount.get("countcoid").toString();
	if(itemCount.equals("0"))
	{
		dImpl.edit("tb_work","wo_id",wo_id);
		dImpl.setValue("wo_status","1",CDataImpl.STRING);
		dImpl.update();
	}
}

if(dCn.getLastErrString().equals(""))
{
  dCn.commitTrans();
}
else
{
  dCn.rollbackTrans();
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


%>
<script language="javascript">
alert("该协调单已撤销!");
window.opener.location.href="CorringList.jsp";
window.close();
</script>
