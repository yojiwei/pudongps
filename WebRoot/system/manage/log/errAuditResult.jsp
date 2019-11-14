<!--writen by nq,modify in 2003-5-14-->
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.platform.log.*" %>
<%@ page import="com.util.CTools" %>

<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function del()
{
  if(!confirm("您确认清除吗？")) return;
  formData.submit();
}
-->
</script>
<%
String user,start_date,end_date,opertype,ct_title;
user=CTools.dealString(request.getParameter("user")).trim();
ct_title=CTools.dealString(request.getParameter("title")).trim();
opertype=CTools.dealString(request.getParameter("opertype")).trim();
start_date=CTools.dealString(request.getParameter("start_date")).trim();
end_date=CTools.dealString(request.getParameter("end_date")).trim();

//String sWhere="where 1=1 and cl.ui_id=ui.ui_id and cl.ct_id=ct.ct_id and ct.sj_id=sj.sj_id ";
String sWhere="where 1=1 and cl.ui_id=ui.ui_id ";
if(!user.equals(""))
{ 
	sWhere=sWhere+ " and ui.ui_name='"+user+"'";
} 
if(!ct_title.equals(""))
{ 
	sWhere=sWhere+ " and ct_title like '%"+ct_title+"%'";
}  
if (!start_date.equals(""))
	{
		sWhere=sWhere + " and cl.cl_date >= TO_DATE('"+ start_date +"','YYYY-MM-DD')";
		//sWhere=sWhere + " and TO_DATE(cl.cl_date,'YYYY-MM-DD') >= TO_DATE('"+ start_date +"','YYYY-MM-DD')";
	}
if (!end_date.equals(""))
	{
		sWhere=sWhere + " and cl.cl_date <= TO_DATE('"+ end_date +"','YYYY-MM-DD')";
		//sWhere=sWhere + " and TO_DATE(cl.cl_date,'YYYY-MM-DD') <= TO_DATE('"+ end_date +"','YYYY-MM-DD')";
	}
if (!opertype.equals("all"))
    {
		sWhere=sWhere +" and cl.cl_operate='"+opertype+"'";
    }
 if (opertype.equals("all"))
    {
	    sWhere=sWhere;
	}


//String strSql="select sj.sj_name as sj_name,ui.ui_name as ui_name,cl.cl_date as cl_date,ct.ct_title as ct_title,cl.cl_operate as opertype from tb_contentlog cl,tb_content ct,tb_userinfo ui,tb_subject sj " +sWhere+" order by cl.cl_date desc";

String strSql="select cl.sj_name as sj_name,ui.ui_name as ui_name,cl.cl_date as cl_date,cl.ct_title as ct_title,cl.cl_operate as opertype from tb_contentlog cl,tb_userinfo ui " +sWhere+" order by cl.cl_date desc";


//out.println(strSql);

String title = "审计日志";

 CDataCn dCn = null;
 CLogInfo jdo = null;
 try{
 	dCn = new CDataCn();
    jdo = new CLogInfo(dCn);

 jdo.setSql(strSql);
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
				    <td width="5%" height="1" class="outset-table">序号</td>
				    <td width="8%" height="1" class="outset-table">登录名</td>
				    <td width="20%" height="1" class="outset-table">操作栏目</td>
				    <td width="36%" height="1" class="outset-table">新闻标题</td>
				    <td width="20%" height="1" class="outset-table">操作时间</td>
					<td width="11%" height="1" class="outset-table">操作方式</td>
					
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

      out.println("<td>" + (j+1) + "</td>");
      out.println("<td>" + content.get("ui_name") + "</td>");
      out.println("<td>" + content.get("sj_name") + "</td>");
      out.println("<td>" + content.get("ct_title") + "</td>");
      out.println("<td>" + content.get("cl_date") + "</td>");
	//  out.println("<td>" + content.get("opertype") + "</td>");
	 if ((content.get("opertype").toString()).equals("Add"))
          out.println("<td>新增</td>");
	  if ((content.get("opertype").toString()).equals("Edit"))
          out.println("<td>编辑</td>");
	   if ((content.get("opertype").toString()).equals("Delete"))
          out.println("<td>删除</td>");
          
      out.println("</tr>");
    }
  }else{
      out.print("<td colspan=6>没有记录！</td>");
  }

%>
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
