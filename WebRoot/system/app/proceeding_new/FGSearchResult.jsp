<%@ page contentType="text/html;charset=GBK" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="java.text.*"%>

<title>相关法规列表</title>

<script language="javascript">
function tj()
{
 //formData.submit();
//window.opener=null;window.open('','_self','');window.close();
	//var obj = document.getElementById("fagui");
	var obj = document.all.fagui;
	var returnValue = "";
	//alert(obj.length);
	if(obj.length==undefined){
		if(obj.checked) returnValue = obj.value;
	}else{
		for(i=0; i<obj.length; i++){
			//alert(obj[i].value)
			if(obj[i].checked){
				//alert();
				returnValue = returnValue + obj[i].value + ",";
			}
		}
	}
	opener.a(returnValue);
	window.close();
	//alert(returnValue);
}
</script>
<body>
<%
CDataCn dCn=null;
CDataImpl dImpl=null;
Hashtable content =null;
String key = request.getParameter("key");
key = new String(key.getBytes("ISO-8859-1"), "GB2312");
String sql = "select c.ct_title,c.ct_id from tb_content c,tb_contentpublish p,tb_subject s where c.ct_id = p.ct_id and p.sj_id = s.sj_id and s.sj_id in( select sj_id from tb_subject s connect by prior s.sj_id = s.sj_parentid start with s.sj_dir='govOpenGz') and c.ct_title like '%"+key+"%' order by c.ct_id desc ";

	//out.print(sql);
%>
<form name="formData" action="ProceedingInfo.jsp" >
<table width="100%" class="table_main">
			<tr><td><table cellpadding="3" width="100%" align="center">
		<%
		Vector vectorPage = null;
		try{
			dCn=new CDataCn();
			dImpl=new CDataImpl(dCn);
			vectorPage = dImpl.splitPage(sql,request,1000);
			if(vectorPage!=null)
			{
				for(int j=0;j<vectorPage.size();j++)
				{
					content = (Hashtable)vectorPage.get(j);
					%>
				<tr class="line-<%=(j%2==0)?"odd":"even"%>" width="100%">
					<td width="10%" align="center"><input type="checkbox" ID="fagui" value="<%=content.get("ct_id").toString()%>"></td>
					<td align="left"><%=content.get("ct_title").toString()%></td>
				</tr>
				<%
				}
			}
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
		
		<tr class="line-odd" width="100%">
		<td colspan="2" align="right"><%//=dImpl.getTail(request)%></td>
		</tr>
		<tr class="line-odd" width="100%">
		<td colspan="3" align="center">
		  <input type="button" onclick="tj()" name="Submit" value="提交" />&nbsp;&nbsp;&nbsp;<input type="reset"  name="reset" value="重置" />&nbsp;&nbsp;&nbsp;<input type="button" onclick="window.close();" name="close" value="关闭" /></td>
		</tr>
	
			</table></td></tr></table>
			</form>
<%@include file="/system/app/skin/bottom.jsp"%>
