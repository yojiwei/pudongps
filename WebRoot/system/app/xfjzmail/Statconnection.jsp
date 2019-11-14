<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../infopublish/common/common.js"></script>
<%
 //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String strTitle ="";

String strDt = "";
String sqlStr_dt = "";
String dt_id = "";
String cp_id_conn="";
String cp_name_conn="";
String cw_trans_id ="";
 
   Vector vPage = dImpl.splitPage(sqlStr_dt,request,200);
             if (vPage!=null)
             {
				 for (int i=0;i<vPage.size();i++)
				 {
					Hashtable content = (Hashtable)vPage.get(i);
					strDt +="<option value='" + content.get("dt_id").toString() + "'>" + content.get("dt_name").toString() + "</option>";
				 }
			 }
%>

<table class="main-table" width="100%">
<form name="formData" method="post" action="StatConnlist.jsp">
             

            <tr class="line-odd">
		<td width="15%" align="right">申请时间</td>
		<td align="left"><input name="beginTime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()">
				&nbsp;至&nbsp;<input style="cursor:hand" name="endTime" class="text-line" readonly size="10" onclick="showCal()"></td>
	    </tr>
		 <tr class="line-odd">
		<td width="15%" align="right">部门名称</td>
		<td align="left">
		 <select name="dt_id" onchange='setValue11();'>
                                     <option value="">请选择委办局</option>
                                     
                                 <%
                                      String Sql_class = "select dt_id,cp_id,cp_name from tb_connproc where cp_upid='o7' order by dt_name";
                                      Vector vPage1 = dImpl.splitPage(Sql_class,request,100);
                                      if (vPage1!=null)
                                      {
                                       for(int i=0;i<vPage1.size();i++)
                                      {
                                       Hashtable content1 = (Hashtable)vPage1.get(i);
									   dt_id = content1.get("dt_id").toString();
                                       cp_id_conn = content1.get("cp_id").toString();
                                       cp_name_conn = content1.get("cp_name").toString();
                                      %>
                                      <option value="<%=dt_id%>" <%=cw_trans_id.equals(cp_id_conn) ? "selected" : ""%>><%=cp_name_conn%></option>
                                      <%
                                       }
                                       }
                                      %>
                  </select>
		</td>
	    </tr>
            <tr class="title1">
                <td align="right" width="100%" colspan="2">
                    <p align="center">
                    <input type="button" class="bttn" value=" 确 定 " name="fsubmit" onclick="fnsubmit(1);">
                    <input type="button" class="bttn" value=" 返 回 " name="freturn" onclick="history.go(-1);"></p>
               </td>
            </tr>
</form>
</table>

<script language="javascript">
function fnsubmit(flag)
{
	if(flag==2)
	{
		document.formData.action="StatConnlist_Excel.jsp";
	}
	else
	{
		document.formData.action="StatConnlist.jsp";
	}
	document.formData.submit();
}
</script>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>

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