<%@include file="../include/import.jsp"%>
<%

String wo_id = "";
String ow_id = "";
//由于前个页面的form的enctype形式，所以这里要采用这种参数接受方式
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
ow_id = CTools.dealString(request.getParameter("ow_id")).trim();
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

String sql = "";
sql = "DELETE FROM TB_WORK WHERE WO_ID = '"+ wo_id +"' ";
long flag = dImpl.executeUpdate(sql);
System.out.println("delete from tb_work : " + flag);

sql = "DELETE FROM TB_ONLINEWORK WHERE OW_ID = '"+ ow_id +"' ";
flag = dImpl.executeUpdate(sql);
System.out.println("delete from TB_ONLINEWORK : " + flag);

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}

response.sendRedirect("/website/usercenter/zcList.jsp?typeid=1");
%>
