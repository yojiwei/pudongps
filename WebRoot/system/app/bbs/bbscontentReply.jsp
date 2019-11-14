<%@page contentType="text/html; charset=GBK"%>
<%String strTitle="新增帖子" ;%>
<%@include file="../skin/head.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

 String stype;
 String bt_name="";
 String bt_manager="";
 String title="";
 String uiid,uiname,sequence,child,id;
 String ssql;

 title=CTools.dealString(request.getParameter("title")).trim();
 id=CTools.dealNumber(request.getParameter("bc_id"));
 sequence=CTools.dealString(request.getParameter("num"));
 child=CTools.dealNumber(request.getParameter("childs"));
 stype=CTools.dealNumber(request.getParameter("stype"));

	ssql="update tb_bbscontent set bc_hit=bc_hit+1 where bc_id="+id;		//点击数加1
	dImpl.executeUpdate(ssql);

 if(!stype.equals("0"))
 {
	 String strSql="select bt.* ,u.ui_name from tb_bbstype bt,tb_userinfo u where bt.bt_manager=u.ui_id and bt.bt_id="+stype;
	 Hashtable content = dImpl.getDataInfo(strSql);
	 bt_name=content.get("bt_name").toString();
	 bt_manager=content.get("ui_name").toString();
 }

CMySelf myBBs = (CMySelf)session.getAttribute("mySelf");
  if(myBBs!=null && myBBs.isLogin())
  {
    uiid = Long.toString(myBBs.getMyID());
		uiname=myBBs.getMyName();
  }
  else
  {
    uiid= "4";
		uiname="";
  }

%>

<script language=javascript>
function check()
{
	if(formData.title.value=="")
	{
		alert("主题不能为空！");
		formData.title.focus();
		return false;
	}
	GetDatademo();
	formData.action="bbscontentResult.jsp";
	formData.submit();
}

function setHtml()
		{
	demo.setHTML (formData.bbs_content.value);
	//alert(formData.bbs_content.value);
		}
</script>
<script language="javascript" for=window event=onload>
setHtml();
</script>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr class="title1">
    <td  width="56%" >
		<img border="0" src="../../images/bbs/bbssmall.gif" WIDTH="30" HEIGHT="20"><b>电子论坛-<%=bt_name%></b>
	</td>
    <td width="44%" align="right">
      <b>版主：<%=bt_manager%></b>&nbsp;&nbsp;&nbsp;
    </td>
  </tr>  
	
</table>
<%

String bbscontent="";
String bcuser="";
if(!id.equals("0"))
{
	ssql="select bc_title,bc_content,bc_writetime,bc_user from tb_bbscontent where bc_id="+id;
	//out.print(ssql);
	Hashtable content2 = dImpl.getDataInfo(ssql);
	 bbscontent=content2.get("bc_content").toString();
	 bcuser=content2.get("bc_user").toString();
}

%>
<table border=0 width=100%>
<tr>
	<td><u><b>主题名称：</b></u><%=title%></td>
</tr>
<tr>
	<td><u><b>发布内容：</b></u>
	<br><%=bbscontent%>
	</td>
</tr>
<tr>
		<td align=right ><u><b>作者：</b></u><%=bcuser%></td>
	</tr>
</table>

<table border=0 width=100%>
<form name=formData action=post>

<input type=hidden name=stype value="<%=stype%>">
<input type=hidden name=uiname value=<%=uiname%>>
<input type=hidden name=bcid value=<%=id%>>
<input type=hidden name=sequence value=<%=sequence%>>
<input type=hidden name=child value=<%=child%>>

	<tr class=line_odd>
		<td><u><b>用户名：</b></u><%=uiname%></td>
	</tr>
	<tr class=line_even>
		<td>
			<%for(int i=0;i<10;i++)
			{%>
			<input type="radio" checked name="face" value="../../images/bbs/mood<%=i%>.gif" >
      <img border="0" src="../../images/bbs/mood<%=i%>.gif" WIDTH="15" HEIGHT="15">&nbsp; 
			<%
			}%>
		</td>
	</tr>
	<tr class="line_odd">
			<td>主题名称：<input type=text class="text-line" name=title size=55 value="RE:<%=title%>"></td>
	</tr>
	<tr class="line-even">
      <td align="center" height="1" colspan="4">☆☆☆★★★回帖内容★★★☆☆☆</td>
  </tr>
   <tr class="line-odd">
       <td height="1" colspan="4"> </td>
  </tr>

	<tr>
		<td colspan=4>
		<iframe id="demo" style="HEIGHT: 350px; TOP: 5px; WIDTH: 100%" src="/system/common/editor/editor.htm"></iframe>
		<input type="hidden" id="bbs_content" name="bbs_content" value="">
		  <script LANGUAGE="javascript">
			<!--
			function GetDatademo()
			{
				var re = "/<"+"script.*.script"+">/ig";
				var re2 = /(http|https|ftp):(\/\/|\\\\)((\w)+){1,}:*[0-9]*(\/|\\){1}/ig;
				var Html=demo.getHTML();
				Html = Html.replace(re,"");
				Html = Html.replace(re2,"/");
				formData.bbs_content.value=Html;
			}
		//-->
		</script>
		</td>
	</tr>
	</form>
</table>
<table width=100%>
	<tr align=center>
		<td>
			<input type=button class=bttn value="提交帖子" onclick="check();">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=button class=bttn value="返回" onclick="history.back();">
		</td>
	</tr>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="../skin/bottom.jsp"%>


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
