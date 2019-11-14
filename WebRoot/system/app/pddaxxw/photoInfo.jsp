<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String op_ischeck="";
String op_imgpath = "";
String op_imgrealname = "";
String op_tel = "";
String op_date = "";
String op_type = "";
String op_imgname = "";
String op_id = "";
String op_name = "";
String op_email = "";
String op_descript = "";
String op_address = "";
String path = "";
String imgpath = "";
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

path = dImpl.getInitParameter("workattach_http_path");//档案局征集图片放置路径
op_id = CTools.dealString(request.getParameter("op_id")).trim();

String sql_Info = " select d.op_id,d.op_name,d.op_tel,d.op_email,d.op_address,d.op_imgname,d.op_imgpath,to_char(d.op_date,'yyyy-MM-dd hh24:mi:ss') as op_date,d.op_imgrealname,d.op_ischeck,d.op_descript from tb_daxxphoto d where d.op_id="+op_id+"";

	Hashtable content = dImpl.getDataInfo(sql_Info);
	if(content!=null)
	{
			op_id = CTools.dealNull(content.get("op_id"));
			op_name = CTools.dealNull(content.get("op_name"));
			op_imgpath = CTools.dealNull(content.get("op_imgpath"));
			op_imgname = CTools.dealNull(content.get("op_imgname"));
			op_imgrealname = CTools.dealNull(content.get("op_imgrealname"));
			op_email = CTools.dealNull(content.get("op_email"));
			op_address = CTools.dealNull(content.get("op_address"));
			op_tel = CTools.dealNull(content.get("op_tel"));
			op_date = CTools.dealNull(content.get("op_date"));
			op_ischeck = CTools.dealNull(content.get("op_ischeck"));
			op_descript = CTools.dealNull(content.get("op_descript"));
			
			imgpath = path+op_imgpath+"/"+op_imgname;
	}
			
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
向您征集图片详细
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table  border="0" width="100%" cellpadding="0" cellspacing="1" class="content-table">
<form name="formData" action="photoCheckResult.jsp" method="post">	
<tr class="line-even" height="20">
  <td width="37%" align="right" valign="middle">征集人姓名：</td>
  <td colspan="3" align="left" valign="middle">
  	<%=op_name%></td>
  </tr>
<tr class="line-odd" height="20">
  <td align="right" valign="middle">联系电话：</td>
  <td colspan="3" align="left" valign="middle"><%=op_tel%></td>
  </tr>
<tr class="line-even" height="20">
  <td  align="right" valign="middle">电子邮箱：</td>
  <td colspan="3" align="left" valign="middle"><%=op_email%></td>
  </tr>
<tr class="line-odd" height="20">
  <td align="right" valign="middle">信件内容：</td>
  <td  colspan="3" align="left" valign="middle"><%=op_descript%></td>
</tr>
<tr class="line-odd" height="20">
  <td align="right" valign="middle">家庭地址：</td>
  <td  colspan="3" align="left" valign="middle"><%=op_address%></td>
</tr>
<tr class="line-even" height="20">
  <td  align="right" valign="middle">提交时间：</td>
  <td colspan="3" align="left" valign="middle"><%=op_date%></td>
</tr>
<tr class="line-odd" height="20">
  <td align="right" valign="middle">审核状态：</td>
  <td colspan="3" align="left" valign="middle"><%="0".equals(op_ischeck)?"审核通过":"未审核"%></td>
</tr>

<!--附件-->
<tr class="line-odd">
  <td align="right" valign="middle">附件：</td>
  <td colspan="3" align="left" valign="top">
  	<%if(!"".equals(op_imgrealname)){%>
	<%=op_imgrealname%>&nbsp;&nbsp;
	<A HREF="photoDownload.jsp?op_id=<%=op_id%>" target="downFrm" title="下载该文件"><img class="hand" border="0" src="/website/images/pub.gif" title="下载" WIDTH="16" HEIGHT="16"></A></br>
	<%}else out.print("暂无附件");%></td>
</tr>
<!--附件-->

<tr class="outset-table">
<td colspan="4" align="center" valign="middle"><input type="hidden" name="opids" value="<%=op_id%>"/>
<input type="hidden" name="opischeck" value="0"/>
<%if(!"0".equals(op_ischeck)){%>
<input type="submit" name = "sub1" value="&nbsp;审核&nbsp;"/>
<%}%>
&nbsp;&nbsp;&nbsp;<input type="button" name = "sub2" value="&nbsp;删除&nbsp;" onclick="javascript:window.location.href='photoDel.jsp?op_id=<%=op_id%>';"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name = "sub2" value="&nbsp;返回&nbsp;" onclick="javascript:window.history.go(-1);"/></td>
</tr>
</form>
</table>
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
                                     
