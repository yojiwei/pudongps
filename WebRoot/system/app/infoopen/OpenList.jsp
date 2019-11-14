<%@page contentType="text/html; charset=GBK"%>
<%
//BY PK 2004-4-24 13:41  拟信息公开列表
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());

String io_id="";  //事项ID
String io_status=""; //办理状态
String io_content=""; //要求内容
String io_attach_path=""; //附件路径
String io_reback=""; //回复内容
String io_reback_time=""; //返回时间
String io_us_name=""; //用户姓名
//String io_us_address=""; //用户地址
//String io_us_tel=""; //电话
//String io_us_link=""; //其他联系方式
//String io_us_email=""; //邮件
String io_send_time=""; //发送时间
String in_subject=""; //发送内容主体
String in_id=""; //信息索引号
String us_id=""; //用户id
String str_sql ="";
String strTitle="";
String strhref="";
String strAct="";
String dt_id="";//部门ID
io_status = request.getParameter("io_status").toString();
int intStatus = Integer.parseInt(io_status);

switch(intStatus)
{
case 1:
  strTitle = "待处理--信息公开需求";
  strhref = "OpenInfo.jsp";
  strAct = "受理";
  break;
case 2:
  strTitle = "处理中--信息公开需求(无效)";
  strhref = "OpenInfo.jsp";
  strAct = "受理";
  break;
case 3:
  strTitle = "已处理--信息公开需求";
  strhref = "OpenInfo.jsp";
  strAct = "查看";
  break;
default:
  strTitle = "";
}


com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf"); //当前用户的部门id
if (mySelf!=null)
{
	dt_id = Long.toString(mySelf.getDtId());
	//out.println(dt_id);
	
}
//

%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


 str_sql="select tb_user.*,io.* from tb_infoopen io,tb_user where io.us_id=tb_user.us_id and io_status = " + io_status;
 if (!dt_id.equals(""))
{
	str_sql = str_sql + " and dt_id="+dt_id;
	//out.println(str_sql);
}
 else
{
str_sql = "";	
}
str_sql = str_sql + " order by io_id desc";
  //out.println(str_sql);
Vector vectorPage = dImpl.splitPage(str_sql,request,20);
%>
 <table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="8" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center" align="left"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>


                                                        <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">

                                                        <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
                <tr class="bttn">
                        <td width="10%" class="outset-table">申请人(单位)</td>
                        <td width="20%" class="outset-table">申请信息主题</td>
                        <td width="16%" class="outset-table">申请时间</td>
                        <%
                         if(intStatus==3)
                          out.print("<td width=\"16%\" class=\"outset-table\">处理完成时间</td>");
                          %>
                        <td width="5%" class="outset-table" nowrap><%=strAct%></td>
                </tr>
 <%
if(vectorPage!=null)
{
  try
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      //io_id = content.get("io_id").toString();
            if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
            else out.print("<tr class=\"line-odd\">");
  %>
          <td width="10%" align="center"><%=content.get("io_us_name")%></td>
          <td width="20%" align="center"><%=content.get("in_project") %></td>
          <td width="16%" align="center"><%=content.get("io_send_time")%></td>
          <%
            if(intStatus==3)
            out.print("<td width=\"16%\" align=\"center\">" + content.get("io_reback_time") + "</td>");
          %>
          <td width="5%" align="center"><a href="<%=strhref%>?io_id=<%=content.get("io_id")%>&io_status=<%=io_status%>"><img class="hand" border="0" src="../../images/modi.gif" title="<%=strAct%>" WIDTH="16" HEIGHT="16"></a></td>
<%
    }
  %>
   </tr>

<%/*分页的页脚模块*/
   out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
}
catch(Exception e)
{
   out.println(e);
}
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