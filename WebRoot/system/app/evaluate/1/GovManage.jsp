<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String gv_name="";
String gv_id="";
String gv_sequence="";
String sql_govlist = " select gv_name,gv_sequence,gv_id from tb_govinfo order by gv_sequence ";

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
                            <img src="/system/images/new.gif" border="0" onclick="window.location='GovInfo.jsp?OPType=Add'" title="新增" style="cursor:hand" align="middle" WIDTH="16" HEIGHT="16">
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
            		<td width="15%" class="outset-table" align="center">编辑</td>
            		<td width="10%" class="outset-table" align="center">删除</td>
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
	     	<a href="/system/app/evaluate/GovInfo.jsp?OPType=Edit&gv_id=<%=gv_id%>">编辑
	     	</td>
		<td align="center">
		<a href="/system/app/evaluate/GovInfoResult.jsp?OPType=Del&gv_id=<%=gv_id%>"><img class="hand" border="0" src="/system/images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onclick="return window.confirm('确认要删除该记录么?');">
		</a>
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
%>
<%@include file="/system/app/skin/bottom.jsp"%>