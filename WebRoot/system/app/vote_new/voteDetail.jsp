<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="网上投票管理";%>
<%@include file="../skin/head.jsp"%>
<%
String strId=CTools.dealString(request.getParameter("strId"));
String strCount="";
String strContent="";
CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

	if (strId.equals("0")==false)
	{
		String strSql="select * from tb_vote where vt_id="+strId;
		 Hashtable content = dImpl.getDataInfo(strSql);
	     strCount=content.get("vt_count").toString();
		 strContent=content.get("vt_content").toString();

	}
%>
<br><br>
 <TABLE cellSpacing=0 cellPadding=0 width=500  border=0>
        <TR> <TD class=p4 align=middle>【 <%=strContent%>】</TD></TR>
</TABLE>
<BR>

<TABLE class=p1 cellSpacing=0 cellPadding=3 width=600 border=3>
<TR class=p1 bgColor=#cccccc>
 <TD align=middle colSpan=3>共有 <FONT color=#ff0033><%=strCount%></FONT>
人参加了投票</TD></TR>

<%

String strSql="select * from tb_votelist where vt_id="+strId;
Vector vectorPage1 = dImpl.splitPage(strSql,request,1000);
if(vectorPage1!=null)
	{
	  try
		{
		   for(int j=0;j<vectorPage1.size();j++)
			{
			  Hashtable content1 = (Hashtable)vectorPage1.get(j);
			  String listContent=content1.get("vt_listcontent").toString();
			  String listCount=content1.get("vt_listcount").toString();
			  int intlistCount=Integer.parseInt(listCount);
			  double dbPercent;
			  if(strCount.equals("0"))
				  dbPercent=0;
			  else
				  dbPercent=Double.parseDouble(listCount)/Double.parseDouble(strCount)*100;
				  String strPercent=Double.toString(dbPercent);
  //double dbPercent=(intlistCount/intCount)*100;

			 String strNew;
			 int intPos=strPercent.indexOf('.');
			if(intPos!=-1)
				{
				  String str1=strPercent.substring(0,intPos);
				  String str2=strPercent.substring(intPos,intPos+2);
				  strNew=str1+str2;
				 }
		    else
				 {
				   strNew=strPercent;
				 }
				double dbNew=Double.parseDouble(strNew);

				 double dbDisp=400;//要显示的图像宽度
				dbDisp=dbDisp*dbNew/100;
				String strDisp=Double.toString(dbDisp);

%>

<TR>
 <TD class=p1 align=right>&nbsp;<%=listContent%>&nbsp;</TD>
<TD class=p1 align=middle><B><%out.write(strNew+"%");%></B></TD>
<TD class=p1 align=left>
<img src="../../images/bar.gif" width=<%=dbDisp%> height="5">&nbsp;&nbsp;<%=listCount%>票</TD>
</TR>
 <%

	}
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



<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>