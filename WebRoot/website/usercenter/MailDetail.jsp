<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/import.jsp"%>
<title>信件查看窗口</title>
<%
String cw_id = ""; //信件id
String sqlStr = "";//用于查询数据库的语句
String ma_content = ""; //消息内容
String strTitle = ""; //页面标题
String cw_title = ""; //标题
String ma_chongfu = ""; //重复回复
String cw_conent = "";
String cw_status = "";
String cp_name = "";
String cp_dtname = "";

cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
cw_status = CTools.dealString(request.getParameter("cw_status")).trim();//cw_status=3已办

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable content = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

if (!cw_id.equals("")) //浏览
{
	strTitle = "查看信件";
	sqlStr = "select c.cw_subject,c.cw_feedback,c.cw_chongfu,c.cw_content,p.cp_name,p.dt_name from tb_connwork c,tb_connproc p where c.cp_id = p.cp_id and c.cw_id='"+cw_id+"'";
	if(!"".equals(cw_status)){
		 sqlStr += " and c.cw_status="+cw_status;
	}else{
		 sqlStr += " and c.cw_status<>3 and c.cw_status<>9";	
	}

	content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		cw_title = CTools.dealNull(content.get("cw_subject"));
		ma_content = CTools.dealNull(content.get("cw_feedback"));
		ma_chongfu = CTools.dealNull(content.get("cw_chongfu"));
		cw_conent = CTools.dealNull(content.get("cw_content"));
		cp_name = CTools.dealNull(content.get("cp_name"));
		cp_dtname = CTools.dealNull(content.get("dt_name"));
		if(ma_content.equals("")){
			ma_content = ma_chongfu;
		}
	}
}

%>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<body topmargin=5>
<table width=98% border=0 align="center" cellpadding=0 cellspacing=0>
  <tr>
  <td bgcolor="#D6E1C1">
<table border=0 width=100% cellspacing=1 cellpadding=0>
<tr>
    <td width=100% height=25 background="/website/images/title.gif"> 
      <div align="center">信件查看窗口</div></td>
</tr>
<tr>
    <td height="35" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="20%" height="35">
					<div align="center">信件标题：</div></td>
          <td height="35">
					<input type="text" name="textfield1" size="45" class="text-line-info" value='<%=cw_title%>'></td>
        </tr>
      </table></td>
</tr>
<tr>
    <td height="35" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="20%" height="35">
					<div align="center">信箱类型：</div></td>
          <td height="35">
					<input type="text" name="textfield2" size="45" class="text-line-info" value='<%=cp_name%><%="－"+cp_dtname%>'></td>
        </tr>
      </table></td>
</tr>
<tr>
  <td height="90" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="20%" height="90"> 
          <div align="center">信件内容：</div></td>
        <td height="90">
			<textarea name="textarea3" cols="45" rows="5" class="text-area-info"><%=cw_conent%></textarea></td>
      </tr>
    </table></td>
</tr>
<tr>
  <td height="100" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="20%" height="100"> 
          <div align="center">回复内容：</div></td>
        <td height="100">
			<textarea name="textarea4" cols="45" rows="8" class="text-area-info"><%=ma_content%></textarea></td>
      </tr>
       <%
       String ismySql = "select * from tb_connsatisfied where cw_id = '"+cw_id+"'";
			  Hashtable iscontent = dImpl.getDataInfo(ismySql);
			  if(iscontent==null){
			  
			  String isopenSql = "select c.cw_status as cws,p.cp_upid as cpu from tb_connwork c,tb_connproc p where c.cw_id = '"+cw_id+"' and c.cp_id = p.cp_id ";
			  String iscw_status = "";
			  String iscp_upid = "";
			  
			  Hashtable isopencontent = dImpl.getDataInfo(isopenSql);
			  if(isopencontent!=null){
			  	 iscw_status = CTools.dealNull(isopencontent.get("cws"));
				 	 iscp_upid = CTools.dealNull(isopencontent.get("cpu"));
			  }
			  if("3".equals(iscw_status)&&("o7".equals(iscp_upid)||"o10000".equals(iscp_upid))){
			  %>
			  <!--咨询信箱反馈信息，前台用户反馈满意度调查-->
			  <form  name="formDate" method="post">
			  <tr> 
                <td height="30" colspan="2">
				  <div align="center">用户满意度调查</div>
                  </td>
                </tr>
              <tr> 
                <td height="30">
				  <div align="center"> 
                  满意度：                  </div></td>
                <td height="30">&nbsp;<input type="radio" class="input-mailBox" name="cs_satis" value="1" />满意&nbsp;<input type="radio" class="input-mailBox" name="cs_satis" value="2"/>基本满意&nbsp;<input type="radio" class="input-mailBox" name="cs_satis" value="3"/>不满意</td>
              </tr>
			  <tr> 
                <td height="30">
				  <div align="center"> 
                  用户意见和建议：                  </div></td>
                <td height="30"><textarea name="cs_message" class="textarea-mailBox" cols="45" rows="8" ></textarea></td>
              </tr>
			  <tr> 
                <td height="30" colspan="2">
<div align="center"> <input type="hidden" name="cw_id" value="<%=cw_id%>"/>
                    <input type="button" name="su" value="提交" class="bttn-info" onClick="tosubmit()">&nbsp;
					<input type="reset" name="re" value="重置" class="bttn-info" >&nbsp;
					<input type="button" name="re" value="关闭" class="bttn-info" onclick="dontsubmit()">
                  </div></td>
              </tr>
			  </form>
			  <script language="javascript">
			  	function dontsubmit(){
			  	if(window.confirm('您确定不需要提交满意度调查？')){
			  		window.close();
			  	}else{
			  		return false;
			  	}
			  }
			  function tosubmit(){
				  form = document.formDate;
				  cflag=false;
					 for(var i=0;i<form.cs_satis.length;i++)
					  { if(form.cs_satis[i].checked==true)  
					   { cflag=true ;} 
					  }
					 if (cflag==false)
					  { alert("请选择满意度!");
					    return false;
					 }
					form.action="../policy/mailSatisResult.jsp";
					form.submit();
					window.close();
			  }
			  </script>
			  <!--咨询信箱反馈信息，前台用户反馈满意度调查-->
			  <%
			}else{
			  %>
			  <tr> 
                <td height="30" colspan="2">
<div align="center"> 
                    <input type="button" name="Submit" value="关闭" class="bttn-info" onClick="javascipt:window.close();">
                  </div></td>
              </tr>
			  <%
			  }
			  }else{
			  %>
			  <tr> 
                <td height="30" colspan="2">
<div align="center"> 
                    <input type="button" name="Submit" value="关闭" class="bttn-info" onClick="javascipt:window.close();">
                  </div></td>
              </tr>
			  <%
			  }
			  %>
    </table></td>
</tr>
<tr>
    <td width=100% height=18 bgcolor="#E3F1D0">
</tr>
</table>
</td>
</tr>
</table>
</center>
<%
}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
</body>
