<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.PublishOperate" %>
<%@ page import="com.beyondbit.web.form.TaskInfoForm" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.component.database.CDataControl" %>
<%@ page import="com.beyondbit.web.publishinfo.Messages,com.smsCase.*" %>
<%@ page import="com.website.*,com.smsCase.SmpService,java.util.*,java.util.Date,java.text.SimpleDateFormat,com.smsCase.*" %>
<%@include file="../skin/head.jsp"%>
<html>
<body>
<%
  
String sj_id="";
String sendtime=(String)request.getParameter("sendtime");//发布时间
String content = (String)request.getParameter("content1");//发布的内容
String ttid = (String)request.getParameter("ttid");//判断是不是点击暂存发过来的。
String sj_id1 = (String)request.getParameter("sjId");//发布所属的栏目
String ModuleDirIds=(String)request.getParameter("ModuleDirIds");//从树中所选的啊
String ct_content1=(String)request.getParameter("CT_content");//发布的内容
String ct_content=new String(ct_content1.getBytes("ISO-8859-1"),"gbk");
String sm_ct_id=CTools.dealString(request.getParameter("sm_ct_id"));
String sm_id1=CTools.dealString(request.getParameter("sm_id"));
String dt_id=CTools.dealString(request.getParameter("dt_id"));//部门ID
String content2=new String(content.getBytes("ISO-8859-1"),"gbk");
if(ttid!=null){
content2=content2;
}else{
content2=content2+" 详见“上海浦东”";
}
String id=request.getParameter("id");//标识是保存还是保存并发送
String sendflag="";//发布状态1表示已经发送过0表示还未发送过
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String mydtid= String.valueOf(mySelf.getDtId());
if(ModuleDirIds!=null)
{
	sj_id=ModuleDirIds;
}
else
{
	sj_id=sj_id1;
}
String strId="";


CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象
CDataControl ctrol = new CDataControl();//操作数据库的东西
Hashtable contentsh=new Hashtable();
Hashtable contentwh=new Hashtable();
Hashtable contentxf=new Hashtable();
Hashtable contentyn = new Hashtable();
Hashtable contentlz = new Hashtable();
Hashtable contentjd = new Hashtable();


