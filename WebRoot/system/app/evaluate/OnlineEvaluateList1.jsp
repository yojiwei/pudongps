<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String gv_name="";
String gv_id="";
String gv_sequence="";
String oe_totalimpress="";
String oe_id="";
String oe_govstyle="";
String oe_executebehavior="";
String oe_supervised="";
String oe_efficiency="";
String oe_probity="";
String oe_serve="";
String oe_practice="";
String oe_workfunction="";
String oe_workstyle="";
String oe_govstyleproblem="";
String sql_govlist = " select gv_id,gv_name,gv_sequence from tb_govinfo order by gv_sequence ";

%>

<table class="main-table" width="100%">
    <tr>
  	<td width="100%">
       	<table class="content-table" width="100%">
        <form name="formData">
        	<tr class="title1">
            	<td colspan="10" align="center">
                	<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                  	  <tr width="100%">
                      	  <td valign="center" width="15%">网上评议情况列表</td>
                          <td valign="center" align="right" nowrap>
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            
                            <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
						  </td>
					 </tr>
					</table>
				</td>
			</tr>
			<tr class="bttn">
            		<td width="15%" class="outset-table" align="center">评议对象</td>
            		<td width="10%" class="outset-table" align="center">统计结果</td>
					
			<td width="10%" class="outset-table" align="center">排序</td>
			</tr>
		<%
		Vector vector_govlist=dImpl.splitPage(sql_govlist,request,20);
		if(vector_govlist!=null)
		{
			for(int i=0;i<vector_govlist.size();i++)
			{
				Hashtable content = (Hashtable)vector_govlist.get(i);
				gv_name=content.get("gv_name").toString();
				gv_id=content.get("gv_id").toString();
				gv_sequence=content.get("gv_sequence").toString();
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 
	     	<td align="center"><%=gv_name%></td>
	     	<td align="center">
	     	<a href="/system/app/evaluate/Statistic.jsp?gv_id=<%=gv_id%>">查看</td>
		<td align="center"><%=gv_sequence%></td>
		 </tr>
		 </form>
		<%
			}
	      out.println("<tr><td colspan=10>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
		}
       else
      {
          out.println("<tr><td colspan=10>没有记录！</td></tr>");
      }
  		%>
    </table>
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