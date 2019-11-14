<%@page contentType="text/html; charset=GBK"%>
<%@include file="../../skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String sqlStr = "select c.cp_id,c.cp_name,c.dt_name from tb_connproc c,tb_deptinfo d where c.dt_id=d.dt_id and c.cp_upid='o9' or c.cp_id='o9' and d.dt_id=" + selfdtid + "order by c.cp_name";
String cp_id = "";
String cp_name = "";
String dt_name = "法院";
String strTitle = "法院事项列表";
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
%>
<table class="main-table" width="100%">
<form name="formData">
 <tr>
   <td width="100%" colspan="9">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="4" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center" align="left"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>
                                                        <img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="../../../images/new.gif" border="0" onclick="window.location='ProceedingInfo.jsp?cp_id=<%=cp_id%>&dt_name=<%=dt_name%>'" title="新信访处理" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                                                        <img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="../../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="../../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
       </table>
    </td>
  </tr>
  <tr class="bttn" width="100%">
    <td align="center" width="10%">法院事项ID</td>
    <td align="center" width="40%">法院事项名称</td>
    <td align="center" width="30%">法院单位</td>
    <td align="center" width="10%">编辑</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   cp_id = content.get("cp_id").toString();
   cp_name = content.get("cp_name").toString();
   dt_name = content.get("dt_name").toString();
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
 %>
  <td align="center"><%=cp_id%></td>
  <td align="center"><%=cp_name%></td>
  <td align="center"><%=dt_name%></td>
  <td align="center"><a href="ProceedingInfo.jsp?cp_id=<%=cp_id%>&dt_name=<%=dt_name%>"><img class="hand" border="0" src="../../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
 </tr>
<%
  }
%>
</form>
<%
/*分页的页脚模块*/
out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
%>
</table>
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
<%@include file="../../skin/bottom.jsp"%>