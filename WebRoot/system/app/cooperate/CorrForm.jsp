<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
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
String co_status="";
String sqlDept="";
String wo_id="";
String pr_id="";
String optype="";
String co_id="";
String de_id="";
String sqlUnSign="";
String de_senddeptid="";
String de_status="";

optype=CTools.dealString(request.getParameter("OPType")).trim();
co_id = CTools.dealString(request.getParameter("co_id")).trim();
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
de_id = CTools.dealString(request.getParameter("de_id")).trim();
de_senddeptid = CTools.dealString(request.getParameter("de_senddeptid")).trim();
de_status = CTools.dealString(request.getParameter("de_status")).trim();


String sqlNeed = " select z.de_senddeptid,z.de_id,y.wo_id,y.pr_id,z.de_status from tb_correspond x,tb_work y,tb_documentexchange z where x.co_id='"+co_id+"' and x.co_id=z.de_primaryid and x.wo_id=y.wo_id and z.de_type='1' ";

Hashtable content = dImpl.getDataInfo(sqlNeed);
if(content!=null)
{
	de_senddeptid = content.get("de_senddeptid").toString();
	de_id = content.get("de_id").toString();
	wo_id = content.get("wo_id").toString();
	pr_id = content.get("pr_id").toString();
	de_status = content.get("de_status").toString();
}
//out.println(sqlNeed);out.close();
//out.println(wo_id);
//out.println(de_id);
String sqlWork = " select wo_projectname from tb_work where wo_id='"+wo_id+"' ";
//out.println(sqlWork);out.close();

Hashtable contWork = dImpl.getDataInfo(sqlWork);
String wo_projectname = contWork.get("wo_projectname").toString();
sqlUnSign = " select x.co_question,x.co_mainopioion,x.co_corropioion,x.co_status from tb_correspond x,tb_work y where co_id='"+co_id+"' ";
//out.println(sqlUnSign); out.close();
Vector vectorUnSign=dImpl.splitPage(sqlUnSign,request,20);
if(vectorUnSign!=null)
{
	for(int i=0;i<vectorUnSign.size();i++)
	{
		Hashtable contUnSign=(Hashtable)vectorUnSign.get(i);
		co_question = contUnSign.get("co_question").toString();
		co_mainopioion = contUnSign.get("co_mainopioion").toString();
		co_corropioion = contUnSign.get("co_corropioion").toString();
		co_status = contUnSign.get("co_status").toString();

	}
}

if(optype.equals("Recorr"))
{
	dImpl.edit("tb_documentexchange","de_id",de_id);
	dImpl.setValue("de_status","2",CDataImpl.STRING);
	dImpl.update();
}
//out.println(pr_id);
sqlDept =" select * from tb_proceedingcorr x,tb_deptinfo y where x.dt_id=y.dt_id and x.pr_id='"+pr_id+"'";
Vector vectorDept=dImpl.splitPage(sqlDept,request,20);
//out.println(sqlDept);
%>
<script>
var dt_id = new Array;
var dt_name =new Array;
var pc_timelimit =new Array;
dt_id[0]="0";
dt_name[0]="选择部门";
pc_timelimit[0]="0";
<%
				if(vectorDept!=null)
				{
				for(int i=0;i<vectorDept.size();i++)
				{
					Hashtable contCorr = (Hashtable)vectorDept.get(i);
%>
	dt_id[<%=(i+1)%>]="<%=contCorr.get("dt_id")%>";
	dt_name[<%=(i+1)%>]="<%=contCorr.get("dt_name")%>";
	pc_timelimit[<%=(i+1)%>]="<%=contCorr.get("pc_timelimit")%>";
<%
				}
				}
