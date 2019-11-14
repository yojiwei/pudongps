<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="java.util.*"%>
<%@page import="Evaluate.*"%>
<%@page import="vote.*"%>


<%
 CDataCn dCn = null;
 CDataImpl dImpl = null;
try{
  dCn = new CDataCn();
  dImpl = new CDataImpl(dCn);
       String  wz_id = "";
		String wz_reciveid = "";
		String wz_applydate = "";
		String wz_subjecttname = "";
		String wz_dealdepat = "";
		String wz_dealperson = "";
		String wz_dealstatus = "";
		String wz_feedback = "";
		String wz_applycompany = "";
		String 	wz_zihao = "" ;
		String wz_tel = "" ; 
		String 	wz_applyname = "" ;
		String 	wz_companyname = "" ;
		String 	wz_conncompany = "" ;
		String 	wz_connperson = "";
		String 	wz_conntel = "" ;
		String	wz_connaddress = "" ;
		

   String OType = CTools.dealString(request.getParameter("OType")).trim();
  wz_id = CTools.dealString(request.getParameter("wz_id")).trim();
  wz_reciveid = CTools.dealString(request.getParameter("wz_reciveid")).trim();  //收文号
  wz_applydate = CTools.dealString(request.getParameter("wz_applydate")).trim();  //申请时间
  wz_subjecttname = CTools.dealString(request.getParameter("wz_subjecttname")).trim();  //项目名称
  wz_dealdepat = CTools.dealString(request.getParameter("wz_dealdepat")).trim();
  wz_dealperson = CTools.dealString(request.getParameter("wz_dealperson")).trim(); //经办人
  wz_dealstatus = CTools.dealString(request.getParameter("wz_dealstatus")).trim();   //处理状态
  wz_feedback =  CTools.dealString(request.getParameter("wz_feedback")).trim();      //回复
 wz_applycompany  =  CTools.dealString(request.getParameter("wz_applycompany")).trim(); // 报送单位
 	wz_zihao = CTools.dealString(request.getParameter("wz_zihao")).trim();
 wz_tel = CTools.dealString(request.getParameter("wz_tel")).trim();       //报送单位电话
wz_applyname  = CTools.dealString(request.getParameter("wz_applyname")).trim();    //报送联系人
wz_conncompany = CTools.dealString(request.getParameter("wz_conncompany")).trim();
wz_companyname  = CTools.dealString(request.getParameter("wz_companyname")).trim();      //项目单位
wz_connperson= CTools.dealString(request.getParameter("wz_connperson")).trim();          //项目联系人
wz_conntel = CTools.dealString(request.getParameter("wz_conntel")).trim();               //项目单位电话
wz_connaddress = CTools.dealString(request.getParameter("wz_connaddress")).trim() ;      //项目单位地址
  if(OType.equals("")) OType="Add";
  dCn.beginTrans();
  if(OType.equals("Edit")){
      dImpl.edit("tb_wzwolinework","wz_id",wz_id);
    }
	else
		{
   wz_id=dImpl.addNew("tb_wzwolinework","wz_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
   }
   

  dImpl.setValue("wz_reciveid",wz_reciveid,CDataImpl.STRING);
 
  dImpl.setValue("wz_applydate",wz_applydate,CDataImpl.STRING);
 
   dImpl.setValue("wz_subjecttname",wz_subjecttname,CDataImpl.STRING);
   
  dImpl.setValue("wz_dealdepat",wz_dealdepat,CDataImpl.STRING);
   
  dImpl.setValue("wz_dealperson",wz_dealperson,CDataImpl.STRING);
 
  dImpl.setValue("wz_dealstatus",wz_dealstatus,CDataImpl.STRING);
  dImpl.setValue("wz_apllycompany",wz_applycompany,CDataImpl.STRING);
   dImpl.setValue("wz_conncompany",wz_conncompany,CDataImpl.STRING);
  dImpl.setValue("wz_zihao",wz_zihao,CDataImpl.STRING);
  dImpl.setValue("wz_tel",wz_tel,CDataImpl.STRING);
  dImpl.setValue("wz_applyname",wz_applyname,CDataImpl.STRING);
  dImpl.setValue("wz_connperson",wz_connperson,CDataImpl.STRING);
  dImpl.setValue("wz_conntel",wz_conntel,CDataImpl.STRING);
  dImpl.setValue("wz_connaddress",wz_connaddress,CDataImpl.STRING);
  dImpl.setValue("wz_companyname",wz_companyname,CDataImpl.STRING);
    //out.print(wz_feedback);
   //if(true) return;
  //dImpl.setValue("wz_feedback",wz_feedback,CDataImpl.STRING);
  //dImpl.setValue("vt_sort",vde_sort,CDataImpl.STRING);
  //dImpl.setValue("vt_parameter",vt_parameter,CDataImpl.STRING);
  dImpl.update();
  dCn.commitTrans();
   dImpl.setClobValue("wz_feedback",wz_feedback);
  
   
  

%>
 <script language="javascript">
  alert("插入成功！");
    window.location="list.jsp"
 </script>
<%
 }
catch(Exception e){
	out.print(e.toString());
	%>
	 <script language="javascript">
  alert("发生错误，录入失败！错误：<%=dCn.getLastErrString()%>");
    window.history.go(-1);
 </script>
	<%
 }
 finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>