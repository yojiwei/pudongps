<%@page contentType="text/html; charset=GBK"%>
<%@include file="/web/include/import.jsp"%>
<%@include file="/web/include/parameter.jsp"%>
<%@page import="vote.*"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);
CDataCn dCn_voteitemid = new CDataCn();
CDataImpl dImpl_voteitemid = new CDataImpl(dCn_voteitemid);

String id = "";
id = CTools.dealString(request.getParameter("id")).trim();
String vs_id = "";

Vector voteitemid = new Vector();
Vote vote = new Vote();
voteitemid = vote.getVoteTableconf(id);

dImpl.setTableName("test_vote"+id);
dImpl.setPrimaryFieldName("vs_id");
vs_id = String.valueOf(dImpl.addNew());

for(int i=0 ; i<voteitemid.size() ; i++)
{	
	String sqlStr_voteitemid = "select * from test_vote where vt_id= " + voteitemid.get(i).toString()+"";
	Hashtable content_voteitemid=dImpl_voteitemid.getDataInfo(sqlStr_voteitemid);
	if(content_voteitemid.get("vt_type").toString().equals("text") || content_voteitemid.get("vt_type").toString().equals("textarea"))
	{
		dImpl.setValue(content_voteitemid.get("vt_dbname").toString(),CTools.dealString(request.getParameter(content_voteitemid.get("vt_frontpagename").toString())).trim(),CDataImpl.STRING);
	}
	if(content_voteitemid.get("vt_type").toString().equals("radio"))
	{
		String tempradioname = content_voteitemid.get("vt_frontpagename").toString();
		String tempradiovalue = CTools.dealString(request.getParameter(tempradioname)).trim();
		if(tempradiovalue.equals(content_voteitemid.get("vt_dbname").toString()))
			dImpl.setValue(content_voteitemid.get("vt_dbname").toString(),"1",CDataImpl.STRING);
	}
	if(content_voteitemid.get("vt_type").toString().equals("checkbox"))
	{
		String tempcheckboxname = content_voteitemid.get("vt_frontpagename").toString();
		String [] tempcheckboxvalue = request.getParameterValues(tempcheckboxname);
		if(tempcheckboxvalue != null)
		{
			for(int j=0 ; j<tempcheckboxvalue.length ; j++)
			{
				if(tempcheckboxvalue[j].equals(content_voteitemid.get("vt_dbname").toString()))
				{
					dImpl.setValue(content_voteitemid.get("vt_dbname").toString(),"1",CDataImpl.STRING);
				}
			}
		}
	}
}

dImpl.update();

dImpl_voteitemid.closeStmt();
dCn_voteitemid.closeCn();
dImpl.closeStmt();
dCn.closeCn();
%>