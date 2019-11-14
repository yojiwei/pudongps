<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/head.jsp"%>

<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
			  <td height="2">&nbsp;</td>
			</tr>
			<tr>
			  <td><%@include file="/website/include/usertop.jsp"%></td>
			</tr>
			<tr>
			  <td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td width="185"><%@include file="/website/include/userleft.jsp"%></td>
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
							  <td>
								<table width="100%" height="18" border="0" cellpadding="0" cellspacing="0">
								  <tr> 
									<td bgcolor="#FF916F"><div align="center">ÌØ±ðÍÆ¼ö</div></td>
									<td width="493" background="/website/images/mid8.gif"><table width="96%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
										  <td>&nbsp;</td>
										  <td><div align="right"></div></td>
										  <td><div align="right"></div></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
							  </td>
							</tr>
							<tr> 
							  <td align="center">
								<table width="100%">
									<%
									//Update 20061231
									CDataCn dCn = null;
									CDataImpl dImpl = null;
									try{
									dCn = new CDataCn();
									dImpl = new CDataImpl(dCn); 								

									String strSql_rec="select * from tb_recommend order by rc_sequence,rc_time desc";
									Vector vec_rec=dImpl.splitPage(strSql_rec,request,20);
									if(vec_rec!=null)
									{
										for(int i=0;i<vec_rec.size();i++)
										{
											Hashtable contentRec=(Hashtable)vec_rec.get(i);
									%>
									<tr width="100%">
												<td width="3%"><img src="/website/images/left5.gif" width="9" height="9"></td>
												<td align="left"><a href="<%=contentRec.get("rc_link")%>" target="_blank"><%=contentRec.get("rc_title")%></a></td>
									</tr>
									<%
										}
									}

									%>
									<tr><td colspan="2"><%=dImpl.getTail(request)%></td></tr>
								</table>
							  </td>
							</tr>
						</table>
					</td>
				  </tr>
				</table>
			  </td>
			</tr>
		</table>
	</td>
  </tr>
</table>
<%@include file="/website/include/bottom.jsp"%>
<%
}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>