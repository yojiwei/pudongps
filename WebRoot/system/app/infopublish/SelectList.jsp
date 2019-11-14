<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="javascript" type="text/javascript">
function SelectA(a,sm_id)//发送成功的
{
	var sm_id=sm_id;
	var sj_id=document.formData.sm_sjid.value;
  window.location.href="SelectList.jsp?id="+a+"&sm_id="+sm_id+"&sm_sj_id="+sj_id+"";
}
function SelectB(b,sm_id)//发送失败的
{
	var sm_id=sm_id;
	var sj_id=document.formData.sm_sjid.value;
	window.location.href="SelectList.jsp?id="+b+"&sm_id="+sm_id+"&sm_sj_id="+sj_id+"";
}
function SelectC(sm_id)//全部的
{
	var sm_id=sm_id;
	var sj_id=document.formData.sm_sjid.value;
	window.location.href="SelectList.jsp?sm_id="+sm_id+"&sm_sj_id="+sj_id+"";
}
</script>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector vectorPage=null;
Hashtable content = null;
Hashtable contentsm = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String urlurl=request.getRequestURI();
String sm_id = "";
String sm_con = "";
String sm_sj_id1 = "";
String strTitle="";
String my_id = "";
String sqltj = "";
String sqlsm = "";
String sm_id11 = "";
String us_uid = "";
String sm_tel = "";
String sj_name="";
String sm_sendtime="";
String sj_flag ="";

if(request.getQueryString()!=null)
{
 urlurl+="?" + CTools.dealString(request.getQueryString());
}

sm_id = CTools.dealString(request.getParameter("sm_id"));
sm_sj_id1 = CTools.dealString(request.getParameter("sm_sj_id"));

sqlsm = "select sm_con from tb_sms where sm_id = "+sm_id+"";

contentsm = dImpl.getDataInfo(sqlsm);
if(contentsm!=null){
		sm_con=CTools.dealNull(contentsm.get("sm_con"));
}
if(sm_con.length()>12)
{
	strTitle=sm_con.substring(0,12)+".....";
}

my_id = CTools.dealString(request.getParameter("id"));
sqltj="select s.sm_id,s.sm_tel,t.us_uid,s.sm_sendtime,s.sm_flag,j.sj_name from tb_sms s,tb_user t,tb_usertake u,tb_subject j where s.sm_tel is not null and s.sm_sj_id=j.sj_id and s.sm_tel=u.ut_tel and u.us_id=t.us_id and s.sm_sj_id="+sm_sj_id1+"";

if(!my_id.equals(""))
{
	sqltj+=" and s.sm_flag="+my_id+"";
}

if(!sm_con.equals(""))
{
	sqltj+=" and s.sm_con='"+sm_con+"'";
}

vectorPage =dImpl.splitPage(sqltj,request,20); 

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                    
<!--    功能按钮开始    -->
<form name="formData">
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
<tr>
<input type="hidden" name="sm_id" value="<%=sm_id%>"/>
<input type="hidden" name="sm_sjid" value="<%=sm_sj_id1%>"/>
<td valign="center" nowrap>
  <input type="radio" name="sendflag" id="send1" onClick="SelectA(1,<%=sm_id%>)" <%if(my_id.equals("1")){out.print("checked");}%>>
  发送成功
	<input type="radio" name="sendflag" id="send2" onClick="SelectB(0,<%=sm_id%>)" <%if(my_id.equals("0")){out.print("checked");}%>>
	发送失败
	<input type="radio" name="sendflag" id="send3" onClick="SelectC(<%=sm_id%>)" <%if(my_id.equals("")){out.print("checked");}%>>
	全部情况
</td>
<td valign="center" align=left></td>
  <td valign="center" align="right" nowrap>
<img src="images/dialog/goback.gif"width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onClick="javascript:history.back();">
返回
</td>
</tr>
</table> 
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<tr class="bttn">
    <td width="12%" class="outset-table" nowrap>信息ID</td>
    <td width="14%" class="outset-table" nowrap>用户名称</td>
    <td width="22%" nowrap class="outset-table">手机号码</td>
    <td width="22%" nowrap class="outset-table">发送时间</td>
    <td width="11%" nowrap class="outset-table">所属栏目</td>
    <td width="19%" nowrap class="outset-table">发送状态</td>
 </tr>
<%
  if(vectorPage!=null)
  {

    for(int j=0;j<vectorPage.size();j++)
    {
      content = (Hashtable)vectorPage.get(j);
	    sm_id11 = CTools.dealNull(content.get("sm_id"));
	    us_uid = CTools.dealNull(content.get("us_uid"));
	    sm_tel = CTools.dealNull(content.get("sm_tel"));
	    sj_name= CTools.dealNull(content.get("sj_name"));
	    sm_sendtime=CTools.getDate(CTools.dealString(content.get("sm_sendtime").toString()));
	    sj_flag = CTools.dealNull(content.get("sm_flag"));
			
		  
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>		<td align=center nowrap ><%=sm_id11%></td>
      <td align="left" nowrap><%=us_uid%></td>
      <td align=center nowrap><%=sm_tel%></td>
      <td align=center nowrap><%=sm_sendtime%></td>
      <td align=center nowrap><%=sj_name%></td>
       <td align=center><%if(sj_flag.equals("0")){out.print("<a href='updateSel.jsp?sm_id="+sm_id11+"&oPage="+urlurl+"'>失败</a>");}else{out.print("成功");}%></td>
      </tr>
</form>
<%
    }
  }
  else
  {
    out.println("<tr><td colspan=17>没有记录！</td></tr>");
  }
%>
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