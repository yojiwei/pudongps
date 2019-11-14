<%@include file="../include/import.jsp"%>
<%
String isTemp = ""; //暂存的标志位
String wo_id = "";
String us_id = "";
String userName = "";//用户名
String tel = "";      //电话
String address = "";  //地址
String zipcode = ""; //邮政编码
String IdCard = "";  //身份证号或者工商注册号
String linkMan = ""; //联系人
String pr_id = "";   //事项id
String workName = ""; //项目名称
String apperTain = ""; //附言
String wa_path = "";   //附件存放的文件夹
String path = "";     //附件存放的路径

String [] pa_name ;
String [] pa_id;
String [] oAttach; //非项目相关材料的说明

com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
try{
myUpload.initialize(pageContext);
myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限
myUpload.setAllowedFilesList("txt,doc,docx,jpg,jpeg,gif,png,bmp,xls");

myUpload.upload();

//由于前个页面的form的enctype形式，所以这里要采用这种参数接受方式
isTemp = CTools.dealUploadString(myUpload.getRequest().getParameter("isTemp")).trim();
wo_id = CTools.dealUploadString(myUpload.getRequest().getParameter("wo_id")).trim();
userName = CTools.dealUploadString(myUpload.getRequest().getParameter("userName")).trim();
tel = CTools.dealUploadString(myUpload.getRequest().getParameter("tel")).trim();
address = CTools.dealUploadString(myUpload.getRequest().getParameter("address")).trim();
zipcode = CTools.dealUploadString(myUpload.getRequest().getParameter("zipcode")).trim();
IdCard = CTools.dealUploadString(myUpload.getRequest().getParameter("idCard")).trim();
linkMan = CTools.dealUploadString(myUpload.getRequest().getParameter("linkMan")).trim();
pr_id = CTools.dealUploadString(myUpload.getRequest().getParameter("pr_id")).trim();
workName = CTools.dealUploadString(myUpload.getRequest().getParameter("workName")).trim();
apperTain = CTools.dealUploadString(myUpload.getRequest().getParameter("appertain")).trim();
wa_path = CTools.dealUploadString(myUpload.getRequest().getParameter("wo_attach_path")).trim();

pa_name = myUpload.getRequest().getParameterValues("pa_name");
pa_id = myUpload.getRequest().getParameterValues("pa_id");
oAttach = myUpload.getRequest().getParameterValues("fjsm1");

User user = (User)session.getAttribute("user");

if (user==null)//如果用户没有登录，则新生成一个用户名，并登录
{
	%>
	<%@include file="ImpTempUser.jsp"%>
	<%
}
us_id = user.getId();

//新建数据库连接和接口
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
path = dImpl.getInitParameter("workattach_save_path");
dCn.beginTrans();

if(!isTemp.equals("1")) isTemp = "0";
//向tb-work表里插入（更新）数据
if (!wo_id.equals(""))
{
	dImpl.edit("tb_work","wo_id",wo_id);
}
else
{
	wo_id = dImpl.addNew("tb_work","wo_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
}

dImpl.setValue("pr_id",pr_id,CDataImpl.STRING);
dImpl.setValue("wo_applyPeople",userName,CDataImpl.STRING);
dImpl.setValue("wo_contactpeople",linkMan,CDataImpl.STRING);
dImpl.setValue("wo_tel",tel,CDataImpl.STRING);
dImpl.setValue("us_id",us_id,CDataImpl.STRING);
dImpl.setValue("wo_postcode",zipcode,CDataImpl.STRING);
dImpl.setValue("wo_projectname",workName,CDataImpl.STRING);
dImpl.setValue("wo_address",address,CDataImpl.STRING);
dImpl.setValue("wo_idcard",IdCard,CDataImpl.STRING);
if (isTemp.equals("1"))
{
	dImpl.setValue("WO_STATUS","0",CDataImpl.STRING);
}
else
{
	dImpl.setValue("WO_STATUS","1",CDataImpl.STRING);//项目状态
	dImpl.setValue("WO_ISSTAT","0",CDataImpl.STRING);//项目是否统计过
	dImpl.setValue("WO_APPLYTIME",new CDate().getNowTime(),CDataImpl.DATE);//项目的申请时间
}
dImpl.update();

if (!apperTain.equals(""))
{
	dImpl.setClobValue("wo_appertain",apperTain);  //clob字段的特殊性
}


//保存附件到指定目录
int count = myUpload.getFiles().getCount();
if (count>0)
{
	if (wa_path.equals("")) //附件的存放目录不存在
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
	count = myUpload.save(path + wa_path,2);//保存文件
	
	if (count>0)
	{
		//规定上传的附件及其相关信息存放到tb-workattach表里
		int length = 0;
		if (pa_id!=null)
		{
			length = pa_id.length;
			for(int i=0;i<length;i++)
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
		//存放非项目相关附件进数据库
		if (oAttach!=null)
		{
			for (int i=0;i<oAttach.length;i++)
			{
				String fileName = myUpload.getFiles().getFile(i+length).getFileName();
				java.io.File file = new java.io.File(path + wa_path + "\\" + fileName);
				dImpl.addNew("tb_workattach","wa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
				dImpl.setValue("wo_id",wo_id,CDataImpl.STRING);  //项目id
				dImpl.setValue("wa_path",wa_path,CDataImpl.STRING);//附件存放路径
				dImpl.setValue("wa_fileName",fileName,CDataImpl.STRING);//附件文件名
				dImpl.setValue("pa_id","-1",CDataImpl.STRING);
				dImpl.setValue("pa_name",oAttach[i],CDataImpl.STRING);
				dImpl.update();
				dImpl.setBlobValue("wa_content",file);
			} 
		}
	}
}

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dCn.commitTrans();
dImpl.closeStmt();
dCn.closeCn(); 
}

String url = "";
url = "/website/usercenter/index.jsp";
%>
<script language="javascript">
window.location = "<%=url%>";
</script>
<%
}catch(SecurityException se){
%>
	<script language="javascript">
	alert("您上传的附件格式不符合要求,请重新选择！");
	window.history.back();
	</script>
<%
  }
%>