<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="浏览论坛" ;%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

		String strSql="select bt_name,bt_id from tb_bbstype";
		Vector vectorPage = dImpl.splitPage(strSql,request,200);

%>
<table class="main-table" width="100%">
 <tr>
  <td width="100%">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="8" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center"><%=strTitle%></td>
                                        </tr>
                                </table>
                        </td>
                </tr>
								<tr>
											<td >
												
											<div style="position: absolute; top: 89; left: 344; width: 229; height: 22">
											<center>
												【<STRONG>电子论坛</STRONG>】
											</center>
											</div>
											<div style="position: absolute; top: 119; left: 344; width: 229; height: 22">
													<table border='0' width='100%' cellpadding='0' cellspacing='0'> 
													<%
														if(vectorPage!=null)
														{
															  for(int j=0;j<vectorPage.size();j++)
																	{
																		Hashtable content = (Hashtable)vectorPage.get(j);
																		String bt_id=content.get("bt_id").toString();

													%>
															<tr>
																<td width=50%>&nbsp;</td>
																<td ><a href="bbscontentDetail.jsp?stype=<%=bt_id%>"><%=content.get("bt_name")%></a></td>
															</tr>
															
													<%
																	}
														}
														else
														{
															out.println("<tr><td colspan=7>无记录</td></tr>");
														}
													
													%>	
													</table>
											</div>	
											<img src="../../images/bbs/bbs.gif"></td>
								</tr>
			</table>
	</td>
</tr>
</table>


<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>

<%


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
