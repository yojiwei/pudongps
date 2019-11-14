<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@include file="../skin/head.jsp"%>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
   com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
  myUpload.initialize(pageContext);
  myUpload.setDeniedFilesList("exe,bat,jsp");
  myUpload.upload();
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
  String lwf_id = "-1";
	String th_title=CTools.dealNull(myUpload.getRequest().getParameter("ct_title"));
  String OPType=CTools.dealNull(myUpload.getRequest().getParameter("OPType"));
  String ct_inserttime=CTools.dealNull(myUpload.getRequest().getParameter("ct_inserttime"));
  String ctContent=CTools.dealNull(myUpload.getRequest().getParameter("CT_content"));
  String th_id=CTools.dealNull(myUpload.getRequest().getParameter("th_id"));
  String ai_start_timehx = CTools.dealNull(myUpload.getRequest().getParameter("ai_start_timehx"));
  String ai_start_timeex = CTools.dealNull(myUpload.getRequest().getParameter("ai_start_timeex"));
  String ai_end_timehx = CTools.dealNull(myUpload.getRequest().getParameter("ai_end_timehx"));
  String ai_end_timeex = CTools.dealNull(myUpload.getRequest().getParameter("ai_end_timeex"));
  String ai_isok = CTools.dealNull(myUpload.getRequest().getParameter("ai_isok"));
	String th_maxnum =  CTools.dealNull(myUpload.getRequest().getParameter("th_maxnum"));
	String th_powercode = CTools.dealNull(myUpload.getRequest().getParameter("th_powercode"));
	String th_display = CTools.dealNull(myUpload.getRequest().getParameter("dis"));
	String th_iscomment = CTools.dealNull(myUpload.getRequest().getParameter("th_iscomment"));
	String th_votetype = CTools.dealNull(myUpload.getRequest().getParameter("th_votetype"));
  String filePath = CTools.dealUploadString(myUpload.getRequest().getParameter("filePath"));
  String backUrl = CTools.dealUploadString(myUpload.getRequest().getParameter("backUrl"));
  String contype = CTools.dealUploadString(myUpload.getRequest().getParameter("contype"));
  String deptinfo = CTools.dealUploadString(myUpload.getRequest().getParameter("deptinfo"));
	String th_colnum = CTools.dealUploadString(myUpload.getRequest().getParameter("th_colnum"));
	CDate oDate = new CDate();
	String [] filename = null;
  String [] fileRealName = null;
	String sToday = oDate.getThisday();	
    dCn.beginTrans();
    String th_starttime = ai_start_timehx + " " + ai_start_timeex + ":00";
    String th_stoptime = ai_end_timehx + " " + ai_end_timeex + ":00";
    dImpl.setTableName("tb_votetheame");
    dImpl.setPrimaryFieldName("th_id");
   if(OPType.equals("Add"))
    {
			lwf_id = Long.toString(dImpl.addNew());	
			//out.print("<br>lwf_id:"+lwf_id);
     }
    else if(OPType.equals("Edit"))
   {
		dImpl.edit("tb_votetheame","th_id",Integer.parseInt(th_id));
    lwf_id=th_id;
    }
  dImpl.setValue("th_starttime",th_starttime,CDataImpl.STRING);
  dImpl.setValue("th_stoptime",th_stoptime,CDataImpl.STRING);
  dImpl.setValue("ai_start_timehx",ai_start_timehx,CDataImpl.STRING);
  dImpl.setValue("ai_start_timeex",ai_start_timeex,CDataImpl.STRING);
  dImpl.setValue("ai_end_timehx",ai_end_timehx,CDataImpl.STRING);
  dImpl.setValue("ai_end_timeex",ai_end_timeex,CDataImpl.STRING);
  //update by yo 20081111
  dImpl.setValue("ai_isok",ai_isok,CDataImpl.STRING);
  //update by yo 20100520
  dImpl.setValue("ai_backurl",backUrl,CDataImpl.STRING);
  dImpl.setValue("ai_contype",contype,CDataImpl.STRING);
  dImpl.setValue("ai_deptinfo",deptinfo,CDataImpl.STRING);
  //
  dImpl.setValue("th_title",th_title,CDataImpl.STRING);
  dImpl.setValue("th_content",ctContent,CDataImpl.SLONG);
  dImpl.setValue("th_maxnum",th_maxnum,CDataImpl.STRING);
  dImpl.setValue("th_powercode",th_powercode,CDataImpl.STRING);
  dImpl.setValue("th_display",th_display,CDataImpl.STRING);
  dImpl.setValue("th_iscomment",th_iscomment,CDataImpl.STRING);
  dImpl.setValue("th_votetype",th_votetype,CDataImpl.STRING);
  dImpl.setValue("th_colnum",th_colnum,CDataImpl.STRING);
  dImpl.update();
  String path = Messages.getString("filepath");
  int count = myUpload.getFiles().getCount(); //上传文件个数
  //modify for hh
  //没有附件的时候不用新建文件夹
  
  if (count > 0 ) {
	 
	  if (filePath.equals("")) //附件的存放目录不存在
	  {
	    int numeral = 0;
	    numeral =(int)(Math.random()*100000);
	    filePath = sToday + Integer.toString(numeral);
	    java.io.File newDir = new java.io.File(path + filePath);
		
	    if(!newDir.exists())
	    {
	      newDir.mkdirs();
	    }
	  }
	  count = myUpload.save(path + filePath,2);//保存文件
	
	  if(count>=1) {
	    filename = new String[count];
	    fileRealName = new String[count];
	  }
	
	  for(int i=0;i<count;i++)
	  {
	    filename[i] =myUpload.getFiles().getFile(i).getFileName();
	
	    int filenum = 0;
	    filenum =(int)(Math.random()*100000);
	
	    String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].lastIndexOf("."));
	    fileRealName[i] = realName;

	    java.io.File file = new java.io.File(path + filePath + "\\\\" +filename[i]);
	    java.io.File file1 = new java.io.File(path + filePath + "\\\\" +realName);
	    file.renameTo(file1);
	    
		  		dImpl.addNew("tb_voteattach","va_id");
          dImpl.setValue("th_id",lwf_id,CDataImpl.STRING);  
          dImpl.setValue("va_path",filePath,CDataImpl.STRING);
          dImpl.setValue("va_filename",filename[i],CDataImpl.STRING);
          dImpl.setValue("va_realname",fileRealName[i],CDataImpl.STRING);
		  		dImpl.update();
	  }
  }
 /* if(OPType.equals("Add"))
  {
    dImpl.update();
    dImpl.setTableName("tb_votetheame");
    dImpl.setPrimaryFieldName("th_id");
    String lwf_id = "-1";

    lwf_id = Long.toString(dImpl.addNew());
    dImpl.setValue("th_title",th_title,CDataImpl.STRING);
    dImpl.setValue("th_content",ctContent,CDataImpl.STRING);
    dImpl.setValue("th_starttime",ct_inserttime,CDataImpl.STRING);
    dImpl.update() ;
}*/
if (!lwf_id.equals("-1"))
{	
	dCn.commitTrans();
%>
<script language="javascript">
	alert("操作已成功！");
	window.location="SubjectList.jsp";
</script>
<%
}
else
{
dCn.rollbackTrans();
%>
<script language="javascript">
	alert("发生错误，录入失败！");
	window.history.go(-1);
</script>
<%
}	

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
  </body>
</html>
