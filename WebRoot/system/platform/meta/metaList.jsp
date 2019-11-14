<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.platform.meta.*" %>
<%@ page import="com.util.CTools" %>

<link href="../style.css" rel="stylesheet" type="text/css">

<script LANGUAGE="javascript">
<!--
function query(list_id,node_title)
{
	formData.list_id.value= list_id ;
	//alert(document.formData.list_id.value);
	formData.node_title.value= node_title ;
	formData.submit();
}
function edit(dd_id)
{
  formData.dd_id.value = dd_id;
  formData.action = "metaDirInfo.jsp";
  formData.submit();
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
	if (!form.flag.checked) {
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
  String title = "";
  String flag = "";
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
 list_id    = request.getParameter("list_id");
 node_title = tools.iso2gb(request.getParameter("node_title"));

 if (list_id==null) list_id = "0";
 if (list_id.equals("")) list_id = "0";

 title = "数据字典";
// out.print(list_id);
// out.print(node_title);


 CDataCn dCn = null;
 CMetaDirInfo jdo = null;
 try{
 	dCn = new CDataCn();
    jdo = new CMetaDirInfo(dCn);
 sql =    "select dd_id as id,dd_name as name,1 as flag,dd_code as code,dd_sequence as sequence from tb_datatdictionary where dd_parentid = " + list_id +
      " union select dv_id as id, dv_value as name,2 as flag,'' as code,dv_sequence as sequence from tb_datavalue where dd_id = " + list_id +
      " order by flag,sequence";
 //out.print(sql);
  jdo.setSql(sql);
%>


<table class="main-table" width="100%">
<tr>
 <td width="100%">
   <div align="center">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr class="bttn">
					   <td width="100%">
					   <table width="100%">
						 <tr>
							<td id="TitleTd" width="100%" align="left"><%=title%></td>
							<td valign="top" align="right" nowrap>
							<img src="/system/images/dialog/split.gif" align="middle" border="0">
								<img src="/system/images/dialog/ftp4.gif" border="0" onclick="window.location='metaDirInfo.jsp?list_id=<%=list_id %>&amp;node_title=<%=node_title%>'" title="新增目录" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
								<img src="/system/images/dialog/new.gif" border="0" onclick="window.location='metaFileInfo.jsp?list_id=<%=list_id %>&amp;node_title=<%=node_title%>'" title="新增数据" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
								<img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence(<%=list_id%>,'<%=node_title%>')" title="修改排序" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
								<img src="/system/images/dialog/split.gif" align="middle" border="0">
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

			<!--内容-->
              <table border="0" width="100%" cellpadding="3" height="44">
                <tr class="bttn">
				    <td width="10%" height="1" class="outset-table">序号</td>
				    <td width="10%" height="1" class="outset-table">类型</td>
				    <td width="48%" height="1" class="outset-table">名称</td>
				    <!--<td width="28%" height="1" class="outset-table">目录</td>-->
				    <td width="12%" height="1" class="outset-table">代码</td>
				    <td width="10%" height="1" class="outset-table">修改</td>
				    <td width="10%" height="1" class="outset-table">排序</td>
				</tr>
<form name="formData" method="post" action="metaList.jsp">
<input type="hidden" name="list_id" value="<%=list_id%>">
<input type="hidden" name="node_title" value="<%=node_title%>">
<input type="hidden" name="dd_id" value="">
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
        seName   = "metaDir" + content.get("id").toString() ;
        sImg     = "<img border=0 src='/system/images/dialog/Hidedir.gif'>";
        sUrl     = "javascript:query(" + content.get("id").toString() + ",'" + content.get("name").toString() + "')";
        sEditUrl = "<a href='javascript:edit("+content.get("id").toString() + ")'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      }else{
        seName   = "metaFile" + content.get("id").toString() ;
        sImg     = "<img border=0 src='/system/images/dialog/document.gif'>";
        sUrl="metaFileInfo.jsp?dv_id=" + content.get("id").toString() + "&list_id="+list_id;
        sEditUrl="<a href='metaFileInfo.jsp?dv_id=" + content.get("id").toString() + "&list_id="+list_id + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      }

      out.println("<td>" + (j+1) + "</td>");
      out.println("<td>" + sImg + "</td>");
      out.println("<td><a href="+sUrl+">" + content.get("name") + "</a></td>");
      out.println("<td>" + content.get("code") + "</td>");
      out.println("<td align=center>"+sEditUrl+"</td>");
      out.println("<td align=center><input type=text class=text-line name='" + seName + "' value='" + se + "' size=4></td>");
      out.println("</tr>");
    }
  }else{
      out.print("<td>没有记录！</td>");
  }

%>
</form>
<tr><td colspan=10>
<%    out.println(jdo.getTail(request));%>
</td></tr>
				  </table>



				<!--内容-->
		      </td>
			 </tr>

		   </table>
		  </div>
	     </td>
	    </tr>
</table>

<%
 dCn.closeCn() ;
 } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
