<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
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
 String cw_id = "";//编号
    String us_id = "";//用户id
    String is_us = "否";//是否注册用户
    String cp_id = "";//项目编号
    String applyname = "";//投诉人姓名
    String applydept = "";//投诉人单位
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
    cw_statusStr = request.getParameter("cw_status").toString();
    //out.print("cw_statusStr"+cw_statusStr);
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
	 break;
    default:
     strStatus = "";
  }
  cw_id = request.getParameter("cw_id").toString();
  sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办

  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null)
  {
   strSql = "select c.cw_id,c.us_id,c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_email,c.cw_appliedname,c.cw_applieddept,";
   strSql += "c.cw_subject,c.cw_content,c.cw_feedback,c.cw_status,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,e.de_requesttime,f.dt_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dept_name + "=f.dt_id and c.cw_id='" + cw_id + "'";
  }
  else
  {
   strSql = "select cw_id,us_id,cp_id,cw_applyingname,cw_applyingdept,cw_email,cw_appliedname,cw_applieddept,cw_subject,cw_content,cw_feedback from tb_connwork where cw_id='"+ cw_id +"'";
  }
  Hashtable content = dImpl.getDataInfo(strSql);

  cw_id = content.get("cw_id").toString();
  us_id = content.get("us_id").toString();
  if(!us_id.equals(""))
  {
    is_us = "是";
  }
  cp_id = content.get("cp_id").toString();
  applyname = content.get("cw_applyingname").toString();
  applydept = content.get("cw_applyingdept").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  strSubject = content.get("cw_subject").toString();
  strContent = content.get("cw_content").toString();
  strfeedback = content.get("cw_feedback").toString();

  if(vectorPage!=null)
  {
   receivername = content.get("dt_name").toString();
   co_corropioion = content.get("co_corropioion").toString();
   de_requesttime = content.get("de_requesttime").toString();
  }
	String sql_att = "select aa_id,aa_filename from tb_appealattach where cw_id='"+cw_id+"'";
	Vector page_att = dImpl.splitPage(sql_att,10,1);
	
%>
<!-- 记录日志 -->
<%
String logstrMenu = "周浦书记信件";
String logstrModule = "受理周浦书记信件";
%>
<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
受理信件
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
受理信件
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
  <form  method="post" name="sForm">
    <tr>
      <td width="100%" align="left" valign="top"><table  height="1" width="100%">
         <tr class="line-odd">
            <td width="18%" align="right">发 送 人：</td>
            <td width="82%"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="<%=applyname%>" readonly></td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">单　　位：</td>
            <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="10" size="30" value="<%=applydept%>" readonly></td>
          </tr>
          <tr class="line-odd">
            <td width="18%" align="right">E-mail：</td>
            <td width="82%"><input type="text" class="text-line" name="strEmail" maxlength="10" size="30" value="<%=strEmail%>" readonly>
            </td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">是否注册用户：</td>
            <td width="82%"><input type="text" class="text-line" name="is_us" maxlength="100" size="30" title="注册用户" value="<%=is_us%>" readonly></td>
          </tr>
          <tr class="line-odd">
            <td colspan="2" align="right">&nbsp;</td>
          </tr>
          <tr class="line-even">
            <td width="18%" align="right">信件主题：</td>
            <td width="82%"><input type="text" class="text-line" name="strSubject" maxlength="10" size="30" value="<%=strSubject%>" readonly></td>
          </tr>
          <%
			if(page_att!=null)
			{
					for(int i=0;i<page_att.size();i++)
					{
					Hashtable content_att = (Hashtable)page_att.get(i);
					String aa_id = content_att.get("aa_id").toString();
					String file_name = content_att.get("aa_filename").toString();
					if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
		            else out.print("<tr class=\"line-odd\">");
				  %>
          <td align="right" width="18%">附件名称：</td>
            <td><a href="/website/include/downloadAPPEAL.jsp?aa_id=<%=aa_id%>" target="_blank"><%=file_name%></a></td>
          </tr>
          <%
					}
			}	  
			%>
          <tr class="line-odd">
            <td align="right">信件内容：</td>
            <td><textarea name="strContent" cols="60" rows="6" title="信件内容" readonly><%=strContent%></textarea></td>
          </tr>
          <tr class="line-even">
            <td colspan="2" align="right">&nbsp;</td>
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
                  <td><textarea name="strFeedback" cols="60" rows="6" title="信件反馈" <%=feedbackType%>><%=strfeedback%></textarea></td>
                </tr>
              </table></td>
          </tr>
         
        </table></td>
    </tr>
    <tr class="outset-table">
      <td width="100%" align="right" colspan="2"><p align="center">
          <%
              switch(cw_status)
              {
               case 1:
                 out.print("<input class='bttn' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button3' name='button4'>&nbsp;");
               %>
          <%
                 break;
               case 2:
                 out.print("<input class='bttn' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button3' name='button4'>&nbsp;");
               %>
          <%
                break;
               case 3:
                 //out.print("<input  class='bttn' value='删除' type='button' onclick='javascript:del()' size='6' id='button4' name='button4'>&nbsp;");
                 break;
                default:
                 strStatus = "";
              }
            %>
          <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
          &nbsp;
          <input type=hidden name="cw_status" value="<%=cw_status%>">
          <input type=hidden name="strSubject" value="<%=strSubject%>">
          <input type=hidden name="strfeedback" value="<%=strfeedback%>">
      </td>
    </tr>
  </form>
</table>
<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="/system/app/procuratorate/AppealDel.jsp?cw_id=<%=cw_id%>";
   }
  }

  //处理中
  function dealLetter(sForm) {
    var form = document.sForm;
    if (form.strFeedback.value == "") {
	    alert("回复不能为空！");
	    return false;
    }
  	if (confirm("确认要把信件存入'处理中信件'吗？")) {
	    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=2";
	    form.submit();
    }
  }
  
  function garbage(sForm) {
  	if (confirm("确认要把信件放入'垃圾信件'吗？")) {
	    var form = document.sForm;
	    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=9";
	    form.submit();
    }
  }
  
  function directDeal(sForm)
  {
    if(sForm.strEmail.value!="")
     {
       if(isEmail(sForm.strEmail.value)==true)
      {
       if(window.confirm('确认要E-mail反馈吗？'))
       {
       window.open("mailto:"+ sForm.strEmail.value);
       window.close();
       var form = document.sForm;
       form.action = "AppealDeal.jsp?cw_id=<%=cw_id%>";
       form.submit();
       }
      }
      else
      {
       alert("邮件地址格式不对！");
       sForm.strEmail.focus();
      }
     }
   else
     {
      alert("邮件地址为空，不能E-mail回复！");
      sForm.strEmail.focus();
     }
  }

  function finish(sForm)
  {
    if(sForm.strFeedback.value=="")
            {
              alert("回复不能为空！");
              return false;
             }
    else
    if(window.confirm('确认要这样处理吗？')){
    var form = document.sForm;
    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=3";
    form.submit();
    }
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
                                     
