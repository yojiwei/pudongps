<%@ page contentType="text/html; charset=GBK" %>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String optype="";
String stroptype="";
String gv_id="";
String gv_name="";
String gv_sequence="";

optype=CTools.dealString(request.getParameter("OPType")).trim();
gv_id=CTools.dealString(request.getParameter("gv_id")).trim();

if(optype.equals("Edit"))
{
stroptype="修改内容";
String sql_edit = " select gv_id,gv_name,gv_sequence from tb_govinfo where gv_id='"+gv_id+"' ";
Hashtable content=dImpl.getDataInfo(sql_edit);
if(content!=null)
{
	gv_name=content.get("gv_name").toString();
	gv_sequence=content.get("gv_sequence").toString();
}
}
else
{
stroptype="新增对象";
}
%>
<table width="100%" class="main-table">
<tr>
<td>
<form method="post" name="formData" action="GovInfoResult.jsp">
    <tr class="title1" align=center>
      	<td><%=stroptype%></td>
    </tr>
    <tr>
     <td width="100%">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	 		 <tr class="line-even" >
           				 <td width="19%" align="right">评议对象名称：</td>
            				 <td width="81%" >
            				 	<input type="text" name="gv_name" class="text-line" size="20" value="<%=gv_name%>" maxlength="50">
					 </td>			 
          			 </tr>
                     
				 <tr class="line-even" >
           				 <td width="19%" align="right">序列号：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="10" name="gv_sequence"  value="<%=gv_sequence%>" >
            				 </td>
          			 </tr>

			</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="title1">
        <td width="100%" align="center">
          <input class="bttn" value="提交" type="button" size="6" name="btnSubmit" onclick="check();">&nbsp;
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >
	  <INPUT TYPE="hidden" name="OPType" value="<%=optype%>">
          <INPUT TYPE="hidden" name="gv_id" value="<%=gv_id%>">
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
function check()
{
	if(formData.gv_name=="")
	{
		alert("请填写名称!");
		formData.gv_name.focus();
		return false;
	}
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
<%@include file="../skin/bottom.jsp"%>