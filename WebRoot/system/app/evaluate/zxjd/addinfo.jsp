<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="java.util.*"%>
<%@page import="vote.*"%>

<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String upperid = "";
String strTitle = "";//抬头标题
//修改用的信息
String vt_id = "";
String vt_name = "";
String vt_upperid = "";
String vt_type = "";
String vt_sequence = "";
String vt_desc = "";
String vt_parameter = "";
String OType = "";
String treeid = "";

String vde_img="";//IM_ID
String vde_starttime = "";//开始时间
String vde_finishtime= "";//结束时间
String vde_type = "";//是否为问卷
String vde_sort= "";//结束时间
String Typepp="";
String sqlStr= "";
Hashtable content = null;
  Vector vPage =null;

  Hashtable newcontent = null;
  Vector newvPage =null;

OType = CTools.dealString(request.getParameter("OType")).trim();
String jd_id = CTools.dealString(request.getParameter("jd_id")).trim();


	//out.print("<tr class='line-odd'>");
	//out.print("<td align='right'>上级栏目：</td>");
//out.print("<td align='left'>");	
if("".equals(jd_id)){%>
<form name="formData" method="post">
 <tr class='line-even'>
<td align='right' width='16%'>接待主题：</td>
<td align='left'><input type='text' name='jd_subject' size='80' value="" class='text-line'></td>
</tr>
  <tr class="line-odd" >
               <td width="19%" align="right">接待时间：</td>
               <td width="51%" align='left'><input type="text" name="jd_date" class="text-line" value="" readonly="true" style="width:86px"onclick="javascript:showCal()" style="cursor:hand"/>
			   <select name="jd_starthours">
			   <%for(int j=0;j<24;j++){%>
			   <option value="<%=j%>"><%=j%></option>
			   <%}%>
			   </select>时
			    <select name="jd_startmin">
			   
			   <option value="00">00</option>
                <option value="30">30</option>
			 
			   </select>分
                &nbsp;&nbsp;结束时间：<input type="text" name="jd_finishdate" class="text-line" value="" readonly="true" style="width:86px"onclick="javascript:showCal()" style="cursor:hand"/>
				 <select name="jd_endhours">
<%
				   for(int j=0;j<24;j++)
{%>
			   <option value="<%=j%>"><%=j%></option>
			   
<%}%>
			   </select>时
			    <select name="jd_endmin">
			   
			   <option value="00">00</option>
               <option value="30">30</option>
			 
			   </select>分
               </td>
             </tr>
	<!--<tr class="line-odd">
		<td align='right' width='16%'>接待时间：</td><td align='left'><input type="text" name="jd_date"  value="<%=vde_starttime%>"  class=text-line ></td>
	  </tr>-->
<tr class="line-even">
		<td align='right' width='16%'>接待地点：</td><td align='left'><input type="text" name="jd_address"  value=""  class=text-line ></td>
	  </tr>
	  
	  <tr class="line-odd">
         <td align='right' width='16%'>接待单位：</td>
		 <td align='left'>
		  <input type='text' name='jd_depart'  value="" class='text-line'>
         <!--<select name="vde_sort" class=text-line >-->
      <!-- <select name="jd_depart" class="input-line" style="width:180px">
                                     <option value="">请选择接待单位</option>
                                     
						  <%
						 // sqlStr = "select ti_name, ti_id from tb_title where ti_upperid =(select ti_id from tb_title where ti_code = 'pudong_jz')order by ti_sequence";
  
 sqlStr="select c.cp_id, c.cp_name, c.dt_name from tb_connproc c, tb_deptinfo d where c.dt_id = d.dt_id and c.cp_upid = 'o10000' or c.cp_id = 'o10000' and d.dt_id = '11883'order by cp_id";
                         vPage = dImpl.splitPage(sqlStr,request,250);
						if(vPage!=null)
						{
							for(int i=0;i<vPage.size();i++)
							{
								content = (Hashtable)vPage.get(i);
						  %>
                            <option value="<%=content.get("cp_name").toString()%>"><%=content.get("cp_name").toString()%></option>
							<%}}%>
                         <%
                                      String Sql_class = "select cp_id,cp_name from tb_connproc where cp_upid='o7' order by dt_name";
                                    vPage = dImpl.splitPage(Sql_class,request,100);
                                      if (vPage!=null)
                                      {
                                       for(int i=0;i<vPage.size();i++)
                                      {
                                       content = (Hashtable)vPage.get(i);
                                      
                                      // cp_name_conn = content1.get("cp_name").toString();
                                      %>
                                      <option value="<%=content.get("cp_name").toString()%>"><%=content.get("cp_name").toString()%></option>
                                      <%
                                       }
                                       }
                                      %>
                  </select>-->
         </td>
	  </tr>
	    <tr class="line-even">
         <td align='right' width='16%'>接待职务：</td><td align='left'>
         <!--<select name="vde_sort" class=text-line >-->
       <input type='text' name='jd_duty'  value="" class='text-line'>
         </td>
	  </tr>
	<tr class="line-odd">
		<td align="center" height="1" colspan="2">简要说明</td>
	</tr>

	<tr class="line-even">
		<td align="left" height="20" colspan=2> <iframe id="desc" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
		<input type="hidden" name="jd_content" value="">
		  <!--textarea id="vt_desc" name="jd_content" style="display:none"></textarea-->
		</td>
	</tr>
		</tr>
		<tr class="title1" width="100%" id="btnObj" style="display:">
<td colspan='2' algin='center'>
	<input type="button" name="btnSubmit" value="确定" onclick="checkForm()" class="bttn">&nbsp;
<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">

<%}
if(OType.equals("Edit")){
	sqlStr = "select * from tb_onlinesubject where jd_id='"+jd_id+"'";
	  vPage = dImpl.splitPage(sqlStr,1,1);
						if(vPage!=null)
						{
							for(int i=0;i<vPage.size();i++)
							{
								content = (Hashtable)vPage.get(i);
	                            jd_id = content.get("jd_id").toString();
								String jd_subject = content.get("jd_subject").toString();
								String jd_date = content.get("jd_date").toString();
								String jd_finishdate = content.get("jd_finishdate").toString();
								String jd_duty = content.get("jd_duty").toString();
								String jd_address = content.get("jd_address").toString();
								String jd_depart = content.get("jd_depart").toString();
								String jd_content = content.get("jd_content").toString();
							    int n = jd_date.indexOf(" ");
								int m = jd_date.indexOf(":");
								int x = jd_date.lastIndexOf(":");
								int m1 = jd_finishdate.indexOf(":");
								int x1 = jd_finishdate.lastIndexOf(":");
								String jd_datetime = jd_date.substring(0,n);
								String jd_datehour = jd_date.substring(n+1,m);
								String jd_datemin = jd_date.substring(m+1,x);
								String jd_finishdatetime = jd_finishdate.substring(0,n);
								String jd_finishdatehour = jd_finishdate.substring(n+1,m1);
								String jd_finishdatemin = jd_finishdate.substring(m1+1,x1);

%>
<form name="formData" method="post">
 <tr class='line-even'>
<td align='right' width='16%'>接待主题：</td>
<td align='left'><input type='text' name='jd_subject' size='80' value="<%=jd_subject%>" class='text-line'></td>
</tr>
	<tr class="line-odd" >
               <td width="19%" align="right">接待时间：</td>
               <td width="51%" align='left'><input type="text" name="jd_date" class="text-line" value="<%=jd_datetime%>" readonly="true" style="width:86px"onclick="javascript:showCal()" style="cursor:hand"/>
			   <select name="jd_starthours">
<%
			for(int j=0;j<24;j++)
	        {
				if(jd_datehour.equals(j+""))
				{
%>
					<option value="<%=j%>" selected><%=j%></option>
<%
					
				}
				else
				{
%>
					<option value="<%=j%>"><%=j%></option>	
<%
				
				}

			}
%>
			   </select>时
			    <select name="jd_startmin">
			   <%if("00".equals(jd_datemin))
								{
	out.print(" <option value='00'>00</option><option value='30'>30</option>");
								}
								if("30".equals(jd_datemin))
								{
	out.print(" <option value='30'>30</option><option value='00'>00</option>");
								}
	
%>
			  
			 
			   </select>分
                &nbsp;&nbsp;结束时间：<input type="text" name="jd_finishdate" class="text-line" value="<%=jd_finishdatetime%>" readonly="true" style="width:86px"onclick="javascript:showCal()" style="cursor:hand"/>
				 <select name="jd_endhours">
			<%
			for(int j=0;j<24;j++)
	        {
				if(jd_finishdatehour.equals(j+""))
				{
%>
					<option value="<%=j%>" selected><%=j%></option>
<%
					
				}
				else
				{
%>
					<option value="<%=j%>"><%=j%></option>	
<%
				
				}

			}
%>
			   </select>时
			    <select name="jd_endmin">
<%
				 if("00".equals(jd_finishdatemin))
								{
	out.print(" <option value='00'>00</option><option value='30'>30</option>");
								}
								if("30".equals(jd_finishdatemin))
								{
	out.print(" <option value='30'>30</option><option value='00'>00</option>");
								}
	
%>
			   </select>分
               </td>
             </tr>
	<tr class="line-odd">
		<td align='right' width='16%'>接待地点：</td><td align='left'><input type="text" name="jd_address"  value="<%=jd_address%>"  class=text-line ></td>
	  </tr>
	  <tr class="line-odd">
         <td align='right' width='16%'>接待单位：</td>
		 <td align='left'>
        <input type='text' name='jd_depart'  value="<%=jd_depart%>" class='text-line'>
         </td>
	  </tr>
	    <tr class="line-even">
         <td align='right' width='16%'>接待职务：</td><td align='left'>
         <!--<select name="vde_sort" class=text-line >-->
       <input type='text' name='jd_duty'  value="<%=jd_duty%>" class='text-line'>
         </td>
	  </tr>
	<tr class="line-odd">
		<td align="center" height="1" colspan="2">简要说明</td>
	</tr>

<tr class="line-even">
		<td align="left" height="20" colspan=2> <iframe id="desc" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
		  <textarea id="vt_desc" name="jd_content" style="display:none"><%=jd_content%></textarea>
		</td>
	</tr>
		</tr>

<tr class="title1" width="100%" id="btnObj" style="display:">
<td colspan='2' algin='center'> 
	<input type="button" name="btnSubmit" value="修改" onclick="chkTitle('<%=jd_id%>')" class="bttn">&nbsp;
<input type="button" name="btnDel"  value="删除" class="bttn" onclick="deleteThis('<%=jd_id%>')">&nbsp;
<input type="button" name="btnReturn" value="返回" onclick="javascript:window.history.go(-1);" class="bttn">
<%}}}%>


