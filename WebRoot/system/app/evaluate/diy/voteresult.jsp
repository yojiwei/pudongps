<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="vote.*"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
CDataCn dCn_voteitemid = new CDataCn();
CDataImpl dImpl_voteitemid = new CDataImpl(dCn_voteitemid);

String id = "";
id = CTools.dealString(request.getParameter("id")).trim();
String vs_id = "";

Vector voteitemid = new Vector();
Vote vote = new Vote();
voteitemid = vote.RetuenVectorVoteTitle();

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
out.print("<script language='javascript'>");
out.print("alert('已经提交了您的评议结果,谢谢您的参与。按确定返回!');");
out.print("window.location.href='vote.jsp?id="+id+"';");
out.print("</script>");
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