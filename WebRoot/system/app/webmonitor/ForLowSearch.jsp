<%@ page contentType="text/html;charset=gb2312" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
        //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

		String dt_id = "";
		String dt_name = "";
		String sqlStr = "";
		Vector vPage = null;
%>
<table width="100%" border="1" align="center">
<form name="searchform" method="post" action="ForLow.jsp">
	<tr class="line-even" width="100%">
                <td width="45%" align="right">选择单位：</td>
                <td align="left"><select class="select-a" name="commonWork">
                        <%
                        sqlStr = "select * from tb_deptinfo where dt_iswork=1 order by dt_id";
                        vPage = dImpl.splitPage(sqlStr,request,100);
                        if (vPage!=null)
                        {
                                for(int i=0;i<vPage.size();i++)
                                {
                                        Hashtable content = (Hashtable)vPage.get(i);
                                        dt_id = content.get("dt_id").toString();
                                        dt_name = content.get("dt_name").toString();
                                        %>
                                        <option value="<%=dt_id%>"><%=dt_name%></option>
                                        <%
                                }
                        }
                        %>
                        </select>
                </td>
	</tr>
	<tr>
			<td align="center" colspan="2">
				<input type=submit name=b1 value="浏览" class="bttn" >&nbsp;&nbsp;&nbsp;
				<input type="button" name=b2 value="下载Excel" class="bttn" onclick="fndown(document.searchform)">
				<input type=hidden name="down" value="">
			</td>
	</tr>
</form>
</table>
<script language="javascript">
function fndown(form)
{
	form.down.value="download";
	form.submit();
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