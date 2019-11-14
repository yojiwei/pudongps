<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript">
function showCal(obj)
{
	if (!obj) var obj = event.srcElement;
	var obDate;
	if ( obj.value == "" ) {
		obDate = new Date();
	} else {
		var obList = obj.value.split( "-" );
		obDate = new Date( obList[0], obList[1]-1, obList[2] );
	}

	var retVal = showModalDialog( "../../common/calendar/calendar.htm", obDate,
		"dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

	if ( typeof(retVal) != "undefined" ) {
		var year = retVal.getFullYear();
		var month = retVal.getMonth()+1;
		var day = retVal.getDate();
		obj.value =year + "-" + month + "-" + day;
	}
}
function checkform()
{
	var form = document.formData ;

	if	 (form.WF_publish_time.value =="")
	{
		alert("请填写本次发布日期!");
		form.WF_publish_time.focus();
		return false;
	}
	if	 (form.WF_contentch.value =="")
	{
		alert("请输入中文版天气预报!");
		form.WF_contentch.focus();
		return false;
	}
	if	 (form.WF_contentch.value !="") {
		if (form.WF_contentch.value.length > 1000) {
			alert("您输入的中文版内容不能超过1000字！");
			form.WF_contentch.focus();
			return false;
		}
	}
	if	 (form.WF_contenten.value =="")
	{
		alert("请输入英文版天气预报!");
		form.WF_contenten.focus();
		return false;
	}
	if	 (form.WF_contenten.value !="") {
		if (form.WF_contenten.value.length > 1000) {
			alert("您输入的英文版内容不能超过1000字！");
			form.WF_contenten.focus();
			return false;
		}
	}

  form.action = "weatherResult.jsp";
  form.target = "_self";
  form.submit();
}
function del1(WF_id)
{
  var con;
  con=confirm("真的要删除吗？");
  if (con)
  {
	var form = document.formData ;
	form.action = "weatherDel.jsp?WF_id="+WF_id;
	form.submit();
  }
}

</script>
<!-- 程序开始 -->
<%
/*获取系统日期*/
/*
DateFormat df     = DateFormat.getDateInstance(DateFormat.DEFAULT , Locale.CHINA);
String systemTime = df.format(new java.util.Date());
*/
String strTitle="天气预报发布" ;
String sql="";//查询条件
String OPType="";//操作方式 Add是添加 Edit是修改
String WF_id=""; //主键
String WF_publish_time=""; //天气预报发布时间
String WF_contentch="";; //中文天气预报内容
String WF_contenten=""; //英文天气预报内容

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

/*得到上一个页面传过来的参数  开始*/
WF_id=CTools.dealString(request.getParameter("WF_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();

/*得到上一个页面传过来的参数  结束*/
%>


<%
if (OPType.equals("Edit"))
{
sql="select * from tb_weatherforecast where wf_id=" + WF_id;
Hashtable content=dImpl.getDataInfo(sql);
WF_publish_time=content.get("wf_publish_time").toString() ;//天气预报发布日期
WF_contentch=content.get("wf_contentch").toString() ;//中文天气预报内容
WF_contenten=content.get("wf_contenten").toString() ;//英文天气预报内容
}
/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
String ctId = CTools.dealString(request.getParameter("ct_id"));
  if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }
  else
  {
    uiid= "2";
  }
%>
<!-- 程序结束 -->
<!-- 主体开始  -->
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
天气预报发布
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%">
<form name="formData" method="post" action="weatherResult.jsp">
<input type="hidden" name="WF_id" value="<%=WF_id%>">
 <tr class="title1" align=center>
      <td>天气预报发布</td>
    </tr>
  <tr>
            <td width="22%" align="right"><font color="red">*</font> 请选择本次发布日期：</td>
            <td width="81%"  align="left"><input type="date" size=13 name="WF_publish_time" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly value="<%=WF_publish_time%>">
            	<!--select class="text-line" name="WF_publish_time">
            <option value="">请选择本次发布时间</option>
            <option value="4:00">--== 凌晨04:00 ==--</option>
            <option value="10:00">--== 上午10:00 ==--</option>
            <option value="16:00">--== 下午16:00 ==--</option>
            </select-->
            </td>
          </tr>
          <tr class="line-odd">
            <td width="22%" align="right" valign="top"><font color="red">*</font> 中文版天气预报：</td>
            <td width="81%" align="left"><textarea name="WF_contentch" rows="4" style="width:85%"><%=WF_contentch%></textarea>
            </td>
          </tr>
          <tr class="line-even">
            <td width="22%" align="right" valign="top"><font color="red">*</font> 英文版天气预报：</td>
            <td width="81%" align="left"><textarea name="WF_contenten" rows="4" style="width:85%"><%=WF_contenten%></textarea>
            </td>
          </tr>
<!--------------------当成短信发送------------------------->
	 <%
		 if(OPType.equals("Edit"))
		 {
		 	String xiaoweiSql="select s.*,d.sj_name from tb_sms s left join tb_subject d on s.sm_sj_id = d.sj_id where s.sm_ct_id="+WF_id;
			Vector vectorPage2 = dImpl.splitPage(xiaoweiSql,request,20);
			  if(vectorPage2!=null)
			  {
				for(int w=0;w<vectorPage2.size();w++)
				{
				  Hashtable content121 = (Hashtable)vectorPage2.get(w);
			if (content121!=null)
			{
			%>
	     <tr class="odd">
         <td width="19%" align="left">短信信息：</td>
          <td width="81%" align='left'>
			
			<%
				String sm_con = content121.get("sm_con").toString();
				String sj_name = content121.get("sj_name").toString();
				String sm_check = content121.get("sm_check").toString();//1待审核 2 通过了 3 没有通过
				String sm_flag = content121.get("sm_flag").toString();//1 发送了 2 没有发送
				out.print(sm_con+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+sj_name+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				switch (Integer.parseInt(sm_check))
				{
				case 1: out.print("待审核");break;
				case 2: out.print("审核通过");break;
				case 3: out.print("没有通过审核");break;
				}
				
				
			%>	
     </td>
     </tr><%
			}
			}
			}
			}
		 %>
<%if(OPType.equals("Add")||OPType.equals("Edit")){%>
     <tr class="line-even">
        <td width="100%" colspan="4">
       §<a onClick="myshow(1,2)" style="cursor:hand">将信息定制成短信</a>(<span id=mess></span><input name="message" value="51" type="text" size="4" readonly/>个字！<span  class="STYLE1">  超出部分将分条收费！</span>) </td>
     </tr>
	 <%}%>
	 <tr class="odd"  id="submenu2" style="display:none ">
         <td width="19%" align="right">短信所属栏目：</td>
          <td width="81%" align='left'>
<%
String strSqlx="select sj_id,sj_parentid,sj_dir,sj_name from tb_subject where sj_dir='dxpd_tqyb' ";
String ri="";
String ni="";
Hashtable contentxw = dImpl.getDataInfo(strSqlx);
  if(contentxw!=null)
  {
	  ri=contentxw.get("sj_name").toString();
	  ni = contentxw.get("sj_id").toString();
  }
  out.print(ri);
%>
  <input type="hidden" name="mysj_id" value="<%=ni%>"/>
     </td>
     </tr>
     <tr class="line-even" id="submenu1"  style="display:none ">
        <td width="100%" colspan="4">
          <textarea name="messages" cols="60" rows="8" onbeforepaste="pp(this.form.messages,this.form.message,51)"></textarea>&nbsp;&nbsp;
          </td>
     </tr>
<!--------------------当成短信发送-------------------------> 
   <tr class="outset-table" align="center">
       <td colspan="2">
<%
        if (OPType.equals("Add"))
        {
%>
<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform()">&nbsp;
<input type="reset" class="bttn" name="reset" value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
<INPUT TYPE="hidden" name="OPType" value="Add">
<%
        }
        else
        {
%>
<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform()">&nbsp;
   <input type="button" class="bttn" name="del" value="删 除" onclick="javascript:del1(<%=WF_id%>)">&nbsp;
   <input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
   <INPUT TYPE="hidden" name="OPType" value="Edit">

<%
        }
%>
       </td>
   </tr>
</form>
</table>
<script language=javascript>
function showDiv(flag)
{
  var obj=document.getElementsByName('infoOpen');
  for(var i=0;i<obj.length;i++)
  {
    obj[i].style.display=flag;
  }
}
function myshow(number,num)
{
	var str=eval("submenu"+number);
	var str1=eval("submenu"+num);
	if(str.style.display=="none")
	{
		eval("submenu"+number+".style.display=''")//等同于document.all.item("submenu"+number).style.display='';
	}else
	{
		eval("submenu"+number+".style.display='none'");//等同于document.all.item("submenu"+number).style.display='';
	}
	if(str1.style.display=="none")
	{
		eval("submenu"+num+".style.display=''")//等同于document.all.item("submenu"+number).style.display='';
	}else
	{
		eval("submenu"+num+".style.display='none'");//等同于document.all.item("submenu"+number).style.display='';
	}
}
<!--//   
function   textCounter(field,   countfield,   maxlimit)   {  
	if(field.value.length   >   maxlimit){
	document.getElementById("mess").innerHTML="<font color='#FF0000'>注意：您已经超出了</font>";  
	} 
	else
	document.getElementById("mess").innerHTML="注意：您还可以输入";  
	countfield.value   =   maxlimit   -   field.value.length;   
}
function pp(field,countfield,maxlimit){ 
var clob = "";
}
setInterval("textCounter(document.all.messages,document.all.message,51)", 1);
//-->   
</SCRIPT>
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
                                     
