<%@include file="/system/app/skin/import.jsp"%>
<%@ page contentType="application/vnd.ms-word; charset=GBK"%>
<%response.setHeader("Content-disposition", "attachment; filename=print_tmp.doc");%>
<%@ page import="java.net.URL"%>
<%
    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
    String cw_id_all = "";//编号
    String cp_id = "";//项目编号
    String us_id = "";//用户id
    String is_us = "否";//是否注册用户
    String applyname = "";//投诉人姓名
    String applydept = "";//投诉人单位
    String strTel = "";//投诉人电话
    String strEmail = "";//投诉人邮件
    String appealname = "";//被投诉人姓名
    String appealdept = "";//被投诉人单位
    String strSubject = "";//投诉主题
    String strContent = "";//投诉内容
    String strfeedback = "";//投诉反馈
    String feedbackType = "";//投诉反馈
    int cw_status;//投诉状态
    String cw_statusStr = "";
    String strStatus = "";//投诉状态
    String strSql = "";
    String sqlcorr = "";//判断是否转办
    String receivername = "";//转办部门
    String dept_name = "";
    String co_corropioion = "";//转办部门意见
    String co_id = "";//转办编号
    String de_requesttime = "";//转办时限
    String cp_id_conn = "";
    String cp_name_conn = "";
    String cw_code = "";
    String cw_codestr = "否";
    String cw_applytime = "";
	String cw_transmittime = "";
    String list="";
	String url_target="";
	String outCon="";
	cw_id_all = request.getParameter("cw_id").toString();
	String [] cw_id = cw_id_all.split(",");
	for(int j = 0;j < cw_id.length;j++) {
		String pr_name= request.getParameter("pr_name");//主题
		strSql = "select cw_emailtype,cw_parentid,cw_id,us_id,cp_id,cw_code,cw_applyingname,cw_applyingdept,cw_email,to_char(cw_transmittime,'yyyy-mm-dd hh24:mi:ss') cw_transmittime,cw_telcode,cw_appliedname,cw_applieddept,cw_subject,cw_content,cw_feedback,cw_applytime,cw_trans_id from tb_connwork where cw_id='"+cw_id[j]+"'";
		strSql += " order by cw_applytime desc";
		Hashtable content = dImpl.getDataInfo(strSql);
			if(content!=null)
			{
			  cp_id = content.get("cp_id").toString();
			  applyname = content.get("cw_applyingname").toString();
			  applydept = content.get("cw_applyingdept").toString();
			  strTel = content.get("cw_telcode").toString();
			  strEmail = content.get("cw_email").toString();
			  strSubject = content.get("cw_subject").toString();
			  strContent = content.get("cw_content").toString();
			  cw_applytime = content.get("cw_applytime").toString();
				 //outCon += "<table width=100% border=0 cellspacing=0 cellpadding=0><tr><td width=100 align=right>发件人：</td><td>"+applyname+"<br><br></td></tr><tr><td align=right>单位：</td><td>"+applydept+"</td></tr><tr><td align=right>联系电话：</td><td>"+strTel+"</td></tr><tr><td align=right>电子邮件：</td><td>"+strEmail+"</td></tr><tr><td align=right>提交时间：</td><td>"+cw_applytime+"</td></tr><tr><td align=right>咨询主题：</td><td>"+strSubject+"</td></tr><tr><td align=right>信件内容：</td><td>"+strContent+"</td></tr></table><br><br>";
				 outCon += "<p>发件人："+applyname+"<br>单位："+applydept+"<br>联系电话："+strTel+"<br>电子邮件："+strEmail+"<br>提交时间："+cw_applytime+"<br>咨询主题："+strSubject+"<br>信件内容："+strContent+"<br><br></p>";
	//outCon +="<html>fsdf<br><br>weqer<br><br>wqre<br><br>sddfs</html>";
			}
		}
	out.print("<html>"+outCon+"</html>");
	dImpl.closeStmt();
	dCn.closeCn();
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