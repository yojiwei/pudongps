<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String pr_id="";
String pr_name="";
String pa_ask="";
String pa_answer="";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
pr_name = CTools.dealString(request.getParameter("pr_name")).trim();

String pr_Sql = "select pr_name from tb_proceeding_new where pr_id = '"+pr_id+"'";
Hashtable contentPr = dImpl.getDataInfo(pr_Sql);
if(contentPr!=null)
{
	pr_name =contentPr.get("pr_name").toString();
}


//update by dongliang 20090106
String curpage= CTools.dealString(request.getParameter("curpage"));
//
String sql_list = " select x.pa_id,x.pa_ask,z.pr_name,x.pa_answer from tb_proceeding_ask x,tb_proceeding_new z where x.pr_id=z.pr_id and z.pr_id='"+pr_id+"' ";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
项目名称：<%=pr_name%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onClick="window.location='AnswerInfo.jsp?OPType=Add&pr_id=<%=pr_id%>'" title="新增问答" style="cursor:hand" align="middle" WIDTH="16" HEIGHT="16">
新增问答
<img src="/system/images/goback.gif" border="0" onClick="javascript:window.location.href='ProceedingList.jsp?OType=manage&strPage=<%=curpage%>';" title="返回" style="cursor:hand" align="middle">
返回

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
        <form name="formData">
        </tr>
        <tr class="bttn">
        <td width="45%" class="outset-table" align="center">问题</td>
			  <td width="50%" class="outset-table" align="center">答案</td>
			  <td width="5%" class="outset-table" align="center">操作</td>
        </tr>
		<%
		Vector vectorList = dImpl.splitPage(sql_list,request,20);
		Hashtable content = null;
		if(vectorList!=null)
		{
			for(int i=0;i<vectorList.size();i++)
			{
				content = (Hashtable)vectorList.get(i);
			    if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
	<td align=""><%=content.get("pa_ask")%></td>
	<td align=""><%=content.get("pa_answer")%></td>
	<td align="center">
	<a href="AnswerInfo.jsp?OPType=Edit&pa_id=<%=content.get("pa_id")%>&pr_id=<%=pr_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑该问答" WIDTH="16" HEIGHT="16"></a>&nbsp;
	<a href="AnswerDel.jsp?OPType=Del&pa_id=<%=content.get("pa_id")%>&pr_id=<%=pr_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除该问答" WIDTH="16" HEIGHT="16" onClick="return window.confirm('确认要删除该记录么?');"></a>
	</td>
</tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
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