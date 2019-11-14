<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="java.text.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String dt_id = "";
String dt_name = "";//区长
Vector vPage = null;

Calendar cal = new GregorianCalendar();
cal.add(GregorianCalendar.DATE,-1);
SimpleDateFormat theDate = new SimpleDateFormat("yyyy-MM-dd");
String ul_time = theDate.format(cal.getTime());
%>
<table align="center" width="100%" class="main-table">
<form name="formData" method="post" action="DeptmailList.jsp">
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">委办局来信情况查询
		</td>
	</tr>
	<tr class="line-odd">
		<td width="40%" align="right">单位名称：</td>
		<td>
			<select name="conntype" class="f12">
			<option value="oo" selected>请选择</option>
                                      <%
                                      String Sql_dt = "select c.dt_id,c.dt_name from tb_deptinfo c,tb_subjectlinkdept d where c.dt_id=d.dt_id order by c.dt_sequence";
                                      vPage = dImpl.splitPage(Sql_dt,request,100);
                                      if (vPage!=null)
                                      {
                                       for(int i=0;i<vPage.size();i++)
                                      {
                                       Hashtable content = (Hashtable)vPage.get(i);
                                       dt_id = content.get("dt_id").toString();
                                       dt_name = content.get("dt_name").toString();
                                      %>
                                      <option value="<%=dt_id%>"><%=dt_name%></option>
                                      <%
                                       }
                                       }
                                      %>
             </select>
		</td>
	</tr>
	<tr class="line-odd">
		<td width="40%" align="right">查询时间：</td>
		<td>
			<input name="begin_time" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">&nbsp;至
			<input name="end_time" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
		</td>
	</tr>
	<tr class="title1" width="100%">
		<td colspan="2" class="outset-table">
			<input type="submit" class="bttn" value="搜索">&nbsp;
			<input type="reset" class="bttn" value="重写">&nbsp;
		</td>
	</tr>
<input type="hidden" name="OPType" value="search">
<input type="hidden" name="status1" value="">
</form>
</table>
<%
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
<%@include file="/system/app/skin/bottom.jsp"%>