<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
发送邮件
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
					<form name="formData" method="post"  action="sendInfoResult.jsp">
					<tr class="line-odd">
					<td  class="">主题</td>
					<td align="left"><input type="text" name="subject" value="" size="280px" style="width:280px;height:22px;"/><font color="red">*</font></td>
				   </tr>
				   <tr class="line-even">
					<td  class="">内容</td>
					<td align="left"><textarea name="bodycontent" value="" style="height:180px;width:400px"></textarea><font color="red">*</font></td>
				   </tr>
					 <tr class=outset-table>
					 <td width="100%" align="right" colspan="2">
						 <p align="center">
						<input class="bttn" value="发送" type="button"  size="6"  onclick="gourl();">&nbsp;
						<input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onclick="javascript:history.go(-1)">
					</td>
					</tr>
                   </form>
 </table>
<script>
	function gourl()
	{
		if(formData.subject.value=="")
		{
			alert("输入邮件主题!");
			return false;
		}
		if(formData.bodycontent.value=="")
		{
			alert("输入邮件内容!");
			return false;
		}
		formData.submit();
	}
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
                                     
