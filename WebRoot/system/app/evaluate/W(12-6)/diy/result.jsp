<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>
<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);

String vt_id = "";
String vt_name = "";
String vt_type = "";
String vt_upperid = "";
String vt_sequence = "";
String vt_frontpagename = "";
String vt_desc = "";
String vt_parameter = "";
String vt_parameter_text_1 = "";
String vt_parameter_text_2 = "";
String vt_parameter_textarea_1 = "";
String vt_parameter_textarea_2 = "";
String OType = "";
String treeid = "";

vt_id = CTools.dealString(request.getParameter("vt_id")).trim();
vt_name = CTools.dealString(request.getParameter("vt_name")).trim();
vt_type = CTools.dealString(request.getParameter("vt_type")).trim();
vt_upperid = CTools.dealString(request.getParameter("vt_upperid")).trim();
vt_sequence = CTools.dealString(request.getParameter("vt_sequence")).trim();
vt_desc = CTools.dealString(request.getParameter("vt_desc")).trim();
vt_parameter_text_1 = CTools.dealString(request.getParameter("vt_parameter_text_1")).trim();
vt_parameter_text_2 = CTools.dealString(request.getParameter("vt_parameter_text_2")).trim();
vt_parameter_textarea_1 = CTools.dealString(request.getParameter("vt_parameter_textarea_1")).trim();
vt_parameter_textarea_2 = CTools.dealString(request.getParameter("vt_parameter_textarea_2")).trim();
OType = CTools.dealString(request.getParameter("OType")).trim();
treeid = CTools.dealString(request.getParameter("treeid")).trim();

if(OType.equals("Add"))
{
	dImpl.setTableName("tb_votediy");
	dImpl.setPrimaryFieldName("vt_id");
	vt_id = String.valueOf(dImpl.addNew());
	if(vt_upperid.equals("0"))
	{
		Vote vote = new Vote();
		vote.CreateVoteDB(vt_id);
	}
}
if(OType.equals("Edit"))
{
	dImpl.edit("tb_votediy","vt_id",vt_id);
}

if(!vt_upperid.equals("0"))
{
	if(vt_type.equals("radio") || vt_type.equals("checkbox"))
	{
		String tempupperid = vt_upperid;
		String tablename = "";
		while(!tempupperid.equals("0"))
		{
			String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
			Hashtable content=dImpl.getDataInfo(sqlStr);
			tempupperid = content.get("vt_upperid").toString();
			tablename = "tb_votediy"+content.get("vt_id").toString();
		}
		Vote vote = new Vote();
		out.print(vote.AlterTable(tablename,vt_id,"2","edit"));
	}
	if(vt_type.equals("text") || vt_type.equals("textarea"))
	{
		String tempupperid = vt_upperid;
		String tablename = "";
		while(!tempupperid.equals("0"))
		{
			String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
			Hashtable content=dImpl.getDataInfo(sqlStr);
			tempupperid = content.get("vt_upperid").toString();
			tablename = "tb_votediy"+content.get("vt_id").toString();
		}
		Vote vote = new Vote();
		vote.AlterTable(tablename,vt_id,"200","edit");
	}
	if(vt_type.equals("title"))
	{
		String tempupperid = vt_upperid;
		String tablename = "";
		while(!tempupperid.equals("0"))
		{
			String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid+"";
			Hashtable content=dImpl.getDataInfo(sqlStr);
			tempupperid = content.get("vt_upperid").toString();
			tablename = "tb_votediy"+content.get("vt_id").toString();
		}
		Vote vote = new Vote();
		vote.AlterTable(tablename,vt_id,"","del");
	}

	if(vt_type.equals("radio"))
		vt_frontpagename = "r"+vt_upperid;
	if(vt_type.equals("checkbox"))
		vt_frontpagename = "c"+vt_upperid;
	if(vt_type.equals("text"))
	{
		vt_frontpagename = "t"+vt_id;
		vt_parameter = vt_parameter_text_1 + "," + vt_parameter_text_2 +",";
	}
	if(vt_type.equals("textarea"))
	{
		vt_frontpagename = "t"+vt_id;
		vt_parameter = vt_parameter_textarea_1 + "," + vt_parameter_textarea_2+",";
	}
	if(vt_type.equals("title"))
		vt_frontpagename = "";
}

dImpl.setValue("vt_name",vt_name,CDataImpl.STRING);
dImpl.setValue("vt_upperid",vt_upperid,CDataImpl.STRING);
dImpl.setValue("vt_type",vt_type,CDataImpl.STRING);
dImpl.setValue("vt_sequence",vt_sequence,CDataImpl.STRING);
dImpl.setValue("vt_dbname","o"+vt_id,CDataImpl.STRING);
dImpl.setValue("vt_frontpagename",vt_frontpagename,CDataImpl.STRING);
dImpl.setValue("vt_desc",vt_desc,CDataImpl.STRING);
dImpl.setValue("vt_parameter",vt_parameter,CDataImpl.STRING);
dImpl.update();

if (dCn.getLastErrString().equals(""))
{
	dCn.commitTrans();
	%>
	<script language="javascript">
		//alert("操作已成功");
	<%
	if(treeid.equals(""))
	{
	%>
		window.location.href="list.jsp?upperid=<%=vt_upperid%>";
	<%
	}
	else
	{
	%>
	window.location.href="listtree.jsp?treeid=<%=treeid%>";
	<%
	}	
	%>
	</script>
	<%
}
else
{
	dCn.rollbackTrans();
	%>
	<script language="javascript">
		alert("发生错误，录入失败！");
		window.history.go(-1);
	</script>
	<%
}

dImpl.closeStmt();
dCn.closeCn();
%>