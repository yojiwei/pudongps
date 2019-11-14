<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/IsLogin.jsp"%>
<%@include file="/website/include/import.jsp"%>
<title>消息窗口</title>
<script type="text/javascript">
	function closeonload(){
	var browser=navigator.appName 
	var b_version=navigator.appVersion 
	var version=b_version.split(";"); 
	var trim_Version=version[1].replace(/[ ]/g,""); 
	if(browser=="Microsoft Internet Explorer" && trim_Version>="MSIE6.0") 
	{
	  if(confirm("请提交您的满意度调查！"))  
	  {
	  	return true;
	  }else{
	  	return false;
	  }
	}  
}
</script>
<body>
<%
String OPType = ""; //操作类型，目前只有Read一个值
String wo_id = ""; //项目id，只有发送消息的时候才传入的参数
String ma_id = ""; //消息id ，浏览消息的时候传入的消息
String sqlStr = "";//用于查询数据库的语句
String ma_content = ""; //消息内容
String strTitle = ""; //页面标题
String ma_title = ""; //消息标题
String receiverName = "";
String receiverId = "";
String ma_primaryid = "";

OPType = CTools.dealString(request.getParameter("OPType")).trim();
wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
ma_id = CTools.dealString(request.getParameter("ma_id")).trim();

//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

if (OPType.equals("Read"))  //是用户阅读消息,置标志位为已阅读
{
    //更新为已读
    dCn.beginTrans();   
    dImpl.edit("tb_message","ma_id",ma_id);
    dImpl.setValue("ma_isnew","0",CDataImpl.STRING);
    dImpl.update();
    dCn.commitTrans();

}
if (!wo_id.equals("")) //发送消息
{
	sqlStr = "select wo_applypeople,us_id from tb_work where wo_id='"+wo_id+"'";

	strTitle = "给申请人发消息";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		receiverId = content.get("us_id").toString();
		receiverName = content.get("wo_applypeople").toString();
	}
}
else if (!ma_id.equals("")) //浏览消息
{
	strTitle = "查看消息";
	sqlStr = "select ma_receiverid,ma_receivername,ma_title,ma_content,ma_primaryid from tb_message where ma_id='"+ma_id+"'";

	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		receiverId = content.get("ma_receiverid").toString();
		receiverName = content.get("ma_receivername").toString();
		ma_title = content.get("ma_title").toString();
		//update by yo 20110620
		ma_title = ma_title.replaceAll("待补件","有反馈信息，请点击查看");
		//
		ma_content = content.get("ma_content").toString();
		ma_primaryid = CTools.dealNull(content.get("ma_primaryid"));
	}
}


%>

<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<table width=98% border=0 align="center" cellpadding=0 cellspacing=0>
  <tr>
  <td bgcolor="#D6E1C1">
<table border=0 width=100% cellspacing=1 cellpadding=0>
<tr>
    <td width=100% height=25 background="/website/images/title.gif"> 
      <div align="center">消息窗口</div></td>
</tr>
<tr>
          <td height="35" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="20%" height="35">
<div align="center">消息标题：</div></td>
                <td height="35">
<input type="text" name="textfield2" size="45" class="text-line-info" value='<%=ma_title%>'></td>
              </tr>
            </table></td>
</tr>
<tr>
          <td height="100" bgcolor="#F6F9EE"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="20%" height="100"> 
                  <div align="center">消息内容：</div></td>
                <td height="100">
<textarea name="textarea2" cols="45" rows="8" class="text-area-info"><%=ma_content%></textarea></td>
              </tr>
			  <%
			  //
			  String ismySql = "select * from tb_connsatisfied where cw_id = '"+ma_primaryid+"'";
			  Hashtable iscontent = dImpl.getDataInfo(ismySql);
			  if(iscontent==null){
			  
			  String isopenSql = "select c.cw_status as cws,p.cp_upid as cpu from tb_connwork c,tb_connproc p where c.cw_id = '"+ma_primaryid+"' and c.cp_id = p.cp_id ";
			  String cw_status = "";
			  String cp_upid = "";
			  
			  Hashtable isopencontent = dImpl.getDataInfo(isopenSql);
			  if(isopencontent!=null){
			  	 cw_status = CTools.dealNull(isopencontent.get("cws"));
				 	 cp_upid = CTools.dealNull(isopencontent.get("cpu"));
			  }
			  if("3".equals(cw_status)&&("o7".equals(cp_upid)||"o10000".equals(cp_upid))){
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
                <td height="30">&nbsp;<input type="radio" class="input-mailBox" name="cs_satis" value="1"/>满意&nbsp;<input type="radio" class="input-mailBox" name="cs_satis" value="2"/>基本满意&nbsp;<input type="radio" class="input-mailBox" name="cs_satis" value="3"/>不满意</td>
              </tr>
			  <tr> 
                <td height="30">
				  <div align="center"> 
                  用户意见和建议：                  </div></td>
                <td height="30"><textarea name="cs_message" class="textarea-mailBox" cols="45" rows="8" ></textarea></td>
              </tr>
			  <tr> 
                <td height="30" colspan="2">
<div align="center"> <input type="hidden" name="cw_id" value="<%=ma_primaryid%>"/>
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
    <td width=100% height=18 bgcolor="#E3F1D0">&nbsp;</td>
</tr>
</table>
</td>
</tr>
</table>
<%
}

catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>
</body>

