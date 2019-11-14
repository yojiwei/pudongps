<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
普通用户查询
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form name="formData" method="post" action="UserList.jsp"  target="">
  <tr>
     <td width="100%">
         <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">用户名：
            </td>
            <td width="81%" align="left" ><input type="text" class="text-line" size="50" name="us_uid" maxlength="150"   >
            </td>
          </tr>
          <tr class="line-odd">
            <td width="19%" align="right" >用户姓名：
            </td>
            <td width="81%"  align="left"><input type="text" class="text-line" size="50" name="us_name" maxlength="150"  >
            </td>
          </tr>
		 <tr class="line-even">
            <td width="19%" align="right" >用户类型：
            </td>
            <td width="81%" align="left" >
	        <select name="us_type" class="select-a">
			<option value="0">所有类型</options>
					<%
						String sql="select uk_id,uk_name from tb_userkind order by uk_sequence";
						Vector vectorPage=dImpl.splitPage(sql,request,20);
							if(vectorPage!=null)
							{
							for(int i=0;i<vectorPage.size();i++)
							{
							Hashtable content = (Hashtable)vectorPage.get(i);
							%>
							<option value="<%=content.get("uk_id")%>"><%=content.get("uk_name")%></options>
							<%
							}
						}
					%>
			</select>
            </td>
          </tr>
		  <tr class="line-odd">
            <td width="19%" align="right" >email：
            </td>
            <td width="81%"  align="left"><input type="text" class="text-line" size="50" name="us_email" maxlength="150"  >
            </td>
          </tr>
		<tr class="line-even">
            <td width="19%" align="right" >联系电话：
            </td>
            <td width="81%" align="left" ><input type="text" class="text-line" size="50" name="us_tel" maxlength="20"  >
            </td>
          </tr>
		<tr class="line-odd">
            <td width="19%" align="right" >联系地址：
            </td>
            <td width="81%"  align="left"><input type="text" class="text-line" size="50" name="us_address" maxlength="150"  >
            </td>
        </tr>
		<tr class="outset-table" align="center">
		 <td colspan="2">
			<input type="submit" class="bttn" value="查 询" >&nbsp;
			<input type="reset" class="bttn"  value="重 写">&nbsp;
			<input type="hidden" name="OPType" value="Search">
			<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
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
                                     