%>
</script>
<table class="main-table" width="100%">
<form name="formData" method="post">
 <tr class="title1" align="center">
      <td nowrap><%=wo_projectname%>协调单
	  <%
		if(co_status.equals("3"))
		{
			out.println("(已通过)");
		}
		if(co_status.equals("4"))
		{
			out.println("(未通过)");
		}
	  %>
	  </td>
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
				<td width="81%"><textarea  class="text-area" name="co_question" cols="100%" rows="5"
				<%
				if(!optype.equals("Corr")&&!optype.equals("Corragain"))   out.println("readonly");
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
	            <td width="19%" align="left">主办部门意见：</td>
				</tr>
				<tr>
				<td width="81%" ><textarea  class="text-area" name="co_mainopioion"  cols="100%" rows="5"
				<%
				if(!optype.equals("Corr")&&!optype.equals("Corragain"))   out.println("readonly");
				%>
				><%=co_mainopioion%></textarea>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			<%
			if(optype.equals("Corr")||optype.equals("Corragain"))
			{
				out.println("<tr><td><table width='100%'><tr><td width='20%' align='left' valign='center'>协办部门:");
				out.println("<select name='corrdt_id' class='select-a' onchange='fnChangeTimeLimit(this.selectedIndex)'></select>");
				out.println("</td><td>要求完成工作日:<input type='text' class='text-line' name='pc_timelimit' size='4' readonly>天");
				out.println("</td></tr></table></td></tr>");
			}
			%>
			<tr>
			<td>
				<table>
				<tr><td>协办部门具体意见:</td></tr>
				<tr><td>
				<textarea class="text-line" name="co_corropioion" cols="100%" rows=5
				<%
				if(!optype.equals("Recorr")&&!optype.equals("dealwith"))   out.println("readonly");
				%>
				><%=co_corropioion%></textarea>
				</td></tr>
				</table>
			</td>
			</tr>
			<tr align="center" width="100%">
			<td>
			<input class="bttn" type="button" name="pass" value="通过" onclick="checkRecorr(0)"
			<%
			if(!optype.equals("Recorr")&&!optype.equals("dealwith")) out.println("disabled");
			%>
			>&nbsp;
			<input class="bttn" type="button" name="unpass" value="不通过" onclick="checkRecorr(1)"
			<%
			if(!optype.equals("Recorr")&&!optype.equals("dealwith")) out.println("disabled");
			%>
			>&nbsp;
			<input class="bttn" type="button" name="frozen" value="需补件" onclick="checkRecorr(2)"
			<%
			if(!optype.equals("Recorr")&&!optype.equals("dealwith")) out.println("disabled");
			%>
			>&nbsp;
			<input class="bttn" type="button" name="tempstore" value="暂存" onclick="checkRecorr(3)"
			<%
			if(!optype.equals("Recorr")&&!optype.equals("dealwith")) out.println("disabled");
			%>
			>&nbsp;
			<input type="hidden" name="co_id" value="<%=co_id%>">
			<input type="hidden" name="de_id" value="<%=de_id%>">
			<input type="hidden" name="de_senddeptid" value="<%=de_senddeptid%>">
			<input type="button" name="continue" value="提交并继续协调" class="bttn" onclick="checkCorr(0);"
			<%
			if(!optype.equals("Corr")&&!optype.equals("Corragain")) out.println("disabled");
			%>>&nbsp;
			<input type="button" name="btnsubmit" value="提交并返回" class="bttn" onclick="checkCorr(1);"
			<%
			if(!optype.equals("Corr")&&!optype.equals("Corragain")) out.println("disabled");
			%>>&nbsp;
			<input type="hidden" name="wo_id" value="<%=wo_id%>">
			<input type="hidden" name="pr_id" value="<%=pr_id%>">
			<input type="hidden" name="OPType" value="<%=optype%>">
			<input type="hidden" name="de_senddeptid" value="<%=de_senddeptid%>">
			<input type="button" name="back" value="返回" class="bttn"
			<%
			if(optype.equals("fdsign"))
			out.println("onclick='backto();'");
			else out.println("onclick='window.close();history.back(-1);'");
			%>
			>
			</td>
			</tr>
	</table>
	</td>
	</tr>
</form>
</table>
<SCRIPT event=onload for=window language="JavaScript">
        for(var i=0;i<dt_name.length;i++)
        {
          var oOption = document.createElement("OPTION");
          oOption.text=dt_name[i];
          oOption.value=dt_id[i];
		  if(typeof(document.all.corrdt_id)!="undefined")
		{
          document.all.corrdt_id.add(oOption);
		}
        }
</script>
<script language="javascript">
function fnChangeTimeLimit(iIndex)
{
  document.all.pc_timelimit.value = pc_timelimit[iIndex];
}

function checkCorr(choice)
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
	if(formData.corrdt_id.value=="0")
	{
		alert("请选择协办部门!");
		formData.corrdt_id.focus();
		return false;
	}
	formData.action="/system/app/cooperate/CorrResult.jsp?choice="+choice;
	//formData.target="_self";
	formData.submit();
}
</script>
<script>
function checkRecorr(choice)
{
	if((choice==0||choice==1)&formData.co_corropioion.value=="")
	{
		alert("请填写协办部门意见!");
		formData.co_corropioion.focus();
		return false;
	}
	else if(choice!=2)
	{
		formData.action="/system/app/cooperate/ReCorrResult.jsp?choice="+choice;
		formData.submit();
	}

	if(choice==2)
	{
		var w=500;
		var h=300;
		var url="/system/app/cooperate/Frozen.jsp?OPType=Frozen&co_id=<%=co_id%>&de_id=<%=de_id%>&de_senddeptid=<%=de_senddeptid%>";
		window.open(url,"需补件理由","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
	}
}
</script>
<script>
function backto()
{
	window.location.href="/system/app/docexchange/CorrExchange.jsp";
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
<%@include file="../skin/bottom.jsp"%>
