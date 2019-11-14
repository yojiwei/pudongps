<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/pophead.jsp"%>
<%@page import="com.app.*"%>
<!--协调单督办的反馈，填入信息-->
<%
String sv_id="";
sv_id= CTools.dealString(request.getParameter("sv_id")).trim();
String sv_feedback="";
%>

<%
String optype="";
optype=CTools.dealString(request.getParameter("OPType")).trim();
%>



<%
String sqlWait="";
String de_id="";
String dt_id="";
String dt_name="";
String de_status="";
String sv_content="";
String sv_type="";
String wo_projectname="";



sqlWait="select a.wo_projectname,b.de_id,b.de_sendtime,b.de_status,d.dt_id,e.sv_feedback,e.sv_content,e.sv_id,e.sv_type from tb_work a,tb_documentexchange b,tb_correspond c,tb_deptinfo d,tb_supervise e where e.sv_id='"+sv_id+"' and (b.de_status='2' or b.de_status='5') and c.co_status='1' and e.sv_type='5' and a.wo_id =c.wo_id and e.SV_FOREIGNID=c.co_id and b.de_primaryid=e.sv_id and b.de_senddeptid=d.dt_id";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
DataDealImpl dDealImpl = new DataDealImpl(dCn.getConnection()); //\u6570\u636E\u4EA4\u6362\u5B9E\u73B0

	Vector vectorPage = dImpl.splitPage(sqlWait,request,20);
		if(vectorPage!=null)
		{
			for(int i=0;i<vectorPage.size();i++)
			{
				 Hashtable content = (Hashtable)vectorPage.get(i);
                                   sv_id=content.get("sv_id").toString();

                                  sv_type=content.get("sv_type").toString();

                                  sv_content=content.get("sv_content").toString();
                                  sv_feedback=content.get("sv_feedback").toString();
                                  de_id=content.get("de_id").toString();


                                  de_status=content.get("de_status").toString();

                                  wo_projectname=content.get("wo_projectname").toString();
                                 dt_id=content.get("dt_id").toString();



			    if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
			}
		}




%>

<form name="formData" action="FeedBackInfoResult.jsp" method="post">
<table class="main-table" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class ="title1">

<td colspan="6" align="center" height="20%" width="100%" ><font size="2" >督办单</font>
</td>
</tr>


   <tr class="line-even">
    <td align="right" >督办事项:
 </td>
 <td>

<input type="text"  name="wo_projectname"   size="50"  class = "text-line"  value=<%=wo_projectname%>  >
 </td>
</tr>

   <tr class="line-even">
    <td align="right" >督办内容:
 </td>
 <td>
<br>
<textarea  name="sv_content" rows="6" cols="50" class = "text-line" readonly><%=sv_content%></textarea>
 </td>
</tr>

  <tr class="line-even">
    <td align="right" >反馈内容:
 </td>
 <td>
<br>
<textarea  name="sv_feedback" rows="6" cols="50" class = "text-line"  <%if (de_status.equals("5")
|| optype.equals("View")) out.println("readonly");%>><%=sv_feedback%></textarea>
 </td>
</tr>

        <tr class="title1" align="center">
        <td colspan="6">
	<input type=<%if (de_status.equals("5") || optype.equals("View")) out.println("hidden"); else out.println("submit");%> class="bttn" value="反馈发送">&nbsp;
	<input type=<%if (de_status.equals("5") || optype.equals("View")) out.println("hidden"); else out.println("reset");%> class="bttn"  value="重设">&nbsp;
	<input type="button" class="bttn" name="back" value="关闭"  onclick="window.close()">




         <input type="hidden" name="sv_id" value="<%=sv_id%>">
         <input type="hidden" name="de_id" value="<%=de_id%>">
          <input type="hidden" name="dt_id" value="<%=dt_id%>">
             <input type="hidden" name="sv_type" value="<%=sv_type%>">
        </td>
         </tr>
</table>

</form>
<%@include file="../skin/popbottom.jsp"%>
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