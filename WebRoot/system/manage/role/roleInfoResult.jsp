<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.platform.role.*" %>
<%@page import="com.component.database.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.util.CTools" %>
<%@ page import="com.platform.CManager" %>
<%
  String tr_id;
  String tr_name;
  String tr_detail;
  String tr_level;
  String url = "";
  String msg = "";
  String tr_createBy = "";
  String dt_id = "";
  long id;
%>
<%
  CDataCn dCn=null;
  CRoleInfo jdo = null;
  try{
  	dCn=new CDataCn();
  	jdo = new CRoleInfo(dCn);
  CManager manage = (CManager)session.getAttribute("manager");
  
  //tr_createBy = manage.getLoginName();
  tr_id        = request.getParameter("tr_id");
  tr_name      = CTools.iso2gb(request.getParameter("tr_name"));
  tr_detail    = CTools.iso2gb(request.getParameter("tr_detail"));
  tr_level     = request.getParameter("tr_level");
  dt_id		   = CTools.dealNumber(request.getParameter("dt_id"));

    if (tr_id.equals("0")) { //ÐÂÔö
       tr_id = new String().valueOf(jdo.addNew());
       jdo.setValue("tr_type","3",jdo.INT );
    }else{
      id = java.lang.Long.parseLong(tr_id);
      jdo.edit(id);
    }

    jdo.setValue("tr_name",tr_name,jdo.STRING);
    jdo.setValue("tr_detail",tr_detail,jdo.STRING);
    jdo.setValue("tr_level",tr_level,jdo.INT );
    jdo.setValue("tr_createby",tr_createBy,jdo.STRING);
	jdo.setValue("dt_id",dt_id,jdo.INT);
    jdo.update() ;
    jdo.closeStmt();

    url = "roleInfo.jsp?tr_id="+tr_id;

    dCn.closeCn();
    response.sendRedirect(url);
    } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(jdo != null)
	jdo.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>

