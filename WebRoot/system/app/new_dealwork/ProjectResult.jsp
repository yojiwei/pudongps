<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
com.app.CMySelf mySelf = (com.app.CMySelf)session.getAttribute("mySelf");
if (mySelf==null)
{
	response.sendRedirect("../logout.jsp");
}
else
{
	String wo_id = "";
	String userName = "";
	String address = "";
	String tel = "";
	String linkMan = "";
	String zipcode = "";
	String IdCard = "";
	String appertain = "";
	String us_id = "";
	String projectName = "";
	String pr_id = "";
	String wa_path = "";
	String path = "";
	
	String [] pa_name;
	String [] pa_id;
	
	//前一个页面form的enctype属性，决定了这里要采用SmartUpload类来接收参数
	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
	myUpload.upload();
	
	userName = CTools.dealUploadString(myUpload.getRequest().getParameter("userName")).trim();
	address = CTools.dealUploadString(myUpload.getRequest().getParameter("address")).trim();
	tel = CTools.dealUploadString(myUpload.getRequest().getParameter("tel")).trim();
	linkMan = CTools.dealUploadString(myUpload.getRequest().getParameter("linkMan")).trim();
	zipcode = CTools.dealUploadString(myUpload.getRequest().getParameter("zipcode")).trim();
	IdCard = CTools.dealUploadString(myUpload.getRequest().getParameter("idCard")).trim();
	appertain = CTools.dealUploadString(myUpload.getRequest().getParameter("appertain")).trim();
	projectName = CTools.dealUploadString(myUpload.getRequest().getParameter("projectName")).trim();
	pr_id = CTools.dealUploadString(myUpload.getRequest().getParameter("projectId")).trim();
	
	pa_name = myUpload.getRequest().getParameterValues("pa_name");
	pa_id = myUpload.getRequest().getParameterValues("pa_id");
	
	User user;//新建用户对象
	%>
	<!--生成临时用户-->
	<%@include file="/website/usercenter/ImpTempUser.jsp"%>
	
	<%
	us_id = user.getId();//获取用户id
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	dCn.beginTrans();
	path = dImpl.getInitParameter("workattach_save_path");
	
	//保存项目信息 
	wo_id = dImpl.addNew("tb_work","wo_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
	
	dImpl.setValue("pr_id",pr_id,CDataImpl.STRING);
	dImpl.setValue("wo_applypeople",userName,CDataImpl.STRING);
	dImpl.setValue("wo_contactpeople",linkMan,CDataImpl.STRING);
	dImpl.setValue("wo_tel",tel,CDataImpl.STRING);
	dImpl.setValue("wo_address",address,CDataImpl.STRING);
	dImpl.setValue("wo_postcode",zipcode,CDataImpl.STRING);
	dImpl.setValue("wo_idcard",IdCard,CDataImpl.STRING);
	dImpl.setValue("wo_projectname",projectName,CDataImpl.STRING);
	dImpl.setValue("us_id",us_id,CDataImpl.STRING);
	dImpl.setValue("WO_STATUS","1",CDataImpl.STRING);//项目状态
	dImpl.setValue("WO_ISSTAT","0",CDataImpl.STRING);//项目是否统计过
	dImpl.setValue("WO_APPLYTIME",new CDate().getNowTime(),CDataImpl.DATE);
	
	dImpl.update();
	dImpl.setClobValue("wo_appertain",appertain);
	
	//保存附件
	int count = myUpload.getFiles().getCount();
	if (count>0)
	{
		if (wa_path.equals(""))//附件存放路径不存在
		{
			CDate oDate = new CDate();
			String sToday = oDate.getThisday();
			int numeral = 0;
			numeral =(int)(Math.random()*100000);
			wa_path = sToday + Integer.toString(numeral);
			java.io.File newDir = new java.io.File(path + wa_path);
			if(!newDir.exists()) //如果目录不存在，则生成目录
			{
			  newDir.mkdirs();
			}
		}
		count = myUpload.save(path+wa_path,2);
		for (int i=0;i<count;i++)
		{
			String fileName = myUpload.getFiles().getFile(i).getFileName();
			java.io.File file = new java.io.File(path + wa_path + "\\" + fileName);
			dImpl.addNew("tb_workattach","wa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
			dImpl.setValue("wo_id",wo_id,CDataImpl.STRING);  //项目id
			dImpl.setValue("wa_path",wa_path,CDataImpl.STRING);//附件存放路径
			dImpl.setValue("wa_fileName",fileName,CDataImpl.STRING);//附件文件名
			dImpl.setValue("pa_id",pa_id[i],CDataImpl.STRING);
			dImpl.setValue("pa_name",pa_name[i],CDataImpl.STRING);
			dImpl.update();
			dImpl.setBlobValue("wa_content",file);
		}
	}
	
	if(!dCn.getLastErrString().equals(""))
	{
		dCn.rollbackTrans();
		%>
		<script>
		alert("发生未知错误，操作不成功！");
		window.history.go(-1);
		</script>
		<%
	}
	else
	{
		dCn.commitTrans();
		%>
		<script>
		window.history.go(-2);
		</script>
		<%
	}
	


<%


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
}
%>
