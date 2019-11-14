<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
String projectId = CTools.dealString(request.getParameter("projectId")).trim();
String OType = CTools.dealString(request.getParameter("OType")).trim();
String userKind = CTools.dealString(request.getParameter("userKind")).trim();
String commonWork = CTools.dealUploadString(request.getParameter("commonWork1")).trim();
String sortWork = CTools.dealUploadString(request.getParameter("sortWork")).trim();
String departIdOut = CTools.dealNumber(request.getParameter("departIdOut")).trim();
String pr_begintime = CTools.dealNumber(request.getParameter("beginTime")).trim();
String pr_endtime = CTools.dealNumber(request.getParameter("endTime")).trim();


if (!projectId.equals(""))
{
		//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


		dCn.beginTrans();
		String wo_id = "";
		/*-**************************
		modify for hh
		Vector vPage = dImpl.splitPage("select wo_id from tb_work where pr_id='"+projectId+"'",1000,1);
		if (vPage!=null)
		{
			for(int i=0;i<vPage.size();i++)
			{
				Hashtable content = (Hashtable)vPage.get(i);
				wo_id = content.get("wo_id").toString();
				dImpl.delete("tb_workattach","wo_id",wo_id);
				dImpl.delete("tb_work","wo_id",wo_id);
			}
		}
		dImpl.delete("tb_proceedingattach","pr_id",projectId);
		dImpl.delete("tb_proceeding","pr_id",projectId);
		end modify
		*-***************************/
		dImpl.executeUpdate("update tb_proceeding set pr_isdel = 1 where pr_id = '" + projectId + "'");

		dCn.commitTrans();

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
		
}
//response.sendRedirect("ProceedingList.jsp");
%>
<form name="formData">
	<input type="hidden" name="OType" value="<%=OType%>">
	<input type="hidden" name="userKind" value="<%=userKind%>">
	<input type="hidden" name="commonWork1" value="<%=commonWork%>">
	<input type="hidden" name="sortWork" value="<%=sortWork%>">
	<input type="hidden" name="departIdOut" value="<%=departIdOut%>">
	<input type="hidden" name="beginTime" value="<%=pr_begintime%>">
	<input type="hidden" name="endTime" value="<%=pr_endtime%>">
</form>
<script>
	formData.action = "ProceedingList.jsp";
	formData.submit();
</script>