</td></tr>
	<tr width="100%" id="confirmObj" style="display:none">
		<td colspan="2">
			<font color="red">您的请求已提交，正在执行操作，请稍候..</font>
		</td>
	</tr>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<script language="javascript">

// function openImgWindow(){
//		fjTble.style.display="block";
//		imgfas.style.display="none";
//		document.all.value="1";
// }
//  function openImgWindow1(){
//		fjTble.style.display="none";
//		imgfas.style.display="block";
//		document.all.value="0";
// }




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

	var retVal = showModalDialog( "../../../common/calendar/calendar.htm", obDate,
		"dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

	if ( typeof(retVal) != "undefined" ) {
		var year = retVal.getFullYear();
		var month = retVal.getMonth()+1;
		var day = retVal.getDate();
		obj.value =year + "-" + month + "-" + day;
	}
}
function openImgWindow()
{
	  var w = 400;
	  var h = 500;
	  var url = "";
	  url = "ExplainInfoImg.jsp";
	  var vde_img = document.formData.vde_img.value;
	  url = url+"?vde_img="+vde_img+"&vde_pp=a";
	  window.open( url, "upload", "Top=0px,Left=0px,Width="+w+"px, Height="+h+"px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=yes" );
}




//判断必填项
function chkText() {
	if (formData.jd_subject.value == "") {
		alert("请输入接待主题！");
		formData.jd_subject.focus();
		return false;
	}
	if (formData.jd_date.value == "") {
		alert("请输入发布时间！");
		formData.jd_date.focus();
		return false;
	}
	if (formData.jd_finishdate.value == "") {
		alert("请输入结束时间！");
		formData.jd_finishdate.focus();
		return false;
	}
	if (formData.jd_address.value == "") {
		alert("请输入接待地点！");
		formData.jd_address.focus();
		return false;
	}
    if (formData.jd_depart.value == "") {
		alert("请选择接待单位！");
		return false;
	}
 if (formData.jd_duty.value == "") {
		alert("请选择接待职务！");
		return false;
	}
	return true;
}



