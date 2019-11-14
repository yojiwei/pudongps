<%@page contentType="text/html; charset=GBK"%>
<%@ page import="java.sql.ResultSet" %>
<%@include file="../../manage/head.jsp"%>


<%
  String cc_us_ip = ""; //评论人ip地址
  String cc_us_name = ""; //评论人姓名
  String cc_create_time = ""; //评论时间
  String cc_content = ""; //评论内容
  String cc_answer_time = ""; //答复时间
  String cc_answer = ""; //答复内容
  String cc_publish_flag = "0"; //是否发布标记
  String cc_us_address = "" ;//评论人联系地址
  Hashtable content = null;

  String ccId = CTools.dealString(request.getParameter("cc_id"));
  String ctId = CTools.dealString(request.getParameter("ct_id"));
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  
  String cc_sql = "select * from tb_contentcomment where cc_id = '"+ ccId +"'";
  content = dImpl.getDataInfo(cc_sql);
  if (content != null)
  {
    cc_us_ip = content.get("cc_us_ip").toString();
    cc_us_name = content.get("cc_us_name").toString();
    cc_us_address = content.get("cc_us_address").toString();
    cc_create_time = content.get("cc_create_time").toString();
    cc_content = content.get("cc_content").toString();
    cc_answer_time = content.get("cc_answer_time").toString();
    cc_answer = content.get("cc_answer").toString();
    cc_publish_flag = content.get("cc_publish_flag").toString();
  }
  String sql_att = "select cm_id,cm_name from tb_commentattach where cc_id='"+ccId+"'";
  Vector page_att = dImpl.splitPage(sql_att,10,1);
%>
<head>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="pragma" content="no-cache">
<title>上海浦东门户网站后台管理系统</title>
<style type="text/css">
<!--
@import url("/system/app/skin/skin3/images/main.css");
-->
</style>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<link href="../style.css" rel="stylesheet" type="text/css">

<script language=javascript>
function checkFrm()
{
	var formdd = document.formData;
	/*if (formdd.ccAnswer.value == "")
	{
		alert ("不能发送空的答复内容");
		formdd.ccAnswer.focus();
		return false;
	}*/
	if (formdd.ccAnswer.value != "") {
		if (formdd.ccAnswer.value.length > 500) {
			alert("答复内容包含" + formdd.ccAnswer.value.length + "个汉字或字母，请修改至500个以内！");
			formdd.focus();
			return false;
		}
	}
	wait();
	formdd.submit();
}

function wait(){
  try{
    document.all.function_buttons.innerHTML = "<p align='center'><b>系统正在处理中，请稍侯...</b></p>";  
  }catch(e){
  
  }
}
</script>
<head>

<body  style="overflow-x:hidden;overflow-y:auto">
  <form name="formData" action="commentResultZB.jsp" method="post">
  <table class="main-table" width="100%">
     <tr class="title1" align=center>
        <td>评论信息</td>
     </tr>
     <tr>
       <td width="100%">
         <table width="100%"  height="1">
           <tr class="line-even" >
             <td width="19%" align="right">评论人IP：</td>
             <td width="81%" ><input type="text" name="ccUsIp"  class="text-line" size="40" value="<%=cc_us_ip%>" readonly>
             </td>
           </tr>
           <tr class="line-even" >
             <td width="19%" align="right">评论人姓名：</td>
             <td width="81%" ><input type="text" name="ccUsName"  class="text-line" size="40" value="<%=cc_us_name%>" readonly>
             </td>
           </tr>
		     <tr class="line-even" >
             <td width="19%" align="right">评论人联系方式：</td>
             <td width="81%" ><input type="text" name="ccUsAddress"  class="text-line" size="40" value="<%=cc_us_address%>" readonly>
             </td>
           </tr>
           <tr class="line-even" >
             <td width="19%" align="right">评论时间：</td>
             <td width="81%" ><input type="text" name="ccCreateTime"  class="text-line" size="40" value="<%=cc_create_time%>" readonly>
             </td>
           </tr>
           <tr class="line-even" >
             <td width="19%" align="right">答复时间：</td>
             <td width="81%" ><input type="text" name="ccAnswerTime" class="text-line" size="40" value="<%=cc_answer_time%>" readonly>
             </td>
           </tr>
           <tr class="line-even" >
             <td width="19%" align="right">评论内容：</td>
             <td width="81%" align='left'><textarea name="ccContent" style="width:500px" rows="6" readonly><%=cc_content%></textarea>
             </td>
           </tr>
           <tr class="line-even" >
             <td width="19%" align="right">答复内容：</td>
             <td width="81%" align='left'><textarea name="ccAnswer" style="width:500px" rows="6"><%=cc_answer%></textarea><br><font color="#FF0000">* 注：答复的内容请不要超过500个汉字</font>
             </td>
           </tr>
		   <%
			if(page_att!=null)
			{
					for(int i=0;i<page_att.size();i++)
					{
					Hashtable content_att = (Hashtable)page_att.get(i);
					String cm_id = content_att.get("cm_id").toString();
					String file_name = content_att.get("cm_name").toString();
					if(i % 2 == 0)  out.print("<tr class=\"line-even\">");
		            else out.print("<tr class=\"line-odd\">");
				  %>
                    <td align="right" width="19%">附件名称：</td>
                    <td width="81%" align='left'><a href="\website\include\downloadComm.jsp?cm_id=<%=cm_id%>" target="_blank"><%=file_name%></a></td>
                   </tr>
				  <%
					}
			}	  
			%>
           <tr class="line-even" >
             <td width="19%" align="right">是否前台显示：</td>
             <td width="81%" align='left'>　是 <input type="radio" name="ccPublishFlag" class="text-line" value="1" <%if (cc_publish_flag.equals("1")) out.println("checked");%> title="选择后，该评论及答复内容会在前台显示！">　否 <input type="radio" name="ccPublishFlag" class="text-line" value="0" <%if (!"1".equals(cc_publish_flag)) out.println("checked");%> title="选择后，该评论及答复内容在前台不显示！">
             </td>
           </tr>
           <input type="hidden" name="cc_id" value="<%=ccId%>">
           <input type="hidden" name="ct_id" value="<%=ctId%>">
           <tr class="line-even">
              <td align="center" height="20" colspan=2 id="function_buttons">
              <input type="button" name="submit01" class="bttn" onclick="checkFrm()" <%if ("".equals(cc_answer_time)) {out.println("value='提交'");} else {out.println("value='修改'");}%>>
              <input type="button" name="del01" class="bttn" onclick="doAction();" value="删除">
              <input type="button" name="back01" class="bttn" onclick="history.go(-1);" value="返回">
              </td>
           </tr>
         </table>
       </td>
     </tr>
   </table>
   </form>
 </body>
<%
  dImpl.closeStmt();
  dCn.closeCn();
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
