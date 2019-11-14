<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
CDataCn dCn_voteitemid = null;
CDataImpl dImpl_voteitemid = null;
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
dCn_voteitemid = new CDataCn();
dImpl_voteitemid = new CDataImpl(dCn_voteitemid);

String vote_num = "";
String id = "";
String vt_name = "";
id = CTools.dealString(request.getParameter("id")).trim();
vote_num = CTools.dealString(request.getParameter("vote_num")).trim();
if(vote_num.equals(""))
	vote_num = "1";

String sqlStr_thisitem = "select * from tb_votediy where vt_id= " + id +"";
Hashtable content_thisitem=dImpl_voteitemid.getDataInfo(sqlStr_thisitem);
vt_name = content_thisitem.get("vt_name").toString();

%>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="15"><b><%=vt_name%></b></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
										<tr class="line-even">

										<%
										int intvote_num = Integer.parseInt(vote_num);
										String str = "select * from tb_votediy"+id+"";
										Vector vPage = dImpl.splitPage(str,request,10000);
										if(vPage != null) {
											int minI = intvote_num/10*10;
											if(intvote_num/10 == vPage.size()/10) {
												for(int i=minI;i<=vPage.size()-1;i++) {
													if((i+1)==intvote_num) {
														out.print("<td bgcolor='#aaeeee' align='center'>");
													}
													else {
														if(i%2==0)
															out.print("<td bgcolor='#eeeeee' align='center'>");
														else
															out.print("<td bgcolor='#ffffff' align='center'>");
													}
													Hashtable content = (Hashtable)vPage.get(i);
													if((i+1)==intvote_num)
														out.print("<a href='votestat.jsp?id="+id+"&vote_num="+(i+1)+"'><font color='#ff0000'>"+(i+1)+"</font></a>");
													else
														out.print("<a href='votestat.jsp?id="+id+"&vote_num="+(i+1)+"'>"+(i+1)+"</a>");
													out.print("</td>");
												}
											}
											else {
												for(int i=minI;i<=(minI+10-1);i++) {
													if((i+1)==intvote_num) {
														out.print("<td bgcolor='#aaeeee' align='center'>");
													}
													else {
														if(i%2==0)
															out.print("<td bgcolor='#eeeeee' align='center'>");
														else
															out.print("<td bgcolor='#ffffff' align='center'>");
													}
													Hashtable content = (Hashtable)vPage.get(i);
													if((i+1)==intvote_num)
														out.print("<a href='votestat.jsp?id="+id+"&vote_num="+(i+1)+"'><font color='#ff0000'>"+(i+1)+"</font></a>");
													else
														out.print("<a href='votestat.jsp?id="+id+"&vote_num="+(i+1)+"'>"+(i+1)+"</a>");
													out.print("</td>");
												}
											}
											%>
											<td align="left" colspan="3">
											<%
											if(intvote_num/10!=0)
												out.print("&nbsp;<a href='votestat.jsp?id="+id+"&vote_num="+((intvote_num/10-1)*10+1)+"'>前10条</a> ");
											else
												out.print("&nbsp;<font color='#aaaaaa'>前10条</font> ");

											if(intvote_num/10 < vPage.size()/10)
												out.print("<a href='votestat.jsp?id="+id+"&vote_num="+((intvote_num/10+1)*10+1)+"'>后10条</a> ");
											else
												out.print("<font color='#aaaaaa'>后10条</font> ");

											out.print("共"+vPage.size()+"条投票 ");
											if((vPage.size()-intvote_num)<10)
												out.print("当前显示的为第"+(intvote_num/10*10+1)+"条到第"+vPage.size()+"条 ");
											else
												out.print("当前显示的为第"+(intvote_num/10*10+1)+"条到第"+(intvote_num/10*10+10)+"条 ");
											out.print("<a href='showall.jsp?id="+id+"' target='_black'>输出全部投票结果</a>");

										%>
										<a href="list.jsp">返回列表</a>
										</td>
										</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="15"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
<%
Vote vote = new Vote();
vote.getVoteTitle(id);
out.print(vote.ShowVoteResultFrontPage(id,intvote_num));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="13"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<%
										}
										else
										{
											intvote_num = 0;
											Vote vote = new Vote();
											vote.getVoteTitle(id);
											out.print(vote.ShowVoteResultFrontPage(id,intvote_num));
										}
										%>
</table>
<%
} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

dImpl_voteitemid.closeStmt();
dCn_voteitemid.closeCn();
dImpl.closeStmt();
dCn.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
