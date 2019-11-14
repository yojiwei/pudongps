<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String id = "";
String vt_name = "";
String bgcolor="#000099";  //色彩定义
int inSize=0;
id = CTools.dealString(request.getParameter("id")).trim();

String sqlStr_thisitem = "select * from tb_votediy where vt_id= " + id +"";
Hashtable content_thisitem=dImpl.getDataInfo(sqlStr_thisitem);
vt_name = content_thisitem.get("vt_name").toString();

%>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="15"><b><%=vt_name%></b></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
  <tr> 
    <td>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">100-90</div></td>
          <td>
		  <%		String strSQL_1="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=90";
					Vector vPage1 = dImpl.splitPage(strSQL_1,request,10000);
					if(vPage1!=null){
					out.print("<table width="+vPage1.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage1.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
				%>
			</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">90-80</div></td>
		  <td>
		  <%		String strSQL_2="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=80 and vdi_mark<90";
					Vector vPage2 = dImpl.splitPage(strSQL_2,request,10000);
					if(vPage2!=null){
					out.print("<table width="+vPage2.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage2.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">80-70</div></td>
		  <td>
		  <%		String strSQL_3="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=70 and vdi_mark<80";
					Vector vPage3 = dImpl.splitPage(strSQL_3,request,10000);
					if(vPage3!=null){
					out.print("<table width="+vPage3.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage3.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">70-60</div></td>
		  <td>
		  <%		String strSQL_4="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=60 and vdi_mark<70";
					Vector vPage4 = dImpl.splitPage(strSQL_4,request,10000);
					if(vPage4!=null){
					out.print("<table width="+vPage4.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage4.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">60-50</div></td>
		  <td>
		  <%		String strSQL_5="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=50 and vdi_mark<60";
					Vector vPage5 = dImpl.splitPage(strSQL_5,request,10000);
					if(vPage5!=null){
					out.print("<table width="+vPage5.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage5.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr >
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">40-30</div></td>
		  <td>
		  <%		String strSQL_6="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=40 and vdi_mark<50";
					Vector vPage6 = dImpl.splitPage(strSQL_6,request,10000);
					if(vPage6!=null){
					out.print("<table width="+vPage6.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage6.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">30-20</div></td>
		  <td>
		  <%		String strSQL_7="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=20 and vdi_mark<30";
					Vector vPage7 = dImpl.splitPage(strSQL_7,request,10000);
					if(vPage7!=null){
					out.print("<table width="+vPage7.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage7.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">20-10</div></td>
		  <td>
		  <%		String strSQL_8="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=10 and vdi_mark<20";
					Vector vPage8 = dImpl.splitPage(strSQL_8,request,10000);
					if(vPage8!=null){
					out.print("<table width="+vPage8.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage8.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
		</td>
        </tr>
        <tr class="line-even"> 
          <td width="40" nowrap><div align="center">10-0</div></td>
		  <td>
		  <%		String strSQL_9="select * from tb_votediyinfo where vt_id="+id+" and vdi_mark>=0 and vdi_mark<10";
					Vector vPage9 = dImpl.splitPage(strSQL_9,request,10000);
					if(vPage9!=null){					
					out.print("<table width="+vPage9.size()+"  border=0 cellspacing=0 cellpadding=0><tr>");
					out.print("<td height=5 bgcolor="+bgcolor+">");
					out.print("<img src=/website/images/mid11.gif width=1 height=5></td>");
					out.print("</tr></table>");
					inSize=vPage9.size();
					}else{
					inSize=0;
					}
					out.print("&nbsp;&nbsp;&nbsp;"+inSize+"人");
			%>
			</td>
        </tr>
      </table> </td>
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