//System.out.println("叶面开始");
//*************************************************保存并发送给所有订制了该栏目的用户******或者是点击了未发送时所作的动作
if(id==null)
{
//---------------------如果是从列表里面点击未发送的话，就要删除原来的那个东西，再保存啦
if(sm_id1!=null)
{
String delSql="delete from tb_sms where sm_id="+sm_id1+"";
ctrol.executeUpdate(delSql);
}

//----------------------先保存到tb_sms表中sm_flag=2未发送状态
String phoneSql="select u.ut_tel from tb_usertake u where u.ut_id in (select s.userid from subscibesetting s where s.subjectid="+sj_id+")";
	Vector vectors1 = dImpl.splitPage(phoneSql,request,20);
	if(vectors1!=null)
	{
		int i=0;
		String userTel[] = new String[vectors1.size()]; //存放订制用户的手机号码
		for(int z=0;z<vectors1.size();z++)
		{
			contentwh=(Hashtable)vectors1.get(z);
			userTel[i++]=contentwh.get("ut_tel").toString();
		}
	
	   //我需要先在tb_sms表中保存一条电话号码为空的信息
	    String my_tel="";
		String my_id="";
		
		dImpl.setTableName("tb_sms");
		dImpl.setPrimaryFieldName("sm_id");
		
		dCn.beginTrans();
		
		String xlSql = "select max(sm_id) as sm_id from tb_sms";
		contentjd = (Hashtable)dImpl.getDataInfo(xlSql);
		if (contentjd != null) {
			strId = contentjd.get("sm_id").toString();
		}
		String sjFirId2 = strId;
		sjFirId2 = String.valueOf(dImpl.addNew()); // 主键自增好吧
		strId = sjFirId2;
		dImpl.setValue("sm_tel", my_tel, CDataImpl.STRING);// 用户手机号码
		dImpl.setValue("sm_con", content2, CDataImpl.STRING);// 发送内容--------手机验证码--手机短信
		dImpl.setValue("sm_flag", "2", CDataImpl.STRING);// 发送与否的标志1已发送2没有发送
		dImpl.setValue("sm_flagtoo", "10", CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
		dImpl.setValue("sm_check","1",CDataImpl.STRING);//审核通过的标志1待审核状态
		dImpl.setValue("sm_sj_id",sj_id,CDataImpl.STRING);//所属栏目ID
		dImpl.setValue("sm_dtid", mydtid, CDataImpl.STRING);//部门ID
		dImpl.setValue("sm_sendtime",sendtime,CDataImpl.DATE);	//发布的时间
		dImpl.update();
		
		dImpl.setClobValue("sm_detail",ct_content);//短信详细内容
		dCn.commitTrans();
		
	   ////////////
//订制内容      content2
//发送时间      sendtime
//发送人的账号  userAccount
//密码          password
//短信平台分布给用户的appCode--------contact
//调用发送用户订阅栏目的接口--

/*

	for(int h=0;h<userTel.length;h++)
	{
		int sm_flag=3; //发送与否的标志3正在发送中。。。。。
		int sm_flagtoo=10;//发送级别的标志
		int sm_check=2;//审核不通过3通过2
		String sm_id="";
		
		dImpl.setTableName("tb_sms");
		dImpl.setPrimaryFieldName("sm_id");
		String xxSql = "select max(sm_id) as sm_id from tb_sms";
		contentlz = (Hashtable)dImpl.getDataInfo(xxSql);
		if (contentlz != null) {
			strId = contentlz.get("sm_id").toString();
		}
		String sjFirId = strId;
		sjFirId = String.valueOf(dImpl.addNew()); // 主键自增好吧
		strId = sjFirId;
		dImpl.setValue("sm_tel", userTel[h], CDataImpl.STRING);// 用户手机号码
		dImpl.setValue("sm_con", content2, CDataImpl.STRING);// 发送内容--------手机验证码--手机短信
		dImpl.setValue("sm_flag", String.valueOf(sm_flag), CDataImpl.STRING);// 发送与否的标志1已发送2没有发送
		dImpl.setValue("sm_flagtoo", String.valueOf(sm_flagtoo), CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
		dImpl.setValue("sm_check",String.valueOf(sm_check),CDataImpl.STRING);//审核通过的标志
		dImpl.setValue("sm_sj_id",sj_id,CDataImpl.STRING);//所属栏目ID
		dImpl.setValue("sm_dtid", mydtid, CDataImpl.STRING);//部门ID
		dImpl.setValue("sm_detail", ct_content, CDataImpl.STRING);//短信的详细信息
		dImpl.setValue("sm_sendtime",sendtime,CDataImpl.DATE);	//发布的时间
		dImpl.update();

	}	
	
*/
	
	 
 }
//----------------------保存到subscibeLog表中
    String suSql="select u.id from subscibesetting u where u.subjectid="+sj_id;
	Vector vectors = dImpl.splitPage(suSql,request,20);
	dImpl.setTableName("subscibeLog");//哪个表
	dImpl.setPrimaryFieldName("id");//表的主键
	if(vectors!=null)
	{
		for(int z1=0;z1<vectors.size();z1++)
		{
			contentxf=(Hashtable)vectors.get(z1);
			String ssSql="select max(id) from subscibeLog";
			Vector vectorPage = dImpl.splitPage(ssSql,request,20);
			if(vectorPage!=null)
			 {
			  for(int j=0;j<vectorPage.size();j++)
			   {
				contentsh = (Hashtable)vectorPage.get(j);
				strId=contentsh.get("max(id)").toString();
				}
			}
			String sjFirId = strId;
			sjFirId = String.valueOf(dImpl.addNew());          //主键自增好吧
			strId=sjFirId;
			sendflag="1";//1代表发送过
			dImpl.setValue("sendtime",sendtime,CDataImpl.DATE);		
			dImpl.setValue("subscibeid",contentxf.get("id").toString(),CDataImpl.STRING);        //订制用户的ID
			dImpl.setValue("content",content2,CDataImpl.STRING);
			dImpl.setValue("sendflag",sendflag,CDataImpl.STRING);
			dImpl.setValue("sj_id",sj_id,CDataImpl.STRING);
			dImpl.update();
			//删除subscibeid为空的那一条
			if(content2!=null){
			String mysql="delete from subscibelog where content='"+content2+"' and subscibeid is null";
			ctrol.executeUpdate(mysql);
			}
			//System.out.println("保存并发送");
		}
	}
    else
	{
      out.println("<script language=\"javascript\">alert(\"暂时无人订阅请点击保存!\");window.history.go(-1);</script>");
	}
}
//**********************************************************************只是保存.......
else
{
//////////////////--------------------先保存一份到tb_sms表里央----sm_flag=4暂存sm_check=1待审核--------
		String sm_tel="";
		String sm_con =content2;
		String strId1="";
		int sm_flag=4; //只是保存的状态
		int sm_flagtoo=10;//发送级别的标志
		int ischeck=1;//待审核
		String sm_id="";
		String cctid = "";
		dImpl.setTableName("tb_sms");
		dImpl.setPrimaryFieldName("sm_id");
		
		dCn.beginTrans();
		
		String xxSql = "select max(sm_id) as sm_id from tb_sms";
		contentyn = (Hashtable)dImpl.getDataInfo(xxSql);
		if (contentyn != null) {
			strId = contentyn.get("sm_id").toString();
		}
		String sjFirId = strId;
		sjFirId = String.valueOf(dImpl.addNew()); // 主键自增好吧
		strId = sjFirId;
		dImpl.setValue("sm_tel", sm_tel, CDataImpl.STRING);// 用户手机号码
		dImpl.setValue("sm_con", sm_con, CDataImpl.STRING);// 发送内容--------手机验证码--手机短信
		dImpl.setValue("sm_flag", String.valueOf(sm_flag), CDataImpl.STRING);// 发送与否的标志1已发送2没有发送
		dImpl.setValue("sm_flagtoo", String.valueOf(sm_flagtoo), CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
		dImpl.setValue("sm_check",String.valueOf(ischeck),CDataImpl.STRING);//审核没有通过的标志
		dImpl.setValue("sm_dtid", mydtid, CDataImpl.STRING);//部门ID
		dImpl.setValue("sm_sj_id",sj_id,CDataImpl.STRING);//所属栏目ID
		dImpl.setValue("sm_sendtime",sendtime,CDataImpl.DATE);	//发布的时间
		dImpl.setValue("sm_ct_id",cctid,CDataImpl.STRING);	//自已发的跟别人无关所以为空
		dImpl.update();
		
		dImpl.setClobValue("sm_detail",ct_content);//短信详细内容
		dCn.commitTrans();
		
		
////////////////----------------------再保存一份到subscibeLog表里面----------
			dImpl.setTableName("subscibeLog");
		    dImpl.setPrimaryFieldName("id");
			String ssSql="select max(id) from subscibeLog";
			Vector vectorPage = dImpl.splitPage(ssSql,request,20);
			if(vectorPage!=null)
			 {
			  for(int j=0;j<vectorPage.size();j++)
			   {
				contentsh = (Hashtable)vectorPage.get(j);
				strId=contentsh.get("max(id)").toString();
				}
			}
			String sjFirId1 = strId;
			sjFirId1 = String.valueOf(dImpl.addNew()); //主键自增好吧
			strId=sjFirId1;
			sendflag="0";//1代表发送过0只是保存 
			dImpl.setValue("sendtime",sendtime,CDataImpl.DATE);		
			dImpl.setValue("content",content2,CDataImpl.STRING);
			dImpl.setValue("sendflag",sendflag,CDataImpl.STRING);
			dImpl.setValue("sj_id",sj_id,CDataImpl.STRING);
			dImpl.update();
}
//-------------------------------终结者
out.println("<script language=\"javascript\">alert(\"操作成功\");window.location=\"UserNoteList.jsp?sj_id="+sj_id+"\";</script>");
//System.out.println("叶面结束 ");
dImpl.closeStmt();
dCn.closeCn();
%>
</body>
</html>