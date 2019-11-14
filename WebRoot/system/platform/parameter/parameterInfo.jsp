<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="预设参数" ;%>
<%@include file="../head.jsp"%>
<%
String sql="";//查询条件
String OPType="";//操作方式 Add是添加 Edit是修改
String strId="";//编号
String strPname="";//参数名称
String strPvalue="";//参数值
String strMemo = "";//备注信息

OPType=CTools.dealString(request.getParameter("OP")).trim();//得到操作方式
strId=CTools.dealString(request.getParameter("strId")).trim();//得到编号

if (OPType.equals("Edit"))
{
sql="select * from tb_initparameter where ip_id=" + strId;
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
Hashtable content=dImpl.getDataInfo(sql);
strPname=content.get("ip_name").toString() ;
strPvalue=content.get("ip_value").toString() ;
strId=content.get("ip_id").toString();
strMemo=content.get("ip_memo").toString();

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
}
%>
<script LANGUAGE="javascript">
<!--
function check()
{
	var form = document.formData ;
	if	 (form.IP_name.value =="")
	{
		alert("请填写预设参数的名称！");
		form.IP_name.focus();
		return false;
	}
	form.submit();
}


//-->
</script>
<form action="parameterResult.jsp" method="post" name="formData">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
   <tr>
        <td width="100%" align="left" valign="top">

	  	<table class="content-table" height="" width="100%">
            <tr class="title1">
              <td align="center" colspan=2><%=strTitle %> </td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">名称：</td>
              <td width="82%"><input class="text-line" name="IP_name"  size="20" value="<%=strPname %>"  maxlength="20"></td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">值：</td>
              <td width="82%"><input class="text-line" name="IP_value"  size="40" value="<%=strPvalue %>"  maxlength="100"></td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">备注：</td>
              <td width="82%"><textarea class="text-line" name="IP_memo" cols="40" rows="6"><%=strMemo%></textarea></td>
            </tr>
          </table>
        </td>
      </tr>

		<tr class=title1>
		  <td width="100%" align="right" colspan="2">
		  <input  type="hidden" name="strId" value="<%=strId%>">


		      <p align="center">
<%
				if (OPType.equals("Add"))
				{
%>
                    <input class="bttn" value="提交" type="button" onclick="javascript:check()" size="6" id="button2" name="button2">&nbsp;
					<input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onclick="javascript:history.go(-1)">
					<INPUT TYPE="hidden" name="OPType" value="Add">

<%
				}
				else
				{
%>
		  			<input class="bttn" value="修改" type="button" onclick="javascript:check()" size="6" id="button4" name="button4">&nbsp;
		  			<input  class="bttn" value="删除" type="button" onclick="javascript:del(<%=strId%>)" size="6" id="button4" name="button4">&nbsp;
		  			<input class="bttn" value="返回" type="button"  size="6" id="button5" name="button5" onclick="javascript:history.go(-1)">&nbsp;
					<INPUT TYPE="hidden" name="OPType" value="Edit">
<%
				}
%>
        </td>
		</tr>
    </table>
	</form>
<SCRIPT LANGUAGE=javascript>
<!--
function del(strId)
{
	//alert("haha");
var url="parameterDel.jsp?strId="+strId;
//alert(url);
if (confirm("确定要删除该纪录吗？"))
	{
		window.location=url;
	}
}
//-->
</SCRIPT>

<%@include file="../bottom.jsp"%>