<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String st_status = request.getParameter("st_status") == null ? "" : request.getParameter("st_status");
st_status = "".equals(st_status) ? "1" : st_status;
int intStatus = Integer.parseInt(st_status);
String strTitle = "";
String strhref = "";
String strAct = "";
String deal_dtid = "";
String deal_name = "";
String str_sql = "";

switch(intStatus)
{
case 1:
  strTitle = "待处理建议";
  strhref = "AppealInfo_1.jsp";
  strAct = "阅读";
  break;
case 2:
  strTitle = "处理中建议";
   strhref = "AppealInfo_1.jsp";
  strAct = "受理";
  break;
case 3:
  strTitle = "已处理建议";
  strhref = "AppealInfo_1.jsp";
  strAct = "查看";
  break;
default:
  strTitle = "";
}
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
	str_sql = "select st_id,st_name,st_title,st_applydate from tb_suggestmail where st_code = 'suggest' and st_restatus = " + st_status +" order by st_applydate desc ";
	Vector vectorPage = dImpl.splitPage(str_sql,request,20);
	
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回      
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">

                <tr class="bttn">
                        <td width="5%" class="outset-table" align="center">序号</td>
                        <td width="25%" class="outset-table">姓名</td>
                        <td width="45%" class="outset-table">主题</td>
                        <td width="20%" class="outset-table">发送时间</td>
                        <td width="5%" class="outset-table" nowrap><%=strAct%></td>
                </tr>
				<%
				if(vectorPage != null) {
				  	int kk = 0;
				    for(int j=0;j<vectorPage.size();j++) {
				      kk++;
				      Hashtable content = (Hashtable)vectorPage.get(j);
				      String st_id = content.get("st_id").toString();
				      	if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
				      	else out.print("<tr class=\"line-odd\">");
				  %>
          			  <td align="center">
                        <center><%=kk%></center>
                      </td>
			          <td width="25%" align="left"><%=content.get("st_name")%></td>
			          <td width="45%" align="left"><%=content.get("st_title")%></td>
			          <td width="20%" align="center"><%=content.get("st_applydate") %></td>
          			  <td width="5%" align="center">
          			    <a href="<%=strhref%>?st_id=<%=st_id%>&st_status=<%=st_status%>"><img class="hand" border="0" src="../../images/modi.gif" title="<%=strAct%>" WIDTH="16" HEIGHT="16"></a>
          			  </td>
				<%
				    }
				%>
   			</tr>

			<%
			}
			else
			{
			  out.println("<tr><td colspan=50>无记录</td></tr>");
			}
			%>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>