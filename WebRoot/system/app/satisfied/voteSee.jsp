<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="用户反馈满意度调查";%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.component.treeview.*"%>
<%@page import="com.platform.subject.*"%>
<%@page import="com.platform.meta.*"%>
<%@page import="com.platform.user.*"%>
<%@page import="com.platform.role.*"%>
<%@page import="com.app.*"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.platform.module.*" %>
<%@page import="com.platform.*" %>
<%@page import="com.share.dbExchange.*" %>
<%@page import="com.share.exchange.*" %>
<%@page import="java.text.*" %>
<%@page import="com.website.*" %>
<script language="javascript" src="../system/include/common.js" ></script>
<link href="../skin/skin3/images/style.css"rel="stylesheet" type="text/css">
<%
//
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象


String strSql="select count(cs_id) as tal,count(decode(c.cs_satis,'1','1','')) as my,count(decode(c.cs_satis,'2','1','')) as yb,count(decode(c.cs_satis,'3','1','')) as bmy,count(decode(c.cs_timesatis,'1','1','')) as timemy,count(decode(c.cs_timesatis,'2','1','')) as timeyb,count(decode(c.cs_timesatis,'3','1','')) as timebmy,count(decode(c.cs_resultsatis,'1','1','')) as resultmy,count(decode(c.cs_resultsatis,'2','1','')) as resultyb,count(decode(c.cs_resultsatis,'3','1','')) as resultbmy from tb_connsatisfied c ";
String tal = "";
String my = "";
String yb = "";
String bmy = "";

String timemy = "";
String timeyb = "";
String timebmy = "";

String resultmy = "";
String resultyb = "";
String resultbmy = "";
double dbDisp1=400;//要显示的图像宽度
double dbDisp2=400;//要显示的图像宽度
double dbDisp3=400;//要显示的图像宽度
double dbDisp4=400;//要显示的图像宽度
double dbDisp5=400;//要显示的图像宽度
double dbDisp6=400;//要显示的图像宽度
double dbDisp7=400;//要显示的图像宽度
double dbDisp8=400;//要显示的图像宽度
double dbDisp9=400;//要显示的图像宽度
String strNew1 = "";
String strNew2 = "";
String strNew3 = "";
String strNew4 = "";
String strNew5 = "";
String strNew6 = "";
String strNew7 = "";
String strNew8 = "";
String strNew9 = "";

