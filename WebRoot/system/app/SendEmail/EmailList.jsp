<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String str_sql="select * from TB_EMAILSAVE where em_needsend='1' order by em_id ";
Vector vectorPage = dImpl.splitPage(str_sql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
申请邮件订阅email地址
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
  
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
   <tr>
        <td width="100%" align="left" valign="top">
			<table class="content-table" height="" width="100%">
				<tr class="bttn">
					<td  class="outset-table">Email地址</td>
					<td  class="outset-table">已发送邮件</td>
					<td  class="outset-table">注册Ip</td>
					<td  class="outset-table">注册时间</td>
				    <td  class="outset-table">删除</td>
				</tr>

<%
	
if(vectorPage!=null)
{
try
  {
   
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  String em_value=content.get("em_value").toString();
	  String em_sendnumber=content.get("em_sendnumber").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
%>
					<td height=30><%=content.get("em_value")+""%></td>
					<td height=30 align="center" ><%=content.get("em_sendnumber")+""%></td>
					<td height=30><%=content.get("em_ip")+""%></td>
					<td height=30 align="center" ><%=content.get("em_datetime")+""%></td>
					<td height=30 align="center"><a href="delEmail.jsp?em_id=<%=content.get("em_id")+""%>" onclick="return confirm('确认要删除么?')">
						<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a></td>

				</tr>

<%
	}
%>
<%
  }
catch(Exception e)
{
   out.println(e);
}
}
else
{
  out.println("<tr><td colspan=6>无记录</td></tr>");
}

%>
			</table>
		 </td>
  </tr>
 <tr class=title1>
	 <td width="100%" align="right" colspan="2">
		 <p align="center">
	</td>
 </tr>
 </table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
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