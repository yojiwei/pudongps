<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");

String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());
String str_sql = "";
String sm_id = "";
String sm_con = "";
String sm_sendtime = "";
String sm_flag = "";
String sm_check = "";
String strTitle = "短信列表";
String ct_id = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable content = null;
Vector vectorPage = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
ct_id = CTools.dealString(request.getParameter("ct_id"));

if("".equals(ct_id)){
	out.println("<script>history.back();</script>");
}
//
str_sql="select sm_id,sm_con,sm_flag,sm_check,sm_sendtime from tb_sms where sm_tel is null and sm_ct_id = "+ct_id+" order by sm_sendtime desc";
vectorPage = dImpl.splitPage(str_sql,request,20);

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='sendDxpd.jsp?ctId=<%=ct_id%>'" title="新建" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建
<img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
返回
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                 
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">                                            
      <td width="40%" class="outset-table">短信内容</td>
      <td width="9%" class="outset-table">发送时间</td>					
	  <td width="9%" class="outset-table" nowrap>审核状态</td>
	  <td width="9%" class="outset-table" nowrap>发送状态</td>	
</tr>
 <%
if(vectorPage!=null)
{
    for(int j=0;j<vectorPage.size();j++)
    {
       content = (Hashtable)vectorPage.get(j);
       sm_id = CTools.dealNull(content.get("sm_id"));
	   sm_con = CTools.dealNull(content.get("sm_con"));
	   sm_sendtime = CTools.getDate(CTools.dealString(content.get("sm_sendtime").toString()));
       sm_flag = CTools.dealNull(content.get("sm_flag"));//发送状态
	   sm_check = CTools.dealNull(content.get("sm_check"));
	   
       
	  if(j % 2 == 0)out.print("<tr class=\"line-even\">");
	  else out.print("<tr class=\"line-odd\">");
  %>       
          <td align="center"><%=sm_con%></td>
          <td align="center"><%=sm_sendtime%></td>
          <td width="16%" align="center">
		  <%
		  switch(Integer.parseInt(sm_check))
		  {
			 case 1: out.print("待审核");break;
			 case 2: out.print("审核通过");break;
			 case 3: out.print("没有通过");break;
			 
		  }
		  %>
		  </td>
      	  <td width="5%" align="center">
		  <%
		  switch(Integer.parseInt(sm_flag))
		  {
			 case 0: out.print("发送失败");break;
			 case 1: out.print("发送成功");break;
			 case 2: out.print("等待发送");break;
			 case 3: out.print("正在发送中");break;
			 
		  }
		  %>
		  </td>
  	 </tr>
<%/*分页的页脚模块*/
}
}
else
{
  out.println("<script>location.href='sendDxpd.jsp?ctId="+ct_id+"';</script>");
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