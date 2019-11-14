<%@include file="/system/app/skin/import.jsp"%>
<%
   //update20080122

CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

    String cw_id = request.getParameter("cw_id").toString();//编号
    String feedback = "已经通过E-mail反馈！";
    dCn.beginTrans();
    dImpl.edit("tb_connwork","cw_id",cw_id);//修改网上投诉
    dImpl.setValue("cw_status","2",CDataImpl.INT);//投诉状态

    dImpl.update();
    dImpl.setClobValue("cw_feedback",feedback);//投诉反馈
    
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
    response.sendRedirect("AppealList.jsp?cw_status=2");
%>
