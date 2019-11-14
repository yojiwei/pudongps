<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import_work.jsp" %>
<%
String  board_name="";
String  board_id ="";
String  revert_title="";
CDataCn dCn = null;
CDataImpl dImpl = null;
Vector  r_vPage = null;
Hashtable r_content = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
String  r_sqlStr ="select board_id,board_name from forum_board_pd where board_hot_flag=1 and board_publish_flag=1";
r_content = dImpl.getDataInfo(r_sqlStr);
if(r_content != null){
	board_name = r_content.get("board_name").toString();
	board_id = r_content.get("board_id").toString();
}
%>
<table width="209" border="0" cellpadding="0" cellspacing="0" bgcolor="#F9F9F9">
  <tr>
    <td height="32" background="../images/pudongnews/NewsIndex_bg01_w.jpg">&nbsp;</td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td valign="top"><table width="191" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td align="left" valign="top"><img src="../images/pudongnews/NewsIndex_icon02_w.jpg" width="70" height="21" /></td>
      </tr>
      <tr>
        <td valign="top"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="3">
          <tr>
            <td height="2"></td>
          </tr>
          <tr>
            <td align="left" valign="top">
            	<a href="http://61.129.65.86/website/pudongForum/index.jsp" target="_blank" class="newsf_wjj" title="<%=board_name%>"><%=board_name.length() >13 ? board_name.substring(0,12) + ".." : board_name%></a>
            </td>
          </tr>
          <tr>
            <td></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td valign="top"><table width="191" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td align="left" valign="top"><img src="../images/pudongnews/NewsIndex_icon03_w.jpg" width="70" height="21" /></td>
      </tr>
      <tr>
        <td valign="top"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="3">
          <tr>
            <td height="6" colspan="2"></td>
          </tr>
     <%
		  r_sqlStr = "select id,type,title,ccontent,author,to_char(cdate,'yyyy-MM-dd hh24:mi:ss') as cdate from (select * from (select revert_id as id,revert_title as title,revert_content as ccontent,revert_author as author,revert_date as cdate,'0' as type from forum_revert where revert_status = 1 and post_id in (select post_id from forum_post_pd where board_id = " + board_id + ") union all select post_id as id,post_title as title,post_content as ccontent,post_author as author,post_date as cdate,'1' as type from forum_post_pd where post_status = 1 and board_id = " + board_id + ") order by cdate desc) where rownum < 3";
      r_vPage = dImpl.splitPageOpt(r_sqlStr,2,1);
			if(r_vPage != null) {
				for(int i = 0 ; i < r_vPage.size() ; i++) {
					r_content = (Hashtable) r_vPage.get(i);
					revert_title = r_content.get("ccontent").toString();
     %>
          <tr>
            <td width="18" height="21" align="left" valign="top"><img src="../images/pudongnews/NewsIndex_icon04_w.jpg" width="14" height="13" /></td>
            <td align="left" valign="top"><%=revert_title.length() >25? revert_title.substring(0,24) + ".." : revert_title%></td>
          </tr>
		  <%
		  		}
		  	}
		  %>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="46" align="center" valign="middle"><a href="http://61.129.65.86/website/pudongForum/index.jsp" target="_blank"><img src="../images/pudongnews/NewsIndex_icon01_w.jpg" width="77" height="24" border="0" /></a></td>
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