<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

	String cw_parentid ="";//转办源编号
    String cw_id = "";//编号
    String cp_id = "";//项目编号
    String us_id = "";//用户id
    String is_us = "是";//是否注册用户
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
	String cw_trans_id = "";
	String cw_emailtype="";//转发email地类型
    cw_statusStr = request.getParameter("cw_status").toString();
	String dd_name = "" ;
  
   String dd_id= "" ;//投诉类型
   String cw_ispublish = "";//用户是否同意发布
   String sqlStr="";
   Vector vPage=null;


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
    default:
     strStatus = "";
  }

  cw_id = request.getParameter("cw_id").toString();
  sqlcorr = "select co_id from tb_correspond where cw_id='" + cw_id + "'";//判断是否转办
	Vector vectorPage = dImpl.splitPage(sqlcorr,request,20);

  if(vectorPage!=null)
  {
   strSql = "select c.cw_emailtype,c.cw_parentid,c.cw_id,c.us_id,c.cp_id,c.cw_code,c.cw_applyingname,c.cw_applyingdept,c.cw_email,c.cw_telcode,c.cw_appliedname,c.cw_applieddept,";
   strSql += "c.cw_emailtype,c.cw_subject,c.cw_content,c.cw_feedback,c.cw_status,c.cw_applytime,c.dd_id,c.cw_ispublish,to_char(c.cw_transmittime,'yyyy-mm-dd hh24:mi:ss') cw_transmittime,d.co_question,d.co_mainopioion,d.co_corropioion,d.co_status,";
   strSql += "e.de_senddeptid,e.de_receiverdeptid,e.de_isovertime,e.de_requesttime,f.dt_name ";
   strSql += "from tb_connwork c,tb_correspond d,tb_documentexchange e,tb_deptinfo f where c.cw_id=d.cw_id and d.co_id=e.de_primaryid and " + dept_name + "=f.dt_id and c.cw_id='" + cw_id + "'";
  }
  else
  {
   strSql = "select cw_emailtype,cw_parentid,cw_id,us_id,cp_id,cw_code,cw_applyingname,cw_applyingdept,cw_email," +
   			"to_char(cw_transmittime,'yyyy-mm-dd hh24:mi:ss') cw_transmittime,cw_telcode,cw_appliedname," +
   			"cw_applieddept,cw_subject,dd_id,cw_ispublish,cw_content,cw_feedback,cw_applytime,cw_trans_id from tb_connwork " +
   			"where cw_id='"+ cw_id +"'";
  }

  Hashtable content = dImpl.getDataInfo(strSql);

  cw_id = content.get("cw_id").toString();
  us_id = content.get("us_id").toString();
  if(!us_id.equals(""))
  {
    is_us = "是";
  }
 
  cw_parentid = content.get("cw_parentid").toString();
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
  cw_applytime = content.get("cw_applytime").toString();
  cw_code = content.get("cw_code").toString();
  cw_trans_id = content.get("cw_trans_id").toString();
  cw_transmittime = content.get("cw_transmittime").toString();
  cw_emailtype = content.get("cw_emailtype").toString();

  dd_id = content.get("dd_id").toString();
  cw_ispublish = content.get("cw_ispublish").toString();

  if(!cw_code.equals(""))
  {	 
     String sql_conn = "select dt_id from tb_connproc where cp_id ='"+cw_code+"'";
     Hashtable content_conn = dImpl.getDataInfo(sql_conn);	
	 if (content_conn!=null) cw_codestr = content_conn.get("dt_id").toString();
	  
	 sql_conn ="select dt_name from tb_deptinfo where dt_id ="+cw_codestr;
	 content_conn =dImpl.getDataInfo(sql_conn);
	 if (content_conn!=null) cw_codestr = content_conn.get("dt_name").toString();
  }
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
String logstrMenu = "信访领导信箱";
String logstrModule = "受理信访件";
%>
<%@include file="/system/app/writelogs/WriteDetailLog.jsp"%>
<!-- 记录日志 -->
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form  method="post" name="sForm" >
<input type=hidden name="cw_id" value="<%=cw_id%>">
<div id="contents">

   <tr>
        <td width="100%" align="left" valign="top">

                  <table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2>查看结果</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">发 件 人：</td>
              <td width="82%" align="left"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="<%=applyname%>" readonly></td>
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
					  %>
			 <tr class="line-odd">
              <td width="18%" align="right">信访目的：</td>
              <td width="82%" align="left"><input type="text" class="text-line" name="dd_name" maxlength="10" size="30" title="信访目的" value="<%=dd_name%>" readonly></td>
            </tr>
			<%}%>
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
              <td width="18%"  align="right">提交时间:</td>
			  <td width="82%"><input type="text" class="text-line" name="applytime" maxlength="10" size="30" value="<%=cw_applytime%>" readonly>
              </td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">咨询主题：</td>
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
                    <td><a href="\website\include\downloadAPPEAL.jsp?aa_id=<%=aa_id%>" target="_blank"><%=file_name%></a></td>
                   </tr>
				  <%
					}
			}	  
			%>
            <tr class="line-even">
              <td align="right">咨询内容：</td>
              <td><textarea name="strContent" cols="60" rows="6" title="信件内容" readonly><%=strContent%></textarea></td>
            </tr>
            <tr class="line-odd">
              <td align="right">来自其他部门：</td>
              <td><%=cw_codestr%>&nbsp;&nbsp;转交时间：<%=cw_transmittime%></td>
            </tr>
            <tr class="line-even">
              <td align="right">咨询处理状态：</td>
              <td><%=strStatus%></td>
            </tr>
            <!--tr class="line-odd">
              <td align="right">转交处理：</td>
              <td align="left">
                <select name="deptconn" onchange='setValue11();'>
				 <select name="deptconn" class="input-text1" style="width:120px">
                                     <option value="">请选择转办单位</option>
                                     
						  <%
						 // sqlStr = "select ti_name, ti_id from tb_title where ti_upperid =(select ti_id from tb_title where ti_code = 'pudong_jz')order by ti_sequence";
  
 sqlStr="select c.cp_id, c.cp_name, c.dt_name from tb_connproc c, tb_deptinfo d where c.dt_id = d.dt_id and c.cp_upid = 'o10000' or c.cp_id = 'o10000' and d.dt_id = '11883' order by cp_id";
                          vPage = dImpl.splitPage(sqlStr,request,250);
						if(vPage!=null)
						{
							for(int i=0;i<vPage.size();i++)
							{
								content = (Hashtable)vPage.get(i);
						  %>
                            <option value="<%=content.get("cp_id").toString()%>"><%=content.get("cp_name").toString()%></option>
							<%}}%>
                        
                  </select>
            </tr-->
            <tr class="line-even" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a>
                咨询回复：</td>
            </tr>
            <tr class="line-odd" id="Info2" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-odd">
                    <td align="right" width="18%">咨询反馈回复：</td>
                    <td><textarea name="strFeedback" cols="60" rows="6" title="咨询反馈" <%=feedbackType%>><%=strfeedback%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>
      <tr class="line-even" width="100%">
         <td width="100%" align="left" colspan="9">
                       <a onclick="javascript:Display(3)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg3"></a>
         查看已发送消息：</td>
      </tr>
      <tr id="Info3" style="display:none">
       <td colspan="9" align="left">
         <table border=0 cellspacing="1" width="100%">
         <tr class="line-odd">
         <td width="18%" align="right">已发消息：</td>
         <td align="left">
                 <div>
                         <% //显示针对该项目的消息
                         if (!cw_id.equals(""))
                         {
                                 sqlStr = "select ma_id from tb_message where ma_primaryid='"+cw_id+"' and ma_relatedtype='1'";

                                  vPage  = dImpl.splitPage(sqlStr,500,1);
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
      <tr class=title1>
         <td width="100%" align="right" colspan="2">
          <p align="center">
            <%
              switch(cw_status)
              {
               case 1:
                 //out.print("<input class='bttn' id ='bttn_sel' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='转办' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button4' name='button4'>&nbsp;");
                 break;
               case 2:
                 strStatus = "处理中";
                 //out.print("<input class='bttn' id ='bttn_sel' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input class='bttn' value='完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 out.print("<input class='bttn' value='垃圾信件' type='button' onclick='garbage(document.sForm)'  size='6' id='button4' name='button4'>&nbsp;");
                 break;
               case 3:
                 //out.print("<input  class='bttn' value='删除' type='button' onclick='javascript:del()' size='6' id='button4' name='button4'>&nbsp;");
                 break;
               case 9:
                 strStatus = "垃圾信件";
                 //out.print("<input class='bttn' id ='bttn_sel' value='处理中' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 out.print("<input type='button' value='还原到待处理信箱中'  name='button' onclick='garbage_Re(sForm)' >&nbsp;");
                 break;

                default:
                 strStatus = "";
              }
            %>

			<input type="button" value="导出"  name="download" onclick="javascript:unload_word();" >
			<input type="button" class="bttn" value="发消息" <%if(cw_statusStr.equals("3")||us_id.equals("")) out.print("disabled");%> onclick="sendMsg('<%=cw_id%>');">&nbsp;
            <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;
            <input type=hidden name="cw_parentid" value="<%=cw_parentid%>">
			<input type=hidden name="cp_id" value="<%=cp_id%>">
            <input type=hidden name="us_id" value="<%=us_id%>">
            <input type=hidden name="cw_status" value="<%=cw_status%>">
            <input type=hidden name="strSubject" value="<%=strSubject%>">
            <input type=hidden name="strfeedback" value="<%=strfeedback%>">
            <input type=hidden name="cw_applytime" value="<%=cw_applytime%>">
		    <input type=hidden name="cw_emailtype" value="<%=cw_emailtype%>">

            <input type=hidden name="dd_id" value="<%=dd_id%>">
		    <input type=hidden name="cw_ispublish" value="<%=cw_ispublish%>">
			
         </td>
      </tr></div>
    </form>
</table>

<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="/system/app/consultation/AppealDel.jsp";
   }
  }

 //导出
