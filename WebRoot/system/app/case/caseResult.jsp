<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
  java.util.Date dateCreated = new java.util.Date();
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String cp_id = CTools.dealString(request.getParameter("type"));
  String cs_id = CTools.dealString(request.getParameter("cs_id"));
  String cs_title = CTools.dealString(request.getParameter("cs_title"));
  String cs_content = CTools.dealString(request.getParameter("cs_content"));
  String cs_date = CTools.dealString(request.getParameter("beginTime"));
  String OPType ="Add";
  if(!cs_id.equals("")){
       OPType ="Edit";
   }
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

 

  dCn.beginTrans();
  dImpl.setTableName("tb_conncase");
  dImpl.setPrimaryFieldName("cs_id");
  if(OPType.equals("Add")){
	  dImpl.addNew();    
	  dImpl.setValue("dt_id",selfdtid,CDataImpl.INT);
      dImpl.setValue("cp_id",cp_id,CDataImpl.STRING);
	  dImpl.setValue("dateCreated",dateCreated.toLocaleString(),CDataImpl.DATE);
  }
  else if(OPType.equals("Edit")){
	  dImpl.edit("tb_conncase","cs_id",Integer.parseInt(cs_id)); 
 }
  
  dImpl.setValue("cs_title",cs_title,CDataImpl.STRING);
 //dImpl.setValue("cs_content",cs_content,CDataImpl.STRING);
  dImpl.setValue("cs_date",cs_date,CDataImpl.DATE);
  dImpl.update();
  dImpl.setClobValue("cs_content",cs_content);

if (dCn.getLastErrString().equals(""))
{	
	dCn.commitTrans();
	response.sendRedirect("caseList.jsp?type="+cp_id);
}else{
	dCn.rollbackTrans();
	out.print("保存失败！");
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

