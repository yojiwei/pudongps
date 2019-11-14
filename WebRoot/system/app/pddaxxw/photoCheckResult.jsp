<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/import.jsp"%>
<%
//update20091103
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
String opids = "";
String opischeck = "";

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 opids = CTools.dealString(request.getParameter("opids")).trim();
 opischeck = CTools.dealString(request.getParameter("opischeck")).trim();
 
	String [] opid = opids.split(",");
	for(int j = 0;j < opid.length;j++) {
		 dImpl.edit("tb_daxxphoto","op_id",opid[j]);
		 dImpl.setValue("op_ischeck",opischeck,CDataImpl.STRING);//审核是否通过0通过1不通过
		 dImpl.update();
	}

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
		dImpl.closeStmt();
	if(dCn != null)
		dCn.closeCn();
}
response.sendRedirect("photoCheck.jsp");
%>