<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="静态栏目维护" ;%>
<%@include file="../skin/head.jsp"%>
<%
//得到当前用户的角色集
String UID="";
CMySelf myStaticSubject = (CMySelf)session.getAttribute("mySelf");
if (myStaticSubject!=null && myStaticSubject.isLogin())
{
  UID=Long.toString(myStaticSubject.getMyID());
}
//out.print(UID);select tr_id from tb_roleinfo where tr_userids like '%,"+UID+",%'
String roleSql="select tr_id from tb_roleinfo where tr_userids like '%,"+UID+",%'";
//得到角色集所有的栏目权限
roleSql="select sj_id from tb_subjectrole where tr_id in ("+roleSql+")";
//String sjCodes="'websitereadme'";//当前用户所能维护的静态栏目code，可以是多个，各个代码之间用逗号分隔开。
String sql="select * from tb_subject where sj_id in (" + roleSql + ")";
//out.print(sql);
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
Vector vectorPage = dImpl.splitPage(sql,request,20);


%>

<form name="formData">
 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">

        <tr class="title1">
            <td colspan="5" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td width="10%" valign="center"><%=strTitle%></td>
						            <td valign="center" align="right" nowrap>

               
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bttn">
            <td width="25%" class="outset-table">栏目名称</td>
            <td width="42%" class="outset-table">超链接</td>
            <td width="15%" class="outset-table">权限代码</td>

            <td width="8%" class="outset-table" nowrap>编辑</td>
			
        </tr>
<%

  if(vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String strId=content.get("sj_id").toString();
	  String se=content.get("sj_sequence").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");

  %>

            <td><%=content.get("sj_name")%></td>

            <td><%=content.get("sj_url")%></td>

			<td><%=content.get("sj_dir")%></td>
			<td nowrap align=center><a href="subjectInfo.jsp?OP=Edit&strId=<%=strId%>&IsStatic=true"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
			</tr>
<%}%>
</table>
        </td>
    </tr>
<%/*分页的页脚模块*/
	dImpl.closeStmt();
	dCn.closeCn();
   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件

  }
  else
  {
    out.println("<tr><td>没有记录！</td></tr>");
  }
%>
</table>
</form>

<%@include file="../skin/bottom.jsp"%>
<%


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