Vector vectorPage1 = dImpl.splitPageOpt(strSql,request,1000);
if(vectorPage1!=null)
	{
	  try
		{
		   for(int j=0;j<vectorPage1.size();j++)
			{
			  Hashtable content1 = (Hashtable)vectorPage1.get(j);
			  if(content1!=null){
				   tal=content1.get("tal").toString();
				   my=content1.get("my").toString();
				   yb=content1.get("yb").toString();
				   bmy=content1.get("bmy").toString();

				   timemy=content1.get("timemy").toString();
				   timeyb=content1.get("timeyb").toString();
				   timebmy=content1.get("timebmy").toString();

				   resultmy=content1.get("resultmy").toString();
				   resultyb=content1.get("resultyb").toString();
				   resultbmy=content1.get("resultbmy").toString();

			  }
			    double dbPercent=0;
				double dbPercent_my=0;
				double dbPercent_yb=0;
				double dbPercent_bmy=0;

				double dbPercent_timemy=0;
				double dbPercent_timeyb=0;
				double dbPercent_timebmy=0;

				double dbPercent_resultmy=0;
				double dbPercent_resultyb=0;
				double dbPercent_resultbmy=0;

			  if(tal.equals("0"))
				  dbPercent=0;
			  else{
				  dbPercent_my=Double.parseDouble(my)/Double.parseDouble(tal)*100;
				  dbPercent_yb=Double.parseDouble(yb)/Double.parseDouble(tal)*100;
				  dbPercent_bmy=Double.parseDouble(bmy)/Double.parseDouble(tal)*100;

				  dbPercent_timemy=Double.parseDouble(timemy)/Double.parseDouble(tal)*100;
				  dbPercent_timeyb=Double.parseDouble(timeyb)/Double.parseDouble(tal)*100;
				  dbPercent_timebmy=Double.parseDouble(timebmy)/Double.parseDouble(tal)*100;

				  dbPercent_resultmy=Double.parseDouble(resultmy)/Double.parseDouble(tal)*100;
				  dbPercent_resultyb=Double.parseDouble(resultyb)/Double.parseDouble(tal)*100;
				  dbPercent_resultbmy=Double.parseDouble(resultbmy)/Double.parseDouble(tal)*100;
			   }
			 
			 String strPercent1 = "";
			 String strPercent2 = "";
			 String strPercent3 = "";
			 String strPercent4 = "";
			 String strPercent5 = "";
			 String strPercent6 = "";
			 String strPercent7 = "";
			 String strPercent8 = "";
			 String strPercent9 = "";
			 
			 strPercent1=Double.toString(dbPercent_my);
			 strPercent2=Double.toString(dbPercent_yb);
			 strPercent3=Double.toString(dbPercent_bmy);

			 strPercent4=Double.toString(dbPercent_timemy);
			 strPercent5=Double.toString(dbPercent_timeyb);
			 strPercent6=Double.toString(dbPercent_timebmy);

			 strPercent7=Double.toString(dbPercent_resultmy);
			 strPercent8=Double.toString(dbPercent_resultyb);
			 strPercent9=Double.toString(dbPercent_resultbmy);
			 
			 
			 //1
			 int intPos1=strPercent1.indexOf('.');
			if(intPos1!=-1)
			{
			  String str1=strPercent1.substring(0,intPos1);
			  String str2=strPercent1.substring(intPos1,intPos1+2);
			  strNew1=str1+str2;
			 }
		    else
			 {
			   strNew1=strPercent1;
			 }
				double dbNew1=Double.parseDouble(strNew1);
			  	
				dbDisp1=dbDisp1*dbNew1/100;

			//2
			int intPos2=strPercent2.indexOf('.');
			if(intPos2!=-1)
			{
			  String str3=strPercent2.substring(0,intPos2);
			  String str4=strPercent2.substring(intPos2,intPos2+2);
			  strNew2=str3+str4;
			 }
		    else
			 {
			   strNew2=strPercent2;
			 }
				double dbNew2=Double.parseDouble(strNew2);
			  	
				dbDisp2=dbDisp2*dbNew2/100;

			//3
			int intPos3=strPercent3.indexOf('.');
			if(intPos3!=-1)
			{
			  String str5=strPercent3.substring(0,intPos3);
			  String str6=strPercent3.substring(intPos3,intPos3+2);
			  strNew3=str5+str6;
			 }
		    else
			 {
			   strNew3=strPercent3;
			 }
				double dbNew3=Double.parseDouble(strNew3);
			  	
				dbDisp3=dbDisp3*dbNew3/100;

			//4
			int intPos4=strPercent4.indexOf('.');
			if(intPos4!=-1)
			{
			  String str5=strPercent4.substring(0,intPos4);
			  String str6=strPercent4.substring(intPos4,intPos4+2);
			  strNew4=str5+str6;
			 }
		    else
			 {
			   strNew4=strPercent4;
			 }
				double dbNew4=Double.parseDouble(strNew4);
			  	
				dbDisp4=dbDisp4*dbNew4/100;
			//5
			int intPos5=strPercent5.indexOf('.');
			if(intPos5!=-1)
			{
			  String str5=strPercent5.substring(0,intPos5);
			  String str6=strPercent5.substring(intPos5,intPos5+2);
			  strNew5=str5+str6;
			 }
		    else
			 {
			   strNew5=strPercent5;
			 }
				double dbNew5=Double.parseDouble(strNew5);
			  	
				dbDisp5=dbDisp5*dbNew5/100;
			//6
			int intPos6=strPercent6.indexOf('.');
			if(intPos6!=-1)
			{
			  String str5=strPercent6.substring(0,intPos6);
			  String str6=strPercent6.substring(intPos6,intPos6+2);
			  strNew6=str5+str6;
			 }
		    else
			 {
			   strNew6=strPercent6;
			 }
				double dbNew6=Double.parseDouble(strNew6);
			  	
				dbDisp6=dbDisp6*dbNew6/100;
			//7
			int intPos7=strPercent7.indexOf('.');
			if(intPos7!=-1)
			{
			  String str5=strPercent7.substring(0,intPos7);
			  String str6=strPercent7.substring(intPos7,intPos7+2);
			  strNew7=str5+str6;
			 }
		    else
			 {
			   strNew7=strPercent7;
			 }
				double dbNew7=Double.parseDouble(strNew7);
			  	
				dbDisp7=dbDisp7*dbNew7/100;
			//8
			int intPos8=strPercent8.indexOf('.');
			if(intPos8!=-1)
			{
			  String str5=strPercent8.substring(0,intPos8);
			  String str6=strPercent8.substring(intPos8,intPos8+2);
			  strNew8=str5+str6;
			 }
		    else
			 {
			   strNew8=strPercent8;
			 }
				double dbNew8=Double.parseDouble(strNew8);
			  	
				dbDisp8=dbDisp8*dbNew8/100;
			//9
			int intPos9=strPercent9.indexOf('.');
			if(intPos9!=-1)
			{
			  String str5=strPercent9.substring(0,intPos9);
			  String str6=strPercent9.substring(intPos9,intPos9+2);
			  strNew9=str5+str6;
			 }
		    else
			 {
			   strNew9=strPercent9;
			 }
				double dbNew9=Double.parseDouble(strNew9);
			  	
				dbDisp9=dbDisp9*dbNew9/100;
}

%>
<br><br>
 <TABLE cellSpacing=0 cellPadding=0 width=500  border=0>
        <TR> <TD class=p4 align=left>【用户反馈满意度调查】</TD></TR>
</TABLE>
<BR>

<TABLE class=p1 cellSpacing=0 cellPadding=3 width=600 border=3>
<TR class=p1 bgColor=#cccccc>
 <TD align=middle colSpan=3>共有 <FONT color=#ff0033><%=tal%></FONT>
人参加了用户反馈满意度调查</TD></TR>
<TR class=p1 bgColor=#cccccc>
 <TD align=middle colSpan=3>来信人对办理部门工作作风、工作态度的评价</TD></TR>
<TR>
 <TD class=p1 align=right>&nbsp;满意&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew1+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp1%> height="5">&nbsp;&nbsp;<%=my%>票</TD>
</TR>
<TR>
 <TD class=p1 align=right>&nbsp;一般&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew2+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp2%> height="5">&nbsp;&nbsp;<%=yb%>票</TD>
</TR>
<TR>
 <TD class=p1 align=right>&nbsp;不满意&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew3+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp3%> height="5">&nbsp;&nbsp;<%=bmy%>票</TD>
</TR>
<TR class=p1 bgColor=#cccccc>
 <TD align=middle colSpan=3>来信人对信访事项办理时效的评价</TD></TR>
<TR>
 <TD class=p1 align=right>&nbsp;满意&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew4+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp4%> height="5">&nbsp;&nbsp;<%=timemy%>票</TD>
</TR>
<TR>
 <TD class=p1 align=right>&nbsp;一般&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew5+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp5%> height="5">&nbsp;&nbsp;<%=timeyb%>票</TD>
</TR>
<TR>
 <TD class=p1 align=right>&nbsp;不满意&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew6+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp6%> height="5">&nbsp;&nbsp;<%=timebmy%>票</TD>
</TR>
<TR class=p1 bgColor=#cccccc>
 <TD align=middle colSpan=3>来信人对信访事项办理结果的意见</TD></TR>
<TR>
 <TD class=p1 align=right>&nbsp;满意&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew7+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp7%> height="5">&nbsp;&nbsp;<%=resultmy%>票</TD>
</TR>
<TR>
 <TD class=p1 align=right>&nbsp;一般&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew8+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp8%> height="5">&nbsp;&nbsp;<%=resultyb%>票</TD>
</TR>
<TR>
 <TD class=p1 align=right>&nbsp;不满意&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew9+"%");%></B></TD>
<TD class=p1 align=left>
<img src="include/images/bar.gif" width=<%=dbDisp9%> height="5">&nbsp;&nbsp;<%=resultbmy%>票</TD>
</TR>
 <%
}
catch(Exception e)
{
	out.println(e);
}
}
else
{
	out.println("<tr><td colspan=3>无记录</td></tr>");
}
%>
</table>
<BR>
 <TABLE cellSpacing=0 cellPadding=0 width=600  border=0>
        <TR> <TD class=p4 align=right><a onclick="javascript:window.history.go(-1);" style="cursor:hand">【返回】</a></TD></TR>
</TABLE>

<%
dImpl.closeStmt();
dCn.closeCn();
%>