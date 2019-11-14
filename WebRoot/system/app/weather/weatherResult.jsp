<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.beyondbit.dataexchange.*,org.apache.log4j.*" %>
<%@include file="../skin/import.jsp"%>

<%
Timestamp ts=new Timestamp(System.currentTimeMillis()); 
String systemTime=ts.toString();

  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
try {
	dCn = new CDataCn(); 
	dImpl = new CDataImpl(dCn); 

	String sql="";//查询条件
	String OPType="";//操作方式 Add是添加 Edit是修改

	String WF_id=""; //主键
	String WF_publish_time=""; //天气预报发布时间
	String WF_contentch="";; //中文天气预报内容
	String WF_contenten=""; //英文天气预报内容
	String mydtid= String.valueOf(mySelf.getDtId());
	/*得到上一个页面传过来的参数  开始*/

	WF_id=CTools.dealString(request.getParameter("WF_id")).trim();
	OPType=CTools.dealString(request.getParameter("OPType")).trim();
	WF_publish_time=CTools.dealString(request.getParameter("WF_publish_time")).trim();//天气预报发布日期
	WF_contentch=CTools.dealString(request.getParameter("WF_contentch")).trim();//中文天气预报内容
	WF_contenten=CTools.dealString(request.getParameter("WF_contenten")).trim();//英文天气预报内容
	String messages = CTools.dealString(request.getParameter("messages")).trim();
	messages=messages+" 详见“上海浦东”";
	String my_sj_id = CTools.dealString(request.getParameter("mysj_id")).trim();
	String cctid="";

	dCn.beginTrans();

	  try
	  {
		dImpl.setTableName("tb_weatherforecast");
		dImpl.setPrimaryFieldName("wf_id");
		String lwf_id = "-1";
		
		if (OPType.equals("Add")){
		  lwf_id = Long.toString(dImpl.addNew());
		}
		else if (OPType.equals("Edit"))
		{
		  dImpl.edit("tb_weatherforecast","wf_id",Integer.parseInt(WF_id));
		  lwf_id=WF_id;
		}
		dImpl.setValue("wf_publish_time",WF_publish_time,CDataImpl.STRING);
		dImpl.setValue("wf_contentch",WF_contentch,CDataImpl.STRING);
		dImpl.setValue("wf_contenten",WF_contenten,CDataImpl.STRING);
		dImpl.setValue("wf_input_time",systemTime,CDataImpl.STRING);

		dImpl.update() ;
	

if (!lwf_id.equals("-1"))		//先都发布
{
//------------------------------短信频道----------------------------------
	if(!messages.equals(" 详见“上海浦东”")&&!"".equals(messages))
	{
	String sm_tel="";
	String sm_con =messages;
	int sm_flag=2; //发送与否的标志没有发送1发送成功0发送失败3正在发送中.......
	int sm_flagtoo=10;//发送级别的标志发送的是短信内容
	int ischeck=1;//待审核没有通过3通过2
	
	dImpl.addNew("tb_sms","sm_id");
	dImpl.setValue("sm_tel", sm_tel, CDataImpl.STRING);// 用户手机号码----保存为空
	dImpl.setValue("sm_con", sm_con, CDataImpl.STRING);// 发送内容----------手机短信
	dImpl.setValue("sm_flag", String.valueOf(sm_flag), CDataImpl.STRING);// 发送与否的标志1已发送2没有发送
	dImpl.setValue("sm_flagtoo", String.valueOf(sm_flagtoo), CDataImpl.STRING);//发送的优先级别1发送验证码快10发送短信内容垃圾
	dImpl.setValue("sm_check",String.valueOf(ischeck),CDataImpl.STRING);//待审核的标志
	dImpl.setValue("sm_dtid", mydtid, CDataImpl.STRING);//部门ID
	dImpl.setValue("sm_sj_id",my_sj_id,CDataImpl.STRING);//所属栏目ID
	dImpl.setValue("sm_sendtime",WF_publish_time,CDataImpl.DATE);	//发布的时间
	dImpl.setValue("sm_ct_id",lwf_id,CDataImpl.STRING);	//跟发布的哪个信息有关
	dImpl.update();
	dImpl.setClobValue("sm_detail",WF_contentch);//短信详细内容
	}
//------------------------------短信频道----------------------------------
	dCn.commitTrans();

	
/*
	if (OPType.equals("Add")){
	   ThreadCache.pushItem(String.valueOf(lwf_id),"0","天气预报","271","http://in-inforportal.pudong.sh/sites/manage");
	   ThreadCache.pushItem(String.valueOf(lwf_id),"0","天气预报","270","http://inforportal.pudong.sh/sites/manage");
	}else if (OPType.equals("Edit")){
	   ThreadCache.pushItem(String.valueOf(lwf_id),"1","天气预报","271","http://in-inforportal.pudong.sh/sites/manage");
	   ThreadCache.pushItem(String.valueOf(lwf_id),"1","天气预报","270","http://inforportal.pudong.sh/sites/manage");
	}
*/
		
%>
  <script LANGUAGE="javascript">
  alert("发布成功！");
  window.location="weatherList.jsp";
  </script>
<%
}
else
{
%>
	<script language="javascript">
		alert("发生错误，请再试一次，如仍有问题请联系管理员！");
		window.history.go(-1);
	</script>
<%	
}
}
catch(Exception e)
{
	out.println("error message:" + e.getMessage() +e.toString() );
}
}
catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>

