<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String wk_id = "";
String sql = "";
String sql_judge = "";
String sqlStr = "";
String sqlCorr = "";
String wk_name = "";
String actiontype="add";
String wk_parameter = "";
Vector vPage = null;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String strTitle="新增类型";
wk_id=CTools.dealString(request.getParameter("wk_id"));
if(!wk_id.equals(""))
{
    sql = "select wk_id,wk_name,wk_parameter from tb_workkind where wk_id = '" + wk_id + "'";
       Hashtable content = dImpl.getDataInfo(sql);
       if (content!=null)
       {
         wk_id = content.get("wk_id").toString();
         wk_name = content.get("wk_name").toString();
         wk_parameter = content.get("wk_parameter").toString();
         actiontype = "modify";
         strTitle = "编辑类型";
        }
 }
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle %>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" BORDER="0">
<form action="WorkKindResult.jsp" method="post" name="formData">
      <tr class="line-even">
        <td width="40%" align="right">类别名称：</td>
		<td width="60%" align="left" ><input  type="text" name="wk_name" value="<%=wk_name%>" maxlength="50" class="text-line" size="30"></td>
      </tr>
      <tr class="line-even">
        <td align="right">参数设置：</td>
		<td align="left"><input type="text" name="wk_parameter" value="<%=wk_parameter%>" maxlength="100" class="text-line" size="30"></td>
      </tr>
      <tr class=outset-table>
    <td align=center colspan=2>
    <input type=button name=b1 value="提交" class="bttn" onClick="doAction()">&nbsp;
    <%
	if(!wk_id.equals(""))
	{
	%>
	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
    <%
	}
	if(wk_id.equals(""))
	{
	%>
	<input type=reset name=b1 value="重填" class="bttn">
	<%
	}	
	%>
	<input value="返回" class="bttn" onclick="javascript:history.go(-1);" type="button" size="6">&nbsp;
  </td>
 </tr>

<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=wk_id value=<%=wk_id%>>
</form>
</table>
<script language="javascript">
  function doAction() {
  	var form1 = document.formData;
  	if (form1.wk_name.value == "" || chkKong(form1.wk_name.value) == false) {
  		alert("请输入类别名称！");
  		form1.wk_name.focus();
  		return false
  	}
  	if (form1.wk_parameter.value == "" || chkKong(form1.wk_parameter.value) == false) {
  		alert("请输入参数设置！");
  		form1.wk_parameter.focus();
  		return false
  	}
  	form1.submit();
  }
  //判定是否以空作为组成内容,是返回fasle,否则返回true
	function chkKong(obj) {
		if (obj.length == 0) return false;
		var bool = 0;
		for (var i = 0;i < obj.length;i++) {
			if (obj.substring(i,i+1) == " ") {
				bool = 1;
			}
			else {
				bool = 0;
				return true;
				break;
			}
		}
		if (bool == 1) {
			//alert("不能以空作为内容！");
			return false;
		}
	}
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="WorkKindDel.jsp?wk_id=<%=wk_id%>";
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
                                     
