<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../head.jsp" %>

<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function query(list_id,node_title)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.node_title.value = node_title ;
        //alert(form.list_id.value);
	form.submit();
}
function setSequence(list_id,node_title)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.node_title.value = node_title ;
	form.action = "setSequence.jsp" ;
	form.submit();
}
function reList(list_id,node_title)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.node_title.value = node_title ;
	if (form.flag.checked) {
		form.flag.value = 0 ;
		form.flag.checked = true ;
	}
		form.submit();
}
document.onkeypress = checkKey;
function checkKey()
{
	if (!(event.keyCode > 47 && event.keyCode < 58))
	{
		alert("请您输入0-9的数值!");
		return false;
	}


}
//-->
</script>
<%
  String sql = "";
  String displayMsg = "";
	String flag="";
  String checkflag = "";
	String mflag="";
  String node_title;
  String list_id ;
  String sEditUrl = "";
  String sUrl = "";
  String sImg = "";
  String se = "";
  String seName = "";
  CTools tools = null;
%>
<%
 tools = new CTools();
 list_id    = CTools.dealString(request.getParameter("list_id"));
 if(list_id.equals("")) list_id = "1";
 node_title = tools.iso2gb(request.getParameter("node_title"));
 flag=request.getParameter("flag");
 if(flag!=null)
 {
	 if(flag.equals("0"))
	 {
		 checkflag="checked";
		 mflag=" and ui_active_flag=0";
	 }
 }
	//out.print(checkflag+"**");
 if (list_id==null) list_id = "0";
 if (list_id.equals("")) list_id = "0";

// out.print(list_id);
// out.print(node_title);

    CDataCn  dCn = null;
    CDeptXML tree = new CDeptXML();
    CRoleAccess ado=null;
    try{
    	dCn = new CDataCn();
    	ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());
    String filterSql="";

    if(!ado.isAdmin(user_id))
      filterSql=ado.getAccessSqlByUser(user_id,ado.OrganAccess);


 //CManager manage = (CManager)session.getAttribute("mySelf");
 String orgname = "";//manage.getAtOrgname();//用户模块

 CUserInfo jdo = new CUserInfo(dCn);

 sql = " select dt_id as id,dt_name as name,1 as flag,dt_sequence as sequence from tb_deptinfo where dt_parent_id = " + list_id + " "+filterSql
 	   + " "+sql+" union select ui_id as id, ui_name as name,"
       + " 2 as flag,ui_sequence as sequence from tb_userinfo where dt_id = " + list_id +mflag+
      " order by flag,sequence";
//out.print(sql);

  jdo.setSql(sql);
%>


<div align="center">
	<table border="0" class="main-table" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
					<form name="formData" method="post" action="userList.jsp">
					   <td width="50%" align="left">
						<table width="100%">
						 <tr class="title1">
							<td id="TitleTd" width="100%" align="left"><%=displayMsg%></td>
							<td valign="top" align="right" nowrap>
							<input class="checkbox1" type="checkbox" <%=checkflag%> name="flag" value="1"  onclick="reList(<%=list_id%>,'<%=node_title%>')">不显示停用帐号
        <img src="/system/images/dialog/split.gif" align="middle" border="0">
        <img src="/system/images/dialog/ftp4.gif" border="0" onclick="window.location='deptInfo.jsp?list_id=<%=list_id %>&dd_id='" title="新增部门" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
        <img src="/system/images/dialog/split.gif" align="middle" border="0">
        <img src="/system/images/dialog/new.gif" border="0" onclick="window.location='userInfo.jsp?list_id=<%=list_id %>&amp;node_title=<%=node_title%>'" title="新增数据" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
        <img src="/system/images/dialog/split.gif" align="middle" border="0">
        <img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence(<%=list_id%>,'<%=node_title%>')" title="修改排序" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
        <img src="/system/images/dialog/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
        <img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
        <img src="/system/images/dialog/split.gif" align="middle" border="0">

							</td>
						  </tr>
						</table>
					  </td>
					</tr>
				</table>
		   </td>
		</tr>

        <tr>
          <td width="100%" valign="top">
              <table border="0" width="100%" cellspacing="0" cellpadding="0" height="46">
                <tr>
                  <td width="100%" height="32">

					  <table border="0" width="100%" cellpadding="3" height="44">
						<tr class="bttn">
						    <td width="5%" height="1" nowrap class="outset-table">序号</td>
						    <td width="8%" height="1" nowrap class="outset-table">类型</td>
						    <td width="66%" height="1" nowrap class="outset-table">名称</td>
						    <td width="10%" height="1" nowrap class="outset-table">修改</td>
						    <td width="10%" height="1" nowrap class="outset-table">排序</td>

<input type="hidden" name="list_id" value=<%=list_id%>>
<input type="hidden" name="node_title" value=<%=node_title%>>
                                                </tr>
<%
  Vector vectorPage = jdo.splitPage(request);
  if (vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");

      se = content.get("sequence").toString() ;
      if (se==null) se = "";

      if (content.get("flag").toString().equals("1")) { //部门
        seName   = "dept" + content.get("id").toString() ;
        sImg     = "<img border=0 src='/system/images/dialog/Hidedir.gif'>";
        sUrl     = "javascript:query(" + content.get("id").toString() + ",'" + content.get("name").toString() + "')";
        sEditUrl = "<a href='" + "deptInfo.jsp?dd_id=" + content.get("id").toString() + "&list_id="+list_id + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      }else{
        seName   = "user" + content.get("id").toString() ;
        sImg     = "<img border=0 src='/system/images/dialog/document.gif'>";
        sUrl="userInfo.jsp?ui_id=" + content.get("id").toString() + "&list_id="+list_id;
        sEditUrl="<a href='" + sUrl + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      }

      out.println("<td align=center>" + (j+1) + "</td>");
      out.println("<td align=center>" + sImg + "</td>");
      out.println("<td><a href="+sUrl+">" + content.get("name").toString() + "</a></td>");
      out.println("<td align=center>" + sEditUrl + "</td>");
      out.println("<td align=center><input type=text class=text-line name=" + seName + " value='" + se + "' size=4></td>");
      out.println("</tr>");
    }
  }else{
      out.print("<tr><td colspan=5 align=center class=line-odd>没有记录</td></tr>");
  }
%>
</form>
<%
out.println(jdo.getTail(request));
%>
				  </table>

		      </td>
			 </tr>
		   </table>
	     </td>
	    </tr>

	</table>
</div>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(ado != null)
	ado.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>



