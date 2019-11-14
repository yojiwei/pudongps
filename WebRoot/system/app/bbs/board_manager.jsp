<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
<%
if ((session.getValue("UserName")==null)||(session.getValue("UserClass")==null)||(!session.getValue("UserClass").equals("系统管理员")))
{
 response.sendRedirect("err.jsp?id=14");
 return;
}

%>


<html><script language="JavaScript"></script></html>

<html>
<head>
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<META NAME="keywords" CONTENT=" 论坛  java forum jsp forum">
<META NAME="description" CONTENT=" 论坛  java forum jsp forum">
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
<script LANGUAGE="javascript" src="publish/chooseTreeJs.jsp"></script>

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
<%@include file="inc/left.jsp"%>

      <jsp:include page="inc/public.jsp" flush="true"/>
  <!--<tr> 
    <td class="tablerow" colspan="7" bgcolor="#FFFFFF" height="16"> 
      <table border="0" align="center" cellspacing="0" width="100%" cellpadding="0">
     	<tr> 
          <!--<td width="50%" align="center"><font color="#333399"><b><a href='manager.jsp'><font color="red">公告管理</font></a></b></font></td>-->
          <!--<td  align="center"><font color="#333399"><b><a href='board_manager.jsp'>论坛管理</a></b></font></td>
          <!--Jony:屏蔽<td width="40%" align="left"><font color="#333399"><b><a href='user_manager.jsp'>用户管理</a></b></font></td>-->
        <!--</tr>
      </table>
    </td>
  </tr>-->
  <tr bgcolor="#ffffff"> 
    <td width="17" height="14">&nbsp;</td>    
    <td colspan=5 align=right><a href="#" onClick="document.setBoradSequence.submit()">修改排序</a>&nbsp;&nbsp;&nbsp;<a href="Javascript:history.back();">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr bgcolor="#e9e9e9"> 
    <td width="17" height="14">&nbsp;</td>
    <td width="302" height="14">论坛名称</td>
    <td width="172" align="center" height="14">论坛斑竹</td>
    <td width="116" align="center" height="14">修改</td>
    <td width="91" align="center" height="14">排序</td>
	<td width="91" align="center" height="14"></td>
  </tr>
 <form name="setBoradSequence" action = "setBoardSequence.jsp" method="post">
<%! String Notice_Id,sql,Not_Title,Not_Content,Submit_Button;%>
 <%
  int PageSize=10;
  int RecordCount=0;
  int PageCount=0;
  int ShowPage=1;
  
   Connection con=yy.getConn();
   Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
   ResultSet rs=null;
 
  sql="Select f.*,u.ur_realname from forum_board f,userinfo u where u.ur_loginname=f.fm_master_name order by fm_sequence,f.fm_id";
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
    <td align="center"  height="26" width="17"><img src="image/folder.gif" width="13" height="16"></td>
    <td height="26" width="302" bgcolor="#F7FBFF"><a href="board_manager.jsp?modifyid=<%=Notice_Id%>"> 
      <%=rs.getString("fm_name")%> </a> <br />
    </td>
    <td align="center" height="26" width="172"><%=rs.getString("fm_master_name")%></td>
    <td align="center" height="26" width="116"><a href='board_manager.jsp?modifyid=<%=Notice_Id%>'>修改</a></td>
	 <td align="center" height="26"><input type="text" name="boardid<%=rs.getString("fm_id")%>" size="5" style="border:1px solid #000000;background-color:#F7FBFF" value="<%if(rs.getString("fm_sequence")!=null) out.print(rs.getString("fm_sequence"));%>"></td>
    <td align="center" height="26" width="91"><a href='queryboard_manager.jsp?deleteid=<%=Notice_Id%>' onclick="{if(confirm('确定删除选定的纪录吗?')){return true;}return false;}">删除</a></td>

  </tr>
<%
if (!rs.next())
break;
}
}


%>
<input type="hidden" name="curPage" value="<%=ShowPage%>">
</form>
  <tr bgcolor="#F7FBFF"> 
    <form method="POST" action="board_manager.jsp">
	<td align="center" height="10" width="17">&nbsp;</td>
    <td colspan="6" height="10" align="right"> 
      
        现在是第 <font color=black ><%=ShowPage%></font> 页 转到 
        <select size="1" name="page">
<%
for (int i=1;i<=PageCount;i++)
{
    out.println(" <option value="+i+">"+i+"页</option>");
}
%>
</select>
<input type="submit" value="go" name="B1">

    </td>
  </tr>

<%
String Modify_Id=request.getParameter("modifyid");
String userId="";
if (Modify_Id!=null)
{
sql="select f.*,u.ur_realname,u.ur_id from forum_board f,userinfo u where fm_id="+Modify_Id+" and u.ur_loginname=f.fm_master_name";
rs=stmt.executeQuery(sql);
while(rs.next())
	{
     Not_Title=rs.getString("fm_name");
	 Not_Content=rs.getString("fm_master_name");
	 userId = rs.getString("ur_id");
    Submit_Button="修改";
}

}else
{
Modify_Id="0";
Not_Title="";
Not_Content="";
Submit_Button="新增";
}
%>
</form>
  <tr bgcolor="#F7FBFF"> 
   <form method="POST" name="form1" action="queryboard_manager.jsp" onSubmit="">
	<td align="center" height="10" width="17">&nbsp;</td>
    <td colspan="6" height="10" align="right" valign="middle"> 
      <div align="left"></div>
        <div align="center">论坛名称：
          <input type="text" name="title" value="<%=Not_Title%>">
          <input type="hidden" name="noticeid" value="<%=Modify_Id%>">
		  斑竹：
          <input id=useid type=text name="userFileIds" treeType="Dept" treeTitle="选择部门用户" isSupportMultiSelect="0" isSupportFile="1" style="background-color:#cccccc" value="<%=Not_Content%>">
		  <input type=hidden name=userDirIds value>
          <!--input type=hidden name=userFileIds value="<%=userId%>" id=usevalue-->
          <input type="button" name="Submit"   value="<%=Submit_Button%>" onClick="CheckValue();">
          <input type="reset" name="Submit2" value="重置">
        </div>
      </form>
      </td>
  </tr>

</table>
</td></tr></table>
<%@include file="inc/bottom.jsp"%>