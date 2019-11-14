<%@page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/pophead.jsp"%>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
String oe_otherpro="";
String sql_content  = "select DISTINCT oe_otherpro from tb_onlineevaluate";
%>
<table class="main-table" width="100%">
<tr>
<td>
	<table class="content-table" width="100%">
	<form name="formData">
	<tr class="title1">
	<td align="center">
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		<tr width="100%" align="center">
		<td width="15%" valign="center" colspan=2><font size="3"><b>其他职业</b></font></td>
		</tr>
		<%
		Vector vector_message=dImpl.splitPage(sql_content,request,20);
		if(vector_message!=null)
		{
			for(int i=0;i<vector_message.size();i++)
			{
				Hashtable content = (Hashtable)vector_message.get(i);
				oe_otherpro=content.get("oe_otherpro").toString();
				if(i%2==0)
				out.println("<tr class=\"line-even\">");
		%>
		 
	     	<td align="center" width="50%"><%=oe_otherpro%></td>
		<%
		if(i%2==1)
		out.println("</tr>");
			}
	      //out.println("<tr><td colspan=10>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
		}
       else
      {
          out.println("<tr><td colspan=10>没有记录！</td></tr>");
      }
  		%>
		</table>
	</td>
	</tr>
	
	</form>
	</table>
</td>
</tr>
</table>

<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/popbottom.jsp"%>
