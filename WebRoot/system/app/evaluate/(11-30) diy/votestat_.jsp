<%@page contentType="text/html; charset=GBK"%>
<%@include file="/web/include/import.jsp"%>
<%@include file="/web/include/parameter.jsp"%>
<%@page import="vote.*"%>
<LINK href="main.css" type="text/css" rel="stylesheet">
<%
String id = "";
id = CTools.dealString(request.getParameter("id")).trim();
%>
<title>Í³¼Æ</title>
<%
Vote vote1 = new Vote();
out.print(vote1.ShowVoteResultFrontPage(id));
%>
<table border="1">
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
CDataCn dCn_voteitemid = new CDataCn();
CDataImpl dImpl_voteitemid = new CDataImpl(dCn_voteitemid);

Vector voteitemid = new Vector();
Vote vote = new Vote();
voteitemid = vote.getVoteTableconf(id);

String sqlStr = "select * from test_vote"+id+"";
Vector vPage = dImpl.splitPage(sqlStr,10000,1);

for(int i=0 ; i<voteitemid.size() ; i++)
{
	String sqlStr_voteitemid = "select * from test_vote where vt_id= " + voteitemid.get(i).toString()+"";
	Hashtable content_voteitemid=dImpl_voteitemid.getDataInfo(sqlStr_voteitemid);
	if(!content_voteitemid.get("vt_type").toString().equals("title"))
	{
		out.print("<tr>");
		out.print("<td>"+content_voteitemid.get("vt_dbname").toString()+"</td>");	

		if(vPage != null)
		{
			for(int j=0;j<vPage.size();j++)
			{
				Hashtable content = (Hashtable)vPage.get(j);
				
				String temp = content.get(content_voteitemid.get("vt_dbname").toString()).toString();
				if(!temp.equals(""))
					out.print("<td>"+temp+"</td>");	
				else
					out.print("<td>&nbsp;</td>");	
			}
		}
		out.print("</tr>");
	}
}

dImpl_voteitemid.closeStmt();
dCn_voteitemid.closeCn();
dImpl.closeStmt();
dCn.closeCn();
%>
</table>