<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/pophead.jsp"%>
<%@page import="com.app.*"%>

<!--签收协调单催办单-->
<%
String ur_id = "";
ur_id = CTools.dealString(request.getParameter("ur_id")).trim();

%>

<%
String urgentcolist = "";
urgentcolist  = CTools.dealString(request.getParameter("urgentcolist")).trim();
//out.println("urgentlist="+urgentlist);

%>

<%
String sqlWait="";
String de_id="";
String ur_content="";
String ur_type="";
String wo_projectname="";
String de_status="";
//sqlWait="select a.ur_type,a.ur_content,b.de_id ,d.wo_projectname from tb_urgent a,tb_documentexchange b ,tb_TB_CORRESPOND c,tb_work d  where a.ur_id='"+ur_id+"' and  b.de_type='3'  and  a.ur_id=b.de_primaryid  and c.co_id=a.UR_FOREIGNID and c.wo_id=d.wo_id ";
sqlWait="select a.ur_type,a.ur_content,b.de_id ,b.de_status,c.wo_projectname from tb_urgent a,tb_documentexchange b ,tb_work c ,tb_correspond d where a.ur_id='"+ur_id+"' and b.de_type='3'  and  d.wo_id=c.wo_id and a.ur_id=b.de_primaryid  and d.co_id=a.UR_FOREIGNID";
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
                                ur_type=content.get("ur_type").toString();
                                ur_content=content.get("ur_content").toString();

                                de_id=content.get("de_id").toString();
                                de_status=content.get("de_status").toString();
                                wo_projectname=content.get("wo_projectname").toString();
                              //  wo_projectname=content.get("wo_projectname").toString();
			    if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
			}
		}




%>
<body onunload="test()">
<form name="formData" action="UrgentListSubmit.jsp" method="post">
<table class="main-table" width="100%" border="0" cellspacing="0" cellpadding="0">

  <tr class="title1">
    <td colspan="2" align="center" height="20"><font size="2">催办单</font>
    </td>
  </tr>

       <tr class="line-even">
    <td align="right" >催办事项:
 </td>
 <td>

<input type="text"  name="wo_projectname"   size="50"  class = "text-line" value=<%=wo_projectname%>  >
 </td>
</tr>

   <tr class="line-even">
    <td align="right" >催办信息:
 </td>
 <td>
<BR>
<textarea  name="dbname" rows="7" cols="50" class = "text-line" readonly><%=ur_content%></textarea>
 </td>
</tr>

             	<tr class="title1" align="center">
	 <td colspan="2">
                 <!-- <input type=<%if (de_status.equals("2")) out.println("hidden");else out.println("submit");%> class="bttn" name="back" value="签收" >-->
        <input type="button" class="bttn" name="back" value="关闭" onclick="window.close();">

	       </tr>

          <input type="hidden" name="de_id" value="<%=de_id%>">
            <input type="hidden" name="ur_type" value="<%=ur_type%>">
</table>

</form>
<%
dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_status","2",CDataImpl.STRING);
//java.util.Date FinishTime = new java.util.Date();//\u53D6\u5F97\u5F53\u524D\u7CFB\u7EDF\u7684\u65F6\u95F4
 dImpl.setValue("de_signtime",new CDate().getNowTime(),CDataImpl.DATE);
//out.println("signtime="+FinishTime );
dImpl.update();
 %>

<script language="javascript">
function test()
{
<%
if(urgentcolist.equals("1"))
{
%>
	alert("催办单已签收");
window.opener.location.href='Urgent.jsp';
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