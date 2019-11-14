<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
 	response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragrma","no-cache");
  response.setDateHeader("Expires",0);
  
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());
  //
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
		String cw_typecode = "";
    String cw_id = "";//编
    String cp_id = "";//项目编号
    String cw_number = "";//事项编号
    String us_id = "";//用户id
    String is_us = "否";//是否注册用户
    String strTel = "";//投诉人电话
    String applyname = "";//投诉人姓名
    String applytime = "";//投诉时间
    String applydept = "";//投诉人单位
    String strEmail = "";//投诉人邮件
    String appealname = "";//被投诉人姓名
    String appealdept = "";//被投诉人单位
    String strSubject = "";//投诉主题
    String strContent = "";//投诉内容
		String strfeedback = "";//投诉反馈
    String feedbackType = "";//投诉反馈
		String strchongfu ="";//重复信件
    int cw_status;//投诉状态
    String cw_statusStr = "";
    String strStatus = "";//投诉状态
    String strSql = "";
    String sqlcorr = "";//判断是否转办
    String receivername = "";//转办部门
    String dept_name = "";
    String wd_name = "";//区长
    String co_corropioion = "";//转办部门意见
    String co_id = "";//转办编号
    String de_requesttime = "";//转办时限
    String wd_id = "";
    String cw_ygname = "";
    String cw_parentid = "";
		String cw_emailtype = "";
		String cp_id_conn = "";
    String cp_name_conn = ""; 
		String cw_trans_id = "";
		String sqlStr = "";
	 	Vector vPage = null;
	 	String Sql_class = "";
   	Vector vPage1 = null;
		String dd_name = "" ;
		String cp_name = "";
		String dd_id= "" ;//投诉类型
   	String cw_ispublish = "";//用户是否同意发布
	String cw_isopen = "";
	
    cw_statusStr = request.getParameter("cw_status").toString();
    cw_status = Integer.parseInt(cw_statusStr);
	
    switch(cw_status)
   {
    case 1:
		 strStatus = "待处理";
		 dept_name = "e.de_senddeptid";
		 break;
    case 2:
		 strStatus = "处理中";
		 break;
    case 3:
		 strStatus = "已完成";
		 dept_name = "e.de_senddeptid";
		 feedbackType = "readonly";
		 break;
    case 8:
		 strStatus = "协调中";
		 dept_name = "e.de_receiverdeptid";
		 break;
	case 9:
		 strStatus = "垃圾信件";
		 dept_name = "e.de_senddeptid";
		 feedbackType = "readonly";
		 break;
	case 12:
		 strStatus = "重复信件";
		 dept_name = "e.de_senddeptid";
		 feedbackType = "readonly";
     break;
    default:
		 strStatus = "";
  }
  cw_id = request.getParameter("cw_id").toString();

   strSql = "select c.wd_id, c.cw_id,c.cw_ygname,c.us_id,c.cw_telcode,c.cw_parentid,c.cw_emailtype,c.cw_ispublish,c.dd_id,c.cp_id,c.cw_typecode,cw_number,c.cw_applyingname,to_char(cw_applytime,'yyyy-mm-dd hh24:mi:ss') cw_applytime,c.cw_applyingdept,c.cw_email,c.cw_appliedname,c.cw_applieddept,c.cw_subject,c.dd_id,c.cw_ispublish,c.cw_content,c.cw_feedback,c.cw_chongfu,c.wd_id,c.cw_ygname,p.cp_name,c.cw_isopen from tb_connwork c,tb_connproc p where c.cp_id = p.cp_id and c.cw_id='"+ cw_id +"'";

  Hashtable content = dImpl.getDataInfo(strSql);

  if(content!=null)
	{
  cw_id = content.get("cw_id").toString();
  us_id = content.get("us_id").toString();
  if(!us_id.equals(""))
  {
   is_us = "是";
  }
  cw_typecode = content.get("cw_typecode").toString();//edit by arin
  cp_id = content.get("cp_id").toString();
  wd_id = content.get("wd_id").toString();
  cw_ygname = content.get("cw_ygname").toString();

  applyname = content.get("cw_applyingname").toString();
  applytime = content.get("cw_applytime").toString();
  applydept = content.get("cw_applyingdept").toString();
  strTel = content.get("cw_telcode").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  cw_number = content.get("cw_number").toString();
  strSubject = content.get("cw_subject").toString();
  cw_emailtype = content.get("cw_emailtype").toString();
  cw_parentid = content.get("cw_parentid").toString();
  strContent = content.get("cw_content").toString();
  
  strchongfu = content.get("cw_chongfu").toString();
  strfeedback = content.get("cw_feedback").toString();
cp_name = content.get("cp_name").toString();
  dd_id = content.get("dd_id").toString();
  cw_isopen = content.get("cw_isopen").toString();
}


	String sql_att = "select aa_id,aa_filename from tb_appealattach where cw_id = '"+cw_id+"'";
	Vector page_att = dImpl.splitPage(sql_att,10,1);
