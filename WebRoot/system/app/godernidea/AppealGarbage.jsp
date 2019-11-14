<%@include file="../skin/import.jsp"%>
<%
  java.util.Date FinishTime = new java.util.Date();

  String cw_id = request.getParameter("cw_id").toString();
	String serSql="";
	String cw_parentid="";

//update20080122
//author yo
CDataCn dCn=null;  
CDataImpl dImpl=null;  

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
 String app_sql="select cw_parentid from tb_connwork where cw_id='"+cw_id+"'";
 Hashtable contentsh=dImpl.getDataInfo(app_sql);
 if(contentsh!=null){
 	cw_parentid=contentsh.get("cw_parentid").toString();
	if(!"".equals(cw_parentid)){
   serSql="select k.cw_id from tb_connwork k connect by prior k.cw_id=k.cw_parentid start with ";
   serSql+=" k.cw_id in(select cw_parentid from tb_connwork where cw_id='"+cw_id+"') ";
 }else{
 	serSql="select k.cw_id from tb_connwork k where k.cw_id='"+cw_id+"'";
 }
  dCn.beginTrans();
  String strStatus = "9";//标记垃圾信件
  
  Vector vectorPage = dImpl.splitPage(serSql,request,20);
  if(vectorPage!=null){
  for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
	  
	  dImpl.edit("tb_connwork","cw_id",content.get("cw_id").toString());
	  dImpl.setValue("cw_status",CTools.dealNumber(strStatus),CDataImpl.INT);//投诉状态
	  dImpl.setValue("cw_finishtime",FinishTime.toLocaleString(),CDataImpl.DATE); //处理完成时间
	  dImpl.update();
	  dImpl.setClobValue("cw_feedback",CTools.dealString(request.getParameter("feedback")));//投诉反馈
	  
	}
  }
  dCn.commitTrans();
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
  
  response.sendRedirect("AppealList.jsp?cw_status=9");
%>