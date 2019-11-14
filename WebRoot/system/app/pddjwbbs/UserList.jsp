<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn);
//
String strTitle="";
String sql="";
String us_name="";
String us_uid = "";
String us_id = "";

strTitle = "普通用户管理列表";
sql = "select us_id,us_uid,us_name from forum_user order by us_id desc ";

vectorPage = dImpl.splitPage(sql,request,20);
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/new.gif" border="0" onclick="window.location='UserInfo.jsp?OPType=Add'" title="新增普通用户" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
新增普通用户
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<form name="formData">
    <tr class="bttn">
        <td width="8%" class="outset-table" align="center" nowrap>用户ID</td>
        <td width="5%" class="outset-table" align="center" nowrap>登录名</td>
        <td width="10%" class="outset-table" align="center" nowrap>用户名</td>
        <td width="20%" class="outset-table" align="center"  nowrap>用户发帖/跟帖数/总数</td>
        <td width="10%" class="outset-table" align="center" nowrap>操作</td>
    </tr>
<%
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      us_uid = CTools.dealNull(content.get("us_uid"));
      us_name = CTools.dealNull(content.get("us_name"));
      us_id = CTools.dealNull(content.get("us_id"));
      
		  String postcount = "";
		  String revertcount = "";
		  
		  String postSql = "select count(post_id) as postcount from forum_post_pd p,forum_user u where p.post_author_id = u.us_id and u.us_uid = '"+us_uid+"'";
		  Hashtable postcontent = dImpl.getDataInfo(postSql);
		  if(postcontent!=null){
		  	postcount = CTools.dealNumber(postcontent.get("postcount"));
		  }
		  String revertSql = "select count(revert_id) as revertcount from forum_revert p,forum_user u where p.revert_author_id = u.us_id and u.us_uid = '"+us_uid+"'";
		  //out.println(revertSql);
		  Hashtable revertcontent = dImpl.getDataInfo(revertSql);
		  if(revertcontent!=null){
		  	revertcount = CTools.dealNumber(revertcontent.get("revertcount"));
		  }
	    int all = Integer.parseInt(postcount)+Integer.parseInt(revertcount);
	    
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>
    <td align="center"><%=us_id%></td>
    <td align="center"><%=us_uid%></td>
    <td align="center"><%=us_name%></td>
		<td align="center"><%=postcount%>/<%=revertcount%>/<%=all%></td>
    <td align="center">
    <a href="UserInfo.jsp?OPType=Edit&us_id=<%=us_id%>">
		<img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a>&nbsp;
		<a href="UserDel.jsp?us_id=<%=us_id%>"><img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');"></a>
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