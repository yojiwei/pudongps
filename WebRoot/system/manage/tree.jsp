<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.sql.*" %>
<%
  try // 数据库联接
  {
    Driver myDriver = (Driver)   Class.forName("weblogic.jdbc.pool.Driver").newInstance();
    Connection conn =   myDriver.connect("jdbc:weblogic:pool:test", null);
    out.println(conn.toString() );
    out.println("OK");
    conn.close();
  }
  catch (Exception ex)
  {
    out.println(ex.toString() );
  }
%>
