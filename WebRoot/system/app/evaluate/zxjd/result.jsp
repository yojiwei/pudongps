
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
  String vt_name = "";
  String vt_type = "";
  String vt_upperid = "";
  String vt_sequence = "";
  String vt_frontpagename = "";
  String vt_desc = "";
  String vt_parameter = "";
  String vt_parameter_text_1 = "";
  String vt_parameter_text_2 = "";
  String vt_parameter_textarea_1 = "";
  String vt_parameter_textarea_2 = "";
  String vde_type = "";
  String vde_sort = "";
  String OType = "";
  String treeid = "";

  String vde_id="";
  String vde_starttime = "";//开始时间
  String vde_finishtime= "";//结束时间

  String vde_img="";
  String vde_status="";

  String jd_id = "" ;
  String jd_subject = "";
  String jd_date = "";
  String jd_finishdate = "";
  String jd_address = "";
  String jd_depart = "";
  String jd_duty = "";
  String jd_starthours = "";
  String jd_startmin = "";
  String jd_endhours = "";
  String jd_endmin = "";
  String jd_content = "";

   OType = CTools.dealString(request.getParameter("OType")).trim();

  jd_id = CTools.dealString(request.getParameter("jd_id")).trim();
  jd_subject = CTools.dealString(request.getParameter("jd_subject")).trim();
  jd_date = CTools.dealString(request.getParameter("jd_date")).trim();
  jd_finishdate = CTools.dealString(request.getParameter("jd_finishdate")).trim();
  jd_address = CTools.dealString(request.getParameter("jd_address")).trim();
  jd_depart = CTools.dealString(request.getParameter("jd_depart")).trim();
  jd_duty = CTools.dealString(request.getParameter("jd_duty")).trim();
  jd_starthours =  CTools.dealString(request.getParameter("jd_starthours")).trim();
  jd_startmin =  CTools.dealString(request.getParameter("jd_startmin")).trim();
  jd_endhours =  CTools.dealString(request.getParameter("jd_endhours")).trim();
  jd_endmin =  CTools.dealString(request.getParameter("jd_endmin")).trim();
   jd_date = jd_date+" "+jd_starthours+":"+jd_startmin+":"+"00";
   jd_finishdate = jd_finishdate+" "+jd_endhours+":"+jd_endmin+":00";
    jd_content = CTools.dealString(request.getParameter("jd_content")).trim();

 //out.print("vt_desc"+vt_desc);
 //if(true) return;



//  vt_name = CTools.dealString(request.getParameter("vt_name")).trim();
 // vt_type = CTools.dealString(request.getParameter("vt_type")).trim();
 // vt_upperid = CTools.dealString(request.getParameter("vt_upperid")).trim();
 // vt_sequence = CTools.dealString(request.getParameter("vt_sequence")).trim();

 // vt_parameter_text_1 = CTools.dealString(request.getParameter("vt_parameter_text_1")).trim();
 // vt_parameter_text_2 = CTools.dealString(request.getParameter("vt_parameter_text_2")).trim();
 // vt_parameter_textarea_1 = CTools.dealString(request.getParameter("vt_parameter_textarea_1")).trim();
 // vt_parameter_textarea_2 = CTools.dealString(request.getParameter("vt_parameter_textarea_2")).trim();
  
 // treeid = CTools.dealString(request.getParameter("treeid")).trim();
 // vde_starttime=CTools.dealString(request.getParameter("vde_starttime")).trim();
 // vde_finishtime=CTools.dealString(request.getParameter("vde_finishtime")).trim();
 // vde_img=CTools.dealString(request.getParameter("vde_img")).trim();
 // vde_type=CTools.dealString(request.getParameter("vde_type")).trim();
 // vde_sort=CTools.dealString(request.getParameter("vde_sort")).trim();
  if(OType.equals("")) OType="Add";
  //dCn.beginTrans();
  if(OType.equals("Edit")){
      dImpl.edit("tb_onlinesubject","jd_id",jd_id);
    }
	else
		{
   jd_id=dImpl.addNew("tb_onlinesubject","jd_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
   }

  dImpl.setValue("jd_subject",jd_subject,CDataImpl.STRING);
  dImpl.setValue("jd_date",jd_date,CDataImpl.STRING);
   dImpl.setValue("jd_finishdate",jd_finishdate,CDataImpl.STRING);
  dImpl.setValue("jd_address",jd_address,CDataImpl.STRING);
  dImpl.setValue("jd_duty",jd_duty,CDataImpl.STRING);
  dImpl.setValue("jd_depart",jd_depart,CDataImpl.STRING);
  dImpl.setValue("jd_content",jd_content,CDataImpl.STRING);
  //dImpl.setValue("vt_sort",vde_sort,CDataImpl.STRING);
  //dImpl.setValue("vt_parameter",vt_parameter,CDataImpl.STRING);
  dImpl.update();
  // dImpl.setClobValue("jd_content",vt_desc);
   //dCn.commitTrans();
   
  

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