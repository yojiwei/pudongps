<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="网上投票管理";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String str_sql="select * from tb_vote where vt_qnid is null or vt_qnid='' order by vt_sequence";
Vector vectorPage = dImpl.splitPage(str_sql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="../../images/new.gif" border="0" onclick="window.location='voteInfo.jsp'" title="新建网上调查" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新建网上调查
<img src="../../images/dialog/sort.gif" border="0" onclick="setSequence()" title="修改排序" style="cursor:hand" align="absmiddle" WIDTH="15" HEIGHT="15">
修改排序
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
	<td  class="outset-table">投票主题</td>
	<td  class="outset-table">总票数</td>
	<td  class="outset-table">是否发布</td>
    <td  class="outset-table">删除</td>
    <td  class="outset-table">编辑</td>
	<td  class="outset-table">排序</td>
</tr>
<form name="formData" method="post"  >
<%
if(vectorPage!=null)
{
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  String strvtId=content.get("vt_id").toString();
	  String se=content.get("vt_sequence").toString();
	  String vt_pubflag=content.get("vt_pubflag").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
%>
			<td height=30><a href="voteDetail.jsp?strId=<%=strvtId%>" target="_blank"><%=content.get("vt_content")%></a></td>
			<td height=30><%=content.get("vt_count")%></td>
			<td height=30 align="center"><%=vt_pubflag.equals("1")?"是":"否"%></td>
			<td height=30><a href='voteDel.jsp?strId=<%=strvtId%>' onclick="return confirm('确认要删除么?')">
				<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16"></a></td>
			<td height=30><a href='votelistInfo.jsp?strId=<%=strvtId%>&actiontype=modify&vt_pubflag=<%=vt_pubflag%>' >
				<img class="hand" border="0" src="../../images/modi.gif" title="修改" WIDTH="16" HEIGHT="16"></a></td>
			<td align=center><input type=text class=text-line name=<%="module"+content.get("vt_id").toString()%> value="<%=se%>" size=4 maxlength=4></td>

		</tr>

<%
	}
%>
</form>
<%
/*分页的页脚模块*/
}
else
{
  out.println("<tr><td colspan=20>无记录</td></tr>");
}

%>
 </table>
 <SCRIPT LANGUAGE=javascript>
<!--
function gourl()
{
	formData.action="voteResult.jsp";
	formData.submit();
}
function setSequence()
{
	var form = document.formData ;
	form.action = "setSequence.jsp";
	form.submit();
}
//-->
</SCRIPT>
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