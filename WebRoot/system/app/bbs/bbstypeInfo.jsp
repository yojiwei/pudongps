<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
		String intId;
		String bt_name="";
		String bt_manager="";

		intId=CTools.dealNumber(request.getParameter("intId"));
		if(!intId.equals("0"))
		{
			String strSql="select * from tb_bbstype where bt_id="+intId;
			Hashtable content = dImpl.getDataInfo(strSql);
			bt_name=content.get("bt_name").toString();
			bt_manager=content.get("bt_manager").toString();
		}
%>
<script language=javascript>
function checkform()
{
	if(formData.bt_name.value=="")
	{
		alert("类型名称不能为空!");
		formData.bt_name.focus();
		return false;
	}
	formData.action="bbstypeResult.jsp";
	formData.submit();
}
</script>
<form name=formData method=post>
<input type=hidden name=bt_id value=<%=intId%>>
<table class="main-table" width="100%">
 <tr class="title1" align=center>
      <td>论坛类型</td>
    </tr>
 <tr>
	<td>
	 <table width="100%" class="content-table" height="1">
          <tr class="line-even" >
            <td width="19%" align="right">类型名称：</td>
            <td width="81%" ><input type="text" class="text-line" size="45" name="bt_name" maxlength="100"  value="<%=bt_name%>" >
            </td>
          </tr>
          <!--<tr class="line-odd">
            <td width="19%" align="right" >版主：</td>
            <td width="81%" ><input type="text" class="text-line" size="45" name="bt_manager" maxlength="100" value=""  readonly>
							<input type=button value="请选择..." class=bttn>
            </td>
          </tr>
					-->
			    <tr class="title1" align="center">
						<td colspan=2 align=center>
							<input type="button" class="bttn" name="fsubmit" value="保 存" onclick="javascript:checkform()">&nbsp;
							<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
							<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
						</td>
					</tr>
	</table>
 </td>
</tr>
</table>
</form>

<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>
<%


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
