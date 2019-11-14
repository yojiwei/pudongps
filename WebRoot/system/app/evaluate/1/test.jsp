<%@page contentType="text/html; charset=GBK"%>
<%@page import="test.*"%>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<%
	Test test = new Test();
	String [] strtemp = new String [20];
	strtemp[0] = "1、年龄";
	strtemp[1] = "① 18-25周岁";
	strtemp[2] = "② 26-39周岁";
	strtemp[3] = "③ 40-59周岁";
	strtemp[4] = "④ 60周岁以上";
	out.print(test.showTest("em_q1_1",4,"tb_examine1",strtemp));
%>
</table>