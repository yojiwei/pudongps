<%@page contentType="text/html; charset=GBK"%>
<title>消息窗口</title>
<%@include file="/system/app/skin/pophead.jsp"%>

<%
String OPType = ""; //操作类型，目前只有Read一个值
String cw_id = ""; //项目id，只有发送消息的时候才传入的参数
String ma_id = ""; //消息id ，浏览消息的时候传入的消息
String sqlStr = "";//用于查询数据库的语句
String ma_content = ""; //消息内容
String strTitle = ""; //页面标题
String ma_title = ""; //消息标题
String receiverName = "";
String receiverId = "";
String cw_status = "";

cw_status = CTools.dealString(request.getParameter("cw_status")).trim();
OPType = CTools.dealString(request.getParameter("OPType")).trim();
cw_id = CTools.dealString(request.getParameter("cw_id")).trim();
ma_id = CTools.dealString(request.getParameter("ma_id")).trim();

//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

if (OPType.equals("Read"))  //是用户阅读消息,置标志位为已阅读
{
	dCn.beginTrans();
	CMessage msg = new CMessage(dImpl,ma_id);
	msg.update(CMessage.msgIsNew,"0");
	msg.update(CMessage.msgReceiveTime,new CDate().getNowTime());
	dCn.commitTrans();
}
if (!cw_id.equals("")) //发送消息
{
	sqlStr = "select cw_applyingname,us_id from tb_connwork where cw_id='"+cw_id+"'";

	strTitle = "给申请人发消息";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		receiverId = content.get("us_id").toString();
		receiverName = content.get("cw_applyingname").toString();
	}
}
else if (!ma_id.equals("")) //浏览消息
{
	strTitle = "查看消息";
	sqlStr = "select ma_receiverid,ma_receivername,ma_title,ma_content from tb_message where ma_id='"+ma_id+"'";
	Hashtable content = dImpl.getDataInfo(sqlStr);
	if (content!=null)
	{
		receiverId = content.get("ma_receiverid").toString();
		receiverName = content.get("ma_receivername").toString();
		ma_title = content.get("ma_title").toString();
		ma_content = content.get("ma_content").toString();
	}
}
dImpl.closeStmt();
dCn.closeCn();
%>
<table class="main-table" width="450" align="center">
<form name="formData" method="post">
	<tr class="title1" width="100%">
		<td align="center" colspan="2"><%=strTitle%></td>
	</tr>
	<tr class="line-even" width="100%">
		<td align="right" width="15%">接收人</td>
		<td align="left"><input class="text-line" name="receiverName" readonly value="<%=receiverName%>"></td>
	</tr>
	<tr class="line-even" width="100%">
		<td align="right" width="15%">消息标题</td>
		<td align="left"><input class="text-line" name="ma_title" size="44" value="<%=ma_title%>"></td>
	</tr>
	<tr class="line-odd" width="100%">
		<td align="right" width="15%" valign="top">消息内容</td>
		<td align="left"><textarea class="text-line" name="ma_content" cols="43" rows="8"><%=ma_content%></textarea>
	</tr>
	<tr class="title1" width="100%">
		<td align="center" colspan="2">
		<%if (!cw_id.equals("")){ //发送消息%>
			<input type="button" name="btnSubmit" value="发送" class="bttn" onclick="checkForm()">
			<input type="reset" name="btnReset" value="重写" class="bttn">
		<%}%>
			<input type="button" name="btnClose" value="关闭" class="bttn" onclick="javascript:window.close();">
		</td>
	</tr>
<input type="hidden" name="receiverId" value="<%=receiverId%>">
<input type="hidden" name="cw_id" value="<%=cw_id%>">
<input type="hidden" name="cw_status" value="<%=cw_status%>">
</form>
</table>
<script language="javascript">
function checkForm()
{
	if(formData.ma_title.value=="")
	{
		alert("消息标题不能为空！");
		return false;
	}
	if(formData.ma_content.value=="")
	{
		alert("消息内容不能为空！");
		return false;
	}
	formData.action="SendResult.jsp";
	formData.submit();
}

</script>
<%@include file="/system/app/skin/popbottom.jsp"%>

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