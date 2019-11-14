<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 


String begin_time = CTools.dealString(request.getParameter("begin_time")).trim();
String end_time = CTools.dealString(request.getParameter("end_time")).trim();

String home_count = "0";
String home_sql = "select co_number from tb_count where co_name='home'";
Hashtable home_content = dImpl.getDataInfo(home_sql);
if(home_content!=null)
{
	home_count = home_content.get("co_number").toString();
}

String work_count = "0";
String work_sql = "select co_number from tb_count where co_name='work'";
Hashtable work_content = dImpl.getDataInfo(work_sql);
if(work_content!=null)
{
	work_count = work_content.get("co_number").toString();
}

String userlogin_count = "";
String userlogin_sql = "select count(ul_id) countnum from jk_userlogin where ul_logintime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and ul_logintime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable userlogin_content = dImpl.getDataInfo(userlogin_sql);
if(userlogin_content!=null)
{
	userlogin_count = userlogin_content.get("countnum").toString();
}

String syslogin_count = "";
String syslogin_sql = "select count(sl_id) countnum from jk_syslogin where sl_logintime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and sl_logintime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable syslogin_content = dImpl.getDataInfo(syslogin_sql);
if(syslogin_content!=null)
{
	syslogin_count = syslogin_content.get("countnum").toString();
}

String wardenmail_count = "";
String wardenmail_sql = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and (d.cp_id='o1' or d.cp_upid='o1') and c.cw_applytime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable wardenmail_content = dImpl.getDataInfo(wardenmail_sql);
if(wardenmail_content!=null)
{
	wardenmail_count = wardenmail_content.get("countnum").toString();
}

String wardenmail_count1 = "";
String wardenmail_sql1 = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and (d.cp_id='o1' or d.cp_upid='o1') and c.cw_finishtime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_finishtime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable wardenmail_content1 = dImpl.getDataInfo(wardenmail_sql1);
if(wardenmail_content1!=null)
{
	wardenmail_count1 = wardenmail_content1.get("countnum").toString();
}

String complaint_count = "";
String complaint_sql = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and (d.cp_id='o2' or d.cp_upid in('o2','o3')  ) and c.cw_applytime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable complaint_content = dImpl.getDataInfo(complaint_sql);
if(complaint_content!=null)
{
	complaint_count = complaint_content.get("countnum").toString();
}

String supervise_count = "";
String supervise_sql = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and (d.cp_id='o4' or d.cp_upid in('o4','o5')  ) and c.cw_applytime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable supervise_content = dImpl.getDataInfo(supervise_sql);
if(supervise_content!=null)
{
	supervise_count = supervise_content.get("countnum").toString();
}

String consultation_count = "";
String consultation_sql = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and d.cp_upid='o7' and c.cw_applytime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_applytime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable consultation_content = dImpl.getDataInfo(consultation_sql);
if(consultation_content!=null)
{
	consultation_count = consultation_content.get("countnum").toString();
}

String complaint_count1 = "";
String complaint_sql1 = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and (d.cp_id='o2' or d.cp_upid in('o2','o3')  ) and c.cw_finishtime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_finishtime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable complaint_content1 = dImpl.getDataInfo(complaint_sql1);
if(complaint_content1!=null)
{
	complaint_count1 = complaint_content1.get("countnum").toString();
}

String supervise_count1 = "";
String supervise_sql1 = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and (d.cp_id='o4' or d.cp_upid in('o4','o5')  ) and c.cw_finishtime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_finishtime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable supervise_content1 = dImpl.getDataInfo(supervise_sql1);
if(supervise_content1!=null)
{
	supervise_count1 = supervise_content1.get("countnum").toString();
}

String consultation_count1 = "";
String consultation_sql1 = "select count(c.cw_id) countnum from tb_connwork c,tb_connproc d where c.cp_id=d.cp_id and d.cp_upid='o7' and c.cw_finishtime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and c.cw_finishtime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable consultation_content1 = dImpl.getDataInfo(consultation_sql1);
if(consultation_content1!=null)
{
	consultation_count1 = consultation_content1.get("countnum").toString();
}

String woapply_count = "";
String woapply_sql = "select count(wo_id) countnum from tb_work where wo_applytime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and wo_applytime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable woapply_content = dImpl.getDataInfo(woapply_sql);
if(woapply_content!=null)
{
	woapply_count = woapply_content.get("countnum").toString();
}

