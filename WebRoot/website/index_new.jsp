<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
//update by yo 20090110
//String ticket = String.valueOf(session.getAttribute("casTicket"));
//if(ticket!=null&&!ticket.equals("no")&&!"".equals(ticket))
//{
//	response.sendRedirect("/website/usermanage/Modify.jsp");
//}
%>
<head>
<title>ÉÏº£ ¡¤ ÆÖ¶«</title>
<link href="imagesnew/newWebMain.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" src="/website/js/government.js" type="text/JavaScript"></script>
<%//Update 20061231
 CDataCn dCn = null;
 CDataImpl dImpl = null;

 String sqlStr = "";
 Vector vPage = null;
 Hashtable content = null;

	try {
	  dCn = new CDataCn();
	  dImpl = new CDataImpl(dCn);
%>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="1002" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="35" align="left" valign="top" background="imagesnew/indexWJ_leftBG03.gif">
    	<!--title-->
    	<%@include file="/website/iframe/indexnew/head.jsp"%>
    	<!--title end-->
     </td>
  </tr>
  <tr>
    <td height="76" align="left" valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" background="/website/images/news_title.jpg">
      <tr>
        <!--td width="151"><img src="imagesnew/indexWJ_PIC_03.jpg" width="151" height="76" /></td-->
        <td width="800" height="76" align="right" id="home_index"><%@include file="/website/iframe/indexnew/index_title.jsp"%></td>
        <td valign="bottom">
          <iframe name="iframe1" src="/website/weather/weather.jsp?cl=FFFFFF&wd=180&toWard=up&toHeight=45" width="100%" height="60" allowTransparency="true" scrolling ="no" frameborder="0"></iframe>
        </td>
      </tr>
    </table>
	</td>
  </tr>
</table>

<!--nav-->
<%@include file="/website/iframe/indexnew/nav.jsp"%>
<!--nav end-->

<table width="1002" border="0" align="center" cellspacing="0" cellpadding="0">
  <tr>
    <td width="804" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="255" align="left" valign="top">
		<!--todayPd-->
		<%@include file="/website/iframe/indexnew/index_JRPD.jsp"%>
		<!--todayPd end-->
		</td>
        <td width="3"></td>
        <td width="546" valign="top">
        <!--bsdt-->
	    <%@include file="/website/iframe/indexnew/index_BSDT.jsp"%>
        <!--bsdt end-->
	    <!--xxgk-->
	    <%@include file="/website/iframe/indexnew/index_XXGK.jsp"%>
	    <!--xxgk end-->
    	</td>
      </tr>
    </table>
    
    <!--fwdh-->
    <%@include file="/website/iframe/indexnew/index_FWDH.jsp"%>
    <!--fwdh end-->
    <!--tzyqjd-->
    <%@include file="/website/iframe/indexnew/index_TZYQJD.jsp"%>
    <!--tzyqjd end-->
    
    </td>
    <td width="3"></td>
    <td width="195" valign="top" class="bg_wjj01">
    <!--right-->
    <%@include file="/website/iframe/indexnew/index_RIGHT.jsp"%>
    <!--right end-->
    </td>
  </tr>
</table>
<!--bottom-->
<%@include file="/website/iframe/indexnew/index_BOTTOM.jsp"%>
<!--bottom end-->
<map name="Map" id="Map"><area shape="rect" coords="459,4,539,21" href="/website/govOpen/index.jsp" /></map>
<map name="Map2" id="Map2"><area shape="rect" coords="460,5,539,21" href="/website/workHall/index.jsp" /></map>
<map name="Map3" id="Map3"><area shape="rect" coords="457,3,536,19" href="/website/understandPudong/index.jsp" /></map>
<map name="Map4" id="Map4"><area shape="rect" coords="458,5,540,19" href="/website/selectedColumn/index.jsp" /></map>
</body>
<%
	Adv ad = new Adv(dCn);
	String adcontent = ad.ShowAdv("indexFloat");
	out.println(adcontent);
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