%>
<!-- 记录日志 -->
<%
String logstrMenu = "网上咨询信件";
String logstrModule = "受理网上咨询信件";
%>
<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
受理区长信件
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
  <form  method="post" name="sForm">
    <tr>
      <td width="100%" align="left" valign="top"><table class="content-table" height="1" width="100%">
          <tr class="line-odd">
            <td width="18%" align="right">发 送 人：</td>
            <td width="82%"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="<%=applyname%>" readonly></td>
          </tr>
          <%
					  if(!"".equals(dd_id)){
					String sql_dd_name = "select dd_name from tb_datatdictionary where dd_code='"+dd_id+"'";
					Vector page_dd_name = dImpl.splitPage(sql_dd_name,1,1);
				  if(page_dd_name!=null)
				{
					for(int i=0;i<page_dd_name.size();i++)
					{
					Hashtable content_dd_name = (Hashtable)page_dd_name.get(i);
				    dd_name = content_dd_name.get("dd_name").toString();
					}
					}
					}
					  %>
          <tr class="line-odd">
            <td width="18%" align="right">信访目的：</td>
            <td width="82%" align="left"><input type="text" class="text-line" name="dd_name" maxlength="10" size="30" title="信访目的" value="<%=dd_name%>" readonly></td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">单　　位：</td>
            <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="10" size="30" value="<%=applydept%>" readonly></td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right">联系电话：</td>
            <td width="82%"><input type="text" class="text-line" name="strTel" maxlength="100" size="30" value="<%=strTel%>" readonly>
            </td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">电子邮件：</td>
            <td width="82%"><input type="text" class="text-line" name="strEmail" maxlength="10" size="30" value="<%=strEmail%>" readonly>
            </td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right">是否注册用户：</td>
            <td width="82%"><input type="text" class="text-line" name="is_us" maxlength="100" size="30" title="注册用户" value="<%=is_us%>" readonly></td>
          </tr>
          <tr class="line-even">
            <td colspan="2" align="right">&nbsp;</td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right">信箱类型：</td>
            <td width="82%"><%=cp_name%></td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">信件主题：</td>
            <td width="82%"><input type="text" class="text-line" name="strSubject1" maxlength="10" size="30" value='<%=CTools.replace(strSubject,"\'","\"")%>' readonly>
              <textarea style="display:none" name = "strSubject"><%=strSubject%></textarea></td>
          </tr>
          <tr class="line-odd">
            <td align="right">信件内容：</td>
            <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="信件内容" readonly><%=strContent%></textarea>
            </td>
          </tr>
          <tr class="line-even">
            <td align="right" colspan=2>&nbsp;</td>
          </tr>
          <tr class="line-even">
            <td align="right">来信编号：</td>
            <td><input type="text" class="text-line" name="cw_number" maxlength="100" size="30" value="<%=cw_number%>"></td>
          </tr>
          <tr class="line-odd">
            <td align="right">信件处理状态：</td>
            <td><%=strStatus%></td>
          </tr>
          <tr class="line-even" width="100%">
            <td width="100%" colspan="2" align="left"><a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a> 信件回复：</td>
          </tr>
          <tr class="line-odd" id="Info2" style="display:none">
            <td align="left" height="20" colspan=2><table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                <tr class="line-odd">
                  <td align="right" width="18%">信件反馈回复：</td>
                  <td valign="middle">
                  <textarea class="text-area" name="strFeedback" cols="60" rows="6" title="信件反馈" <%=feedbackType%>><%out.print(strfeedback);%></textarea>
                    </td>
                  <td><font color="#EC004D">
                    <%if(strfeedback.equals("")){%>
                    （注：＃＃由信访处理人员根据实际情况替换）
                    <%}%></font></td>
                </tr>
				<input type="hidden" name="isOver" value=""/>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr class=outset-table>
      <td width="100%" align="right" colspan="2"><p align="center">
          <input class="bttn" value="审核通过" type="button" <%="0".equals(cw_isopen)?"disabled":""%> size="6" id="button6" name="button6" onclick="printlist('0')">
          &nbsp;
		  <input class="bttn" value="审核不通过" type="button"  size="6" <%="1".equals(cw_isopen)?"disabled":""%> id="button6" name="button6" onclick="printlist('1')">
          &nbsp;
          <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
          &nbsp;
      </td>
    </tr>
  </form>
</table>
<script language="javascript">
  function printlist(cw_status)
  {
  		var form = document.sForm;
	    form.action = "AppealOperate.jsp?cwids=<%=cw_id+","%>&cw_ispublish="+cw_status;
	    form.submit();
  }
  function Display(Num)
  {
        var obj=eval("Info"+Num);
        var objImg=eval("document.sForm.InfoImg"+Num);

        if (typeof(obj)=="undefined") return false;
        if (obj.style.display=="none")
        {
                obj.style.display="";
                objImg.src="/system/images/topminus.gif";
        }
        else
        {
                obj.style.display="none";
                objImg.src="/system/images/topplus.gif";
        }
  }
</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
