<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
String em_id="";
String em_workcontent="";
String em_workdept="";
String em_workstation="";
String em_age="";
String em_education="";
String em_dept="";
String em_queation1="";
String em_queation2="";
String em_queation3="";
String em_queation4="";
String em_queation5="";
String em_queation6="";
String em_queation7="";
String em_queation8="";
String em_queation9="";
String em_queation10="";
String em_queation11="";
String em_queation12="";
String em_queation13="";
String em_queation14="";
String em_queation15="";
String em_queation16="";
String em_applypeople="";
String em_idea="";

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
//String sql_massage = " select * from tb_examine  where em_workcontent is not null or em_idea is not null order by em_id desc";
String sql_massage = " select * from tb_examine order by em_id desc";
%>

<table class="main-table" width="100%">
    <tr>
  	<td width="100%">
       	<table class="content-table" width="100%">
        <form name="formData">
        	<tr class="title1">
            	<td colspan="26" align="center">
                	<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                  	  <tr width="100%">
                      	  <td valign="center" width="60%">浦东新区审改效能情况调查问卷-详细投票情况</td>
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
            		<td width="11%" class="outset-table" align="center">办理的内容</td>
            		<td width="11%" class="outset-table" align="center">涉及部门</td>
					<td width="10%" class="outset-table" align="center">涉及岗位</td>
            		<td width="2%" class="outset-table" align="center">1</td>
            		<td width="2%" class="outset-table" align="center">2</td>
            		<td width="2%" class="outset-table" align="center">3</td>
            		<td width="2%" class="outset-table" align="center">1</td>
            		<td width="2%" class="outset-table" align="center">2</td>
            		<td width="2%" class="outset-table" align="center">3</td>
            		<td width="2%" class="outset-table" align="center">4</td>
            		<td width="2%" class="outset-table" align="center">5</td>
            		<td width="2%" class="outset-table" align="center">6</td>
            		<td width="2%" class="outset-table" align="center">7</td>
            		<td width="2%" class="outset-table" align="center">8</td>
            		<td width="2%" class="outset-table" align="center">9</td>
            		<td width="2%" class="outset-table" align="center">10</td>
            		<td width="2%" class="outset-table" align="center">11</td>
            		<td width="2%" class="outset-table" align="center">12</td>
            		<td width="2%" class="outset-table" align="center">13</td>
            		<td width="2%" class="outset-table" align="center">14</td>
            		<td width="2%" class="outset-table" align="center">15</td>
            		<td width="2%" class="outset-table" align="center">16</td>
            		<td width="11%" class="outset-table" align="center">表扬或批评</td>
            		<td width="11%" class="outset-table" align="center">意见和建议</td>
            		<td width="4%" class="outset-table" align="center">查看</td>
            		<td width="4%" class="outset-table" align="center">删除</td>
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
				em_workdept=content.get("em_workdept").toString();
				em_workstation=content.get("em_workstation").toString();
				em_age=content.get("em_age").toString();
				em_education=content.get("em_education").toString();
				em_dept=content.get("em_dept").toString();
				em_queation1=content.get("em_queation1").toString();
				em_queation2=content.get("em_queation2").toString();
				em_queation3=content.get("em_queation3").toString();
				em_queation4=content.get("em_queation4").toString();
				em_queation5=content.get("em_queation5").toString();
				em_queation6=content.get("em_queation6").toString();
				em_queation7=content.get("em_queation7").toString();
				em_queation8=content.get("em_queation8").toString();
				em_queation9=content.get("em_queation9").toString();
				em_queation10=content.get("em_queation10").toString();
				em_queation11=content.get("em_queation11").toString();
				em_queation12=content.get("em_queation12").toString();
				em_queation13=content.get("em_queation13").toString();
				em_queation14=content.get("em_queation14").toString();
				em_queation15=content.get("em_queation15").toString();
				em_queation16=content.get("em_queation16").toString();
				em_applypeople=content.get("em_applypeople").toString();
				em_idea=content.get("em_idea").toString();

				if(em_workcontent.length()>11)
					em_workcontent=em_workcontent.substring(0,11)+"...";
				if(em_workdept.length()>11)
					em_workdept=em_workdept.substring(0,11)+"...";
				if(em_workstation.length()>11)
					em_workstation=em_workstation.substring(0,11)+"...";
				if(em_applypeople.length()>11)
					em_applypeople=em_applypeople.substring(0,11)+"...";
				if(em_idea.length()>11)
					em_idea=em_idea.substring(0,11)+"...";

				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 
	     	<td align="center"><%=em_workcontent%></td>
	     	<td align="center"><%=em_workdept%></td>
			<td align="center"><%=em_workstation%></td>
			<td align="center"><%=em_age%></td>
			<td align="center"><%=em_education%></td>
			<td align="center"><%=em_dept%></td>
			<td align="center"><%=em_queation1%></td>
			<td align="center"><%=em_queation2%></td>
			<td align="center"><%=em_queation3%></td>
			<td align="center"><%=em_queation4%></td>
			<td align="center"><%=em_queation5%></td>
			<td align="center"><%=em_queation6%></td>
			<td align="center"><%=em_queation7%></td>
			<td align="center"><%=em_queation8%></td>
			<td align="center"><%=em_queation9%></td>
			<td align="center"><%=em_queation10%></td>
			<td align="center"><%=em_queation11%></td>
			<td align="center"><%=em_queation12%></td>
			<td align="center"><%=em_queation13%></td>
			<td align="center"><%=em_queation14%></td>
			<td align="center"><%=em_queation15%></td>
			<td align="center"><%=em_queation16%></td>
			<td align="center"><%=em_applypeople%></td>
			<td align="center"><%=em_idea%></td>
	     	<td align="center"><a href="MessageInfo.jsp?em_id=<%=em_id%>"><img src="/system/images/dialog/icon3.gif" border="0"></a></td>
	     	<td align="center"><a href="MessageDel.jsp?em_id=<%=em_id%>"><img src="/system/images/dialog/delete.gif" border="0"></a></td>
		 </tr>
		 </form>
		<%
			}
	      out.println("<tr><td colspan=26>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
		}
       else
      {
          out.println("<tr><td colspan=26>没有记录！</td></tr>");
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