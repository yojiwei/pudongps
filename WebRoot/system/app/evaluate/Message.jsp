<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
String em_id="";
String em_workcontent="";
String em_applypeople="";
String em_idea="";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String sql_massage = " select * from tb_examine  where em_workcontent is not null or em_idea is not null order by em_id desc";
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
                      	  <td valign="center" width="15%">评议留言列表</td>
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
            		<td width="15%" class="outset-table" align="center">办理内容</td>
            		<td width="10%" class="outset-table" align="center">表扬或批评</td>
					<td width="10%" class="outset-table" align="center">意见和建议</td>
            		<td width="10%" class="outset-table" align="center">查看</td>
            		<td width="10%" class="outset-table" align="center">删除</td>
			</tr>
		<%
		Vector vector_message=dImpl.splitPage(sql_massage,request,20);
		if(vector_message!=null)
		{
			for(int i=0;i<vector_message.size();i++)
			{
				Hashtable content = (Hashtable)vector_message.get(i);
				em_id=content.get("em_id").toString();
				em_workcontent=content.get("em_workcontent").toString();
				em_idea=content.get("em_idea").toString();
				em_applypeople=content.get("em_applypoeple").toString();
				
				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 
	     	<td align="center"><%=em_workcontent%></td>
	     	<td align="center"><%=em_applypeople%></td>
			<td align="center"><%=em_idea%></td>
	     	<td align="center" style="cursor:hand" onclick="openwindow('<%=em_id%>')">查看</td>
	     	<td align="center" style="cursor:hand" onclick="fndel('<%=em_id%>')">删除</td>
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
<script>
function openwindow(oe_id)
{
	var url="/system/app/evaluate/MessageInfo.jsp?oe_id="+oe_id;
	window.location.href=url;
}
function fndel(em_id)
{
	var delurl="/system/app/evaluate/MessageDel.jsp?em_id="+em_id;
	if (window.confirm('确定要删除吗？'))
	{
		window.location.href=delurl;
	}	
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
<%@include file="/system/app/skin/bottom.jsp"%>