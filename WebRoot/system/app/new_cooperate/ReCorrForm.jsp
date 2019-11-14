<%@page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String co_question="";
String co_mainopioion="";
String co_corropioion="";
String co_id="";
String de_id="";
String sqlUnSign="";
String de_senddeptid="";

co_id = CTools.dealString(request.getParameter("co_id")).trim();
//out.print(co_id);
de_id = CTools.dealString(request.getParameter("de_id")).trim();
de_senddeptid =CTools.dealString(request.getParameter("de_senddeptid")).trim();
//out.print(de_senddeptid);
dImpl.edit("tb_documentexchange","de_id",de_id);
dImpl.setValue("de_status","2",CDataImpl.STRING);
dImpl.update();
sqlUnSign = " select * from tb_correspond where co_id='"+co_id+"'";
//out.println(sqlUnSign);
Vector vectorUnSign=dImpl.splitPage(sqlUnSign,request,20);

if(vectorUnSign!=null)
{
	for(int i=0;i<vectorUnSign.size();i++)
	{
		Hashtable contUnSign=(Hashtable)vectorUnSign.get(i);
		co_question = contUnSign.get("co_question").toString();
		co_mainopioion = contUnSign.get("co_mainopioion").toString();
		co_corropioion = contUnSign.get("co_corropioion").toString();

	}
}
//out.println(co_question);
//out.println(co_mainopioion);
%>
<table class="main-table" width="100%">
<form name="formData" method="post">
 <tr class="title1" align="center">
      <td>业务处理协调单</td>
 </tr>
  <tr>
  <td width="100%">
       <table width="100%" class="content-table" height="1">
	     <tr>
			<td>
			   <table width="100%">
				<tr>
	            <td width="19%" align="left">项目涉及主要问题：</td>
				</tr>
				<tr>
				<td width="81%" ><textarea  class="text-line" name="co_question" cols="100%" rows="5" readonly><%=co_question%></textarea>
				</td>
				</tr>
				</table>
			</td>
		</tr>
			<tr>
			<td>
				<table class="content-table" width="100%">
				<tr>
	            <td width="19%" align="left">主办部门意见：</td>
				</tr>
				<tr>
				<td width="81%" ><textarea  class="text-line" name="co_mainopioion"  cols="100%" rows="5" readonly><%=co_mainopioion%></textarea>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			<tr>
			<td>
				<table>
				<tr><td>协办部门具体意见:</td></tr>
				<tr><td>
				<textarea class="text-line" name="co_corropioion" cols="100%" rows=5><%=co_corropioion%></textarea>
				</td></tr>
				</table>
			</td>
			</tr>
			<tr align="center" width="100%">
			<td>
			<input class="bttn" type="button" name="pass" value="通过" onclick="check(0)">&nbsp;
			<input class="bttn" type="button" name="unpass" value="不通过" onclick="check(1)">&nbsp;
			<input class="bttn" type="button" name="frozen" value="需补件" onclick="check(2)">&nbsp;
			<input class="bttn" type="button" name="tempstore" value="暂存" onclick="check(3)">&nbsp;
			<input type="hidden" name="co_id" value="<%=co_id%>">
			<input type="hidden" name="de_id" value="<%=de_id%>">
			<input type="hidden" name="de_senddeptid" value="<%=de_senddeptid%>">
			</td>
			</tr>
		</table>
		</td>
		</tr>
</form>
</table>
<script>
function check(choice)
{
	if(choice==0&formData.co_corropioion==null)
	{
		alert("请填写具体意见!");
		formData.co_corropioion.focus();
	}
	formData.action="/system/app/cooperate/ReCorrResult.jsp?choice="+choice;
	formData.target="_self";
	formData.submit();
}
</script>
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
