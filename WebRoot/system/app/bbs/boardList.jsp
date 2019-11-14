<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<html><script language="JavaScript"></script></html>
<html>
<head>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>

<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{ settings=
"toolbar=no,location=no,directories=no,"+
"status=no,menubar=no,scrollbars=yes,"+
"resizable=yes,width="+window_width+",height="+window_height;

NewWindow=window.open(url,window_name,settings); }

function CheckValue()
{
	if (form1.title.value=="")
		{
		   alert("论坛名称不能为空!");
		   form1.title.focus();
		   return false;
	}
	if (form1.userFileIds.value=="")
		{
		   alert("斑竹不能为空!");
		   form1.userFileIds.focus();
		   return false;
	}
	form1.submit();
}

function icon(theicon) {
document.input.message.value += " "+theicon;
document.input.message.focus();
}
</script>


<script LANGUAGE="javascript">

function on_choose_user()
{
  if(chooseTree('user','form1'))
  {
  }
  //formData.submit();
}
</script>


<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<table width='100%' class="main-table" align='center'>
  <tr bgcolor="#ffffff"> 
    <td height="14">&nbsp;</td>    
    <td colspan=2 align=right></td>
  </tr>
  <tr bgcolor="#e9e9e9"> 
    <td height="14">&nbsp;</td>
    <td height="14" align="center" >论坛名称</td>
    <td align="center" height="14">论坛斑竹</td>
  </tr>

<%! String Notice_Id,sql,Not_Title,Not_Content,Submit_Button;%>
 <%
  int PageSize=10;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;
  
CDataCn dCn = null;
 try{
  dCn = new CDataCn();
 	Connection con=dCn.getConnection();
   java.sql.Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   ResultSet rs=null;
 
  sql="Select f.* from forum_board f,tb_userinfo u where u.ui_uid=f.fm_master_name order by fm_sequence,f.fm_id";
  //sql="Select f.* from forum_board f order by fm_id desc";	
  // Statement  stmt=con.createStatement();
  rs=stmt.executeQuery(sql);
  rs.last();
  RecordCount=rs.getRow();
  PageCount=(RecordCount % PageSize==0)?(RecordCount/PageSize):(RecordCount/PageSize+1);
  String Page=request.getParameter("page");
  if (Page!=null)
  {
        ShowPage=Integer.parseInt(Page);
     if (ShowPage>PageCount)
        ShowPage=PageCount;
     else if(ShowPage<0)
        ShowPage=1;
  }else
        ShowPage=1;

if (RecordCount>0)
{
rs.absolute((ShowPage-1)*PageSize+1);
for (int i=0;i<PageSize;i++)
{
Notice_Id=rs.getString("fm_id");
%>
  <tr bgcolor="#F7FBFF"> 
    <td align="center"  height="26" ><img src="image/folder.gif" width="13" height="16"></td>
    <td height="26" bgcolor="#F7FBFF" align="center" ><a href="board.jsp?fid=<%=Notice_Id%>"> 
      <%=rs.getString("fm_name")%> </a> <br />
    </td>
    <td align="center" height="26" ><%=rs.getString("fm_master_name")%></td>
   </td>

  </tr>
<%
if (!rs.next())
break;
}
}
con.close();
dCn.closeCn();
%>
</table>
<%@ include file="/system/app/skin/bottom.jsp"%>
<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {

	if(dCn != null)
	dCn.closeCn();
}

%>
