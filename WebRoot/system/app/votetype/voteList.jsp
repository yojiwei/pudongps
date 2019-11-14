<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@ page import="com.website.DataOper" %>
<%@ page buffer="none"%>
<script LANGUAGE="javascript">
<!--
function query(list_id,node_title)
{
	formData.list_id.value= list_id ;
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
	form.action = "voteList.jsp?refresh=true" ;
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

String refresh =  "";
if(request.getParameter("refresh")!= null )
refresh = request.getParameter("refresh");
  if(refresh.equals("true"))
	  response.sendRedirect("metaList.jsp?list_id="+request.getParameter("list_id"));
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
  
//added by zhuhp 2006-07-11
  boolean  isNewSequence = false; 	
  Hashtable ht =  new Hashtable();
 //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String strTitle = "投票类别管理";
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 Vector vectorPage = null;
 Hashtable content = null ;

 tools = new CTools();
 list_id    = request.getParameter("list_id");
 node_title = tools.iso2gb(request.getParameter("node_title"));

		if (list_id==null) list_id = "0";
		if (list_id.equals("")) list_id = "0";
 		title = "投票类别管理";
    CRoleAccess ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());
    String filterSql="";

    if(!ado.isAdmin(user_id))
    filterSql=ado.getAccessSqlByUser(user_id,ado.MetaAccess);

CMetaDirInfo jdo = new CMetaDirInfo(dCn);
sql = "select ty_id,ty_name,ty_code from tb_votetype" ;
%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
<img src="/system/images/dialog/split.gif" align="middle" border="0"> 
<img src="/system/images/dialog/ftp4.gif" border="0" onclick="window.location='voteDirInfo.jsp?OType=add'" title="新增目录" style="cursor:hand" align="absmiddle" id="image2" name="image2" WIDTH="16" HEIGHT="16"> 
<img src="/system/images/dialog/split.gif" align="middle" border="0">
<img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14"> 
<img src="/system/images/dialog/split.gif" align="middle" border="0"> 
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
  <tr class="bttn">
    <td width="10%" height="1" class="outset-table">序号</td>
    <td width="10%" height="1" class="outset-table">类型</td>
    <td width="60%" height="1" class="outset-table">名称</td>
    <td width="12%" height="1" class="outset-table">代码</td>
    <td width="10%" height="1" class="outset-table">修改</td>
  </tr>
  <form name="formData" method="post" action="metaList.jsp">
<%
  vectorPage = dImpl.splitPage(sql,request,20);
  if (vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
			seName   = content.get("ty_name").toString() +"-" + content.get("ty_id").toString() ;
      sImg     = "<img border=0 src='/system/images/dialog/Hidedir.gif'>";
      
      out.println("<td>" + (j+1) + "</td>");
      out.println("<td align='center'>" + sImg + "</td>");
      out.println("<td><a href=\"voteDetailList.jsp?ty_id="+content.get("ty_id").toString()+"\">" + content.get("ty_name") + "</a></td>");
      out.println("<td>" + content.get("ty_code") + "</td>");
      out.println("<td align=center><a href=\"voteDirInfo.jsp?OType=edit&ty_id="+content.get("ty_id").toString()+"\"><img src='/system/images/modi.gif' style='cursor:hand' border='0'></img></a></td>");
    	out.println("</tr>");  
    }
  }else{
      out.print("<td colspan='20'>没有记录！</td>");
  }

%>
  </form>
</table>
<!--内容-->
<!--    列表结束    -->
<%@include file="/system/app/skin/skin4/template/list_bottom.jsp"%> 
<%
	dImpl.closeStmt();
 	dCn.closeCn() ;
		Enumeration  enu =  null; 
    enu = ht.keys();
   while(enu.hasMoreElements())
   {
	   String sg_name =    (String)enu.nextElement();
	   String sg_sequence = (String) ht.get(sg_name);
	   String  new_sg_sequence  =  request.getParameter(sg_name);
	   System.out.println(sg_name+":"+new_sg_sequence);
	  
	  
	   if(new_sg_sequence !=null && !new_sg_sequence.equals("") )
	   { ht.remove(sg_name);
	   ht.put(sg_name,new_sg_sequence);
	   }
   }
   
   String condition_Column="";
   DataOper dataOper = new DataOper();
  
   dataOper.doUpdateExt(ht);
   } catch (Exception ex) {
			System.out.println(new java.util.Date() + "--"
					+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
// added by zhuhp 2006-07-11
%>
<%@include file="/system/app/skin/bottom.jsp"%>