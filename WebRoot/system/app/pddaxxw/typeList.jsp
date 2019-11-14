<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String ty_id="";
String ty_name="";
String ty_ispublic="";
String ty_imgpath = "";
String ty_imgrealname = "";
String path = "";
String imgpath = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

path = dImpl.getInitParameter("workattach_http_path");//档案局征集图片放置路径

String sql_list = " select ty_id,ty_name,ty_imgpath,ty_imgrealname,ty_ispublic from tb_daxxtype order by ty_id desc ";

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
档案类别列表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onClick="window.location='typeInfo.jsp?OPType=Add'" title="新增类别" style="cursor:hand" align="middle" WIDTH="16" HEIGHT="16">
新增类别
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<form name="formData">
	</tr>
	<tr class="bttn">
	<td width="35%" class="outset-table" align="center">类别名称</td>
	<td width="35%" class="outset-table" align="center">类别图片</td>
	<td width="20%" class="outset-table" align="center">是否前台显示</td>
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
			ty_id = CTools.dealNull(content.get("ty_id"));
			ty_name = CTools.dealNull(content.get("ty_name"));
			ty_imgpath = CTools.dealNull(content.get("ty_imgpath"));
			ty_imgrealname = CTools.dealNull(content.get("ty_imgrealname"));
			
			imgpath = path+ty_imgpath+"/"+ty_imgrealname;
			
			ty_ispublic = CTools.dealNull(content.get("ty_ispublic"));
			
			if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
			else out.print("<tr class=\"line-odd\">");
	%>
	<td align="center"><%=ty_name%></td>
	<td align="center"><img src="<%=imgpath%>" width="60" height="50" border="0"></td>
	<td align="center"><%="0".equals(ty_ispublic)?"显示":"不显示"%></td>
<td align="center">
<a href="typeInfo.jsp?OPType=Edit&ty_id=<%=ty_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑该类别" WIDTH="16" HEIGHT="16"></a>&nbsp;
<a href="typeDel.jsp?OPType=Del&ty_id=<%=ty_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除该类别" WIDTH="16" HEIGHT="16" onClick="return window.confirm('确认要删除该记录么?');"></a>
</td>
</tr>

<%
    }
  }
  else
  {
    out.println("<tr><td colspan=20>没有记录！</td></tr>");
  }
%>
</form>
</table>
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + e.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>