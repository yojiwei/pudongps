<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
	String operatetype = CTools.dealString(request.getParameter("operatetype")).trim();
  String cwids = CTools.dealString(request.getParameter("cwids")).trim();
  String [] cw_id = cwids.split(",");
  String cw_feedback = "";
  String FinishTime = CDate.getNowTime();
  //System.out.println(operatetype+"=========cwids=========="+cwids);
  
//处理重复信件
CDataCn dCn=null;   //
CDataImpl dImpl=null;  //

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 
 dCn.beginTrans();

if("rublish".equals(operatetype)){
	cw_feedback = "该件不做信访件处理，谢谢。";
	for(int j=0;j<cw_id.length;j++)
	{
		  dImpl.edit("tb_connwork","cw_id",cw_id[j]);
		  dImpl.setValue("cw_status","9",CDataImpl.INT);//垃圾信件
		  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE);//办结时间
		  dImpl.update();
		  dImpl.setClobValue("cw_feedback",cw_feedback);
	}
}else if("turnto".equals(operatetype)){
	for(int j=0;j<cw_id.length;j++)
	{
		  dImpl.edit("tb_connwork","cw_id",cw_id[j]);
		  dImpl.setValue("cw_zhuanjiao","0",CDataImpl.INT);//0待转交信件
		  dImpl.update();
	}	
}else if("chongfu".equals(operatetype)){
	cw_feedback = "请勿重复提交邮件，谢谢。";
	for(int j=0;j<cw_id.length;j++)
	{
		  dImpl.edit("tb_connwork","cw_id",cw_id[j]);
		  dImpl.setValue("cw_status","12",CDataImpl.INT);//重复信件
		  dImpl.setValue("cw_finishtime",FinishTime,CDataImpl.DATE);//办结时间
		  dImpl.update();
		  dImpl.setClobValue("cw_feedback",cw_feedback);
		  dImpl.setClobValue("cw_chongfu",cw_feedback);
	}
}

dCn.commitTrans();

} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
  
  response.sendRedirect("AppealList.jsp?cw_status=1");
%>

