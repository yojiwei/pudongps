<%
/**************************************
this page is made by honeyday 2002-12-2
***************************************/
%>
<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="下载服务" ;%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sj_id="0";
String sWhere="";
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();

if (!sj_id.equals(""))
{
	sWhere=" where sj_id in ( select sj_id from tb_subject where sj_parentid= " + sj_id + ") or sj_id=" + sj_id;
}
String str_sql="select * from tb_download " + sWhere;
//out.println(str_sql);
Vector vectorPage = dImpl.splitPage(str_sql,request,20);

/*
栏目列表
*/

CSubjectList jdo = new CSubjectList(dCn);

String s="";

s = jdo.getListByCode("download",sj_id);


String attach_http_path="";
String sql="";
sql="select ip_id,ip_name,ip_value from tb_initparameter where ip_name='attach_http_path'";
Hashtable content_p=dImpl.getDataInfo(sql);
attach_http_path=content_p.get("ip_value").toString() ;
//CDataImpl dImpl1 = new CDataImpl(dCn);

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
                        <td valign="center" width="10%"><%=strTitle%></td>
                        <td valign="left">栏目列表:<%=s%></td>
                        <td valign="center" align="right" nowrap>

                            <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/new.gif" border="0" onclick="window.location='downloadInfo.jsp?OP=Add&SJ_id=<%=sj_id%>'" title="新增数据" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
                            <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

                            <img src="../..images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bttn">
            <td width="60%" class="outset-table">主题</td>
            <td width="15%" class="outset-table">发布日期</td>
                        <td width="8%" class="outset-table">文件大小</td>
            <td width="8%" class="outset-table">发布标志</td>
            <td width="8%" class="outset-table" nowrap>编辑</td>
        </tr>

<%

  if(vectorPage != null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String intId=content.get("dl_id").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
  %>

            <td>
				<A HREF="downloadList.jsp?sj_id=<%=content.get("sj_id")%>"><img border="0" src="../../images/arrow_yellow.gif" title="转到该分类" WIDTH="15" HEIGHT="13"></A>&nbsp;&nbsp;
				<A HREF="<%=attach_http_path+content.get("dl_directory_name").toString()+"/"+ content.get("dl_file_name").toString()%>" title="下载该文件"><%=content.get("dl_title")%></A>
			</td>

            <td><%=content.get("dl_create_time")%></td>

			<td><%= Double.toString(Math.ceil(Integer.parseInt(content.get("dl_file_size").toString())/1024))  %>KB</td>

			<td align=center><%if (content.get("dl_publish_flag").toString().equals("1")) {%><img class="hand" border="0" src="../../images/button-01.jpg" title="已发布" WIDTH="16" HEIGHT="16"><%}%><%//=content.get("dl_create_time")%></td>

            <td nowrap align=center><a href="downloadInfo.jsp?OP=Edit&strId=<%=intId%>&SJ_id=<%=sj_id%>"><img class="hand" border="0" src="../../images/modi.gif" title="编辑" WIDTH="16" HEIGHT="16"></a></td>
        </tr>
<%}%>
</table>
        </td>
    </tr>
<%/*分页的页脚模块*/

   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件

  }
  else
  {
    out.println("<tr><td colspan=10 class=line-odd align=center>没有记录！</td></tr>");
  }
%>
</table>

</form>
<%@include file="../skin/bottom.jsp"%>


<script LANGUAGE="javascript">
	function onChange()
	{
		var sj_id;
		sj_id=formData.sj_id.value;
		formData.action='downloadList.jsp?sj_id='+sj_id;
		formData.submit();
	}
</script>


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