<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript">
function query(list_id,node_title)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.submit();
}
function setSequence(list_id)
{
	var form = document.formData ;
	form.list_id.value = list_id ;
	form.action = "setSequence.jsp" ;
	form.submit();
}
</script>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String seName = "";
String sImg = "";
String sUrl = "";
String sEditUrl = "";
String sequence = "";

String list_id = CTools.dealString(request.getParameter("list_id")).trim();
if(list_id.equals("")) list_id = "o0";
String sqlStr = "select fs_id as id,fs_name as name,1 as flag,fs_sequence as sequence from tb_frontsubject where fs_parentid='"+list_id+"' and fs_name <> '静态页面' union select fi_id as id ,fi_title as name,2 as flag,fi_sequence as sequence from tb_frontinfo where fs_id='"+list_id+"' order by flag,sequence,id desc";
//out.println(sqlStr);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

%>
<table class="main-table" width="100%">
<form name="formData" method="post" action="frontSubjectList.jsp">
 <tr>
   <td width="100%" colspan="9">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="3" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center" align="left"></td>
                                                <td valign="center" align="right" nowrap>
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
														<img src="/system/images/dialog/ftp4.gif" border="0" onclick="window.location='frontSubjectInfo.jsp?list_id=<%=list_id%>'" title="增加栏目" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/new.gif" border="0" onclick="window.location='frontInfo.jsp?list_id=<%=list_id%>'" title="增加信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
														<img src="/system/images/dialog/split.gif" align="middle" border="0">
														<img src="/system/images/dialog/sort.gif" border="0" onclick="setSequence('<%=list_id%>')" title="修改排序" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
       </table>
    </td>
  </tr>
  <tr class="bttn" width="100%">
    <td align="center" width="10%">序号</td>
    <td align="center" width="10%">类型</td>
	<td align="center" width="60%">名称</td>
    <td align="center" width="10%">编辑</td>
	<td align="center" width="10%">排序</td>
  </tr>
<%
Vector vPage = dImpl.splitPage(sqlStr,request,20);
if (vPage != null)
{
  for(int j=0;j<vPage.size();j++)
  {
   Hashtable content = (Hashtable)vPage.get(j);
   if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
   else out.print("<tr class=\"line-odd\">");
   sequence = content.get("sequence").toString();
   if (content.get("flag").toString().equals("1")) { //栏目
		seName   = "subject" + content.get("id").toString() ;
        sImg     = "<img border=0 src='/system/images/dialog/Hidedir.gif'>";
        sUrl     = "javascript:query('" + content.get("id").toString() + "','" + content.get("name").toString() + "')";
        sEditUrl = "<a href='" + "frontSubjectInfo.jsp?fs_id=" + content.get("id").toString() + "&list_id="+list_id + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      }else{
        seName   = "info" + content.get("id").toString() ;
        sImg     = "<img border=0 src='/system/images/dialog/document.gif'>";
        sUrl="frontInfo.jsp?fi_id=" + content.get("id").toString() + "&list_id="+list_id;
        sEditUrl="<a href='" + sUrl + "'><img src='/system/images/dialog/icon3.gif' border='0' height=16 width=16 title='修改'></a>";
      }
 %>
  <td align="center"><%=j+1%></td>
  <td align="center"><%=sImg%></td>
  <td align="left"><a href="<%=sUrl%>"><%=content.get("name").toString()%></a></td>
  <td align="center"><%=sEditUrl%></td>
  <td align="center"><input class="text-line" name="<%=seName%>" size="5" value="<%=sequence%>"></td>
 </tr>
<%
  }
%>
<input type="hidden" name="list_id" value="<%=list_id%>">
</form>
<%
/*分页的页脚模块*/
out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
else
{
out.println("<tr><td colspan=7 align='right'>没有记录！</td></tr>"); //输出尾部文件
}
%>
</table>
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