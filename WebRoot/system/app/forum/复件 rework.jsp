<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="../common/common.js"></script> 
<script type="text/javascript" src="../infopublish/editor/fckeditor.js"></script>
<%
Calendar cal = new GregorianCalendar();
cal.add(GregorianCalendar.DATE,-1);
SimpleDateFormat theDate = new SimpleDateFormat("yyyy-MM-dd");
String ul_time = theDate.format(cal.getTime());

String sort_id="";
String sort_name="";
String us_uid = CTools.dealString(request.getParameter("us_uid")).trim();       //管理人

String board_id = CTools.dealString(request.getParameter("board_id")).trim();       //主题ID
String sortid = CTools.dealString(request.getParameter("sort_id")).trim();      //栏目ID
String board_master_name="";
String new_board_master_name="";
String new_board_master_id="";
String board_create_date = "";   
String board_name ="";				//主题名称
String board_comment ="";			    //主题说明
String board_netmeet_url="";    //本期办公会URL
String board_shi_url="";    //实录URL
String board_xuan_url = "";   //选编URL
String board_publish_flag="";	     //发布状态：0不发布、1发布
String board_hot_flag="";	     //本期主题 1是 其余不是
String	now_board_master_id= CTools.dealString(request.getParameter("board_master_id")).trim();//调出当前用户所属的部门
String	board_master_id="";//调出所有的部门
String master_id=""; //所属部门ID
String master_name =""; //所属部位单位
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
String sqlStr = "select board_name,board_comment,board_netmeet_url,board_shi_url,board_xuan_url,board_publish_flag,board_hot_flag,board_master_id,board_master_name,to_char(board_create_date,'yyyy-MM-dd')as board_create_date from forum_board_pd where board_id="+board_id;
//
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		board_name =CTools.dealNull(content.get("board_name"));				//主题名称
		board_comment =CTools.dealNull(content.get("board_comment"));			    //主题说明
		board_netmeet_url =CTools.dealNull(content.get("board_netmeet_url"));				//本期办公会URL
		board_shi_url =CTools.dealNull(content.get("board_shi_url"));				//实录URL
		board_xuan_url =CTools.dealNull(content.get("board_xuan_url"));			     //选编URL
		board_publish_flag=CTools.dealNull(content.get("board_publish_flag"));	     //发布状态：0不发布、1发布
		board_hot_flag=CTools.dealNull(content.get("board_hot_flag"));	     //本期主题：1是、其余不是
		master_id=CTools.dealNull(content.get("board_master_id")); //所属部门ID
		master_name =CTools.dealNull(content.get("board_master_name")); //所属部位单位
		board_create_date = CTools.dealNull(content.get("board_create_date"));   
		ul_time=board_create_date;
	}
%>
<script language="javascript">
function checkform(board_id){

	if(formData.board_name.value =="")
	{
			alert("请填写主题!");
			formData.board_name.focus();
			return false;
	}
	formData.action = "reworkResult.jsp?board_id="+board_id;
	formData.submit();
}

