<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
String em_id="";
String em_q1_1="";
String em_q1_2="";
String em_q1_3="";
String em_q1_4="";
String em_q1_4_1="";
String em_q2_1="";
String em_q2_2="";
String em_q3_1="";
String em_q3_2="";
String em_q3_3="";
String em_q3_4="";
String em_q3_5="";
String em_q3_6="";
String em_q3_7="";
String em_q3_8="";
String em_q3_9="";
String em_q3_10="";
String em_q3_11="";
String em_q3_12="";
String em_q4="";
String em_q4_1="";
String em_q5="";

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
//String sql_massage = " select * from tb_examine  where em_workcontent is not null or em_idea is not null order by em_id desc";
String sql_massage = " select * from tb_examine2 order by em_id desc";
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
                      	  <td valign="center" width="60%">浦东新区教育系统行风状况调查问卷</td>
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
            		<td width="2%" class="outset-table" align="center">1</td>
            		<td width="2%" class="outset-table" align="center">2</td>
					<td width="2%" class="outset-table" align="center">3</td>
            		<td width="2%" class="outset-table" align="center">4</td>
            		<td width="15%" class="outset-table" align="center">其它（请注明）</td>
            		<td width="2%" class="outset-table" align="center">1</td>
            		<td width="2%" class="outset-table" align="center">2</td>
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
            		<td width="10%" class="outset-table" align="center">行风问题</td>
            		<td width="15%" class="outset-table" align="center">其它</td>
            		<td width="16%" class="outset-table" align="center">建议和要求</td>
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
				em_q1_1=content.get("em_q1_1").toString();
				em_q1_2=content.get("em_q1_2").toString();
				em_q1_3=content.get("em_q1_3").toString();
				em_q1_4=content.get("em_q1_4").toString();
				em_q1_4_1=content.get("em_q1_4_1").toString();
				em_q2_1=content.get("em_q2_1").toString();
				em_q2_2=content.get("em_q2_2").toString();
				em_q3_1=content.get("em_q3_1").toString();
				em_q3_2=content.get("em_q3_2").toString();
				em_q3_3=content.get("em_q3_3").toString();
				em_q3_4=content.get("em_q3_4").toString();
				em_q3_5=content.get("em_q3_5").toString();
				em_q3_6=content.get("em_q3_6").toString();
				em_q3_7=content.get("em_q3_7").toString();
				em_q3_8=content.get("em_q3_8").toString();
				em_q3_9=content.get("em_q3_9").toString();
				em_q3_10=content.get("em_q3_10").toString();
				em_q3_11=content.get("em_q3_11").toString();
				em_q3_12=content.get("em_q3_12").toString();
				em_q4=content.get("em_q4").toString();
				em_q4_1=content.get("em_q4_1").toString();
				em_q5=content.get("em_q5").toString();

				if(em_q1_4_1.length()>11)
					em_q1_4_1=em_q1_4_1.substring(0,11)+"...";
				if(em_q4_1.length()>11)
					em_q4_1=em_q4_1.substring(0,11)+"...";
				if(em_q5.length()>11)
					em_q5=em_q5.substring(0,11)+"...";

				if(i%2==0) out.println("<tr class=\"line-even\">");
				else out.print("<tr class=\"line-odd\">");
		%>
		 
	     	<td align="center"><%=em_q1_1%></td>
	     	<td align="center"><%=em_q1_2%></td>
			<td align="center"><%=em_q1_3%></td>
			<td align="center"><%=em_q1_4%></td>
			<td align="center"><%=em_q1_4_1%></td>
			<td align="center"><%=em_q2_1%></td>
			<td align="center"><%=em_q2_2%></td>
			<td align="center"><%=em_q3_1%></td>
			<td align="center"><%=em_q3_2%></td>
			<td align="center"><%=em_q3_3%></td>
			<td align="center"><%=em_q3_4%></td>
			<td align="center"><%=em_q3_5%></td>
			<td align="center"><%=em_q3_6%></td>
			<td align="center"><%=em_q3_7%></td>
			<td align="center"><%=em_q3_8%></td>
			<td align="center"><%=em_q3_9%></td>
			<td align="center"><%=em_q3_10%></td>
			<td align="center"><%=em_q3_11%></td>
			<td align="center"><%=em_q3_12%></td>
			<td align="center"><%=em_q4%></td>
			<td align="center"><%=em_q4_1%></td>
			<td align="center"><%=em_q5%></td>
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