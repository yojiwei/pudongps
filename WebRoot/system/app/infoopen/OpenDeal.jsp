<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
    
    //获得时间
    DateFormat df = DateFormat.getDateInstance(DateFormat.DEFAULT , Locale.CHINA);
    String IN_showtime = df.format(new java.util.Date());

 	String io_id = request.getParameter("io_id");
  	String io_reback_kind =  CTools.dealString(request.getParameter("io_reback_kind")).trim();
 	
    String feedback = "已经通过E-mail反馈！";
    dCn.beginTrans();
    
	  dImpl.edit("tb_infoOpen","io_id",io_id);
	  dImpl.setValue("io_status","3",CDataImpl.STRING);//办理状态
	  dImpl.setValue("io_reback ",feedback,CDataImpl.STRING); //反馈信息
	  dImpl.setValue("io_reback_kind ",io_reback_kind,CDataImpl.STRING); //反馈信息类别
	  dImpl.setValue("io_reback_time",IN_showtime,CDataImpl.STRING); //处理完成时间
	  dImpl.update();
    
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
    response.sendRedirect("OpenList.jsp?io_status=3");
%>
