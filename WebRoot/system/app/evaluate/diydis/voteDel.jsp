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

String vs_id = CTools.dealString(request.getParameter("vote_num"));				//生成表id
String id = CTools.dealString(request.getParameter("id"));						//生成表名称
String cSort = CTools.dealString(request.getParameter("tr_code"));				//小类
String vt_sort = CTools.dealString(request.getParameter("vt_sort"));			//大类
String alert = "";

String delDiySql = "delete from tb_votediy" + id + " where vs_id = " + vs_id;
String delIpSql = "delete from tb_remip where vs_id = " + vs_id + " and vt_id = " + 
				  id + " and tr_code = '" + cSort + "'";

	dCn.beginTrans();
	
    dImpl.executeUpdate(delDiySql);
    dImpl.executeUpdate(delIpSql);
	        
	if (!"".equals(dCn.getLastErrString())) {
	    dCn.rollbackTrans();
	    alert = "删除数据时出错，请与管理员联系！";
	}
	else {
	    dCn.commitTrans();
	    alert = "删除成功！";
	}

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
<script language="javascript">
	alert("<%=alert%>");
	location.href = "detailList.jsp?id=<%=id%>&cSort=<%=cSort%>&vt_sort=<%=vt_sort%>";
</script>
