<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String strTitle="短信发送日志一览表";
String sj_dir="";
String subid="";
String title = "";
String subscibeid = "";
String sendtime = "";

String  sname="";
String  sname1="";       //传递过来的主题名
String  sid="";
String strSql="";
%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
sid=CTools.dealString(request.getParameter("id")).trim();

sname=request.getParameter("subjectname");
sname1 = new String(sname.getBytes("ISO-8859-1"), "GB2312");//强行转码
String username=(String)request.getSession().getAttribute("hello");

strSql="select * from subscibelog s left outer join subscibesetting b on s.subscibeid=b.id where s.subscibeid="+sid;
Vector vectorPage = dImpl.splitPage(strSql,request,20);
%>
<table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="4" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center" align="left"><%=username%>的<%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>

                                                        <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">                                                </td>
                                        </tr>
                                </table>
						</td>
                </tr>
                <tr class="bttn">
                        <td width="14%" height="17" class="outset-table">信息ID</td>
                        <td width="41%" class="outset-table">短信主题</td>
                        <td width="20%" class="outset-table">短信所属栏目</td>
                        <td width="20%" class="outset-table">发送时间</td>
                </tr>
                <%

          if(vectorPage!=null)
          {
            for(int j=0;j<vectorPage.size();j++)
            {
              Hashtable content = (Hashtable)vectorPage.get(j);
			  subid=content.get("id").toString();
			  title=content.get("content").toString();
			  subscibeid=content.get("subscibeid").toString();
			  sendtime=content.get("sendtime").toString();
			  

              if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
              else out.print("<tr class=\"line-odd\">");
        %>
		      <td align="center"><%=subid%></td>
              <td align="center"><%=title%></td>
              <td align="center"><%=sname1%></td>
              <td align="center"><%=sendtime%></td>
            <%
            }
        %>
        
		</tr>
        <%
      /*分页的页脚模块*/
       out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件


      }
      else
      {
        out.println("<tr><td colspan=7>无记录</td></tr>");
			}
      %>
       </table>
  </td>
</tr>
</table>
<%
//session.removeAttribute("hello");
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
<%@include file="../skin/bottom.jsp"%>

