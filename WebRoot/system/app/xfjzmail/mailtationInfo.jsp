<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

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
    //int intStatus = Integer.parseInt(cw_status);//投诉状态
    String cw_statusStr = "";
    String strStatus = "";//投诉状态
    String strSql = "";
    String sqlcorr = "";//判断是否转办
    String receivername = "";//转办部门
    String dept_name = "";
    String co_corropioion = "";//转办部门意见
    String co_id = "";//转办编号
    String de_requesttime = "";//转办时限
	String cw_addresscode = "";
	String cw_applytime = "";
    cw_statusStr = request.getParameter("cw_status").toString();
    //out.print("cw_statusStr"+cw_statusStr);
    int cw_status = Integer.parseInt(cw_statusStr);
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
  //out.println("strStatus"+strStatus);
try
{
  cw_id = request.getParameter("cw_id").toString();
  sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办

  Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null)
  {
   strSql = "select c.cw_id,c.us_id,c.cw_applytime,c.cw_telcode,c.cp_id,c.cw_applyingname,c.cw_applyingdept,c.cw_addresscode,c.cw_email,c.cw_appliedname,c.cw_applieddept,";
   strSql += "c.cw_subject,c.cw_content,c.cw_feedback,c.cw_status,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,e.de_requesttime,f.dt_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dept_name + "=f.dt_id and c.cw_id='" + cw_id + "'";
  }
  else
  {
   strSql = "select cw_id,cp_id,us_id,cw_applytime,cw_telcode,cw_applyingname,cw_addresscode,cw_applyingdept,cw_email,cw_appliedname,cw_applieddept,cw_subject,cw_content,cw_feedback from tb_connwork where cw_id='"+ cw_id +"'";
  }
  //out.println(strSql);
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
  strTel = content.get("cw_telcode").toString();
  strEmail = content.get("cw_email").toString();
  appealname = content.get("cw_appliedname").toString();
  appealdept = content.get("cw_applieddept").toString();
  strSubject = content.get("cw_subject").toString();
  strContent = content.get("cw_content").toString();
  strfeedback = content.get("cw_feedback").toString();
  cw_addresscode = content.get("cw_addresscode").toString();
  cw_applytime = content.get("cw_applytime").toString();
  if(vectorPage!=null)
  {
   receivername = content.get("dt_name").toString();
   co_corropioion = content.get("co_corropioion").toString();
   de_requesttime = content.get("de_requesttime").toString();
  }

%>

<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form  method="post" name="sForm">
   <tr>
      <td width="100%" align="left" valign="top">
        <table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2>受理信件</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">发 送 人：</td>
              <td width="82%"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="<%=applyname%>" readonly></td>
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
              <td width="18%" align="right">联系地址：</td>
              <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="10" size="30" value="<%=applydept%>" readonly></td>
            </tr>
			  <tr class="line-even">
              <td width="18%" align="right">邮政编码：</td>
              <td width="82%"><input type="text" class="text-line" name="cw_addresscode" maxlength="10" size="30" value="<%=cw_addresscode%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">信件主题：</td>
              <td width="82%"><input type="text" class="text-line" name="strSubject" maxlength="10" size="30" value="<%=strSubject%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td align="right">信件内容：</td>
			<!--td><!--textarea class="text-area" name="strContent" cols="60" rows="6" title="信件内容" readonly--><!--%=strContent%><!--/textarea--><!--/td--> 

				<td><textarea name="strContent" cols="60" rows="6" title="信件内容" readonly><%=strContent%></textarea>
            </tr>
            <tr class="line-odd">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-even">
              <td align="right">信件处理状态：</td>
              <td><%=strStatus%></td>
            </tr>

			<tr class="line-odd">
              <td align="right">转交处理：</td>
              <td align="left">
				<select name="deptconn" onchange='setValue11();'>
                                     <option value="">请选择转交单位</option>
                                     <%
                                      String Sql_class = "select cp_id,cp_name from tb_connproc where cp_upid='o10000' or cp_id='o5' order by cp_id desc,dt_name";
                                      Vector vPage1 = dImpl.splitPage(Sql_class,request,100);
                                      if (vPage1!=null)
                                      {
                                       for(int i=0;i<vPage1.size();i++)
                                      {
                                       Hashtable content1 = (Hashtable)vPage1.get(i);
                                       String cp_id_conn = content1.get("cp_id").toString();
                                       String cp_name_conn = content1.get("cp_name").toString();
                                      %>
                                      <option value="<%=cp_id_conn%>"><%=cp_name_conn%></option>
                                      <%
                                       }
                                       }
                                      %>
				</select>
              </td>
            </tr>


            <tr class="line-odd" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a>
                信件回复：</td>
            </tr>
            <tr class="line-even" id="Info2" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                    <td align="right" width="18%">信件反馈回复：</td>
                    <td><textarea class="text-area" name="strFeedback" cols="60" rows="6" title="信件反馈" <%=feedbackType%>><%=strfeedback%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>           
      <tr class=title1>
         <td width="100%" align="right" colspan="2">
          <p align="center">           
            <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;
            <input type=hidden name="cw_status" value="<%=cw_status%>">
            <input type=hidden name="strSubject" value="<%=strSubject%>">
            <input type=hidden name="strfeedback" value="<%=strfeedback%>">
			<input type=hidden name="cw_applytime" value="<%=cw_applytime%>">
			<input type=hidden name="us_id" value="<%=us_id%>">
         </td>
      </tr>
    </form>
</table>
</td></tr></table>
<%@include file="/system/app/skin/bottom.jsp"%>


<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="/system/app/court/AppealDel.jsp?cw_id=<%=cw_id%>";
   }
  }
	
	
  //处理中
  function dealLetter(sForm) {
    if(sForm.strFeedback.value == "") {
    	alert("回复不能为空！");
    	return false;
    }
  	if (confirm("确定要将信件存入'处理中信件'吗?")) {   
  	   var form = document.sForm; 
       form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=2";
       form.submit();
  	}
  }  
  
  //垃圾信件
  function dirtyLetter(sForm) {
  	if (confirm("确定要将信件放入'垃圾信件'吗?")) {
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
	       //window.location="mailto:" + sForm.strEmail.value;
	       window.open("mailto:"+ sForm.strEmail.value);
	       window.close();
	       var form = document.sForm;
		   form.strFeedback.value="已经通过E-mail反馈！";
	       form.action = "AppealResult.jsp?cw_id=<%=cw_id%>&cw_status=3";
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


	function setValue11()
  {		
	var form = document.sForm;		
	for(i=1;i<form.deptconn.length;i++)
	{		
		if(form.deptconn[i].selected)
		{
			form.strFeedback.value="已将该情况交由“" + form.deptconn[i].text　+ "”办理";
		}
	}
	if(form.deptconn[0].selected)
	{
		form.strFeedback.value="";
	}
  }

  function finish(sForm)
  {
    if(sForm.strFeedback.value=="") {
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
</script>
<%
}
catch(Exception e)
{
     out.println(e);
}
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

