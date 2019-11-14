<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="用户订制一览表";

String US_ID = "";
String UT_ID = "";
String US_NAME = "";
String US_TEL = "";
String US_EMAIL = "";
String CODEDATE = "";      //用户订阅时间
String beginTime = "";    //开始查询时间
String endTime = "";      //结束查询时间
String username = "";     //用户名称查询
String usertel = "";
String id = "";           //用于判断是不是从查询页面跳转过来
String strSql="";         //执行条件的SQL语句
int tid=0;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
id = (String)request.getParameter("id");
if(id!=null)
{
  tid=Integer.parseInt(id);
}
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
username = CTools.dealString(request.getParameter("us_username")).trim();
usertel = CTools.dealString(request.getParameter("us_usertel")).trim();

%>
<%@include file="/system/app/skin/skin4/template/list_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/list_function.jsp"%>                                                            
<!--    功能按钮开始    -->
 <img src="images/menu_about.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="查找" onClick="javascript:window.location.href='/system/app/dxpd/UserTakeSearch.jsp' ">
 查找
<img src="images/goback.gif" width="16" height="16" border="0" align="absmiddle" style="cursor:hand" title="返回" onclick="javascript:history.back();">
返回                                     
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/list_listtop.jsp"%>                                                                                        
<!--    列表开始    -->
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
	<tr class="bttn">
	<td width="7%" class="outset-table">用户ID</td>
	<td width="11%" class="outset-table">用户名称</td>
	<td width="16%" class="outset-table"> 手机号码 </td>
	<td width="23%" class="outset-table">Email</td>
	<td width="23%" class="outset-table">绑定时间</td>
	<td class="outset-table"> 操作</td>
	</tr>
    <%
			strSql="select u.ut_id,t.us_id,t.us_uid,t.us_name,t.us_cellphonenumber,t.us_email,u.codedate from tb_usertake u,tb_user t where u.us_id= t.us_id and u.status=1";
			if(!username.equals(""))
			{
				strSql += " and t.us_uid='"+username+"'";
			}
			if(!beginTime.equals(""))
			{
			   strSql += " and u.codedate > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
			}
		    if(!endTime.equals(""))
			{
				strSql += " and u.codedate < to_date('" + endTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
			}
			if(!usertel.equals(""))
			{
				strSql+=" and t.us_cellphonenumber='"+usertel+"'";
			}
			strSql+=" order by u.codedate desc,u.ut_id desc";
			
			Vector vectorPage = dImpl.splitPage(strSql,request,20);          
			if(vectorPage!=null)
            {
            for(int j=0;j<vectorPage.size();j++)
            {
              Hashtable content = (Hashtable)vectorPage.get(j);
			  			UT_ID=content.get("ut_id").toString();
              US_ID=content.get("us_id").toString();
              US_NAME=content.get("us_uid").toString();
						  US_TEL=content.get("us_cellphonenumber").toString();
						  US_EMAIL=content.get("us_email").toString();
						  CODEDATE=content.get("codedate").toString();
              if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
              else out.print("<tr class=\"line-odd\">");
			  %><td><%=US_ID%></td>
              <td align="center"><%=US_NAME%></td>
              <td align="center"><%=US_TEL%></td>
              <td align="center"><%=US_EMAIL%></td>
              <td align="center"><%=CODEDATE%></td>
            <td align="center"><a href="UserTakeDetail.jsp?id=<%=UT_ID%>&us_id=<%=US_ID%>">查看订阅</a></td>
        <%
            }
        %>
        </form>
        <%
      }
      else
      {
        out.println("<tr><td colspan=20>无记录</td></tr>");
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