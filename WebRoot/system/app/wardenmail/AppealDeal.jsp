<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%

    java.util.Date FinishTime = new java.util.Date();
  
    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

		String strStatus = CTools.dealString(request.getParameter("status")).trim();
		if (strStatus.equals(""))
		{
			strStatus = "3";
		}

    String cw_id = request.getParameter("cw_id").toString();//编号
    String feedback = "已经通过E-mail反馈！";
    dCn.beginTrans();
    dImpl.edit("tb_connwork","cw_id",cw_id);//修改网上投诉
    dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态
    dImpl.setValue("cw_finishtime",FinishTime.toLocaleString(),CDataImpl.DATE); //处理完成时间

    dImpl.update();
    dImpl.setClobValue("cw_feedback",feedback);//投诉反馈
    
    dCn.commitTrans();
    dImpl.closeStmt();
    dCn.closeCn();
    
    response.sendRedirect("AppealList.jsp?cw_status="+strStatus);
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
