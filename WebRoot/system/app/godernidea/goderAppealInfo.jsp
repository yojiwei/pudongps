<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>

<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String selfdtid = String.valueOf(self.getDtId());
String sender_id = String.valueOf(self.getMyID());
//update20080122
String cp_id_conn = "";
String cp_name_conn = "";
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<form  method="post" name="sForm" action="goderAppealResult.jsp">
<div id="contents">
<tr>
<td width="100%" align="left" valign="top">
 <table class="content-table" height="1" width="100%">
	<tr class="title1">
	  <td align="center" colspan=2>查看结果</td>
	</tr>
	<tr class="line-odd">
	  <td width="18%" align="right">发 件 人：</td>
	  <td width="82%" align="left"><input type="text" class="text-line" name="applyname" maxlength="10" size="30" title="发送人" value="" ></td>
	</tr>
	<tr class="line-even">
	  <td width="18%" align="right">单　　位：</td>
	  <td width="82%"><input type="text" class="text-line" name="applydept" maxlength="10" size="30" value="" ></td>
	</tr>
	<tr class="line-odd">
	  <td width="18%" align="right">联系电话：</td>
	  <td width="82%"><input type="text" class="text-line" name="strTel" maxlength="100" size="30" value="" >
	  </td>
	</tr>
	<tr class="line-even">
	  <td width="18%" align="right">电子邮件：</td>
	  <td width="82%"><input type="text" class="text-line" name="strEmail" maxlength="30" size="30" value="" >
	  </td>
	</tr>
	<tr class="line-odd">
	  <td width="18%" align="right">是否注册用户：</td>
	  <td width="82%"><input type="text" class="text-line" name="is_us" maxlength="100" size="30" title="注册用户" value="" ></td>
	</tr>
	<tr class="line-even">
	  <td width="18%"  align="right">提交时间:</td>
	  <td width="82%"><input name="cw_finishtime" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()"/>
	  </td>
	</tr>
	<tr class="line-odd">
	  <td width="18%" align="right">咨询主题：</td>
	  <td width="82%"> 
	  <select name="strSubject">
		<option value="经济发展">金点子信箱:经济发展</option>
		<option value="城市建设">金点子信箱:城市建设</option>
		<option value="市容环境">金点子信箱:市容环境</option>
		<option value="教育医疗">金点子信箱:教育医疗</option>
		<option value="社会管理">金点子信箱:社会管理</option>
		<option value="就业保障">金点子信箱:就业保障</option>
		<option value="政府改革">金点子信箱:政府改革</option>
		<option value="科技创新">金点子信箱:科技创新</option>
	  </select>
	   </td>
	</tr>
	<tr class="line-even">
	  <td align="right">咨询内容：</td>
	  <td><textarea name="strContent" cols="60" rows="6" title="信件内容"></textarea></td>
	</tr>
	<tr class="line-odd">
	  <td align="right">来自其他部门：</td>
	  <td>&nbsp;&nbsp;转交时间：</td>
	</tr>
	<tr class="line-even">
	  <td align="right">咨询处理状态：</td>
	  <td></td>
	</tr>
	<tr class="line-odd">
	  <td align="right">转交处理：</td>
	  <td align="left">
	 <select name="deptconn">
	 <option value="">请选择委办局</option>
	 <option value="o5">信访信箱</option>
	 <%
	  String Sql_class = "select cp_id,cp_name from tb_connproc where cp_upid='o7' order by dt_name";
	  Vector vPage1 = dImpl.splitPage(Sql_class,request,100);
	  if (vPage1!=null)
	  {
	   for(int i=0;i<vPage1.size();i++)
	  {
	   Hashtable content1 = (Hashtable)vPage1.get(i);
	   cp_id_conn = content1.get("cp_id").toString();
	   cp_name_conn = content1.get("cp_name").toString();
	  %>
	  <option value="<%=cp_id_conn%>"><%=cp_name_conn%></option>
	  <%
	   }
	   }
	  %>
	  </select>
	</tr>
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
			<td><textarea name="strFeedback" cols="60" rows="6" title="咨询反馈" ></textarea></td>
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
	  </td>
	 </tr>
	 </table></td>
</tr>
  </table>
</td>
</tr>
<tr class=title1>
 <td width="100%" align="center" colspan="2">
	<input type="submit" value="保存"  name="download">
	<input class="bttn" value="取消" type="reset"  size="6" id="button6" name="button6" >&nbsp;
 </td>
</tr></div>
</form>
</table>
<script language="javascript">
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
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
