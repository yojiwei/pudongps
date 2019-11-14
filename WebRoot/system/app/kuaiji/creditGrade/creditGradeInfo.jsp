<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript">

function checkform(rd)
{
	var form = document.formData ;

	if	 (form.cg_ep_name.value =="")
	{
		alert("请填写单位名称!");
		form.cg_ep_name.focus();
		return false;
	}
	if	 (form.cg_grade.value =="")
	{
		alert("请填写财务会计信用等级!");
		form.cg_grade.focus();
		return false;
	}
  form.action = "creditGradeResult.jsp?rd="+rd;
  form.target = "_self";
	form.submit();
}
function del1(cg_id)
{
  var con;
  con=confirm("真的要删除吗？");
  if (con)
  {
	var form = document.formData ;
	form.action = "creditGradeDel.jsp?cg_id="+cg_id;
	form.submit();
  }
}

</script>
<%
String strTitle="添加财务会计信用等级单位" ;
String sql                 = "";//查询条件
String OPType              = "";//操作方式 Add是添加 Edit是修改
String cg_id               = "";//主键
String cg_ep_name          = "";//单位名称
String cg_ep_kind          = "";//企业类型
String cg_ep_code = "";         //主管部门
String cg_sequence         = "";//排序
String cg_grade            = "";//财务会计信用等级

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

/*得到上一个页面传过来的参数  开始*/
cg_id=CTools.dealString(request.getParameter("cg_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();

//System.out.println(sj_id);
/*得到上一个页面传过来的参数  结束*/

if (OPType.equals("Edit"))
{
	strTitle = "编辑财务会计信用等级单位";
sql="select * from tb_kjcreditgrade where cg_id = " + cg_id;
Hashtable content=dImpl.getDataInfo(sql);
cg_id               = CTools.dealNull(content.get("cg_id"));//主键
cg_ep_name          = CTools.dealNull(content.get("cg_ep_name")) ;//单位名称
cg_ep_kind          = CTools.dealNull(content.get("cg_ep_kind")) ;//企业类型
cg_ep_code				  = CTools.dealNull(content.get("cg_ep_code")) ;//主管部门
cg_sequence         = CTools.dealNull(content.get("cg_sequence")) ;//排序
cg_grade            = CTools.dealNull(content.get("cg_grade"));//财务会计信用等级
}

String [] gd = new String[5];
if (cg_grade.equals("A"))
{
	gd[1] = "selected";
}
else if (cg_grade.equals("B"))
{
	gd[2] = "selected"; 
}
else if (cg_grade.equals("C"))
{
	gd[3] = "selected"; 
}
else if (cg_grade.equals("D"))
{
	gd[4] = "selected"; 
}
else
{
	gd[0] = "selected"; 
}


dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%">
<form name="formData" method="post" action="creditGradeResult.jsp">
  <tr>
     <td width="100%">
         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">单位名称：</td>
            <td width="81%"  align="left"><input type="text" class="text-line" size="45" name="cg_ep_name" maxlength="150"  value="<%=cg_ep_name%>" ><font color=red>*</font></td>
          </tr>
          <tr class="line-odd">
            <td width="19%" align="right">企业类型：</td>
            <td width="81%" align="left"><input type="text" class="text-line" size="45" name="cg_ep_kind" maxlength="150"  value="<%=cg_ep_kind%>" ></td>
          </tr>
          <tr class="line-even">
            <td width="19%" align="right" >主管部门：</td>
            <td width="81%" align="left"><input type="text" class="text-line" size="45" name="cg_ep_code" maxlength="150"  value="<%=cg_ep_code%>">
            </td>
          </tr>
          <tr class="line-odd">
            <td width="19%" align="right" >财务会计信用等级：</td>
            <td width="81%" align="left">
              <select name="cg_grade" class="select-a">
                <option value="" <%=gd[0]%>>请选择</option>
                <option id="1" value="A" <%=gd[1]%>>A类</option>
                <option id="2" value="B" <%=gd[2]%>>B类</option>
                <option id="3" value="C" <%=gd[3]%>>C类</option>
                <option id="4" value="D" <%=gd[4]%>>D类</option>
              </select><font color=red>*</font>
            </td>
          </tr>
          <tr class="line-even">
            <td width="19%" align="right" >排序：</td>
            <td width="81%" align="left"><input type="text" class="text-line" size="4" name="cg_sequence" maxlength="10" value=<%if (cg_sequence.equals("")) {out.print("100");} else {out.println(cg_sequence);}%>>
            </td>
          </tr>
   <tr class="outset-table" align="center">
       <td colspan="2">
<input type="button" class="bttn" name="fsubmit" value="保存并继续发布" onclick="javascript:checkform(1)">&nbsp;
<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
<%
        if (OPType.equals("Add"))
        {
%>
<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
<INPUT TYPE="hidden" name="OPType" value="Add">
<%
        }
        else
        {
%>
   <input type="button" class="bttn" name="del" value="删 除" onclick="javascript:del1(<%=cg_id%>)">&nbsp;
   <INPUT TYPE="hidden" name="OPType" value="Edit">
<INPUT TYPE="hidden" name="cg_id" value=<%=cg_id%>>
<%
    }
%>
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
       </td>
   </tr>
</form>
</table>
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
                                     
