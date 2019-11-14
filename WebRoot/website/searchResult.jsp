<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%

CDataCn dCn = null;
CDataImpl dImpl = null;

String sqlStr = "";
Vector vPage = null;
Hashtable content = null;
int pageSize = 0;

String get_dir = ""; //根目录权限代码
String keyWord = ""; //查询关键字
String content_url = "/website/pudongNews/InfoContent.jsp"; //详细页面路径

String stIds = "";

String ct_id = "";
String ct_title = "";
String ct_titleShow = "";
String ct_create_time = "";
String ct_url = "";
String href = "";
String sj_dir = "";
String sj_id = "";

get_dir = CTools.dealString(request.getParameter("ch_id")).trim();
keyWord=CTools.dealString(request.getParameter("query")).trim();

if ("govOpen".equals(get_dir)) {
	content_url = "/website/govOpen/InfoContent.jsp";
}
else if ("qlgkzw".equals(get_dir)) {
	content_url = "/qlgk/powerstd_detail.jsp";
}
else if ("credit".equals(get_dir)) {
	content_url = "/website/credit/Content.jsp";
}
else if ("investInfo".equals(get_dir)) {
	content_url = "/website/investInfo/infoContent.jsp";
}

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
sqlStr = "select c.ct_id,c.ct_title,c.ct_create_time,c.ct_url,s.sj_dir,s.sj_id from tb_content c,tb_contentpublish p,tb_subject s where s.sj_id in (select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_dir = '"+ get_dir +"') and c.ct_id = p.ct_id and p.sj_id = s.sj_id and p.cp_ispublish = 1 and c.ct_create_time is not null and c.ct_title like '%"+ keyWord +"%' order by to_date(c.ct_create_time,'YYYY-MM-DD') desc,c.ct_id desc";

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海 · 浦东</title>
<link href="images/newWebMain.css" rel="stylesheet" type="text/css" />
<link href="pudongNews/style.css" rel="stylesheet" type="text/css" />
</head>
<body leftmargin="0" topmargin="0">
<!--head start-->
<%@ include file="/website/iframe/index/indexHead.jsp"%>
<%@ include file="/website/iframe/sub/subNewTopNavi.jsp" %> 
<!--head end-->
<table width="1002" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="778" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="200" height="636" align="center" valign="top" background="images/sub_leftBg.gif">
          </td>
          <td align="center" valign="top"><!--main start-->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="6"></td>
              </tr>
            </table>
            <table width="536" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="32" class='font'><a href="/website/index.html" class='three'>首页</a> > 查询结果 </td>
              </tr>
            </table>
            <!--list begin-->
            <table width="545" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="8"></td>
              </tr>
            </table>
            <table width="545" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25" align="right" background="images/new_news_subTitleBg02.gif" style="background-repeat:repeat-y; background-position:left"><table width="99%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="font-title01">查询结果</td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td height="20"></td>
              </tr>
              <tr>
                <td valign="top"><table width="520" border="0" cellspacing="0" cellpadding="0">
                    <%
										vPage =  dImpl.splitPage(sqlStr,request,18);
										if (vPage != null) {
											pageSize = vPage.size();
											for (int i=0;i<pageSize;i++) {
												content = (Hashtable)vPage.get(i);
												ct_id = content.get("ct_id").toString();
												ct_title = content.get("ct_title").toString();
												ct_titleShow = ct_title;
												if (ct_title.length()>33) {
													ct_title = ct_title.substring(0,32) + ".." ;
												}
												ct_create_time = content.get("ct_create_time").toString();
												ct_url = content.get("ct_url").toString();
												sj_dir = content.get("sj_dir").toString();
												sj_id = content.get("sj_id").toString();
												href = !"".equals(ct_url) ? ct_url : content_url + "?sj_dir=" + sj_dir + "&ct_id=" + ct_id;
												if ("qlgkzw".equals(get_dir)) {
													href = !"".equals(ct_url) ? ct_url : content_url + "?psid=" + sj_id + "&substdid=" + ct_id;
												}
										%>
                    <tr>
                      <td height="28" valign="top" class="font-list01" width="20"><img src="images/arrow03.gif" width="4" height="8" vspace="8" hspace="5" /></td>
                      <td class="font-list01"><a href="<%=href%>" target="_blank" title="<%=ct_titleShow%>"> <%=ct_title%></a> (<%=ct_create_time%>)</td>
                    </tr>
                    <%		
												}
										%>
                    <tr>
                      <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                      <td align="center" colspan="2"><%=dImpl.getNewTail(request)%></td>
                    </tr>
                    <%
											}
										else {
										%>
                    <tr>
                      <td height="27" align="center" valign="bottom" bgcolor="#F5F5F5" colspan="2"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" align="center" class="f12"><font color="#009900">对不起，没有找到主题包含“<font color="#FF0000"><%=keyWord%></font>”的相关信息!</font></td>
                          </tr>
                        </table></td>
                    </tr>
                    <%
											}
										%>
                  </table></td>
              </tr>
              <tr>
                <td height="26"></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30"></td>
              </tr>
            </table>
            <!--main end-->
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="1"></td>
        </tr>
      </table>
      <!--bottom start-->
      <%@ include file="/website/iframe/index_bottom.jsp" %>
      <!--bottom end-->
    </td>
    <td width="4" background="images/index_addLeftNewBg01.gif"></td>
    <td align="center" valign="top" background="images/index_addBg.gif">
    	<%@include file="/website/iframe/sub/subRight.jsp"%>
    </td>
  </tr>
</table>
</body>
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
