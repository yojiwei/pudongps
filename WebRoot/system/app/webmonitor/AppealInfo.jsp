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
    cw_statusStr = request.getParameter("cw_status").toString();
    //out.print("cw_statusStr"+cw_statusStr);
    cw_status = Integer.parseInt(cw_statusStr);

	String cw_ispostil = "";
	String cw_postilname = "";
	String cw_postilcontent = "";
	String cw_postiltime = "";

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
    default:
     strStatus = "";
  }
  cw_id = request.getParameter("cw_id").toString();
  sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办

  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null)
  {
   strSql = "select c.cw_id,c.cp_id,c.us_id,c.cw_applyingname,c.cw_applyingdept,c.cw_email,c.cw_telcode,c.cw_appliedname,c.cw_applieddept,";
   strSql += "c.cw_subject,c.cw_content,c.cw_feedback,c.cw_status,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,e.de_requesttime,f.dt_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dept_name + "=f.dt_id and c.cw_id='" + cw_id + "'";
  }
  else
  {
	   strSql = "select cw_id,cp_id,us_id,cw_applyingname,cw_applyingdept,cw_email,cw_telcode,cw_appliedname,cw_applieddept,cw_subject,cw_content,cw_feedback from tb_connwork where cw_id='"+ cw_id +"'";
  }
  Hashtable content = dImpl.getDataInfo(strSql);

  us_id = content.get("us_id").toString();
  if(!us_id.equals(""))
  {
    is_us = "是";
  }
  cw_id = content.get("cw_id").toString();
  cp_id = content.get("cp_id").toString();
  applyname = content.get("cw_applyingname").toString();
  applydept = content.get("cw_applyingdept").toString();
  strEmail = content.get("cw_email").toString();
  strTel = content.get("cw_telcode").toString();
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
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
受理区长信件
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table align="center" width="100%" CELLPADDING="1" cellspacing="1">
<form  method="post" name="sForm">
   <tr>
        <td width="100%" align="left" valign="top">
						<table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2>受理区长信件</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">发 送 人：</td>
              <td width="82%"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="反映人" value="<%=applyname%>" readonly></td>
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
              <td width="18%" align="right">主　　题：</td>
              <td width="82%"><input type="text" class="text-line" name="strSubject" maxlength="10" size="30" value="<%=strSubject%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td align="right">内　　容：</td>
              <td><textarea class="text-area" name="strContent" cols="60" rows="6" title="内容" readonly><%=strContent%></textarea></td>
            </tr>
            <tr class="line-odd">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-even">
              <td align="right">处理状态：</td>
              <td><%=strStatus%></td>
            </tr>
			
            <tr class="line-odd" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(1)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg1"></a>
                转办处理情况</td>
	    </tr>
            <tr class="line-even" id="Info1" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                    <td align="right" width="18%">转办部门：</td>
                    <td><%=receivername%></td>
                   </tr>
                   <tr class="line-odd">
                    <td align="right" width="18%">转办时限：</td>
                    <td> <%=de_requesttime%> 天</td>
                   </tr>
                   <tr class="line-even">
                    <td align="right" width="18%">转办部门意见：</td>
                    <td><textarea class="text-area" name="co_corropioion" cols="60" rows="6" title="转办部门意见" readonly><%=co_corropioion%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>
            <tr class="line-odd" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a>
                回　　复：</td>
            </tr>
            <tr class="line-even" id="Info2" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                    <td align="right" width="18%">反馈回复：</td>
                    <td><textarea class="text-area" name="strFeedback" cols="60" rows="6" title="信访反馈" <%=feedbackType%>><%=strfeedback%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>
      <tr class="line-odd">
         <td colspan="9" align="left">
                       <a onclick="javascript:Display(3)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg3"></a>
         查看已发送消息：</td>
      </tr>
      <tr  id="Info3" style="display:none">
       <td colspan="9" align="left">
         <table border=0 cellspacing="1" width="100%">
         <tr class="line-even">
         <td width="10%" align="right">已发消息：</td>
         <td align="left">
                 <div>
                         <% //显示针对该项目的消息
                         if (!cw_id.equals(""))
                         {
                                 String sqlStr = "select ma_id from tb_message where ma_primaryid='"+cw_id+"' and ma_relatedtype='1'";

                                 Vector vPage  = dImpl.splitPage(sqlStr,500,1);
                                 if(vPage!=null)
                                 {
                                         for(int i=0;i<vPage.size();i++)
                                         {
                                                 Hashtable l_content = (Hashtable)vPage.get(i);
                                                 //String msgTitle = l_content.get("ma_title").toString();
                                                 String msgId = l_content.get("ma_id").toString();
                                                 //String sendTime = l_content.get("sendtime").toString();
                                                 //String senderDesc = l_content.get("ma_senderdesc").toString();
                                                 CMessage msg = new CMessage(dImpl,msgId);
                                                 %>
                                                 <a href="#" onclick="showMsgDetail('<%=msg.getValue(CMessage.msgId)%>')"><%=msg.getValue(CMessage.msgTitle)%></a>&nbsp;<%=msg.getValue(CMessage.msgSendTime)%>&nbsp;<%=msg.getValue(CMessage.msgSenderDesc)%><br>
                                                 <%
                                         }
                                 }
                         }
                         %>
                         </div>
         </td>
         </tr>
         </table></td>
	</tr>
          </table>
        </td>
      </tr>
      <tr class=outset-table>
         <td width="100%" align="right" colspan="2">
          <p align="center">
            <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;
            <input type=hidden name="cw_status" value="<%=cw_status%>">
            <input type=hidden name="strSubject" value="<%=strSubject%>">
            <input type=hidden name="strfeedback" value="<%=strfeedback%>">
         </td>
      </tr>
    </form>
</table>

<script language="javascript">
  function dovalidate(sForm)//通用文本域校验
  {
     window.open("./cooperate/CorrType.jsp?cw_id=<%=cw_id%>&cp_id=<%=cp_id%>&OPType=Corr","选择信访转办类型","Top=200px,Left=300px,Width=350px,Height=180px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=yes");
  }
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="/system/app/complaint/AppealDel.jsp?cw_id=<%=cw_id%>";
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
       //window.location="mailto:" + sForm.strEmail.value;
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


  function withdraw()
  {
    window.location="/system/app/complaint/AppealDrop.jsp?cw_id=<%=cw_id%>";
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
    form.action = "AppealResult.jsp?cw_id=<%=cw_id%>";
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

  function showMsgDetail(ma_id)
 {
        var w=450;
        var h=250;
        var url = "message/MessageDetail.jsp?ma_id="+ma_id;
        window.open(url,"已发消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
 }
 function sendMsg(cw_id)
 {
        var w=450;
        var h=250;
        var url = "message/MessageDetail.jsp?cw_id="+cw_id;
        window.open(url,"给用户发消息","Top=0px,Left=0px,Width="+w+"px,Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes");
 }

  function openwindow()
  {
          var w=500;
          var h=300;
          var url="exchange/RemoveCorr.jsp?cw_id=<%=cw_id%>";
          window.open(url,"撤销协调单","top=300px,left=300px,width="+w+",height="+h+",toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=yes,scrollbars=yes");
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
                                     
