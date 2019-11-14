<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"%>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>

<%!
  String  DateToString(){
	  String str;
	  //int i,j;
	  java.util.Date date = new java.util.Date();
	  str=String.valueOf(date.getTime());
	  //i=str.length();
	  //j=i-9;
	  str=str.substring(0,9);
	  return str;
  }
%>
<%! String sql,Time_Str,User_List,Guest_List,UserName;
    long Online_Time;
    int Guest_Num,User_Num;
%>
<%
 Guest_List="";
 User_List="";
 
 Connection con=yy.getConn();
 Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs=null;


  sql="select * from forum_online where ol_id='"+session.getId()+"'";
  rs=stmt.executeQuery(sql);
  rs.last();
  if (rs.getRow()>0)
	  {
  if (session.getValue("UserName")==null)
  sql="update forum_online set ol_end_time=to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),ol_last_time='"+DateToString()+"' where ol_id='"+session.getId()+"'";
  else
  sql="update forum_online set ol_name='"+session.getValue("UserName")+"',ol_end_time=to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),ol_last_time='"+DateToString()+"' where ol_id='"+session.getId()+"'";
  stmt.executeUpdate(sql);
  }else
	  {
  sql="insert into forum_online(ol_id,ol_name,ol_begin_time,ol_end_time,ol_last_time,ol_ip) ";

  if (session.getValue("UserName")==null)
  sql=sql+" values('"+session.getId()+"','øÕ»À',To_Date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),'"+DateToString()+"','"+request.getRemoteAddr()+"')";

  else
  sql=sql+" values('"+session.getId()+"','"+session.getValue("UserName")+"',To_Date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),'"+DateToString()+"','"+request.getRemoteAddr()+"')";
  //out.println(sql);
  stmt.executeUpdate(sql);
  
  }

  Time_Str=DateToString();
  Online_Time=Integer.parseInt(Time_Str);;
  Online_Time=Online_Time-60;
  sql="delete from forum_online where ol_last_time<'"+Online_Time+"'";
  stmt.executeUpdate(sql);
    try {
		
		rs.close();
		stmt.close();
		con.close();
		}
		     catch (Exception ex) {
         }
%>