function unload_word(){
 var url=location.href;
 //document.sForm.pages.value=document.getElementById("contents").innerHTML;
 //document.sForm.pages.value=document.getElementById("contents").innerHTML;
 //alert(document.sForm.pages.value);
 document.sForm.action="unload_word.jsp";
 document.sForm.submit();
}

 

  //处理中
  function dealLetter(sForm) {
    if(sForm.strFeedback.value == "") {
    	alert("回复不能为空！");
    	return false;
    }
  	if (confirm("确认要把信件存入'处理中信件'吗？")) {
	    var form = document.sForm;
	    form.action = "AppealResult.jsp?cw_status=2";
	    form.submit();
    }
  }
  
  function directDeal(sForm)
  {
    if(sForm.strEmail.value!="")
     {
       //if(isEmail(sForm.strEmail.value)==true)
      //{
       if(window.confirm('确认要E-mail反馈吗？'))
       {
       		//window.location="mailto:" + sForm.strEmail.value;
       		//window.open("mailto:"+ sForm.strEmail.value);
       		//window.close();
	       showModalDialog("../court/outLook.jsp?eMail="+sForm.strEmail.value,'dialogWidth:45px; dialogHeight:45; status:0; help:0; scroll:0; resizable:0');
	       var form = document.sForm;
	       form.action = "AppealResult.jsp?cw_status=3";
	       form.submit();
       }
      //}
      //else
      //{
      // alert("邮件地址格式不对！");
      // sForm.strEmail.focus();
      //}
     }
   else
     {
      alert("邮件地址为空，不能E-mail回复！");
      sForm.strEmail.focus();
     }
  }

  function withdraw()
  {
    window.location="/system/app/consultation/AppealDrop.jsp";
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
    form.action = "AppealResult.jsp?cw_status=3";
    form.submit();
    }
  }
  function setdisplay(){
	 if(sForm.deptconn.value=="")		
	{
		//document.all.bttn_sel.style.display="";
	//	document.all.bttn_sel.disabled=false;
	}
	else{
		//document.all.bttn_sel.style.display="none";
	//	document.all.bttn_sel.disabled=true;
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
	if(form.deptconn.value=="")		
	{
		//document.all.bttn_sel.style.display="";
	//	document.all.bttn_sel.disabled=false;
	}
	else{
		//document.all.bttn_sel.style.display="none";
		//document.all.bttn_sel.disabled=true;
	}
  }





  function garbage(sForm)
  {
  	/*****************
    if(sForm.strFeedback.value=="")
            {
              alert("回复不能为空！");
              return false;
             }
    else
    *******************/
    if(window.confirm("确认要把信件放入'垃圾信件'吗？")){
    	//alert(sForm.strFeedback.value)
    //var form = document.sForm;
    	sForm.action = "AppealGarbage.jsp";
    	sForm.submit();
    }
  }

  /*******************处理还原功能******/

  function garbage_Re(sForm){
		    if(window.confirm("确认要把信件还原到'待处理信件'中吗？")){
    	//alert(sForm.strFeedback.value)
    //var form = document.sForm;
    	sForm.action = "Appeal_Re_Garbage.jsp";
    	sForm.submit();
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
                                     