function deleteThis(board_id,board_hot_flag)
{     
	  if(board_hot_flag=="1"){alert("此主题为本期主题,删除后请更换本期主题");}
	  if(confirm("确实要删除吗？\n将会删除该主题下的所有内容!\n请谨慎操作!"))
	  {
			formData.action = "reworkdel.jsp?board_id="+board_id;
			formData.submit();
	  }
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
修改主题
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
	<form method="post" name="formData" >
	<table cellspacing="0" cellpadding="0" border="0" align="center"
		width="100%">
		<tr>
			<td bgcolor="#e9e9e9" width="100%">
			<table border="0" cellspacing="1" cellpadding="6" align="center"
				width="100%">
				<tr>
					<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">主题名称：</div></td>
					<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
						name="board_name" type="text" value="<%=board_name%>"  size="30" maxlength="200"></td>
				</tr>
				<tr>

					<td height="45" bgcolor="#F7FBFF" nowrap><div align="right">主题说明：</div></td>
					<td height="45" bgcolor="#F7FBFF" align="left"><textarea name="board_comment" cols="45" rows="4" ><%=board_comment%></textarea></td>
				</tr>
				<tr>
					<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">本期网上办公URL：</div></td>
					<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
						name="board_netmeet_url" type="text" value="<%=board_netmeet_url%>" size="30" maxlength="200">&nbsp;&nbsp;<font color=red>*没有请不要填写</font></td>
				</tr>
				<tr>
					<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">实录URL：</div></td>
					<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
						name="board_shi_url" type="text" value="<%=board_shi_url%>" size="30" maxlength="200">&nbsp;&nbsp;<font color=red>*没有请不要填写</font></td>
				</tr>
				<tr>
					<td width="30%" height="35" nowrap bgcolor="#F7FBFF"><div align="right">选编URL：</div></td>
					<td width="70%" height="35" align="left" bgcolor="#F7FBFF"><input
						name="board_xuan_url" type="text" value="<%=board_xuan_url%>" size="30" maxlength="200">&nbsp;&nbsp;<font color=red>*没有请不要填写</font></td>
				</tr>
				
				<%
					if(us_uid.equals("admin"))
	                {
				%>
				<tr>
					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">设为本期主题:</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT
						NAME="board_hot_flag" TYPE="radio" value="1"  <%="1".equals(board_hot_flag)?"checked":""%>>
					是&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="radio" NAME="board_hot_flag"
						value="0" <%="1".equals(board_hot_flag)?"":"checked"%>>否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>*本论坛中最多有一个为本期主题</font></td>
				</tr>
				<%
					}
				%>

				<tr>

					<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">发布状态：</div></td>
					<td height="35" bgcolor="#F7FBFF" align="left"><INPUT NAME="board_publish_flag" TYPE="radio" value="1" <%="1".equals(board_publish_flag)?"checked":""%>>
					发布&nbsp;&nbsp;<INPUT TYPE="radio" NAME="board_publish_flag" value="0" <%="1".equals(board_publish_flag)?"":"checked"%>>不发布</td>
				</tr>
				
				  <% 
				  	 dCn = new CDataCn(); //新建数据库连接对象
			 dImpl = new CDataImpl(dCn); //新建数据接口对象
		
			Vector vPage = null;
				  
				   sqlStr="select dt_name,dt_id from forum_deptmanage_pd where board_id="+board_id;
              vPage = dImpl.splitPage(sqlStr,request,20);
              if(vPage!=null)
              { 
               	for(int j=0;j<vPage.size();j++)
               	{
               		content=(Hashtable)vPage.get(j);
               		new_board_master_name = new_board_master_name+""+content.get("dt_name").toString()+",";
               		new_board_master_id = new_board_master_id+""+content.get("dt_id").toString()+",";
               	}
              }
             

					if(us_uid.equals("admin"))
	                {
				%>
				
				<td height="35" bgcolor="#F7FBFF" nowrap><div align="right">所属部门:</div></td>
				  <td height="35" bgcolor="#F7FBFF" align="left">
				  <textarea name="dept_name" cols="25" rows="4" readonly><%=new_board_master_name%></textarea>
				  <input type="hidden" name="dept_id" value="<%=new_board_master_id%>">
	  		<select class="select-a" name="board_master_id" onchange="dt(this)">
					<option value="" >请选择受理单位</option>
							
			<%
		
			sqlStr = "select * from tb_deptinfo order by dt_id";
			vPage = dImpl.splitPage(sqlStr,request,100);
			if (vPage!=null)
			{
					for(int i=0;i<vPage.size();i++)
					{
							content = (Hashtable)vPage.get(i);
							board_master_id = content.get("dt_id").toString();
							board_master_name = content.get("dt_name").toString();
							%>
							<option  value="<%=board_master_id%>" name="<%=board_master_name%>" > <%=board_master_name%>                
							</option>

							<%
					}
			}
			
			%>
			</select>&nbsp;<input type="button" name="clear" value="清空"  onclick="clearValue();"/>			</td>
			  </tr>
			  	<tr>
				  <td height="35" bgcolor="#F7FBFF" nowrap><div align="right">更换此主题的栏目:</div></td>
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
							<option value="<%=sort_id%>" <%=sort_id.equals(sortid) ? "selected" : ""%>><%=sort_name%>                
							</option>
							<%
					}
			}
			
			%>
			</select>&nbsp; </td>
			  </tr>

				<% }else{
				%>
				<input type="hidden" name="board_master_id" value="<%=now_board_master_id%>">
				<input type="hidden" name="sort_id" value="<%=sortid%>">
				<%}
				%>

				<tr>
					<td valign="top" bgcolor="#F7FBFF"><div align="right">创建时间：</div></td>
					<td bgcolor="#F7FBFF" align="left">
<input name="board_create_date" style="cursor:hand" class="text-line" readonly size="10" onclick="showCal()" value="<%=ul_time%>">
		</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr class="outset-table">
			<td >
	<div id="subdiv" style="display:none" >正在提交数据...</div>
		<input type="button" name="topicsubmit" value="修改" onClick="javascript:checkform('<%=board_id%>');"/>

		&nbsp; <input type="button" name="Del" value="删除"  <%=us_uid.equals("admin") ? "" : "disabled"%> onClick="deleteThis('<%=board_id%>','<%=board_hot_flag%>')"/>
		&nbsp; <input type="button" name="previewpost" value="返回" onClick="window.history.back();" />
		<% if(!us_uid.equals("admin"))
				{
		%>                                      
					<input type="hidden" name="board_master_id" value="<%=board_master_id%>"> 
					<input type="hidden" name="sort_id" value="<%=sort_id%>"> 
		<%	}
		%>
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
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
