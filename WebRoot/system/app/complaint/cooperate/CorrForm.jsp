<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../../skin/head.jsp"%>
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
String sqlDept="";
String cw_id="";
String cp_id="";
String optype="";
String co_id="";
String de_id="";
String sqlUnSign="";
String de_senddeptid="";
String dt_id = "";
String dt_name = "";
String pc_timelimit = "";

optype = CTools.dealString(request.getParameter("OPType")).trim();
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
cp_id = CTools.dealString(request.getParameter("cp_id")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
//de_id = CTools.dealString(request.getParameter("de_id")).trim();
//de_senddeptid =CTools.dealString(request.getParameter("de_senddeptid")).trim();
//out.println(co_id);
//out.println(de_id);
sqlUnSign = " select * from tb_correspond where co_id='"+co_id+"'";
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

sqlDept =" select x.dt_id,x.pc_timelimit,y.dt_name from tb_connproccorr x,tb_deptinfo y where x.dt_id=y.dt_id and x.cp_id='"+cp_id+"'";
Vector vectorDept=dImpl.splitPage(sqlDept,request,20);
//out.println(sqlDept);
	if(vectorDept!=null)
	{
	for(int i=0;i<vectorDept.size();i++)
	{
	Hashtable contCorr = (Hashtable)vectorDept.get(i);
	dt_id = contCorr.get("dt_id").toString();
	dt_name = contCorr.get("dt_name").toString();
	pc_timelimit = contCorr.get("pc_timelimit").toString();
	}
	}
%>
<table class="main-table" width="100%">
<form name="formData" method="post">
 <tr class="title1" align="center">
      <td>信访处理协调单</td>
 </tr>
  <tr>
  <td width="100%">
       <table width="100%" class="content-table" height="1">
	     <tr>
			<td>
			   <table width="100%">
				<tr>
	            <td width="19%" align="left">涉及主要问题：</td>
				</tr>
				<tr>
				<td width="81%"><textarea  class="text-line" name="co_question" cols="100%" rows="5"
				<%
				if(!optype.equals("Corr"))   out.println("readonly");
				%>
				><%=co_question%></textarea>
				</td>
				</tr>
				</table>
			</td>
		</tr>
			<tr>
			<td>
				<table class="content-table" width="100%">
				<tr>
	            <td width="19%" align="left">承办部门意见：</td>
				</tr>
				<tr>
				<td width="81%" ><textarea  class="text-line" name="co_mainopioion"  cols="100%" rows="5"
				<%
				if(!optype.equals("Corr"))   out.println("readonly");
				%>
				><%=co_mainopioion%></textarea>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			<%
			if(optype.equals("Corr"))
			{
				out.println("<tr><td><table width='100%'><tr><td width='20%' align='left' valign='center'>转办部门:");
				out.println("<input type='text' class='text-line' name='dt_name' size='10' readonly value="+ dt_name +">");
				out.println("</td><td>要求完成工作日:<input type='text' class='text-line' name='pc_timelimit' size='4' readonly value=" + pc_timelimit + ">天");
				out.println("</td></tr></table></td></tr>");
			}
			%>
			<tr align="center" width="100%">
			<td>
                        <input type="hidden" name="co_id" value="<%=co_id%>">
			<input type="hidden" name="de_id" value="<%=de_id%>">
			<input type="hidden" name="de_senddeptid" value="<%=de_senddeptid%>">
                        &nbsp;
			<input type="button" name="btnsubmit" value="提交并返回列表" class="bttn" onclick="checkCorr();"
			<%
			if(!optype.equals("Corr")) out.println("disabled");
			%>>&nbsp;
			<input type="hidden" name="cw_id" value="<%=cw_id%>">
			<input type="hidden" name="cp_id" value="<%=cp_id%>">
			<input type="hidden" name="OPType" value="<%=optype%>">
                        <input type="hidden" name="Receiverid" value="<%=dt_id%>">
                        <input type="hidden" name="Timelimit" value="<%=pc_timelimit%>">
			<input type="button" name="back" value="返回" class="bttn" onclick="history.go(-1);"
			<%
			if(!optype.equals("Corr")) out.println("disabled");
			%>
			>
			</td>
			</tr>
	</table>
	</td>
	</tr>
</form>
</table>
<script language="javascript">
function checkCorr()
{
	if(formData.co_question.value=="")
	{
		alert("项目涉及主要问题不能为空!");
		formData.co_quesiton.focus();
		return false;
	}
	if(formData.co_mainopioion.value=="")
	{
		alert("主办部门意见不能为空!");
		formData.co_mainopioion.focus();
		return false;
	}
	formData.action="CorrFormResult.jsp";
	//formData.target="_self";
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
<%@include file="../../skin/bottom.jsp"%>
