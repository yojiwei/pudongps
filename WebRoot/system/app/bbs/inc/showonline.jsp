<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*"  %>
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
<%! String sql_online,Time_Str,User_List,Guest_List,UserName;
    long Online_Time;
    int Guest_Num,User_Num;
%>
<%
 Guest_List="";
 User_List="";
 
 Connection con=yy.getConn();
 Statement  stmt_online=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
 ResultSet rs_online=null;


  sql_online="select * from forum_online where ol_id='"+session.getId()+"'";
 
  rs_online=stmt_online.executeQuery(sql_online);

  rs_online.last();
  if (rs_online.getRow()>0)
  {
	  if (session.getValue("UserName")==null)
	  sql_online="update forum_online set ol_end_time=to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),ol_last_time='"+DateToString()+"' where ol_id='"+session.getId()+"'";
	  else
	  sql_online="update forum_online set ol_name='"+session.getValue("UserName")+"',ol_end_time=to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),ol_last_time='"+DateToString()+"' where ol_id='"+session.getId()+"'";


	  stmt_online.executeUpdate(sql_online);
  }
  else
  {
	sql_online="insert into forum_online(ol_id,ol_name,ol_begin_time,ol_end_time,ol_last_time,ol_ip) ";

	if (session.getValue("UserName")==null)
	sql_online=sql_online+" values('"+session.getId()+"','客人',to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),'"+DateToString()+"','"+request.getRemoteAddr()+"')";
	else
	sql_online=sql_online+" values('"+session.getId()+"','"+session.getValue("UserName")+"',to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),to_date('"+yy.getTime()+"','YYYY-MM-DD HH24:MI:SS'),'"+DateToString()+"','"+request.getRemoteAddr()+"')";

	stmt_online.executeUpdate(sql_online);

  }

  Time_Str=DateToString();
  Online_Time=Integer.parseInt(Time_Str);;
  Online_Time=Online_Time-60;
  sql_online="delete from forum_online where ol_last_time<'"+Online_Time+"'";
  stmt_online.executeUpdate(sql_online);
  
  
  
  //out.println(Online_Time);
  sql_online="select ol_name,ur_realname from forum_online f,userinfo u where ol_name<>'客人' and ur_loginname=ol_name order by ol_last_time desc";
  rs_online=stmt_online.executeQuery(sql_online);
  User_Num = 0;
  while(rs_online.next()){
	User_Num+=1;
	UserName=rs_online.getString("ur_realname");
	User_List=User_List+"<!--<a href=member.jsp?member="+UserName+">-->"+UserName+"<!--</a>-->&nbsp;&nbsp";

  }
 sql_online="select ol_name from forum_online where ol_name='客人' order by ol_last_time desc";
  rs_online=stmt_online.executeQuery(sql_online);
  Guest_Num=0;
  while(rs_online.next()){
  	Guest_Num+=1;
	    Guest_List=Guest_List+"客人&nbsp;&nbsp";

  }



%>
		<tr bgcolor="#e9e9e9">
          <td colspan="7"  style="line-height:20px"><b><font color="#333399">在线人员
            - 目前有 <%=Guest_Num%> 位游客和 <%=User_Num%> 位会员在线</font></b></td>
        </tr>
        <tr bgcolor="#F7FBFF">
          <td align="center" style="line-height:20px" width="15"><img src="image/pmlogin.gif" width="14" height="15"></td>
          <td colspan="6" style="line-height:20px"><%=User_List%><%=Guest_List%></td>
    </tr>