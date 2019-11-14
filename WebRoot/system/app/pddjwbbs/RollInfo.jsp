<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String ro_id="";
String ro_content="";
String OPType = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn("pddjw");
dImpl = new CDataImpl(dCn);
//
OPType = CTools.dealString(request.getParameter("OPType")).trim();
ro_id = CTools.dealString(request.getParameter("ro_id")).trim();

if(OPType.equals("Edit"))
{
	String sql="select ro_id,ro_content from forum_roll where ro_id='"+ro_id+"'";
	
	Hashtable content=dImpl.getDataInfo(sql);
	ro_content = content.get("ro_id").toString();
	ro_content = content.get("ro_content").toString();

}
%>

<script>
    function check()
    {
      if(formData.ro_content.value=="")
      {
				alert("滚动内容不能为空！");
				formData.ro_content.focus();
        return false;
      }
      document.formData.submit();
   }
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
滚动标题信息维护
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form action="RollInfoResult.jsp" method="post" name="formData">
    <tr>
     <td width="100%">
		<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
					<tr class="line-even">
	  	    		<td width="15%" align="right">标题：</td>
	  	    		<td width="85%"><textarea name="ro_content" cols="50" rows="4" class="text-line"><%=ro_content%></textarea>
					<font color="#FF0000">*</font>
					</td>
		       </tr>
	  		</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
        	<input type="hidden" name="optype" value="<%=OPType%>"/>
        	<input type="hidden" name="ro_id" value="<%=ro_id%>"/>
          <input class="bttn" value="提交" type="button" onclick="check();" size="6" name="btnSubmit">&nbsp;
          <input class="bttn" value="重置" type="reset" size="6" >&nbsp;
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
        </td>
      </tr>
    </table>
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
                                     
