<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%

  String  strId="0";
  String DL_title="";
  String DL_keywords="";
  String DL_publish_flag="";
  String DL_create_time="";
  String SJ_id="";
  String DL_desc="";
  String DL_directory_name="";
  String DL_file_name="";
  String DL_file_size="";

  String OPType="";

  strId=CTools.dealString (request.getParameter("DL_id").trim());
  DL_title=CTools.dealString (request.getParameter("DL_title"));
  DL_keywords=CTools.dealString (request.getParameter("DL_keywords"));
  DL_publish_flag=CTools.dealNumber (request.getParameter("DL_publish_flag"));
  DL_create_time=CTools.dealString (request.getParameter("DL_create_time"));
  SJ_id=CTools.dealString (request.getParameter("sj_id"));
  DL_desc=CTools.dealString (request.getParameter("DL_desc"));
  DL_directory_name=CTools.dealString (request.getParameter("DL_directory_name"));
  DL_file_name=CTools.dealString (request.getParameter("DL_file_name"));
  DL_file_size=CTools.dealNumber (request.getParameter("DL_file_size"));
  OPType=CTools.dealString (request.getParameter("OPType"));



//strFaqPf="0";
//out.println("-"+strFaqPf+"-");
//out.close();
if (DL_publish_flag==null || DL_publish_flag=="0")
   DL_publish_flag="0";
 else
   DL_publish_flag="1";
/*
 out.println("-"+strId+"-");
 out.println("-"+DL_title+"-");
 out.println("-"+DL_keywords+"-");
 out.println("-"+DL_create_time+"-");
 out.println("-"+SJ_id+"-");
 out.println("-"+DL_desc+"-");
 out.println("-"+OPType+"-");
 out.println("-"+DL_publish_flag+"-");
 */
 //out.close();

 //OPType=request.getParameter("OPType").trim();


//out.close();
//OPType = "Add";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
try
{
  dImpl.setTableName("tb_download");
  dImpl.setPrimaryFieldName("dl_id");
  if (OPType.equals("Add")||OPType.equals(""))
  {  dImpl.addNew();
  out.println("-"+OPType+"-");}
  else if (OPType.equals("Edit"))
   { out.println("-"+OPType+"-");
    dImpl.edit("tb_download","dl_id",Integer.parseInt(strId));
   }
//out.close();
  dImpl.setValue("dl_title",DL_title,CDataImpl.STRING);
  dImpl.setValue("dl_keywords",DL_keywords,CDataImpl.STRING);
  dImpl.setValue("dl_publish_flag",DL_publish_flag,CDataImpl.INT);
  dImpl.setValue("dl_create_time",DL_create_time,CDataImpl.STRING);
  dImpl.setValue("sj_id",SJ_id,CDataImpl.INT);
  dImpl.setValue("dl_desc",DL_desc,CDataImpl.STRING);
  dImpl.setValue("dl_directory_name",DL_directory_name,CDataImpl.STRING);
  dImpl.setValue("dl_file_name",DL_file_name,CDataImpl.STRING);
  dImpl.setValue("dl_file_size",DL_file_size,CDataImpl.INT);

  dImpl.update() ;
  dImpl.closeStmt();
  dCn.closeCn();
  response.sendRedirect("downloadList.jsp");
}
catch(Exception e)
{
  out.println("error message:" + e.getMessage() +e.toString() );
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
%>