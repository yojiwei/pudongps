<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>网站导航</title>
<link href="images/newWebMain.css" rel="stylesheet" type="text/css" />
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/lmdh_mainBg.gif">
<table width="703" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="159" align="left" valign="top"><img src="images/lmdh_top_pic_1.jpg" width="169" height="159" /></td>
    <td align="left" valign="top"><img src="images/lmdh_top_pic_2.jpg" width="173" height="159" /></td>
    <td align="left" valign="top"><img src="images/lmdh_top_pic_3.jpg" width="150" height="159" /></td>
    <td align="left" valign="top"><img src="images/lmdh_top_pic_4.jpg" width="103" height="159" /></td>
    <td align="left" valign="top"><img src="images/lmdh_top_pic_5.jpg" width="108" height="159" /></td>
  </tr>
</table>
<table width="703" border="0" align="center" cellpadding="0" cellspacing="0" background="images/lmdh_bg.gif">
  <tr>
    <td width="26"></td>
    <td align="left" valign="top">
<%//Update 20061231
 CDataCn dCn = null;
 CDataImpl dImpl = null;

	String root_dir = "shpd"; //根节点权限代码
	String first_id = ""; //一级栏目节点id
	String first_name = ""; //一级栏目名
	String first_url = ""; //一级栏目url
	String first_dir = ""; //一级栏目权限代码
	String first_linkto = ""; //跳转地址
	
	String second_id = ""; //二级栏目节点id
	String second_name = ""; //一级栏目名
	String second_url = ""; //一级栏目url
	String second_dir = ""; //一级栏目权限代码
	String second_linkto = ""; //跳转地址
	
	String td_bgcolor = "";
	
	String first_sql = "";
	String second_sql = "";

 try{
  dCn = new CDataCn();
  dImpl = new CDataImpl(dCn);

	first_sql = "select sj_id,sj_name,sj_url,sj_dir from tb_subject where sj_parentid = (select sj_id from tb_subject where sj_dir = '"+ root_dir +"') and sj_dir <> 'publicservice' and sj_display_flag=0 order by sj_sequence,sj_id";
	Vector first_vPage = dImpl.splitPageOpt(first_sql,30,1);
	if (first_vPage != null)
	{
		for (int i=0;i<first_vPage.size();i++)
		{
			Hashtable first_content = (Hashtable)first_vPage.get(i);
			first_id = first_content.get("sj_id").toString();
			first_name = first_content.get("sj_name").toString();
			first_url = first_content.get("sj_url").toString();
			first_dir = first_content.get("sj_dir").toString();

/*if (first_url.indexOf("?")>-1)
{
	first_linkto = first_url + "&sj_dir=" + first_dir;
}
else
{
	first_linkto = first_url + "?sj_dir=" + first_dir;
}*/
			first_linkto = first_url;
			if (i%2 == 1)
			{
%>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="123"></td>
        <td align="left" valign="top">
<%
			}
%>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="80%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="143" height="20" align="left" valign="top" background="images/lmdh_titlebg.jpg"><table width="80%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="2"></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="f13">&nbsp;&nbsp;<a href="<%=first_linkto%>"><strong><font color="#FFFFFF">>><%=first_name%></font></strong></a></td>
              </tr>
            </table></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="12"></td>
      </tr>
      <tr>
        <td align="left" valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="0">
<%
            second_sql = "select sj_id,sj_name,sj_url,sj_dir from tb_subject where sj_parentid = "+ first_id +" and sj_display_flag=0 order by sj_sequence,sj_id";
						Vector second_vPage = dImpl.splitPageOpt(second_sql,50,1);
						if (second_vPage != null)
						{
							for (int j=0;j<second_vPage.size();j++)
							{
								Hashtable second_content = (Hashtable)second_vPage.get(j);
								second_id = second_content.get("sj_id").toString();
								second_name = second_content.get("sj_name").toString();
								second_url = second_content.get("sj_url").toString();
								second_dir = second_content.get("sj_dir").toString();
								if (second_url.indexOf("?")>-1)
								{
									second_linkto = second_url + "&pardir=" +first_dir;
								}
								else
								{
									second_linkto = second_url + "?pardir=" +first_dir;
								}
								//out.println(second_url.indexOf("sj_dir"));
								if (second_url.indexOf("sj_dir")==-1)
								{
									second_linkto += "&sj_dir=" + second_dir;
								}
								//out.println(j%4);
								if ((j/4)%2 == 0) //奇数行
								{
									td_bgcolor = "#EDEDED";
								}
							else //偶数行
								{
									td_bgcolor = "#F9F9F9";
								}
								if (j%4 == 0) //行首
								{
%>
          <tr>
            <td width="18"></td>
<%
								}
%>
            <td width="124" bgcolor="<%=td_bgcolor%>"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="3"></td>
              </tr>
              <tr>
                <td align="center" valign="top" class="f12W"><%if (!second_url.equals("")) {%><a href="<%=second_linkto%>"><font color="#053B93"><%=second_name%></font></a><%} else {%><font color="#053B93"><%=second_name%></font><%}%></td>
              </tr>
            </table></td>
<%
								if ((j+1)%4 == 0) //行尾
								{
%>
            <td>&nbsp;</td>
          </tr>
<%
								}
								if ((j+1) == second_vPage.size() && (j+1)%4 != 0) //数据结束非整行
								{
									for (int k=(j%4);k<3;k++)
									{
%>
            <td width="124" bgcolor="<%=td_bgcolor%>" align="center">&nbsp;</td>
<%
										if ((k+1) == 3)
										{
%>
            <td>&nbsp;</td>
          </tr>
<%
										}
									}
								}
							}
						}
%>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="30"></td>
      </tr>
    </table>
<%
			if (i%2 == 1)
			{
%>
        </td>
      </tr>
    </table>
<%
			}
		}
	}
%>
    </td>
  </tr>
</table>
<table width="703" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" valign="top" background="images/lmdh_bgbottom.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10" height="54" align="left" valign="top"><img src="images/lmdh_leftbottom.gif" width="10" height="54" /></td>
        <td align="center" valign="top"><table width="70%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="16"></td>
          </tr>
          <tr>
            <td align="center" valign="middle"><font color="#FFFFFF">上海市浦东新区人民政府主办</font></td>
          </tr>
          <tr>
            <td align="center" valign="middle"><font color="#FFFFFF">Copyright &copy; 2006-2007 Shanghai</font></td>
          </tr>
        </table></td>
        <td width="10" align="right" valign="top"><img src="images/lmdh_rightbottom.gif" width="10" height="54" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="42" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="left" valign="top"><img src="images/lmdh_bottom_pic_1.jpg" width="169" height="42" /></td>
        <td align="left" valign="top"><img src="images/lmdh_bottom_pic_2.jpg" width="173" height="42" /></td>
        <td align="left" valign="top"><img src="images/lmdh_bottom_pic_3.jpg" width="150" height="42" /></td>
        <td align="left" valign="top"><img src="images/lmdh_bottom_pic_4.jpg" width="103" height="42" /></td>
        <td align="left" valign="top"><img src="images/lmdh_bottom_pic_5.jpg" width="108" height="42" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
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