//内容判断
function chkTitle(jd_id) {
	if (formData.jd_subject.value == "") {
		alert("请输入接待主题！");
		formData.jd_subject.focus();
		return false;
	}
	btnObj.style.display="none";
	confirmObj.style.display="";
	formData.action = "result.jsp?OType=Edit&jd_id="+jd_id;
	GetDatadesc();
	formData.submit();
}

function deleteThis(jd_id)
{
	  if(confirm("确实要删除吗？"))
	  {
			formData.action = "deletesubject.jsp?jd_id="+jd_id;
			formData.submit();
	  }
}
function checkForm()
{
	if (chkText() == false) return false;
	btnObj.style.display="none";
	confirmObj.style.display="";
	formData.action = "result.jsp";
	GetDatadesc();
	formData.submit();
}
function checkFtype(a){
	if (chkText() == false) return false;
	btnObj.style.display="none";
	confirmObj.style.display="";
	formData.action = "state.jsp?state="+a+"&del=0";
	formData.submit();
}

function typechang1(obj1)
{
	if(obj1=="title")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="none";
	}
	if(obj1=="checkbox")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="none";
	}
	if(obj1=="radio")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="none";
	}
	if(obj1=="text")
	{
		document.all.type1.style.display="block";
		document.all.type2.style.display="none";
	}
	if(obj1=="textarea")
	{
		document.all.type1.style.display="none";
		document.all.type2.style.display="block";
	}
}
</script>

<script language="javascript">
function setHtml()
{
  desc.setHTML(formData.jd_content.value);
}
function GetDatadesc()
{
	var re = "/<"+"script.*.script"+">/ig";
	var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
	var reHttp = /(href=\")(http|https|ftp):(\/\/|\\\\)(<%//=WEBSITE_ADDRESS%>)(\/|\\)/ig; //去掉链接地址
	var Html=desc.getHTML();
	Html = Html.replace(re,"");
	Html = Html.replace(re2,"src=\"/");
	Html = Html.replace(reHttp,"href=\"\/");
	formData.jd_content.value=Html;
}
</script>
<script language="javascript" for=window event=onload>
setHtml();
</script>
</table>
  </td>
</tr>
</table>
</form>
</html>

<%@include file="/system/app/skin/bottom.jsp"%>
<%


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
