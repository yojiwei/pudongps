<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.component.database.*" %>

<%@ page import="com.util.*"%>

<%

String code =  CTools.dealString(request.getParameter("code"));

%>
<HTML>
<HEAD>
<TITLE></TITLE>
<META NAME="Author" CONTENT="moonpiazza">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<link rel="stylesheet" type="text/css" href="treeRes/XMLSelTree.css">
</HEAD>
<body  leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">
<BODY>
</HTML>
<FORM METHOD=POST ACTION="" name='form2'>
<table width="100%" height="40" border="0" cellpadding="0" cellspacing="0" background="images/bg.jpg">
  <tr>
    <td><table border="0"  cellpadding="0" cellspacing="10">
        <tr>
          <td>
					
			<font color="white">您选择的:</font><INPUT TYPE="text" NAME="content" value="" >
			<input type="hidden" name="englishName" value="">
		  </td>
		</tr>
		<tr>
          <td>
          	<input onclick="on_choose();" type="button" value="确定" id=button1 name=button1>
            <input type="reset" name="Submit2" value="重置"></td>
        </tr>
      </table></td>
  </tr>
</table>
</FORM>
<div style="overflow: auto; width: 100%; height:371; border: 0px solid #336699">
<table width="100%" height="355px" border="0" cellpadding="10" cellspacing="0" class="kuang">
  <tr>
    <td valign="top"> 
		<DIV id="SrcDiv" onselectstart="selectstart()"></DIV>
	</td>
  </tr>
</table>
</DIV>
<SCRIPT LANGUAGE=javascript src="treeRes/XMLSelTree.js"></SCRIPT>
<SCRIPT LANGUAGE=javascript>
<!--
var initFlag=0;
var m_sXMLFile	= "TreeNode.jsp?code=<%=code%>";						// 主菜单项文件(可改为TreeNode.asp)
var m_sXSLPath	= "treeRes/";						// xsl文件相对路径
var m_oSrcDiv	= SrcDiv;								// HTML标记(菜单容器，菜单在此容器显示)
function window.onload()
{
	InitTree(m_sXMLFile, m_sXSLPath, m_oSrcDiv,true);
	form2.content.value="";
}
/************************************************
** GoLink(p_sHref, p_sTarget)
************************************************/
function GoLink(p_sHref, p_sTarget,p_sContnet,p_sEnglishName,p_sShowFlag)
{
	var sHref	= p_sHref;
	var sTarget	= p_sTarget;
	if(undefined == p_sContnet)
		p_sContnet = "";
	//alert(p_sHref);
	if(cTrim(p_sContnet,0) != "" && p_sShowFlag == 1 && initFlag!=0)
		alert(p_sContnet);
	document.form2.englishName.value = p_sEnglishName;
	document.form2.content.value= p_sHref;
	initFlag=1;
}

//sInputString 为输入字符串，iType为类型，分别为 0 - 去除前后空格; 1 - 去前导空格; 2 - 去尾部空格
function cTrim(sInputString,iType){
	var sTmpStr = ' ';
	var i = -1;
	if(iType == 0 || iType == 1){
		while(sTmpStr == ' '){
			++i;
			sTmpStr = sInputString.substr(i,1);
		}
		sInputString = sInputString.substring(i);
	}
	if(iType == 0 || iType == 2){
		sTmpStr = ' ';
		i = sInputString.length;
		while(sTmpStr == ' '){
			--i;
			sTmpStr = sInputString.substr(i,1);
		}
		sInputString = sInputString.substring(0,i+1);
	}
	return sInputString;
}


function on_choose()
{
  var sep = "";
  var sep1 = '\x01' ;
  var sep2 = '\x02' ;
  var englishName = "englishName="+document.form2.englishName.value;
  s3 = "content="+document.form2.content.value + sep1 + englishName;
  returnValue = s3 ;
  //alert(returnValue)
  close() ;
}

//-->
</SCRIPT>

