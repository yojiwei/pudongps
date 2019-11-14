<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/pophead.jsp"%>
<%@page import="com.app.*"%>
<!--签收项目督办单-->
<%
String sv_id = "";
sv_id = CTools.dealString(request.getParameter("sv_id")).trim();

%>
<%
String supervisallist = "";
supervisallist  = CTools.dealString(request.getParameter("supervisallist")).trim();
//out.println("urgentlist="+urgentlist);

%>





<%
String sqlWait="";
String de_id="";
String dt_id="";
String dt_name="";
String de_status="";
String sv_content="";
String sv_type="";
String sv_feedback="";
String wo_projectname="";
sqlWait="select a.sv_type,a.sv_content,a.sv_feedback,b.de_id ,b.de_status,c.wo_projectname ,d.dt_id,d.dt_name from tb_supervise a,tb_documentexchange b ,tb_work c ,tb_deptinfo d  where a.sv_id='"+sv_id+"' and  a.sv_type='4'  and  a.sv_id=b.de_primaryid  and c.wo_id=a.SV_FOREIGNID and b.de_senddeptid=d.dt_id";

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
                             sv_type=content.get("sv_type").toString();
                              sv_feedback=content.get("sv_feedback").toString();
                                sv_content=content.get("sv_content").toString();
                                  de_id=content.get("de_id").toString();
                                    de_status=content.get("de_status").toString();
                                  wo_projectname=content.get("wo_projectname").toString();
                                  dt_id=content.get("dt_id").toString();
                                   dt_name=content.get("dt_name").toString();
			    if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
			}
		}

%>


<body onunload="test()">
<form name="formData" action="SupervisalListSubmit.jsp" method="post">
<table class="main-table" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title1">
    <td colspan="2" align="center" height="20"><font size="2">督办单</font>
    </td>
  </tr>



   <tr class="line-even">
    <td align="right" >督办事项:
 </td>
 <td>
<input type="text"  name="wo_projectname"   size="50"      class = "text-line" value=<%=wo_projectname%> >
 </td>
</tr>

   <tr class="line-even">
    <td align="right" >督办信息:
 </td>
 <td>
  <br>
    <textarea  name="sv_dbname" rows="6" cols="50" class = "text-line" readonly><%=sv_content%></textarea>
 </td>
</tr>

  <tr class="line-even">
    <td align="right" >反馈信息:
 </td>
 <td>
<br>
<textarea  name="sv_feedback" rows="6" cols="50" class = "text-line"  <%if (de_status.equals("1")) out.println("readonly");%> <%if( de_status.equals("4")) out.println("readonly");%><%if( de_status.equals("5"))out.println("readonly");%>><%=sv_feedback%></textarea>
 </td>
</tr>









	<tr class="title1" align="center">
	 <td colspan="2">

      <!--  <input type=<%if (de_status.equals("5")) out.println("hidden");out.println("submit");%>  class="bttn" name="back" value=<%if (de_status.equals("2")) out.println("反馈"); else out.println("签收");%> >-->
        <input type="button" class="bttn" name="back" value="关闭" onclick="window.close();">
        <input type="hidden" name="sv_id" value="<%=sv_id%>">
          <input type="hidden" name="de_id" value="<%=de_id%>">
           <input type="hidden" name="de_status" value="<%=de_status%>">
              <input type="hidden" name="dt_id" value="<%=dt_id%>">
	       </tr>






</table>
</form>

<%
//当状态为4的时候表示反馈发送状态，当状态为1的时候表示发送状态
if(de_status.equals("4"))
{
dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_status","5",CDataImpl.STRING);
 dImpl.setValue("de_feedbacksigntime",new CDate().getNowTime(),CDataImpl.DATE);
dImpl.update();
}
if(de_status.equals("1"))
{

dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_status","2",CDataImpl.STRING);
dImpl.setValue("de_signtime",new CDate().getNowTime(),CDataImpl.DATE);
dImpl.update();
}
%>

<script language="javascript">
function test()
{
<%
if(supervisallist.equals("1"))
{
%>
	alert("督办单已签收");
window.opener.location.href='Supervisal.jsp';
<%
}
%>

}

</script>
</body>



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
