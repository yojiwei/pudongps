<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script language="vbscript">
function AddAttach1()'新增附件
	dim count_obj,tr_obj,td_obj,file_obj,form_obj,count,table_obj
	dim button_obj,countview_obj
	dim str1,str2

	set form_obj=document.getElementById("formData")
	set fj_obj=document.getElementById("TdInfo1")
	if fj_obj.innertext="无附件" then
	   fj_obj.innertext=""
	end if

	set count_obj=document.getElementById("count_obj")
	if (count_obj is nothing) then
		set count_obj=document.createElement("input")
		count_obj.type="hidden"
		count_obj.id="count_obj"
		count_obj.value=1
	
		form_obj.appendChild(count_obj)
		count=1
		count_obj.value=1
	else
		set count_obj=document.getElementById("count_obj")
		count=cint(count_obj.value)+1
		count_obj.value=count
	end if

	set div_obj=document.createElement("div")
	div_obj.id="div_"&cstr(count)
	fj_obj.appendchild(div_obj)
	str1 = "<hr style='border-top-style: dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1' dotted; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1 size=0 noshade color=#000000>"
	str1 = str1 & "附件名称："
	str1 = str1 & "<input type='file' name='fj2' size=30 class='text-line' id=fj1'>"
	str2="<br>附件说明：<input type='text' name='fjsm1'  size=30  class='text-line' maxlength=100 id='fjsm1'>"
	str3="&nbsp;<img src='/system/images/delete.gif' class=hand onclick='vbscript:delthis1("+""""+div_obj.id+""""+")' id='button1' name='button1'>"
	div_obj.innerHtml = str1 + str2 + str3
end function

'删除函数
function delthis1(id)
	dim child,parent
	set child_t=document.getElementById(id)
	if  (child_t is nothing ) then
		alert("对象为空")
	else
		call DelMain1(child_t)
	end if
	set parent=document.getElementById("TdInfo1")
	if parent.hasChildNodes() =false then
	   parent.innerText="无附件"
	end if
end function

function DelMain1(obj)
	dim length,i,tt
	set tt=document.getElementById("table_obj")
	if (obj.haschildNodes) then
		length=obj.childNodes.length
		for i=(length-1) to 0 step -1
			call DelMain1(obj.childNodes(i))
			if obj.childNodes.length=0 then
				obj.removeNode(false)
			end if
		next
	else
		obj.removeNode(false)
	end if
end function
</script>
<%
//BY PK 2004-4-24 13:41  拟信息公开详细信息
  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String selfdtid = String.valueOf(self.getDtId());
  String sender_id = String.valueOf(self.getMyID());

    //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  
    	String io_id="";  //事项ID
	String io_status=""; //办理状态
	String io_content=""; //要求内容
	String io_reback=""; //回复内容
	String io_reback_time=""; //返回时间
	String io_us_name=""; //用户姓名
	String io_us_address=""; //用户地址
	String io_us_tel=""; //电话
	String io_us_link=""; //其他联系方式
	String io_us_email=""; //邮件
	String io_send_time=""; //发送时间
	String in_project=""; //发送内容主体
	String in_id=""; //信息索引号
	String us_id=""; //用户id
	String str_sql ="";
	String strTitle="";
	String dept_name="";
	String strStatus="";
	String io_reback_kind="";//返回书类别
	
	String if_path=""; //附件路径
	String if_name=""; //附件名称
	String if_nick_name="";//附件别名
	String if_id="";//附件ID
	String if_kind="";//附件上传者类别
	String if_content="";//附件内容
	
    io_status = request.getParameter("io_status").toString();
    //out.print("cw_statusStr"+cw_statusStr);
    int io_status_int = Integer.parseInt(io_status);
    switch(io_status_int)
   {
    case 1:
     strStatus = "待处理";
     dept_name = "e.de_senddeptid";
     break;
    case 2:
     dept_name = "e.de_senddeptid";
     strStatus = "处理中";
     break;
    case 3:
     strStatus = "已完成";
     dept_name = "e.de_senddeptid";
     //feedbackType = "readonly";
     break;
    case 8:
     strStatus = "协调中";
     dept_name = "e.de_receiverdeptid";
     break;
    default:
     strStatus = "";
  }
