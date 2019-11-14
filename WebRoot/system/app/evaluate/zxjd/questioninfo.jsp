<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

  String wt_id = "";
  String cw_id = "";

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	
   String sqlStr="";
   Vector vPage=null;

try
{
  wt_id = request.getParameter("wt_id").toString();
  sqlStr = "select jd_id,to_char(wt_senddate,'yyyy-mm-dd hh24:mi:ss')wt_senddate,wt_question,wt_feddback,cw_applyname,to_char(wt_solvedate,'yyyy-mm-dd hh24:mi:ss')wt_solvedate from tb_onlinewt where wt_id='" + wt_id + "'";
	//out.println(sqlcorr);
  Hashtable content = dImpl.getDataInfo(sqlStr);


 // cw_parentid = content.get("cw_parentid").toString();
 String jd_id = content.get("jd_id").toString();
  String cw_applyname = content.get("cw_applyname").toString();
 /// applydept = content.get("cw_applyingdept").toString();
 // strTel = content.get("cw_telcode").toString();
 // strEmail = content.get("cw_email").toString();
 // appealname = content.get("cw_appliedname").toString();
 //// appealdept = content.get("cw_applieddept").toString();
 String wt_question = content.get("wt_question").toString();
 // strContent = content.get("cw_content").toString();
  String wt_feddback = content.get("wt_feddback").toString();
  String wt_senddate = content.get("wt_senddate").toString();
  String wt_solvedate = content.get("wt_solvedate").toString();
 // cw_code = content.get("cw_code").toString();
 // cw_trans_id = content.get("cw_trans_id").toString();
 // cw_transmittime = content.get("cw_transmittime").toString();
 // cw_emailtype = content.get("cw_emailtype").toString();



%>

<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form  method="post" name="sForm" >
<input type=hidden name="wt_id" value="<%=wt_id%>">
<input type=hidden name="jd_id" value="<%=jd_id%>">
<div id="contents">

   <tr>
        <td width="100%" align="left" valign="top">

                  <table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2>查看结果</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">发 件 人：</td>
              <td width="82%" align="left"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="<%=cw_applyname%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">单　　位：</td>
              <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="10" size="30" value="" readonly></td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">联系电话：</td>
              <td width="82%"><input type="text" class="text-line" name="strTel" maxlength="100" size="30" value="" readonly>
              </td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">电子邮件：</td>
              <td width="82%"><input type="text" class="text-line" name="strEmail" maxlength="10" size="30" value="" readonly>
              </td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">是否注册用户：</td>
              <td width="82%"><input type="text" class="text-line" name="is_us" maxlength="100" size="30" title="注册用户" value="是" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%"  align="right">提交时间:</td>
			  <td width="82%"><input type="text" class="text-line" name="wt_senddate" maxlength="10" size="30" value="<%=wt_senddate%>" readonly>
              </td>
            </tr>
			 <%if(!"".equals(wt_feddback)){%>
             <tr class="line-even">
              <td width="18%"  align="right">回复时间:</td>
			  <td width="82%"><input type="text" class="text-line" name="wt_solvedate" maxlength="10" size="30" value="<%=wt_solvedate%>" readonly>
              </td>
            </tr>
			 <%}%>
            <tr class="line-odd">
              <td width="18%" align="right">咨询主题：</td>
              <td width="82%"><textarea name="wt_question" cols="60" rows="6" title="咨询主题" readonly><%=wt_question%></textarea></td>
            </tr>
			<!--
            <tr class="line-even">
              <td align="right">咨询内容：</td>
              <td><textarea name="strContent" cols="60" rows="6" title="信件内容" readonly></textarea></td>
            </tr>
            <tr class="line-odd">
              <td align="right">来自其他部门：</td>
              <td>&nbsp;&nbsp;转交时间</td>
            </tr>-->
            <tr class="line-even">
              <td align="right">咨询处理状态：</td>
              <td><%="".equals(wt_feddback)?"等待回复":"已回复"%></td>
            </tr>
          <!--  <tr class="line-odd">
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
            </tr>
            <tr class="line-even" width="100%">
                <td width="100%" colspan="2" align="left">
                        <a onclick="javascript:Display(2)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg2"></a>
                咨询回复：</td>
            </tr>
            <tr class="line-odd" id="Info2" style="display:none">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">-->
                   <tr class="line-odd">
                    <td align="right" width="18%">在线反馈回复：</td>
                    <td><textarea name="wt_feddback" cols="60" rows="6" title="在线反馈回复" ><%=wt_feddback%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>
      <tr class=title1>
         <td width="100%" align="right" colspan="2">
          <p align="center">
		  <%if("".equals(wt_feddback)){%>
         <input class='bttn' value='回复' type='button' onclick='dealLetter(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;
		 <%}%>
        <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
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
    if(sForm.wt_feddback.value == "") {
    	alert("回复不能为空！");
    	return false;
    }
	
  	if (confirm("确认要这样回复吗？")) {
	    var form = document.sForm;
	    form.action = "questionResult.jsp";
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
    if(sForm.deptconn.value=="")
		{
              alert("转办部门不能为空！");
              return false;
        }
	
	if(sForm.wt_feddback.value=="")
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
			form.wt_feddback.value="已将该情况交由“" + form.deptconn[i].text　+ "”办理";
		}
	}
	if(form.deptconn[0].selected)
	{
		form.wt_feddback.value="";
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
    if(sForm.wt_feddback.value=="")
            {
              alert("回复不能为空！");
              return false;
             }
    else
    *******************/
    if(window.confirm("确认要把信件放入'垃圾信件'吗？")){
    	//alert(sForm.wt_feddback.value)
    //var form = document.sForm;
    	sForm.action = "AppealGarbage.jsp";
    	sForm.submit();
    }
  }

  /*******************处理还原功能******/

  function garbage_Re(sForm){
		    if(window.confirm("确认要把信件还原到'待处理信件'中吗？")){
    	//alert(sForm.wt_feddback.value)
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
<%@include file="/system/app/skin/bottom.jsp"%>

