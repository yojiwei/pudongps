<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@include file="/website/include/import.jsp"%>
<%
//获取页面提交过来的数据
String HandleTime = CTools.dealString(request.getParameter("HandleTime")).trim();
String HandleTime2 = CTools.dealString(request.getParameter("HandleTime2")).trim();
String HD_flag = CTools.dealString(request.getParameter("holiday")).trim();
String HD_remark = CTools.dealString(request.getParameter("remark")).trim();

//数据格式转换
DateFormat df = DateFormat.getDateInstance();
Calendar beginDate = Calendar.getInstance();
Calendar endDate = Calendar.getInstance();
beginDate.setTime(df.parse(HandleTime));
endDate.setTime(df.parse(HandleTime2));
%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
for(;(beginDate.getTime()).compareTo(endDate.getTime())<=0;beginDate.add(Calendar.DATE,1))
{
    CFormatDate cFDate = new CFormatDate(beginDate.getTime().toLocaleString());
    String strSql = "select * from TB_HOLIDAY where HD_DATE = to_date('"+cFDate.getFullDate()+"','YYYY-MM-DD')";
    Hashtable content = dImpl.getDataInfo(strSql);
    if(content!=null)
    {
		dImpl.edit("TB_HOLIDAY","HD_ID",content.get("hd_id").toString());
		dImpl.setValue("HD_FLAG",HD_flag,CDataImpl.INT);
		dImpl.setValue("HD_REMARK",HD_remark,CDataImpl.STRING);
		dImpl.update();
    }
    else
    {
		dImpl.addNew("TB_HOLIDAY","HD_ID",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		dImpl.setValue("HD_DATE",cFDate.getFullDate(),CDataImpl.DATE);
		dImpl.setValue("HD_FLAG",HD_flag,CDataImpl.INT);
		dImpl.setValue("HD_REMARK",HD_remark,CDataImpl.STRING);
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
response.sendRedirect("SetCalendar.jsp");
%>
