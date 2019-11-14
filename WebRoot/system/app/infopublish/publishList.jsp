<%
/**************************************
this page is made by honeyday 2002-12-6
***************************************/
%>
<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<%
String strTitle = "信息维护";
String node_title=CTools.dealString(request.getParameter("node_title")).trim();
String id = request.getParameter("sj_id");
//if(node_title.equals("气象预报"))response.sendRedirect("../weather/weatherList.jsp");
if(node_title.equals("weather"))response.sendRedirect("../weather/weatherList.jsp");
if(node_title.equals("网上申报"))response.sendRedirect("../proceeding/ProceedingList.jsp?OType=manage&myname=wssb");
if(node_title.equals("外资项目审批结果"))response.sendRedirect("../wzwonlinework/list.jsp");

//不得走出这个框啊，我的地盘
if(node_title.equals("新事项维护"))response.sendRedirect("../proceeding_new/ProceedingList.jsp?OType=manage");
if("28517".equals(id))response.sendRedirect("../proceeding_new/ProceedingList.jsp?OType=manage");

if(node_title.equals("事项维护"))response.sendRedirect("../proceeding/ProceedingList.jsp?OType=manage");
if(node_title.equals("街镇领导信箱"))response.sendRedirect("../leadbox/leadBoxList.jsp");
if("6457".equals(id))response.sendRedirect("../leadbox/leadBoxList.jsp");
if(node_title.equals("特别推荐"))response.sendRedirect("../sugandquestion/SuggestionList.jsp");
//if(node_title.equals("常见问题解答"))response.sendRedirect("../sugandquestion/QuestionList.jsp");
if(node_title.equals("餐饮"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=餐饮&SmallSort=食';</script>");
if(node_title.equals("政府机关"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=单位&SmallSort=政府机关';</script>");
if(node_title.equals("街镇驻地"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=单位&SmallSort=街镇驻地';</script>");
if(node_title.equals("村委会"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=单位&SmallSort=村委会';</script>");
if(node_title.equals("邮局"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=单位&SmallSort=邮局';</script>");
if(node_title.equals("公司"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=单位&SmallSort=公司';</script>");
if(node_title.equals("车站"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=行&SmallSort=车站';</script>");
if(node_title.equals("加油站"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=行&SmallSort=加油站';</script>");
if(node_title.equals("码头"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=行&SmallSort=码头';</script>");
if(node_title.equals("汽车维修"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=行&SmallSort=汽车维修';</script>");
if(node_title.equals("售票处"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=行&SmallSort=售票处';</script>");
if(node_title.equals("停车场"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=行&SmallSort=停车场';</script>");
if(node_title.equals("宾馆饭店"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=游&SmallSort=宾馆景点';</script>");
if(node_title.equals("旅游景点"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=游&SmallSort=旅游景点';</script>");
if(node_title.equals("超市便利店"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=购&SmallSort=超市便利店';</script>");
if(node_title.equals("商业网点"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=购&SmallSort=商业网点';</script>");
if(node_title.equals("大学"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=大学';</script>");
if(node_title.equals("中学"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=中学';</script>");
if(node_title.equals("工读学校"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=工读学校';</script>");
if(node_title.equals("书店"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=书店';</script>");
if(node_title.equals("小学"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=小学';</script>");
if(node_title.equals("幼儿园"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=幼儿园';</script>");
if(node_title.equals("职业中学"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=学&SmallSort=职业中学';</script>");
if(node_title.equals("体育场馆"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=娱&SmallSort=体育场馆';</script>");
if(node_title.equals("文化娱乐"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=娱&SmallSort=文化娱乐';</script>");
if(node_title.equals("保险"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=金融&SmallSort=保险';</script>");
if(node_title.equals("金融投资机构"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=金融&SmallSort=金融、投资公司';</script>");
if(node_title.equals("期货"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=金融&SmallSort=期货';</script>");
if(node_title.equals("信用社"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=金融&SmallSort=信用社';</script>");
if(node_title.equals("银行"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=金融&SmallSort=银行';</script>");
if(node_title.equals("证券"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=金融&SmallSort=证券';</script>");
if(node_title.equals("地段医院"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=地段医院';</script>");
if(node_title.equals("妇幼保健所(站)"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=妇幼保健所(站)';</script>");
if(node_title.equals("门诊部"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=门诊部';</script>");
if(node_title.equals("卫生院"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=卫生院';</script>");
if(node_title.equals("药房"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=药房';</script>");
if(node_title.equals("中医医院"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=中医医院';</script>");
if(node_title.equals("专科医院"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=专科医院';</script>");
if(node_title.equals("综合医院"))
	out.print("<script LANGUAGE='javascript'>location.href='../gis/gisList.jsp?BigSort=医&SmallSort=综合医院';</script>");

//判断是否需要审核
String audit = CTools.dealString(request.getParameter("audit"));
if(!audit.equals(""))
{
  strTitle = "审核";
}
//

%>
<%@include file="../../manage/head.jsp"%>
<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script>
function doAction(ctId ) {
 	  var url = "publishListAbout.jsp?ct_id="+ctId +"&OPType=Edit";
      window.open(url,'newwindow','height=600,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
 }

function fnSelectSJ2(sjchk,bootid)
{

	dW = 300;
	dH = 350;
	//pageUrl = "PublishSJ.jsp";//选择栏目
	pageUrl = "../subpublish/PublishSJFrame11.jsp?bootid=" + bootid;//选择栏目
	var args = new Object();
	args["AuthorityCheck"] = document.formData.autho_Ids.value;	//权限的参数
	args["AuthorityName"] = document.formData.autho_Names.value;		//有权限的栏目名称
	args["NowSelectId"] = document.formData.sj_id.value; //现在被选中的id

    args["NowSelectValue"] = ","+document.formData.sjName1.value; //现在被选中的id
	returnSet = showModalDialog(pageUrl, args ,"dialogWidth: "+dW+"px; dialogHeight: "+dH+"px; help=no; status=no; scroll=yes; resizable=no; ") ;
	//alert(returnSet);
	if (typeof(returnSet) == "undefined" || returnSet == "")
	{
		return ;
	}else{
		sValue = returnSet.split(";");
		if(sjchk)
        {

			var trueor02 = 0
			sj_idvalue02=sValue[0].split(",")
			sj_idvalue03=(sValue[1].substring(1,sValue[1].length)).split(",")
			var sj_id=document.PublishForm.sj_id.value;
			sj_idvalue=sj_id.split(",")
			var trueor=1
			for(i=0;i<sj_idvalue02.length;i++)
			{

				for(j=0;j<sj_idvalue.length;j++)
				{
					if(sj_idvalue02[i]==sj_idvalue[j])
					{
						trueor =0;
					}
				}
				if(trueor!=0)
				{
                  var div_obj02=document.createElement("DIV")
					div_obj02.id="div"+sj_idvalue02[i]
					document.all.TdInfo02.appendChild(div_obj02);
                  div_obj02.innerHTML="<input type='checkbox' value='1' name='ch" + sj_idvalue02[i] + "' id='ch" + sj_idvalue02[i] + "' onclick='javascript:clickall()'>"+sj_idvalue03[i];
				}
				trueor =1
        }
                for(i=0;i<sj_idvalue.length;i++)
				{
					var div_obj=document.getElementById("div"+sj_idvalue[i]);
					trueor02=0;
					for(j=0;j<sj_idvalue02.length;j++)
					{
						if(sj_idvalue[i]==sj_idvalue02[j])
						{
							trueor02=1;
						}
					}
					if(trueor02!=1)
					{
						if(div_obj!=null)
						{
							div_obj.removeNode(true);
						}
					}
                }
     }

	document.formData.sjName1.value = sValue[1];
	document.formData.sj_id.value = sValue[0];
	document.formData.submit();

    }
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="../style.css" rel="stylesheet" type="text/css">
<title></title>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String bootid = "";
CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String strSql1 = "select sj_id from tb_subjectsub where dt_id = '" + mySelf.getDtId() + "' and sj_parentid=0";

Vector vectorPage = null;
Hashtable contentSJ = dImpl.getDataInfo(strSql1);

if(contentSJ!=null)
	bootid = contentSJ.get("sj_id").toString();
else
	bootid = "0";

String ct_id="";
String cna_str="";
Vector vPage=null;


String sj_id="";//栏目id
sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
String selDt_id = "";//部门id
selDt_id = CTools.dealString(request.getParameter("dt_id")).trim();
String dt_id   = "";
String dt_name = "";
String dtSql   = "";
String isadmin = CTools.dealString(request.getParameter("isadmin"));
String sjName1 = CTools.dealString(request.getParameter("sjName1"));

String sql="select sj_id from tb_subject where sj_parentid="+sj_id;
//out.println(sql);
ResultSet rs=dImpl.executeQuery(sql);
boolean canAdd=!rs.next();


//建言献策的东东。
String jysql="select s.sj_id,s.sj_dir from tb_subject s connect by prior s.sj_id=s.sj_parentid start with sj_dir='aiya'";

ResultSet jyrs=dImpl.executeQuery(jysql);
while(jyrs.next())
{
	String jysj_id=CTools.dealNull(jyrs.getString("sj_id"));
	String jysj_dir=CTools.dealNull(jyrs.getString("sj_dir"));
	if(id.equals(jysj_id)){
	response.sendRedirect("../propose/zhenqiuList.jsp?sj_dir="+jysj_dir+"");
	}
}
jyrs.close();
//建言献策结束 

//我的短信频道不与你们同流合污！
String mysql="select s.sj_id from tb_subject s connect by prior s.sj_id=s.sj_parentid start with sj_dir='dxpd'";
ResultSet myrs=dImpl.executeQuery(mysql);
while(myrs.next())
{
	String mysj_id=CTools.dealNull(myrs.getString("sj_id"));
	if(id.equals(mysj_id)){
	response.sendRedirect("../dxpd/UserNoteList.jsp?sj_id="+id);
	}
}
myrs.close();
//我的地盘我作主！

/*得到当前登陆的用户id  开始*/
/*String uiid="";
if(mySelf!=null && mySelf.isLogin())
{
  uiid = Long.toString(mySelf.getMyID());
}
else
{
  uiid= "2";
}*/

/*得到当前登陆的用户id  结束*/
/*得到当前登陆用户的部门id  开始*/
String dtid="";
if(mySelf!=null && mySelf.isLogin())
{
  dtid = Long.toString(mySelf.getDtId());
}

/*得到当前登陆的用户id  结束*/

/*生成栏目列表  开始*/
String subject_ids="";
String subjectCode="";
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
String strSelect="";
Vector sjIdsPage = null;

/*生成栏目列表  结束*/
if (subject_ids.length()>0){
  subject_ids=subject_ids.substring(0,subject_ids.length()-1);
}

/*得到是否审核的标志  开始  1=审核  0=该栏目不要审核 */
String NeedAudit="0";
String auditsql="";

String sj_ids="";
String sWhere="";
    CRoleAccess ado=new CRoleAccess(dCn);
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    String user_id = String.valueOf(self.getMyID());

    if(!ado.isAdmin(user_id) && !ado.isInRole("新闻直通车",user_id)) {
    dtSql = "select dt_id from tb_deptinfo  connect by prior dt_id = dt_parent_id start with dt_id = " + dtid;
    Vector dtPage = dImpl.splitPage(dtSql,100,1);
    if (dtPage != null) {
    	String dt_ids = "";
    	int dtpsize = dtPage.size();
    	for (int k=0;k<dtpsize;k++) {
	    	Hashtable dtContent = (Hashtable)dtPage.get(k);
	    	dt_ids += dtContent.get("dt_id").toString();
    		if (k+1<dtpsize) {
    			dt_ids += ",";
    		}
	    }
	    sWhere += " and t.dt_id in (" + dt_ids + ")";
    }
    
	//sWhere += " and t.dt_id='" + dtid + "'";
	
}else{
if(sj_id.equals("") || sj_id.equals("0"))
{
%>
	<script language="javascript">
		//alert ("请您先选择一个栏目,您的选择越准确将越快获得您想要的信息！");
	</script>
<%
sWhere += "and 1=0";
}
}
//out.println(ado.isInRole("浦东新闻",user_id));

if (!"0".equals(sj_id) && !"293".equals(sj_id)) {
String sjids_sql = "select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_id = "+ sj_id;
sjIdsPage = dImpl.splitPageOpt(sjids_sql,6000,1);
if (sjIdsPage != null)
{
	for (int m=0;m<sjIdsPage.size();m++)
	{
		Hashtable sjIdsCOntent = (Hashtable)sjIdsPage.get(m);
		sj_ids += sjIdsCOntent.get("sj_id").toString();
		if (m+1 < sjIdsPage.size())
		{
			sj_ids += ",";
		}
	}
}

sWhere += " and ct.sj_id in (" + sj_ids + ")";

/*
if (NeedAudit.equals("1"))
{
  sWhere=sWhere + " and t.ct_publish_flag=0 ";
  strTitle="信息审核";
}
*/
String strSql="";
if(audit.equals(""))
{
  //strSql = "select * from (select distinct t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,ct.AUDIT_STATUS,ct.CHECK_STATUS,ct.CP_ISPUBLISH,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where s.sj_id=ct.sj_id and ct.ct_id=t.ct_id  " + sWhere + " and  t.dt_id=d.dt_id  order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=200" ;
  
  //rem by tlboy
  //2007-8-22
  //strSql = "select * from (select distinct t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,ct.AUDIT_STATUS,ct.CHECK_STATUS,ct.CP_ISPUBLISH,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where s.sj_id=ct.sj_id and ct.ct_id=t.ct_id  " + sWhere + " and  t.dt_id=d.dt_id  order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=200" ;

  //modify by tlboy
  strSql = "select * from (select distinct t.ct_id,t.ct_create_time,t.ct_title,t.ct_updatetime,t.ct_publish_flag,ct.AUDIT_STATUS,ct.CHECK_STATUS,ct.CP_ISPUBLISH,t.dt_id,d.dt_name,ct_sequence,t.sj_id from tb_content t,tb_subject s,tb_deptinfo d,tb_contentpublish ct where ct.ct_id=t.ct_id and s.sj_id=ct.sj_id and  t.dt_id=d.dt_id and cp_id in (select cp_id from (select ct.cp_id from tb_contentpublish ct,tb_content t  where ct.ct_id = t.ct_id " + sWhere + " order by ct.ct_id desc) where rownum <=300) order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc) where rownum<=200" ;
 //modify end
}
else if (audit.equals("true"))
{
  //strSql = "select t.ct_id,t.ct_create_time,t.ct_publish_flag,t.ct_focus_flag,t.ct_updatetime,t.ct_image_flag,t.ct_message_flag,t.ct_title,t.ct_sequence,t.dt_id,s.sj_name,d.dt_name from tb_content t,tb_subject s,tb_deptinfo d where 1=1 and t.dt_id=d.dt_id and t.sj_id=s.sj_id and t.ct_publish_flag <> 1 "+ sWhere +" and s.sj_id in(select sj_id from tb_auditrole where  tr_id in (select tr_id from tb_roleinfo where tr_userids like '%,"+uiid+",%')) order by to_date(t.ct_create_time,'YYYY-MM-DD') desc,t.ct_id desc";
}
vectorPage = dImpl.splitPageOpt(strSql,request,20);
//out.print(strSql);
}
%>

 <table class="main-table" width="100%">
    <tr>
  <td width="100%">
       <table class="content-table" width="100%">
		 <form name="formData">
     <INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
     <INPUT TYPE="hidden" name="curpage" value="<%=CTools.dealNumber(request.getParameter("strPage"))%>">
     <INPUT TYPE="hidden" name="audit" value="<%=audit%>">

        <tr class="title1">
            <td colspan="7" align="center">
                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                    <tr>
                        <td valign="center" nowrap><%=strTitle%></td>
			<td valign="center" align=left></td>

                        <td valign="center" align="right" nowrap>

<%
    if (canAdd){ //栏目树的叶子节点才可以发布信息
%>
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/new.gif" border="0" onClick="window.location='PublishEdit.jsp?OPType=Add&sj_id=<%=sj_id%>&subjectCode=<%=subjectCode%>&audit=false'" title="新增信息" style="cursor:hand" align="absmiddle" WIDTH="16" HEIGHT="16">
<%
    }
%>

                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/menu_about.gif" border="0" onClick="javascript:window.location.href='publishSearch.jsp' " title="查找" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                            <img src="/system/images/goback.gif" border="0" onClick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                            <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
   </td>
  </tr>
 </table>
  </td>
        </tr>
        <tr class="bttn">
            <td width="40%" class="outset-table" nowrap>信息主题</td>
            <!-- td width="10%" class="outset-table">分类</td-->
            <td width="10%" class="outset-table" nowrap>发布日期</td>

            <td width="15%" class="outset-table" nowrap>部门</td>
            <td width="12%" class="outset-table" nowrap>更新时间</td>            
            <td width="12%" class="outset-table" nowrap>状态</td>
            <td width="8%" class="outset-table" nowrap>相关新闻</td>
            <!-- td width="8%" class="outset-table">排序</td-->
            <td width="8%" class="outset-table" nowrap>
            <%
            //if (NeedAudit.equals("1"))
            //{
            //out.print("审核");
            //}
            //else
            //{
            out.print("操作");
            //}
            %>
            </td>
        </tr>
<%

	CDataImpl dImpl_1 = new CDataImpl(dCn);
  if(vectorPage!=null)
  {
    for(int j=0;j<vectorPage.size();j++)
    {
      Hashtable content = (Hashtable)vectorPage.get(j);
      String ct_updatetime = CTools.getDate(CTools.dealString(content.get("ct_updatetime").toString()));
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
      String CP_ISPUBLISH=CTools.dealNull(content.get("cp_ispublish"));
      String AUDIT_STATUS=CTools.dealNull(content.get("audit_status"));
      String CHECK_STATUS=CTools.dealNull(content.get("check_status"));
      //out.println(CHECK_STATUS);
      ct_id = CTools.dealNull(content.get("ct_id"));
      cna_str ="select ct_id from tb_countnewsabout where ct_id="+ct_id;
      //vPage = dImpl.splitPageOpt(cna_str,10,1);
	  vPage = dImpl_1.splitPageOpt(cna_str,request,15);
      
      String status="已采用";
      if(CP_ISPUBLISH.equals("0")) status="未采用";
      if(CHECK_STATUS.equals("0")) status="待审批";
      if(AUDIT_STATUS.equals("0")) status="待审核";
%>

                <td ><img border="0" src="/system/images/arrow_yellow.gif" WIDTH="15" HEIGHT="13">&nbsp;<a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><%=content.get("ct_title")%></a></td>
                <!-- td align="center"></td -->
                <td align="center" nowrap><%=content.get("ct_create_time")%></td>
                <td align=center nowrap><%=content.get("dt_name")%></td>
                 <td align=center><%=ct_updatetime%></td>
                 <td align=center><%=status%></td>
                 <td align=center>
<%
              if (vPage!=null){
      			 out.print("<img class='hand' border='0' src='/system/images/modi.gif\' title='查看' WIDTH='16' HEIGHT='16' onclick='doAction("+ct_id+")'>");
      			}   
%>
				</td>
                <!-- td align=center><input type=text class=text-line name='<%//="module"+content.get("ct_id").toString()%>' value="<%//=content.get("ct_sequence").toString()%>" size=4 maxlength=4></td-->
                <td align="center" nowrap><a href="PublishEdit.jsp?OPType=Edit&ct_id=<%=content.get("ct_id")%>&subjectCode=<%=subjectCode%>&curpage=<%=CTools.dealNumber(request.getParameter("strPage"))%>&audit=<%=audit%>"><img class="hand" border="0" src="
                <%
                if (audit.equals("true"))
                {
                out.print("/system/images/dialog/hammer.gif\" title=审核");
                }
                else
                {
                out.print("/system/images/modi.gif\" title=编辑");
                }
                %>
                 " WIDTH="16" HEIGHT="16"></a>&nbsp;
<a href="javascript:delcontent('<%=content.get("ct_id")%>','<%=CTools.htmlEncode(content.get("ct_title").toString())%>');">
<img class="hand" border="0" src="../../images/delete.gif" title="删除" WIDTH="16" HEIGHT="16" onClick="return window.confirm('确认要删除该记录么?');"></a>&nbsp;<!--img class="hand" border="0" src="images/fileImg/sms.gif"  title="发送短消息" WIDTH="16" HEIGHT="16" onClick="javascript:openopen('<%=CTools.htmlEncode(content.get("ct_title").toString())%>')"-->
								</td>
            </tr>

<%
    }
%>
</form>
<%
      out.println("<tr><td colspan=7>" + dImpl.getTail(request) + "</td></tr>"); //输出尾部文件
  }
  else
  {
    out.println("<tr><td colspan=7>没有记录！</td></tr>");
  }
%>
</table>
        </td>
    </tr>
</table>

<%
	dImpl_1.closeStmt();
  dImpl.closeStmt();
  dCn.closeCn();
%>
<%@ include file="../skin/bottom.jsp"%>
<script LANGUAGE="javascript">
	function onChange()
	{
		var sj_id;
		var audit;
                sj_id=formData.sj_id.value;
                audit=formData.audit.value;
		formData.action='publishList.jsp?sj_id='+sj_id+'&audit='+audit;
		formData.submit();
	}

function setSequence()
{
	//var form = document.formData ;
	document.formData.action = "setSequence.jsp";
	document.formData.submit();
}

function delcontent(ctId,ctTitle){
var objhttpPending=new ActiveXObject("Msxml2.XMLHTTP");
	var objxmlPending =	objxmlPending=new ActiveXObject("Microsoft.XMLDOM");

		strA = "abc"

		objhttpPending.Open("post","http://<%=request.getServerName()%>:<%=request.getServerPort()%>/system/app/infopublish/delete.jsp?ct_id=" + ctId + "&ctTitle=" + ctTitle ,true);
		objhttpPending.setRequestHeader("Content-Length",strA.length);
		objhttpPending.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");



		objhttpPending.onreadystatechange = function (){
			var statePending = objhttpPending.readyState;
		    if (statePending == 4)
		    {
		    	var returnvalue = objhttpPending.responsetext;
		    	//alert(returnvalue);
		    	if(returnvalue.indexOf("yes")!=-1){
		    		document.location.reload();
		    	}
			}
		};

		objhttpPending.Send(strA);

}
function openopen(ct_title)
{
window.open("../dxpd/openopen.jsp?title="+ct_title+"","","height=250, width=500,top=300,left=300,toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}
</script>
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