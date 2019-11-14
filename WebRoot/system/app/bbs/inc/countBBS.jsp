<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<link rel='stylesheet' type='text/css' href='inc/FORUM.CSS'>
<link href="/oa30/website/images/main.css" rel="stylesheet" type="text/css">
<META NAME="keywords" CONTENT="论坛  java forum jsp forum">
<META NAME="description" CONTENT="论坛  java forum jsp forum">

<title>论坛</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>           
<%
		Calendar cal = new GregorianCalendar();
		cal.add(GregorianCalendar.DATE,0);
		SimpleDateFormat theDate = new SimpleDateFormat("yyyy-MM-dd");
		String ul_time = theDate.format(cal.getTime());
		//out.println(ul_time);
		 
		String post_count = "";
		String main_post_count = "";
		int hf_post_count = 0;
		String per_count = "";
		String new_count = "0";
%>
                             
<table cellspacing="0" cellpadding="0" width="100%" border="0" background="/oa30/website/images/indexsub_leftbg.gif" align="center">
	<tr bgcolor="#e9e9e9">
	  <td nowrap height="14" colspan="6">&nbsp;</td>        
	</tr>

	<%
	sql = "select sum(fm_main_post_count) as fm_main_post_count,sum(fm_post_count) as fm_post_count from forum_board";
	rs=stmt.executeQuery(sql);
	if (rs.next()){
		post_count = rs.getString("fm_post_count");
		main_post_count = rs.getString("fm_main_post_count");
		hf_post_count = Integer.parseInt(rs.getString("fm_post_count"))-Integer.parseInt(rs.getString("fm_main_post_count"));
	}

	sql = "select count(post_id) as newcount from forum_post where post_date >= to_date('"+ul_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and post_date <= to_date('"+ul_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";		
	rs=stmt.executeQuery(sql);
	if (rs.next()){
		new_count = rs.getString("newcount");			
	}
	sql = "select count(ur_id) as urcount from userinfo";
	rs=stmt.executeQuery(sql);
	if (rs.next()){
		per_count = rs.getString("urcount");
	}
	%>
	<tr bgcolor="#F7FBFF">
	<td height="26" align="center" width="50"></td>
	  <td>今日新帖：<%=new_count%></td>
	  <td>会员总数：<%=per_count%></td>
	  <td>帖子总数：<%=post_count%></td>
	  <td>主题总数：<%=main_post_count%></td>
	  <td>回复总数：<%=hf_post_count%></td> 
	</tr>
<%
if(!new_count.equals("0"))
{
	String fid[] = new String [20];
	String fname[] = new String [20];
	sql = "select fm_name,fm_id from forum_board order by fm_id";
	rs=stmt.executeQuery(sql);
	short s = 0;
	while(rs.next()){
		fid[s] = rs.getString("fm_id");
		fname[s] = rs.getString("fm_name");
		s++;			
	}

	for(short m=1;m<=s;m++)
	{
		if(m%5==1)
		{
			out.print("<tr bgcolor=\"#F7FBFF\"><td height=\"26\" width=\"50\"></td><td>");				
		}
		else
		{
			out.print("<td>");
		}
		out.print("<a href=\"board.jsp?fid="+fid[m-1]+"\">");
		out.print(fname[m-1]+"：");
		sql = "select count(post_id) as newcount from forum_post where post_board_id='"+fid[m-1]+"' and post_date >= to_date('"+ul_time+" 00:00:00','yyyy-mm-dd hh24:mi:ss') and post_date <= to_date('"+ul_time+" 23:59:59','yyyy-mm-dd hh24:mi:ss')";
		rs=stmt.executeQuery(sql);
		if(rs.next())
		{
			out.print(rs.getString("newcount"));
		}
		out.print("</a>&nbsp;&nbsp;");
		out.print(m%5==0 ? "</td></tr>" : "</td>");			
	}
	if(s>0&& s%5!=0)
	{
		for(int x=0;x<5-(s%5);x++)
		{
			if(x==(5-(s%5)))
				out.print("<td></td></tr>");
			else
				out.print("<td></td>");
		}
	}
}
%>
</table>
