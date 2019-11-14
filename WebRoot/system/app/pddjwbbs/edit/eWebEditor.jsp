<%@include file="/system/app/skin/import.jsp"%>
<%
/**	名称：eWebEditor在线文本编辑器--飞鱼修改版
*  	作者：飞鱼
* 	日期：2004.11.30
*   网址：http://www.fiyu.net
*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="net.fiyu.edit.EditWebhelper,net.fiyu.edit.EditBean"%>
<%
	String 	sContentID,
        	sStyleID,
        	sFullScreen,
        	sStyleName,
              	sStyleDir,
            	sStyleCSS,
              	sStyleUploadDir,
              	nStateFlag,
              	sDetectFromWord,
              	sInitMode,
              	sBaseUrl,
              	sVersion,
              	sReleaseDate,
		sAutoRemote,
              	sToolBar;

EditWebhelper web = new EditWebhelper();
//初始化处理bean
web.filename = config.getServletContext().getRealPath("/")+"/WEB-INF/style.xml";
web.filename2 = config.getServletContext().getRealPath("/")+"/WEB-INF/button.xml";
web.getInstance();
//初始化输出bean
EditBean bean = web.InitPara();
sVersion = bean.getSVersion();
sReleaseDate = bean.getSReleaseDate();
sStyleName = bean.getSStyleName();
sStyleDir = bean.getSStyleDir();
sStyleUploadDir = bean.getSStyleUploadDir();
sInitMode = bean.getSInitMode();
sDetectFromWord = bean.getSDetectFromWord();
sBaseUrl = bean.getSBaseUrl();
sAutoRemote = bean.getSAutoRemote();
sToolBar = bean.getSToolBar();



//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

//String full_edit_user = dImpl.getInitParameter("full_edit_user");

//CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
//String userName = mySelf.getMyUid();
//System.out.println(userName + "xxx:"+full_edit_user);
//if (full_edit_user.indexOf(","+ userName +",") != -1) {
sToolBar = "<table border=0 cellpadding=0 cellspacing=0 width='100%' class='Toolbar' id='eWebEditor_Toolbar'><tr><td><div class='yToolbar'><DIV CLASS=\"TBHandle\"></DIV><SELECT CLASS=\"TBGen\" onchange=\"format('FormatBlock',this[this.selectedIndex].value);this.selectedIndex=0\"><option selected>段落样式</option> <option value=\"&lt;P&gt;\">普通</option> <option value=\"&lt;H1&gt;\">标题一</option> <option value=\"&lt;H2&gt;\">标题二</option> <option value=\"&lt;H3&gt;\">标题三</option> <option value=\"&lt;H4&gt;\">标题四</option> <option value=\"&lt;H5&gt;\">标题五</option> <option value=\"&lt;H6&gt;\">标题六</option> <option value=\"&lt;p&gt;\">段落</option> <option value=\"&lt;dd&gt;\">定义</option> <option value=\"&lt;dt&gt;\">术语定义</option> <option value=\"&lt;dir&gt;\">目录列表</option> <option value=\"&lt;menu&gt;\">菜单列表</option> <option value=\"&lt;PRE&gt;\">已编排格式</option></SELECT><SELECT CLASS=\"TBGen\" onchange=\"format('fontname',this[this.selectedIndex].value);this.selectedIndex=0\"><option selected>字体</option> <option value=\"宋体\">宋体</option> <option value=\"黑体\">黑体</option> <option value=\"楷体_GB2312\">楷体</option> <option value=\"仿宋_GB2312\">仿宋</option> <option value=\"隶书\">隶书</option> <option value=\"幼圆\">幼圆</option> <option value=\"Arial\">Arial</option> <option value=\"Arial Black\">Arial Black</option> <option value=\"Arial Narrow\">Arial Narrow</option> <option value=\"Brush Script MT\">Brush Script MT</option> <option value=\"Century Gothic\">Century Gothic</option> <option value=\"Comic Sans MS\">Comic Sans MS</option> <option value=\"Courier\">Courier</option> <option value=\"Courier New\">Courier New</option> <option value=\"MS Sans Serif\">MS Sans Serif</option> <option value=\"Script\">Script</option> <option value=\"System\">System</option> <option value=\"Times New Roman\">Times New Roman</option> <option value=\"Verdana\">Verdana</option> <option value=\"Wide Latin\">Wide Latin</option> <option value=\"Wingdings\">Wingdings</option></SELECT><SELECT CLASS=\"TBGen\" onchange=\"format('fontsize',this[this.selectedIndex].value);this.selectedIndex=0\"><option selected>字号</option> <option value=\"7\">一号</option> <option value=\"6\">二号</option> <option value=\"5\">三号</option> <option value=\"4\">四号</option> <option value=\"3\">五号</option> <option value=\"2\">六号</option> <option value=\"1\">七号</option></SELECT><SELECT CLASS=\"TBGen\" onchange=\"doZoom(this[this.selectedIndex].value)\"><option value=\"10\">10%</option> <option value=\"25\">25%</option> <option value=\"50\">50%</option> <option value=\"75\">75%</option> <option value=\"100\" selected>100%</option> <option value=\"150\">150%</option> <option value=\"200\">200%</option> <option value=\"500\">500%</option></SELECT><DIV CLASS=\"Btn\" TITLE=\"粗体\" onclick=\"format('bold')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/bold.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"斜体\" onclick=\"format('italic')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/italic.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"下划线\" onclick=\"format('underline')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/underline.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"左对齐\" onclick=\"format('justifyleft')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/justifyleft.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"居中对齐\" onclick=\"format('justifycenter')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/justifycenter.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"右对齐\" onclick=\"format('justifyright')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/justifyright.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"两端对齐\" onclick=\"format('JustifyFull')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/justifyfull.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"删除文字格式\" onclick=\"format('RemoveFormat')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/removeformat.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"中划线\" onclick=\"format('StrikeThrough')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/strikethrough.gif\"></DIV></div></td></tr><tr><td><div class='yToolbar'><DIV CLASS=\"Btn\" TITLE=\"上标\" onclick=\"format('superscript')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/superscript.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"下标\" onclick=\"format('subscript')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/subscript.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"全部选中\" onclick=\"format('SelectAll')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/selectall.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"取消选择\" onclick=\"format('Unselect')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/unselect.gif\"></DIV><DIV CLASS=\"TBHandle\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入或修改图片\" onclick=\"ShowDialog('dialog/img.htm', 350, 330, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/img.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入Flash动画\" onclick=\"ShowDialog('dialog/flash.htm', 350, 200, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/flash.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入自动播放的媒体文件\" onclick=\"ShowDialog('dialog/media.htm', 350, 200, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/media.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入其他文件\" onclick=\"ShowDialog('dialog/file.htm', 350, 150, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/file.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"表格菜单\" onclick=\"showToolMenu('table')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/tablemenu.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入或修改栏目框\" onclick=\"ShowDialog('dialog/fieldset.htm', 350, 170, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/fieldset.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入或修改网页帧\" onclick=\"ShowDialog('dialog/iframe.htm', 350, 200, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/iframe.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入水平尺\" onclick=\"format('InsertHorizontalRule')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/inserthorizontalrule.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入或修改字幕\" onclick=\"ShowDialog('dialog/marquee.htm', 395, 150, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/marquee.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"撤消\" onclick=\"format('undo')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/undo.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"恢复\" onclick=\"format('redo')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/redo.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入或修改超级链接\" onclick=\"format('CreateLink')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/createlink.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"取消超级链接或标签\" onclick=\"format('UnLink')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/unlink.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入特殊字符\" onclick=\"ShowDialog('dialog/symbol.htm', 350, 220, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/symbol.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入表情图标\" onclick=\"ShowDialog('dialog/emot.htm', 300, 180, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/emot.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入当前日期\" onclick=\"insert('nowdate')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/date.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"插入当前时间\" onclick=\"insert('nowtime')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/time.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"引用样式\" onclick=\"insert('quote')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/quote.gif\"></DIV></div></td></tr><tr><td><div class='yToolbar'><DIV CLASS=\"Btn\" TITLE=\"代码样式\" onclick=\"insert('code')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/code.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"全屏返回\" onclick=\"parent.Minimize()\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/minimize.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"编号\" onclick=\"format('insertorderedlist')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/insertorderedlist.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"项目符号\" onclick=\"format('insertunorderedlist')\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/insertunorderedlist.gif\"></DIV><DIV CLASS=\"TBSep\"></DIV><DIV CLASS=\"Btn\" TITLE=\"字体颜色\" onclick=\"ShowDialog('dialog/selcolor.htm?action=forecolor', 280, 250, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/forecolor.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"对象背景颜色\" onclick=\"ShowDialog('dialog/selcolor.htm?action=bgcolor', 280, 250, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/bgcolor.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"字体背景颜色\" onclick=\"ShowDialog('dialog/selcolor.htm?action=backcolor', 280, 250, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/backcolor.gif\"></DIV><DIV CLASS=\"Btn\" TITLE=\"背景图片\" onclick=\"ShowDialog('dialog/backimage.htm', 350, 210, true)\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/standard/bgpic.gif\"></DIV></div></td></tr></table>";
//}

//out.println(sToolBar);
//if(true)return;

//System.out.println(sToolBar);
//out.println(sToolBar);
//if(true)return;


nStateFlag = bean.getNStateFlag();
		//设置颜色样式
		sStyleCSS = request.getParameter("color");
                if (sStyleCSS == null)
                	sStyleCSS = "blue";
                else
                sStyleCSS = request.getParameter("color").trim();
                //设置全屏幕选项
                sFullScreen = request.getParameter("fullscreen");
                if (sFullScreen == null)
                	sFullScreen = "0";
                else
                sFullScreen = request.getParameter("fullscreen").trim();
                //设置内容选项
                sContentID = request.getParameter("id");
                if (sContentID == null)
                	sContentID = "content1";
                else
                sContentID = request.getParameter("id").trim();
                //设置样式
                sStyleName = request.getParameter("style");
                if (sStyleName == null)
                	sStyleName = "standard";
                else
                sStyleName = request.getParameter("style").trim();
 %>
<html>
<head>
<title>eWebEditor - eWebSoft在线文本编辑器</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="css/<%=sStyleCSS%>/Editor.css" type="text/css" rel="stylesheet">

<Script Language=Javascript>
var sPath = document.location.pathname;
sPath = sPath.substr(0, sPath.length-14);

var sLinkFieldName = "<%=sContentID%>" ;

// 全局设置对象
var config = new Object() ;
config.Version = "<%=sVersion%>" ;
config.ReleaseDate = "<%=sReleaseDate%>" ;
config.StyleName = "<%=sStyleName%>";
config.StyleEditorHeader = "<head><link href=\""+sPath+"css/<%=sStyleCSS%>/EditorArea.css\" type=\"text/css\" rel=\"stylesheet\"></head><body MONOSPACE>" ;
config.StyleMenuHeader = "<head><link href=\""+sPath+"css/<%=sStyleCSS%>/MenuArea.css\" type=\"text/css\" rel=\"stylesheet\"></head><body scroll=\"no\" onConTextMenu=\"event.returnValue=false;\">";
config.StyleDir = "<%=sStyleDir%>";
config.StyleUploadDir = "<%=sStyleUploadDir%>";
config.InitMode = "<%=sInitMode%>";
config.AutoDetectPasteFromWord = <%=sDetectFromWord%>;
config.BaseUrl = <%=sBaseUrl%>;
config.AutoRemote = <%=sAutoRemote%>;
</Script>
<Script Language=Javascript src="include/editor.js"></Script>
<Script Language=Javascript src="include/table.js"></Script>
<Script Language=Javascript src="include/menu.js"></Script>

<script language="javascript" event="onerror(msg, url, line)" for="window">
//return true ;	 // 隐藏错误
</script>

</head>

<body SCROLLING=no onConTextMenu="event.returnValue=false;" onFocus="VerifyFocus()">

<table border=0 cellpadding=0 cellspacing=0 width='100%' height='100%'>
<tr><td>

	<%=sToolBar%>

</td></tr>
<tr><td height='90%'>

	<table border=0 cellpadding=0 cellspacing=0 width='100%' height='100%'>
	<tr><td height='100%'>
	<input type="hidden" ID="ContentEdit" value="">
	<input type="hidden" ID="ContentLoad" value="">
	<input type="hidden" ID="ContentFlag" value="0">
	<iframe class="Composition" ID="eWebEditor" MARGINHEIGHT="1" MARGINWIDTH="1" width="100%" height="100%" scrolling="yes">	</iframe>
	</td></tr>
	</table>

</td></tr>

<% if(nStateFlag.equals("1")){ %>
<tr><td height=25>

	<TABLE border="0" cellPadding="0" cellSpacing="0" width="100%" class=StatusBar height=25>
	<TR valign=middle>
	<td>
		<table border=0 cellpadding=0 cellspacing=0 height=20>
		<tr>
		<td width=10></td>
		<td class=StatusBarBtnOff id=eWebEditor_CODE onClick="setMode('CODE')"><img border=0 src="buttonimage/<%=sStyleDir%>/modecode.gif" width=50 height=15 align=absmiddle></td>
		<td width=5></td>
		<td class=StatusBarBtnOff id=eWebEditor_EDIT onClick="setMode('EDIT')"><img border=0 src="buttonimage/<%=sStyleDir%>/modeedit.gif" width=50 height=15 align=absmiddle></td>
		<td width=5></td>
		<!--<td class=StatusBarBtnOff id=eWebEditor_VIEW onClick="setMode('VIEW')"><img border=0 src="buttonimage/<%=sStyleDir%>/modepreview.gif" width=50 height=15 align=absmiddle></td>-->
		</tr>
		</table>
	</td>
	<td align=right>
		<!--table border=0 cellpadding=0 cellspacing=0 height=20>
		<tr>
		<td style="cursor:pointer;" onclick="sizeChange(300)"><img border=0 SRC="buttonimage/<%=sStyleDir%>/sizeplus.gif" width=20 height=20 alt="增高编辑区"></td>
		<td width=5></td>
		<td style="cursor:pointer;" onclick="sizeChange(-300)"><img border=0 SRC="buttonimage/<%=sStyleDir%>/sizeminus.gif" width=20 height=20 alt="减小编辑区"></td>
		<td width=40></td>
		</tr>
		</table-->
	</td>
	</TR>
	</Table>

</td></tr>
<% } %>

</table>

<div id="eWebEditor_Temp_HTML" style="VISIBILITY: hidden; OVERFLOW: hidden; POSITION: absolute; WIDTH: 1px; HEIGHT: 1px"></div>

<form id="eWebEditor_UploadForm" hh_action="upload.jsp?action=remote&type=remote&style=<%=sStyleName%>" method="post" target="eWebEditor_UploadTarget">
<input type="hidden" name="eWebEditor_UploadText">
</form>
<iframe name="eWebEditor_UploadTarget" width=0 height=0></iframe>
<div id=divProcessing style="width:200px;height:30px;position:absolute;display:none">
<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%"><tr><td bgcolor=#3A6EA5><marquee align="middle" behavior="alternate" scrollamount="5" style="font-size:9pt"><font color=#FFFFFF>...远程文件收集中...请等待...</font></marquee></td></tr></table>
</div>

</body>
</html>
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