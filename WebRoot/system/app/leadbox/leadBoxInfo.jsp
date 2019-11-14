<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/common/parameter.jsp"%>
<%
CMySelf self = (CMySelf)session.getAttribute("mySelf");
String dt_id="";
String uiid="";
if(self!=null && self.isLogin())
{
	dt_id = String.valueOf(self.getDtId());
	uiid = Long.toString(self.getMyID());
}
String OPType = CTools.dealString(request.getParameter("OPType")).trim();//操作方式 Add是添加 Edit是修改
if(OPType.equals(""))
{
	OPType = "Add";
}
CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String in_title = "";
String in_sequence = "100";
String in_content = "";
String in_description = "";
String in_id = CTools.dealString(request.getParameter("in_id")).trim();//编号
String ti_id = "";
String in_img_path="";//图片路径
String [] files = null;
String sql_admin = "select * from tb_roleinfo r,tb_functionrole f where tr_userids like '%," + uiid + ",%' and r.tr_id = f.tr_id and f.ft_id = (select ft_id from tb_function where ft_code='ISADMIN')";
Hashtable content_admin = dImpl.getDataInfo(sql_admin);

if(!in_id.equals(""))
{
	String sql_in = "select in_title,in_sequence,in_content,in_description,ti_id,in_img_path from tb_info where in_id=" + in_id;
	Hashtable content_in = dImpl.getDataInfo(sql_in);
	if(content_in!=null)
	{
		in_title = content_in.get("in_title").toString();
		in_sequence = content_in.get("in_sequence").toString();
		in_content = content_in.get("in_content").toString();
		in_description = content_in.get("in_description").toString();
		ti_id = content_in.get("ti_id").toString();		
		in_img_path=content_in.get("in_img_path").toString();
	}
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
信息发布
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script LANGUAGE="javascript">
function checkform(rd)
{
	var form = document.formData ;
	if(form.ti_id.value =="oo")
	{
		alert("请选择所属栏目!");
		form.ti_id.focus();
		return false;
	}
    if(form.in_title.value =="")
	{
		alert("请填写领导姓名!");
		form.in_title.focus();
		return false;
	}
    if(form.in_description.value =="")
    {
		alert("请填写领导分工!");
		form.in_description.focus();
		return false;
	}	
	GetDatademo();

	btnObj.style.display="none";
	confirmObj.style.display="";
	form.target = "_self";
	if(rd==1)
	{
		document.all.is_img.value = "1";
	}
	form.submit();
	

}
function deleteFile(in_img_path,in_id,fileName)
{
	if(confirm("确认要删除该文件吗？"))
	{
		var url = "leadImgDel.jsp?in_img_path="+in_img_path+"&in_id="+in_id+"&fileName="+fileName+"&OPType=<%=OPType%>";
		window.location = url;
	}
}
</script>
<!-- 主体开始  -->

<script LANGUAGE="javascript">
function onChange()
{
}
function setHtml()
{
  demo.setHTML (formData.in_content.value);
}
function fnReset()
{
  demo.setHTML ("");

}
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
<script language="javascript" for=window event=onload> 
  setHtml();
</script>
 <table class="main-table" width="100%">
<form name="formData" method="post" action="leadBoxResult.jsp" enctype="multipart/form-data">
 <tr class="title1" align=center>
      <td>信息发布</td>
    </tr>
 <tr>
     <td width="100%">
		<table width="100%" class="content-table" height="1">
		<%
			if(content_admin!=null)
			{
		%>
			<tr class="line-even">
				<td width="19%" align="right">所属街道：</td>
				<td width="81%" align="left">                              
					<select name="ti_id" class=select-a>
						<option value="oo" selected>请选择</option>
						<%
						String lead_ti_id = "";
						String lead_ti_name = "";
						String sql_leadtown = "select ti_id,ti_name from tb_title where ti_upperid = (select ti_id from tb_title where ti_code = 'pudong_jz')";
						Vector vPage = dImpl.splitPage(sql_leadtown,request,100);
						if (vPage!=null)
						{
							for(int i=0;i<vPage.size();i++)
							{
							Hashtable content = (Hashtable)vPage.get(i);
							lead_ti_id = content.get("ti_id").toString();
							lead_ti_name = content.get("ti_name").toString();
							%>
							<option value="<%=lead_ti_id%>" <%if(lead_ti_id.equals(ti_id)) {out.print("selected");}%>><%=lead_ti_name%></option>
							<%
							}
						}
						%>
					 </select>                                
				</td>
			</tr>
		<%
			}else{
				String sql_dtid = "select ti_id from tb_title where ti_upperid = (select ti_id from tb_title where ti_code = 'pudong_jz') and ti_ownerdtid = "+dt_id;
				Hashtable content_dtid = dImpl.getDataInfo(sql_dtid);
				ti_id = content_dtid.get("ti_id").toString();
		%>
		<input type="hidden" name="ti_id" value="<%=ti_id%>">
		<%
			}
		%>
			<tr class="line-even" >
					<td width="19%" align="right">领导姓名：</td>
					<td width="81%" align="left"><input type="text" class="text-line" size="45" name="in_title" maxlength="150"  value="<%=in_title%>" >（注：填写时请同时填写领导职务，如“主任某某”）
					</td>
			</tr>
			<tr class="line-odd">
				<td width="19%" align="right" >领导分工：</td>
				<td width="81%" align="left"><input type="text" class="text-line" size="60" name="in_description" value="<%=in_description%>">
				</td>
			</tr>						
			<tr class="line-even">
				<td width="19%"  align="right">排序字段：</td>
				<td width="81%" align="left">
					<input name="in_sequence" size="4" value="<%=in_sequence%>" class="text-line">
				</td>
			</tr>
			
			<tr class="line-odd">
				<td align="center" height="1" colspan="2">☆☆☆★★★领导简历★★★☆☆☆</td>
			</tr>
			<tr class="line-odd">
				<td height="1" colspan="2"> </td>
			</tr>
			<tr class="line-even">
				<td align="left" height="20" colspan=2> <iframe id="demo" style="HEIGHT: 400px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
				  <textarea id="in_content" name="in_content" style="display:none"><%=in_content%></textarea>
				  <script LANGUAGE="javascript">
				<!--
				function GetDatademo()
				{
					var re = "/<"+"script.*.script"+">/ig";
					var re2 = /(src=\")(http|https|ftp):(\/\/|\\\\)(.[^\/|\\]*)(\/|\\)/ig;
					var reHttp = /(href=\")(http|https|ftp):(\/\/|\\\\)(<%=WEBSITE_ADDRESS%>)(\/|\\)/ig; //去掉链接地址
					var Html=demo.getHTML();
					Html = Html.replace(re,"");
					Html = Html.replace(re2,"src=\"/");
					Html = Html.replace(reHttp,"href=\"\/");
					formData.in_content.value=Html;
				}
				-->
				</script>
				</td>
			</tr>
			<input type="hidden" name="in_img_path" value="<%=in_img_path%>">
			<input type="hidden" name="in_id" value="<%=in_id%>">
			<%
			if (!in_img_path.equals(""))
			{
				
				String path = dImpl.getInitParameter("images_save_realpath");
				int imgflag = 1;
				File impfile = new File(path + in_img_path);
				files = impfile.list();
			}
			
			if(files==null||files.length==0)
			{
			%>
			<tr class="line-even">
				<td class="row" id="TdInfo1" align="right">上传领导照片<font color="red">(尺寸请缩小至66*94像素，大小不超过2M,附件名称请不要有空格)</font>：</td>
				<td>
					<div id='div1'><input type='file' name='fj1' size=30 class='text-line' id='fj1' ></div>
					
				</td>
			</tr>
			<%
			} 
			else
			{
			%>
				<tr class="line-even"><td align="right">图片名称：
					<td><%=files[0]%><img SRC="../../images/dialog/delete.gif" style="cursor:hand" onclick="javascript:deleteFile('<%=in_img_path%>','<%=in_id%>','<%=files[0]%>');" title='删除该文件'style="cursor:hand">
					<%
			}
			%>			
			</td>
			</tr>
		</table>
     </td>
   </tr>

   <tr align="center" id="confirmObj" style="display:none">
   		<td colspan="2">
   			<font color="red">您的请求已经提交，操作正在进行，请稍候。</font>
   		</td>
   </tr>
   <tr class="outset-table" align="center" id="btnObj" style="display:">
    <td colspan="2">
		<input type="button" class="bttn" name="fsubmit1" value="保存附件并返回当前页面" onclick="javascript:checkform(1)">&nbsp;
		<input type="button" class="bttn" name="fsubmit" value="保存并返回列表" onclick="javascript:checkform(0)">&nbsp;
		<input type="reset" class="bttn" name="reset" value="重 写" onclick="fnReset()">&nbsp;
		<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">

		<INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
		<INPUT TYPE="hidden" name="in_id" value="<%=in_id%>">
		<INPUT TYPE="hidden" name="is_img" value="0">
   </td>
  </tr>
</form>
</table>
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
                                     
