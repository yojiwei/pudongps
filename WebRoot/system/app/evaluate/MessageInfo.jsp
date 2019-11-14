<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
String em_id=CTools.dealString(request.getParameter("oe_id")).trim();
String em_workcontent="";
String em_workdept="";
String em_workstation="";
String em_applypeople="";
String em_idea="";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sql_message = " select * from tb_examine  where em_id='" + em_id + "'";
Hashtable content = dImpl.getDataInfo(sql_message);
if(content!=null)
{
	em_workcontent = content.get("em_workcontent").toString();
	em_workdept = content.get("em_workdept").toString();
	em_workstation = content.get("em_workstation").toString();
	em_applypeople = content.get("em_applypoeple").toString();
	em_idea = content.get("em_idea").toString();
}
%>

<table class="main-table" width="100%">
    <tr>
  	<td width="100%">
       	<table class="content-table" width="100%">
        	<tr class="title1">
            	<td colspan="10" align="center">
                	评议留言内容
				</td>
			</tr>
			<tr class="line-even">
            		<td width="35%" align="right">办理的内容：</td>
            		<td width="65%" align="left"><%=em_workcontent%></td>
			</tr>
			<tr class="line-odd">
            		<td width="35%" align="right">涉及部门：</td>
            		<td width="65%" align="left"><%=em_workdept%></td>
			</tr>
			<tr class="line-even">
            		<td width="35%" align="right">涉及岗位：</td>
            		<td width="65%" align="left"><%=em_workstation%></td>
			</tr>
			<tr class="line-odd">
            		<td width="35%" align="right">表扬或提出批评的部门、工作人员：</td>
            		<td width="65%" align="left"><%=em_applypeople%></td>
			</tr>
			<tr class="line-even">
            		<td width="35%" align="right">意见和建议：</td>
            		<td width="65%" align="left"><%=em_idea%></td>
			</tr>
    </table>
    </td>
    </tr>
	<tr class=title1>
	<td>
		<input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
	</td>
	</tr>
</table>
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