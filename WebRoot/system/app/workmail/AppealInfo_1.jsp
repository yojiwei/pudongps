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
	String strStatus = "";
	String feedbackType = "";
	String st_id = CTools.dealString(request.getParameter("st_id"));
	String st_status = CTools.dealString(request.getParameter("st_status"));
	st_status = "".equals(st_status) ? "1" : st_status;
	int intStatus = Integer.parseInt(st_status);

	if (intStatus == 1)
		dImpl.executeUpdate("update tb_suggestmail set st_restatus = 2 where st_id = " + st_id);
	
    switch(intStatus) {
	    case 1:
	     strStatus = "待处理";
	     break;
	    case 2:
	     strStatus = "处理中";
	     break;
	    case 3:
	     strStatus = "已处理";
	     feedbackType = "readonly";
	     break;
	    default:
	     strStatus = "";
  } 
	  String strSql = "select * from tb_suggestmail where st_id = " + st_id;
	  Hashtable content = dImpl.getDataInfo(strSql);	
		
	  String st_name = content.get("st_name").toString();
	  String st_dept = content.get("st_dept").toString();
	  String st_tel = content.get("st_tel").toString();
	  String st_email = content.get("st_email").toString();
	  String st_title = content.get("st_title").toString();
	  String st_content = content.get("st_content").toString();
	  String st_applydate = content.get("st_applydate").toString();
	  String st_recontent = content.get("st_recontent").toString();
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
错误信息受理
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
           <tr class="line-odd">
              <td width="18%" align="right">发 送 人：</td>
              <td width="82%"><input type="text" class="text-line" name="st_name" maxlength="10" size="30" title="发送人" value="<%=st_name%>" readonly></td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">联系方式：</td>
              <td width="82%"><input type="text" class="text-line" name=st_tel maxlength="100" size="30" value="<%=st_tel%>" readonly>
              </td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">工作单位：</td>
              <td width="82%"><input type="text" class="text-line" name=st_dept maxlength="100" size="30" value="<%=st_dept%>" readonly>
              </td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">电子邮件：</td>
              <td width="82%"><input type="text" class="text-line" name=st_email maxlength="100" size="30" value="<%=st_email%>" readonly>
              </td>
            </tr>
            <tr class="line-even">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-odd">
              <td width="18%" align="right">主　　题：</td>
              <td width="82%"><input type="text" class="text-line" name=st_title maxlength="100" size="30" value="<%=st_title%>" readonly>
              </td>
            </tr>
            <tr class="line-even">
              <td align="right">建议信息：</td>
              <td><textarea class="text-area" name="st_content" cols="60" rows="6" title="信息内容" readonly><%=st_content%></textarea></td>
            </tr>
            <%
            	strSql = "select * from tb_appealattach where cw_id = 'GZ" + st_id + "'";
            	Hashtable conAttach = dImpl.getDataInfo(strSql);
            	if (conAttach != null) {
					String aa_id = conAttach.get("aa_id").toString();
					String file_name = conAttach.get("aa_filename").toString();
            %>
            <tr class="line-even">
              <td align="right">附　　件：</td>
              <td><a href="/website/include/downloadAPPEAL.jsp?aa_id=<%=aa_id%>" target="_blank"><%=file_name%></a></td>
            </tr>
            <%	}%>
            <tr class="line-odd">
              <td colspan="2" align="right">&nbsp;</td>
            </tr>
            <tr class="line-even">
              <td align="right">信息处理状态：</td>
              <td><%=strStatus%></td>
             </tr>
            <tr class="line-even" id="Info2">
                <td align="left" height="20" colspan=2>
                  <table cellspacing="1" border="0" bgcolor="#ffffff" width="100%">
                   <tr class="line-even">
                    <td align="right" width="18%">信息反馈回复：</td>
                    <td><textarea class="text-area" name="st_recontent" cols="60" rows="6" title="信息反馈" <%=feedbackType%>><%=st_recontent%></textarea></td>
                   </tr>
                  </table>
                </td>
            </tr>           
      <tr class=outset-table>
         <td width="100%" align="right" colspan="2">
          <p align="center">
            <%
              switch(intStatus)
              {
               case 1:
               	  out.print("<input class='bttn' value='完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
               	  break;
               case 2:
               	  out.print("<input class='bttn' value='完成' type='button' onclick='finish(document.sForm)'  size='6' id='button3' name='button3'>&nbsp;");
               	  break;
               default:
                 strStatus = "";
              }
            %>
            <input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">&nbsp;

         </td>
      </tr>
    </form>
</table>

<script language="javascript">

  function finish(sForm)
  {
    if(sForm.st_recontent.value=="") {
      alert("回复不能为空！");
      sForm.st_recontent.focus();
      return false;
    }
    else
    if(window.confirm('确认要这样处理吗？')){
	    var form = document.sForm;
	    form.action = "AppealResult_1.jsp?st_id=<%=st_id%>&st_status=3";
	    form.submit();
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
                                     
