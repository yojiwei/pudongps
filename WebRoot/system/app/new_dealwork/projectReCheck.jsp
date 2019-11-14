<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%
String wo_id = "";
long count = -1;
String sqlStr = "";
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();

//update20080122
String owSql = "select ow_id,ow_content from tb_onlinework where wo_id = '"+ wo_id +"'";
Hashtable owTable = null;
Vector owList = null;
String ow_contentOld = "";
String ow_contentNew = "";
String owIdLsh = "";
String attPath = "";  //办事保存的路径
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

CDataCn dCnWSB=null;   //新建数据库连接对象
CDataImpl dImplWSB=null;  //新建数据接口对象

sqlStr = " update tb_owexch set oe_status = 0 where oe_id in (select o.oe_id as oe_id from tb_owexch o ,"
		+"tb_work w where o.wo_id =w.wo_id and w.wo_id = '"+ wo_id +"')";
//System.out.println("-------------------------------"+sqlStr);
try{
	dCn = new CDataCn(); 
	dImpl = new CDataImpl(dCn); 
	
	dCnWSB = new CDataCn("wsb"); 
	dImplWSB = new CDataImpl(dCnWSB);
	attPath = dImpl.getInitParameter("wo_attpath");
	//修改tb_owexch 表的 oe_status 的值为 0 
	count = dImpl.executeUpdate(sqlStr);

	//修改流水号--start
	owList = dImplWSB.splitPage(owSql,request,20);
	if(owList != null){
		for(int countLsh = 0 ; countLsh < owList.size(); countLsh++){
			owTable = (Hashtable) owList.get(countLsh);
			ow_contentOld = CTools.dealNull(owTable.get("ow_content"));
		
			//------------修改从文件中读取xml内容---------------start---------------------
			StringBuffer contentStr = new StringBuffer("");
			BufferedReader in = CFile.read(attPath + "\\\\" + ow_contentOld);
			//System.out.println("----------------------------------path = " + attPath + "\\\\" + ow_contentOld);
			String tempStr = "";
			try{
				while((tempStr = in.readLine())!=null){
			 		contentStr.append(tempStr);
				}
			}catch(IOException e){
				e.printStackTrace();
			}
			//------------修改从文件中读取xml内容---------------end-----------------------
			
			ow_contentNew = CwsbTools.tranOwContent(contentStr.toString());
			CFile.write(attPath + "\\\\" + ow_contentOld,ow_contentNew);
			
			//owIdLsh = owTable.get("ow_id").toString();
			//dCnWSB.beginTrans();
			//dImplWSB.edit("tb_onlinework","ow_id",owIdLsh);
			//dImplWSB.setValue("ow_content",ow_contentNew,CDataImpl.SLONG);
			//dImplWSB.update();
			//dCnWSB.commitTrans();
			//dImpl.executeUpdate("update tb_onlinework set ow_content = '"+ ow_contentNew +"' where ow_id = '"+ owIdLsh +"'");
		}
	}
	//修改流水号--end

}catch(Exception e){
	System.out.println("update fail!" + e.getMessage());
}finally{
	dImpl.closeStmt();
	dCn.closeCn();
	dImplWSB.closeStmt();
	dCnWSB.closeCn();
}
out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
if (count <= 0)
{
	out.print("alert('修改状态值时出错！');");
	out.print("window.history.back();");
}
else
{
	out.print("alert('状态修改成功！');");
	out.print("window.location='/system/app/dealwork/WaitList.jsp?Menu=事项受理&Module=待处理业务'");
}

out.print("</SCRIPT>");
%>