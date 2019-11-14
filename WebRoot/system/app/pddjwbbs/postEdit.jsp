<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../common/common.js"></script>
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<%
Calendar cal = new GregorianCalendar();
cal.add(GregorianCalendar.DATE,-1);
SimpleDateFormat theDate = new SimpleDateFormat("yyyy-MM-dd");

String ul_time = theDate.format(cal.getTime());
String us_uid = "";
String sqlStr="";
String board_name ="";				//主题名称
String board_comment ="";		    //主题说明
String board_publish_flag="";       //发布状态：0不发布、1发布
String board_create_date="";		//栏目创建日期
String us_id = CTools.dealString(request.getParameter("us_id")).trim();					//管理人ID
us_uid = CTools.dealString(request.getParameter("us_uid")).trim();					//管理人
String type_post=CTools.dealString(request.getParameter("type_post")).trim();				 //类型为新建
String sort_id ="";	                //所属分类ID
String sort_name="";             //所属分类名称
String now_board_master_id="";//当前所属部门ID
String board_master_id="";//所属部门ID
String board_master_name ="";//所属部位单位
String board_hot_flag="";//是否为本期主题 1是,其余都不是
Vector vPage=null;
Hashtable content = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;

CDataCn cdCn = null;//原来的数据库连接
CDataImpl cdImpl = null;//原来的数据库连接
try{
cdCn = new CDataCn();//原来的数据库连接
cdImpl = new CDataImpl(cdCn);//原来的数据库连接

dCn = new CDataCn("pddjw");//党建网数据库连接
dImpl = new CDataImpl(dCn);

sqlStr = "select dt_id from tb_userinfo where ui_id="+us_id;
vPage = cdImpl.splitPage(sqlStr,request,10);
	if (vPage!=null)
	{
		for(int i=0;i<vPage.size();i++)
		{
		 content = (Hashtable)vPage.get(i);
		 now_board_master_id = content.get("dt_id").toString();							
		}
	}
%>
<script language="javascript">
function checkform()
{  
	if(formData.board_name.value =="")
	{
		alert("请填写主题!");
		formData.board_name.focus();
		return false;
	}
	formData.submit();
}
function dt(obj)
{	
if(obj.selectedIndex == 0) { return false; }
formData.dept_name.value=formData.dept_name.value+""+obj.options[obj.selectedIndex].name+",";
formData.dept_id.value=formData.dept_id.value+""+obj.options[obj.selectedIndex].value+",";
obj.selectedIndex=0;
formData.topicsubmit.focus();
  return true;
}
function clearValue()
{
	formData.dept_name.value="";
	formData.dept_id.value="";
}
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
        var retVal = showModalDialog( "/system/common/calendar/calendar.htm", obDate,
                "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

        if ( typeof(retVal) != "undefined" ) {
                var year = retVal.getFullYear();
                var month = retVal.getMonth()+1;
                var day = retVal.getDate();
                obj.value =year + "-" + month + "-" + day;
        }
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<strong>新建主题</strong>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<form method="post" name="formData" action="postResult.jsp">
<table width="100%" cellspacing="0" cellpadding="0" align="center">
<input type="hidden" name="type_post" value="<%=type_post%>">
			<tr>
				<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">主题名称：</div></td>
				<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
					name="board_name" type="text" value="" size="30" maxlength="200"></td>
			</tr>
			<tr>
				<td height="45" bgcolor="#F7FBFF" nowrap><div align="right">主题说明：</div></td>
				<td height="45" bgcolor="#F7FBFF" align="left"><textarea
					name="board_comment" cols="45" rows="4"></textarea></td>
			</tr>
			<tr>
				<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">本期网上办公URL：</div></td>
				<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
					name="board_netmeet_url" type="text" value="" size="30" maxlength="200">&nbsp;&nbsp;<font color=red>*没有请不要填写</font></td>
			</tr>
			<tr>
				<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">实录URL：</div></td>
				<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
					name="board_shi_url" type="text" value="" size="30" maxlength="200">&nbsp;&nbsp;<font color=red>*没有请不要填写</font></td>
			</tr>
			<tr>
				<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">选编URL：</div></td>
				<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
					name="board_xuan_url" type="text" value="" size="30" maxlength="200">&nbsp;&nbsp;<font color=red>*没有请不要填写</font></td>
			</tr>
			<%
				if(us_uid.equals("djwbbs_01"))
         {
			%>
			<tr>
				<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">本期主题:</div></td>
				<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
					NAME="board_hot_flag" TYPE="radio" value="1" >
				是&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="radio" NAME="board_hot_flag"
					value="0" checked>否 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>*本论坛中最多有一个为本期主题</font></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">发布状态：</div></td>
				<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
					NAME="board_publish_flag" TYPE="radio" value="1" checked >
				发布&nbsp;&nbsp;<INPUT TYPE="radio" NAME="board_publish_flag"
					value="0">不发布</td>
			</tr>
			<%
				if(us_uid.equals("djwbbs_01"))
				{
			%>
			
			<tr>
			  <td height="35" bgcolor="#F7FBFF" nowrap><div align="right">所属部门:</div></td>
			  <td height="35" bgcolor="#F7FBFF" align="left">
			  <textarea name="dept_name" cols="25" rows="4" readonly></textarea>
			  <input type="hidden" name="dept_id" value="">
  			<select class="select-a" name="board_master_id" onchange="dt(this)">
				<option value="" >请选择受理单位</option>
		<%
		vPage = null;
		sqlStr = "select dt_id,dt_name from tb_deptinfo order by dt_id";
		vPage = cdImpl.splitPage(sqlStr,request,250);
		if (vPage!=null)
		{
				for(int i=0;i<vPage.size();i++)
				{
						content = (Hashtable)vPage.get(i);
						board_master_id = content.get("dt_id").toString();
						board_master_name = content.get("dt_name").toString();//System.out.print(board_master_id+board_master_name+"==");
						%>
						<option  value="<%=board_master_id%>" name="<%=board_master_name%>" > <%=board_master_name%>                
						</option>
						<% 
				}
		}
		%>
		</select>&nbsp; <input type="button" name="clear" value="清空"  onclick="clearValue();"/>	</td>
		  </tr>

		  <% }else{
		  %>
		  	<input type="hidden" name="board_master_id" value="<%=now_board_master_id%>">
		  <%}
		  %>	

			<tr>
			  <td height="35" bgcolor="#F7FBFF" nowrap><div align="right">选择主题的栏目:</div></td>
			  <td height="35" bgcolor="#F7FBFF" align="left">
  			<select class="select-a" name="sort_id" >   
		<%
		Vector Page = null;
		String sql = "select sort_id,sort_name from forum_sort order by sort_id";
		Page = dImpl.splitPage(sql,request,100);
		if (Page!=null)
		{
		
			for(int i=0;i<Page.size();i++)
			{
				content = (Hashtable)Page.get(i);
				sort_id = content.get("sort_id").toString();
				sort_name = content.get("sort_name").toString();
				%>
				<option value="<%=sort_id%>" ><%=sort_name%>                
				</option>
				<%
			}
		}
		%>
		</select>&nbsp; </td>
		  </tr>
			<tr>
				<td valign="top" bgcolor="#F7FBFF"><div align="right">创建时间：</div>
				</td>
				<td bgcolor="#F7FBFF" align="left">
					<input name="board_create_date" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
				</td>
			</tr>
			<tr>
				<td class=outset-table colspan='2'>
					<div id="subdiv" style="display:none" align='center'>正在提交数据...</div>
					<input type="button" name="topicsubmit" value="提交" onClick="checkform();"/>
					&nbsp; <input type="reset" name="previewpost" value="重写" />
					&nbsp; <input type="button" name="previewpost" value="返回" onClick="window.history.back();" />
				</td>
			</tr>
     </table>
</form>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	cdImpl.closeStmt();
	cdCn.closeCn();
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
