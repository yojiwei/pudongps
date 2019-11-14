<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String optype="";
String pc_id="";
String stroptype="";
String pr_id="";
optype = CTools.dealString(request.getParameter("OPType")).trim();
pc_id = CTools.dealString(request.getParameter("pc_id")).trim();
pr_id = CTools.dealString(request.getParameter("pr_id")).trim();
String dt_id="";
String pc_timelimit="";
String dt_name="";

if(optype.equals("Edit"))
{
	stroptype="修改部门信息";
}
else 
{
	stroptype="新增协办部门";
}
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
if(optype.equals("Edit"))
{
	String sqlInfo = " select x.pc_timelimit,y.dt_name,x.dt_id from tb_proceedingcorr x,tb_deptinfo y where  x.pc_id='"+pc_id+"' and x.dt_id=y.dt_id ";
	Hashtable contInfo=dImpl.getDataInfo(sqlInfo);
	pc_timelimit = contInfo.get("pc_timelimit").toString();
	dt_name = contInfo.get("dt_name").toString();
	dt_id = contInfo.get("dt_id").toString();
}

String sqlDept = " select distinct x.dt_id,x.dt_name,x.dt_sequence from tb_deptinfo x,tb_proceeding_new y where x.dt_id=y.dt_id and x.dt_iswork='1' order by x.dt_sequence ";

%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=stroptype%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<tr>
<td>
<form method="post" name="formData" action="CorrDeptInfoResult.jsp">
  <tr>
     <td width="100%">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	 		 <tr class="line-even" >
           				 <td width="19%" align="right">协办部门名称：</td>
            				 <td width="81%" >
							 <select name="dt_id" class="select-a">
							 <option value="0">请选择部门</option>
							 <%
								Vector vectorDept = dImpl.splitPage(sqlDept,1000,1);
								if(vectorDept!=null)
								{
									for(int i=0;i<vectorDept.size();i++)
									{
										Hashtable contDept = (Hashtable)vectorDept.get(i);
							%>
							<option value="<%=contDept.get("dt_id").toString()%>" 
							<%
								if(dt_id.equals(contDept.get("dt_id").toString()))
								{
									out.println("selected");
								}
							%>
							>
							<%=contDept.get("dt_name").toString()%>
							</option>
							<%
									}
								}
							 %>
							 </select>
          			 </tr>
					 			<tr class="line-even" >
           				 <td width="19%" align="right">该部门时限：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="45" name="pc_timelimit" maxlength="150"  value="<%=pc_timelimit%>" ></td>
          			 </tr>
			</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="title1">
        <td width="100%" align="center">
          <input class="bttn" value="提交" type="button" size="6" name="btnSubmit" onclick="check();">&nbsp;
		  <%if(optype.equals("Edit")){%>
		  <input class="bttn" value="删除" type="button" size="6" name="btnSubmit" onclick="del();">&nbsp;
		  <%}%>
      <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >
		  <INPUT TYPE="hidden" name="OPType" value="<%=optype%>">
      <INPUT TYPE="hidden" name="pc_id" value="<%=pc_id%>">
			<input type="hidden" name="pr_id" value="<%=pr_id%>">
        </td>
      </tr>
    </table>
    </td>
  </tr>
</form>
</td>
</tr>
</table>
<script>
function selectproceeding()
{
	var w=300;
	var h=400;
	var url="SelectProceeding.jsp";
	window.open(url,"网上办事事项列表","top=250px,left=500px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=no");
}
function check()
{
	if(formData.dt_id.value == "0")
	{
		alert("请选择协办部门!");
		formData.dt_id1.focus();
		return false;
	}
	
	if(formData.pc_timelimit.value=="")
	{
		alert("请输入办事时限!");
		formData.pc_timelimit.focus();
		return false;
	}
	formData.submit();
}
function del()
{
	if(confirm("确认删除该协办部门?"))
	{
		window.location.href("/system/app/corrdeptmanage/CorrDeptDel.jsp?OPType=Del&pr_id=<%=pr_id%>&pc_id=<%=pc_id%>");
	}
}
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
