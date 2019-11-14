package yy;
import java.io.*;
import java.sql.*;
public class jdbc {

  public jdbc() {
  }
 Connection conn = null ;
 //String re = "" ;
 //设置你的数据库ip
 //String dbip = "127.0.0.1" ;
 //设置你的数据库用户名和密码：
 //String use = "" ;
 //String pass = "" ;
  public java.sql.Connection getConn(){
    try{
     Class.forName("sun.jdbc.odbc.JdbcOdbcDriver").newInstance();
     //String url ="jdbc:mysql://"+dbip+":3306/"+use+"?user="+use+"&password="+pass+"&useUnicode=true&characterEncoding=gb2312" ;
     conn= DriverManager.getConnection("jdbc:odbc:yyForum","xyworker","999");
     ///Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	
	}
    catch(Exception e){
    e.printStackTrace();
    System.out.println("LICHAO");
    }
    return this.conn ;
  }

  public String ex_chinese(String str){
     if(str==null){
     str  ="" ;
     }
     else{
         try {
        str = new String(str.getBytes("iso-8859-1"),"gb2312") ;
         }
         catch (Exception ex) {
         }
     }
     return str ;
  }

 public String getTime() {
    String datestr =  "" ;
    try {
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-M-d HH:ss") ;
    java.util.Date date = new java.util.Date() ;
    datestr = df.format(new java.util.Date()) ;
    }
    catch (Exception ex) {
    }
    return datestr ;
  }
}