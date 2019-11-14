<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String uc_id = CTools.dealString(request.getParameter("uc_id")).trim();
String th_id = "";
String uc_name = "" ;
String uc_address = "" ;
String uc_comment = "" ;
String uc_ipaddress = "" ;
String uc_status = "";
String name = "匿名";

th_id = CTools.dealString(request.getParameter("th_id")).trim();
String strSql = "select uc_id,uc_ipaddress,uc_name,uc_address,uc_comment,uc_status from tb_voteusercomment where uc_id='"+uc_id+"'";
Hashtable content = dImpl.getDataInfo(strSql);
if(content!=null){
	uc_name = content.get("uc_name").toString();
	uc_address = content.get("uc_address").toString();
	uc_comment = content.get("uc_comment").toString();
	uc_ipaddress = content.get("uc_ipaddress").toString();
	uc_status = content.get("uc_status").toString();
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
用户管理
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form  method="post" name="formData">
<div align="center">
 <tr>
  <td width="100%">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  		  <tr class="line-odd">
	  		    <td width="15%" align="right">姓名：</td>
	  		    <td width="85%" align="left"><input type="text" readonly class="text-line" size="20" name="uc_name" value="<%="".equals(uc_name)?name:uc_name%>"></font></td>
	  		  </tr>
			  <tr class="line-even">
	  		    <td width="15%" align="right">IP地址：</td>
	  		    <td width="85%" align="left">
	  		    	<input type="text" name="uc_ipaddress" readonly value="<%=uc_ipaddress%>" class="text-line">
	  		    </td>
	  		  </tr>
	  		  <tr class="line-odd">
	  		    <td width="15%" align="right">联系方式：</td>
	  		    <td width="85%" align="left">
	  		    	<input type="text" name="uc_address" readonly value="<%=uc_address%>" class="text-line">
	  		    </td>
	  		  </tr>
			   <tr class="line-even">
	  		    <td width="15%" align="right">评论内容：</td>
	  		    <td width="85%" align="left">
						<textarea name = "uc_address" readonly style="width:400px;height:100px"><%=uc_comment%></textarea>
	  		    </td>
	  		  </tr>
			</table>
		</td>
	  </tr>
	  <tr class="outset-table">
	    <td width="100%" align="center" colspan="4">
		<%if("".equals(uc_status)){%>
			<input type="button" onclick="javascript:window.location.href='commeninfoDetail.jsp?uc_id=<%=uc_id%>&uc_status=1&th_id=<%=th_id%>'" name="button4" value="审核通过"/>
		<%}else{%>
		<input type="button" onclick="javascript:window.location.href='commeninfoDetail.jsp?uc_id=<%=uc_id%>&th_id=<%=th_id%>'" name="button4" value="审核不通过"/>
		<%}%>
	  		<input class='bttn' value='返回' type='button' onclick='history.back();' size='6' name='button3'>&nbsp;
	    </td>
      </tr>
	</table>
</div>
</td>
</tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