String wofinish_count = "";
String wofinish_sql = "select count(wo_id) countnum from tb_work where wo_finishtime > to_date('"+begin_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and wo_finishtime < to_date('"+end_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
Hashtable wofinish_content = dImpl.getDataInfo(wofinish_sql);
if(wofinish_content!=null)
{
	wofinish_count = wofinish_content.get("countnum").toString();
}

String dynamic_count = "0";
String dynamic_sql = "select count(ct_id) count_num from tb_content where sj_id in (select sj_id from tb_subject where sj_devide='dongtai') and to_date(ct_create_time,'yyyy-mm-dd hh:mi:ss') >= to_date('"+begin_time+"','yyyy-mm-dd hh:mi:ss') and to_date(ct_create_time,'yyyy-mm-dd hh:mi:ss') <= to_date('"+end_time+"','yyyy-mm-dd hh:mi:ss')";
//out.print(dynamic_sql);
Hashtable dynamic_content = dImpl.getDataInfo(dynamic_sql);
if(dynamic_content!=null)
{
	dynamic_count = dynamic_content.get("count_num").toString();
}

String news_count = "0";
CSubjectXML m = new CSubjectXML();
String sj_newdesc = m.getIdByCode("news") + "";
CSubjectIds Subject_ids = new CSubjectIds();
String sj_ids = Subject_ids.getSubDirIdsByIDS(sj_newdesc);
String news_sql = "SELECT COUNT(c.ct_id) count_num FROM TB_CONTENT c,TB_SUBJECT s WHERE c.sj_id=s.sj_id AND s.sj_id in ("+sj_ids+") and to_date(ct_create_time,'yyyy-mm-dd hh:mi:ss') >= to_date('"+begin_time+"','yyyy-mm-dd hh:mi:ss') and to_date(ct_create_time,'yyyy-mm-dd hh:mi:ss') <= to_date('"+end_time+"','yyyy-mm-dd hh:mi:ss')";
//out.print(news_sql);
Hashtable news_content = dImpl.getDataInfo(news_sql);
if(news_content!=null)
{
	news_count = news_content.get("count_num").toString();
}

String strTitle = "网站运行情况监控列表("+begin_time+"至"+end_time+")";
%>
<table class="main-table" width="100%">
<form name="formData">
 <tr>
   <td width="100%" colspan="16">
       <table class="content-table" width="100%">
                <tr class="title1">
                        <td colspan="5" align="center">
                                <table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
                                        <tr>
                                                <td valign="center" align="left"><%=strTitle%></td>
                                                <td valign="center" align="right" nowrap>
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                        <img src="/system/images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                                                        <img src="/system/images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                                                </td>
                                        </tr>
                                </table>
                        </td>
                </tr>
       </table>
    </td>
  </tr>
  <tr class="bttn" width="100%">
    <td align="center" width="6.25%">门户首页点击数</td>
    <td align="center" width="6.25%">平台首页点击数</td>
	<td align="center" width="6.25%">前台用户登录数</td>
	<td align="center" width="6.25%">后台维护登录数</td>
    <td align="center" width="6.25%">区长信箱数</td>
	<td align="center" width="6.25%">区长信箱答复数</td>
    <td align="center" width="6.25%">信访数</td>
	<td align="center" width="6.25%">信访答复数</td>
	<td align="center" width="6.25%">投诉数</td>
	<td align="center" width="6.25%">投诉答复数</td>
	<td align="center" width="6.25%">咨询数</td>
	<td align="center" width="6.25%">咨询答复数</td>
	<td align="center" width="6.25%">办事申请数</td>
	<td align="center" width="6.25%">答复办结事项数</td>
	<td align="center" width="6.25%">部门动态发布数</td>
	<td align="center" width="6.25%">新闻发布数</td>
  </tr>
  <tr  class="line-odd">
  <td align="center"><%=home_count%></td>
  <td align="center"><%=work_count%></td>
  <td align="center"><%=userlogin_count%></td>
  <td align="center"><%=syslogin_count%></td>
  <td align="center"><%=wardenmail_count%></td>
  <td align="center"><%=wardenmail_count1%></td>
  <td align="center"><%=complaint_count%></td>
  <td align="center"><%=complaint_count1%></td>
  <td align="center"><%=supervise_count%></td>
  <td align="center"><%=supervise_count1%></td>
  <td align="center"><%=consultation_count%></td>
  <td align="center"><%=consultation_count1%></td>
  <td align="center"><%=woapply_count%></td>
  <td align="center"><%=wofinish_count%></td>
  <td align="center"><%=dynamic_count%></td>
  <td align="center"><%=news_count%></td>
  </tr>
</form>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>
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