try
{
  io_id = request.getParameter("io_id").toString();
  //out.println(io_id);
  str_sql="select * from tb_infoOpen where io_id = '" + io_id + "'";
  //out.println(str_sql);
  Hashtable content = dImpl.getDataInfo(str_sql);
  if (content!=null)
  {
  io_us_name=content.get("io_us_name").toString();
  //io__usaddress=content.get("io_us_address").toString();
  io_us_address=content.get("io_us_address").toString();
  io_us_tel=content.get("io_us_tel").toString();
  io_us_email=content.get("io_us_email").toString();
  io_us_link=content.get("io_us_link").toString();
  io_send_time=content.get("io_send_time").toString();
  io_content=content.get("io_content").toString();
  in_project=content.get("in_project").toString();
  io_reback_time=content.get("io_reback_time").toString();
  io_reback=content.get("io_reback").toString();
  io_reback_kind=content.get("io_reback_kind").toString();
  us_id=content.get("us_id").toString();
  }
%>

<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
<form  method="post" name="sForm" enctype="multipart/form-data">
   <tr>
        <td width="100%" align="left" valign="top">

                  <table class="content-table" height="1" width="100%">
            <tr class="title1">
              <td align="center" colspan=2>拟申请信息公开</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">申请人（单位）：</td>
              <td width="82%"><input type="text" class="text-line" name="io_us_name" maxlength="100" size="52" title="申请人" value="<%=io_us_name%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">地    址：</td>
              <td width="82%"><input type="text" class="text-line" name="io_us_address" maxlength="100" size="52" value="<%=io_us_address%>" readonly>
              </td>
              </tr>
            <tr class="line-odd">
              <td width="18%" align="right">联系电话：</td>
              <td width="82%"><input type="text" class="text-line" name="io_us_tel" maxlength="100" size="52" value="<%=io_us_tel%>" readonly>
              </td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">电子邮件：</td>
              <td width="82%"><input type="text" class="text-line" name="io_us_email" maxlength="100" size="52" value="<%=io_us_email%>" readonly>
              </td>
              </tr>
            <tr class="line-odd">
              <td width="18%" align="right">其他联系方式：</td>
              <td width="82%"><input type="text" class="text-line" name="io_us_link" maxlength="100" size="52" title="注册用户" value="<%=io_us_link%>" readonly></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">申请日期：</td>
              <td width="82%"><input type="text" class="text-line" name="io_send_time" maxlength="100" size="52" value="<%=io_send_time%>" readonly>
              </td>
              </tr>
            <tr class="line-odd">
              <td width="18%" align="right">申请人附言：</td>
              <td width="82%"><textarea rows='5' cols='50' name="io_content" readonly><%=io_content%></textarea></td>
            </tr>
            
            <tr class="line-even">
              <td width="18%" align="right">申请事项名称：</td>
              <td width="82%"><input type="text" class="text-line" name="in_project" maxlength="100" size="52" title="投诉人" value="<%=in_project%>"readonly></td>
            </tr>
            <tr class="line-odd">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">事项反馈用户类别：</td>
              <td width="82%">
              <select name="io_reback_kind">
              
              <option value="1" <%if(io_reback_kind.equals("1")) out.print("selected");%>>政府信息公开</option>
              <option value="2" <%if(io_reback_kind.equals("2")) out.print("selected");%>>政府信息部分公开</option>
              <option value="3" <%if(io_reback_kind.equals("3")) out.print("selected");%>>政府信息不予公开</option>
              <option value="4" <%if(io_reback_kind.equals("4")) out.print("selected");%>>非本机关政府信息</option>
              <option value="5" <%if(io_reback_kind.equals("5")) out.print("selected");%>>政府信息不存在</option>
              <option value="6" <%if(io_reback_kind.equals("6")) out.print("selected");%>>补正申请通知</option>
              </select>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">事项办理返回日期：</td>
              <td width="82%"><input type="text" class="text-line" name="io_reback_time" maxlength="100" size="52" value="<%=io_reback_time%>"></td>
            </tr>
            <tr class="line-even">
              <td width="18%" align="right">事项办理返回附言：</td>
              <td width="82%"><textarea rows='5' cols='50' name="io_reback"><%=io_reback%></textarea></td>
            </tr>
             <!--返回附件-->
            <tr class="line-odd">
            <%
            String sqlcontent="select * from tb_infoFile where io_id = '" + io_id + "' and if_kind = '1'";
            //out.println(sqlcontent);
            Hashtable content0 = dImpl.getDataInfo(sqlcontent);
            if_name="";
            if_id="";
            if_nick_name="";
            String if_file="";
            if_path="";
            if (content0!=null)
            {
            	if_name=content0.get("if_name").toString();
            	if_id=content0.get("if_id").toString();
            	if_nick_name=content0.get("if_nick_name").toString();
            	if_path=content0.get("if_path").toString();
            %>
            <td align='right'>返回结果书:</td>
            <td>
            <a href="/website/include/downloadIF.jsp?if_id=<%=if_id%>" title="下载该文件" target="_blank"><%=if_nick_name%></a>
            </td>
            <%
            }
            else
            {
            %>
            <td align='right'>返回结果书：</td>
            <td>
            	<input type="file" name="fj1" class="text-line">
		<input type="hidden" name="if_name" value="<%=if_name%>">
		<input type="hidden" name="if_id" value="<%=if_id%>">
		<input type="hidden" name="if_path" value="<%=if_path%>">
	   </td>
            <%}%>
            </tr>
            <!---->
            <!--用户附件-->
            <tr class="line-even">
            <td align='right'>用户申请书：</td>
            <%
            sqlcontent="select * from tb_infoFile where io_id = '" + io_id + "' and if_kind = '2'";
            //out.println(sqlcontent);
            Hashtable content1 = dImpl.getDataInfo(sqlcontent);
            if (content1!=null)
            {
            	if_name=content1.get("if_name").toString();
            	if_id=content1.get("if_id").toString();
            	if_nick_name=content1.get("if_nick_name").toString();
            	if_path=content1.get("if_path").toString();
            %>
            
            <td>
            <a href="downloadIF.jsp?if_id=<%=if_id%>" title="察看该文件"><%=if_nick_name%></a>
            </td>
            <%
            }
            else
            {
            %>
            <td>无用户申请书,请与用户取得联系。
	   </td>
            <%}%>
            </tr>
            <!---->
      <tr class="line-odd" width="100%">
         <td width="100%" align="left" colspan="9">
                       <a onclick="javascript:Display(3,document.sForm)" style="cursor:hand"><img border="0" src="/system/images/topplus.gif" WIDTH="16" HEIGHT="16" id="InfoImg3"></a>
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
                         if (!io_id.equals(""))
                         {
                                 String sqlStr = "select ma_id from tb_message where ma_primaryid='"+io_id+"' and ma_relatedtype='2'";

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
      <tr class=title1>
         <td width="100%" align="right" colspan="2">
          <p align="center">
            <%
              
              switch(io_status_int)
              {
               case 1:
                 out.print("<input class='bttn' value='处理' type='button'  size='6' id='button6' name='button6' onclick='javascript:save()'>&nbsp;");
                 out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 break;
               case 2:
                 out.print("<input class='bttn' value='处理' type='button'  size='6' id='button6' name='button6' onclick='javascript:save()'>&nbsp;");
                 out.print("<input class='bttn' value='E-mail回复' type='button' onclick='directDeal(document.sForm)'  size='6' id='button1' name='button1'>&nbsp;");
                 //out.print("<input class='bttn' value='处理完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
                 break;
               case 3:
                 //out.print("<input  class='bttn' value='删除' type='button' onclick='javascript:del()' size='6' id='button4' name='button4'>&nbsp;");
                 break;
               default:
                 strStatus = "";
              }
            %>
            
            <input type="button" class="bttn" value="发消息" <%if(io_status.equals("3")||us_id.equals("")) out.print("disabled");%> onclick="sendMsg('<%=io_id%>');">&nbsp;
            <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;
            <input type=hidden name="io_status" value="<%=io_status%>">
         </td>
      </tr>
    </form>
</table>

<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么？'))
   {
    window.location="/system/app/appeal/OpenDel.jsp?io_id=<%=io_id%>";
   }
  }

  function directDeal(sForm)
  {
  	if (sForm.io_us_email.value == "") {
  		alert("申请人没有填写电子邮件，不能以E-mail回复！");
  		return false;
  	}
    if(sForm.io_us_email.value!="")
     {
       if(isEmail(sForm.io_us_email.value)==true)
      {
       if(window.confirm('确认要E-mail反馈吗？'))
       {
       //window.location.href = "mailto:" + sForm.strEmail.value;
       window.open("mailto:"+ sForm.io_us_email.value);
       window.close();
       var form = document.sForm;
       form.action = "OpenDeal.jsp?io_id=<%=io_id%>";
       form.submit();
       }
      }
      else
      {
       alert("邮件地址格式不对！无法通过该方式回复用户");
       form.action = "OpenInfo.jsp?io_id=<%=io_id%>";
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
    window.location="/system/app/appeal/AppealDrop.jsp?io_id=<%=io_id%>";
  }
  function save()
  {
    if(sForm.io_reback.value=="") {
      alert("回复不能为空！");
      sForm.io_reback.focus();
      return false;
    }
    //var form = document.sForm;
    sForm.action = "OpenReply.jsp?io_id=<%=io_id%>";
    sForm.submit();
  }
  function finish(sForm)
  {
    
    if(sForm.io_reback.value=="")
            {
              alert("回复不能为空！");
              return false;
             }
    else
    if(window.confirm('确认要这样处理吗？')){
    //var form = document.sForm;
    sForm.action = "openResult.jsp?io_id=<%=io_id%>";
    sForm.submit();
    }
  }

  function Display(Num,xForm)
  {
        var obj=eval("Info"+Num);
        var objImg=eval("xForm.InfoImg"+Num);

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

