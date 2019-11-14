<%@include file="/website/include/import.jsp"%>
<%@page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*"%>
<jsp:useBean id="yy" scope="page" class="yy.jdbc"/>
<%!String User_Name,User_Password,User_Password1,sql,User_Sex,User_Email,User_Address,User_Mobile,User_Oicq,User_Year,User_Month,User_Day,User_Birthday,User_Icon,User_Sign;%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 



User_Name=request.getParameter("name");
//User_Name=yy.ex_chinese(User_Name);
User_Password=request.getParameter("password");
//User_Password=yy.ex_chinese(User_Password);
User_Password1=request.getParameter("password2");
//User_Password1=yy.ex_chinese(User_Password1);
User_Sex=request.getParameter("sex");
//User_Sex=yy.ex_chinese(User_Sex);
User_Email=request.getParameter("email");
User_Address=request.getParameter("address");
//User_Address=yy.ex_chinese(User_Address);
User_Mobile=request.getParameter("mobile");
User_Oicq=request.getParameter("ur_oicq");
User_Year=request.getParameter("year");
User_Month=request.getParameter("month");
User_Day=request.getParameter("day");
User_Icon=request.getParameter("icon");
User_Sign=request.getParameter("sign");
//User_Sign=yy.ex_chinese(User_Sign);

if (User_Year.equals(""))
{
   if ((User_Month.equals(""))&&(User_Day.equals("")))
      User_Birthday="保密";
   else
	  User_Birthday=User_Month+"月"+User_Day+"日";
}else
{
  if ((User_Month.equals(""))&&(User_Day.equals("")))
     User_Birthday="保密";
  else
     User_Birthday=User_Year+"年"+User_Month+"月"+User_Day+"日";
}

//User_Birthday=yy.ex_chinese(User_Birthday);

if (User_Email.equals(""))
{
  response.sendRedirect("err.jsp?id=11");
  return;
}else
{

}

if (!User_Password.equals(User_Password1))
{
response.sendRedirect("err.jsp?id=9");
return;
}
if ((User_Password.length()<5)||(User_Password.length()>12))
{
response.sendRedirect("err.jsp?id=10");
return;
}

if ((User_Name.indexOf("'")>0)||(User_Name.indexOf(" ")>0)||(User_Name.indexOf("@")>0)||(User_Name.indexOf("=")>0)||(User_Name.indexOf("%")>0))
{
response.sendRedirect("err.jsp?id=12");
return;
}


if ((User_Email.indexOf("@")<0)||(User_Email.indexOf(".")<0))
{
response.sendRedirect("err.jsp?id=13");
return;
}


Connection con=yy.getConn();
Statement  stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet  rs=null;
sql="select * from USERINFO where ur_loginname='"+User_Name+"'";
rs=stmt.executeQuery(sql);
rs.last();
//out.println(sql);
if (rs.getRow()>0)
{
   response.sendRedirect("err.jsp?id=3");
}else
{


	String count = "0";
	String  viscount = "1";
	dImpl.setTableName("USERINFO");
	dImpl.setPrimaryFieldName("ur_id");
	dImpl.addNew();
	//dImpl.setValue("us_id",us_id,CDataImpl.STRING);
	dImpl.setValue("ur_loginname",User_Name,CDataImpl.STRING);
	dImpl.setValue("ur_password",User_Password,CDataImpl.STRING);
	dImpl.setValue("ur_sex","男",CDataImpl.STRING);
	dImpl.setValue("ur_email",User_Email,CDataImpl.STRING);
	dImpl.setValue("ur_address",User_Address,CDataImpl.STRING);
	dImpl.setValue("mobilephone",User_Mobile,CDataImpl.STRING);
	dImpl.setValue("ur_oicq",User_Oicq,CDataImpl.STRING);
	dImpl.setValue("ur_birthday",User_Birthday,CDataImpl.STRING);
	dImpl.setValue("ur_portrait",User_Icon,CDataImpl.STRING);
	dImpl.setValue("ur_sign",User_Sign,CDataImpl.STRING);
	dImpl.setValue("ur_post_count","0",CDataImpl.INT);
	dImpl.setValue("ur_visit_count","1",CDataImpl.INT);
	dImpl.setValue("ur_grade","新手上路",CDataImpl.STRING);
	dImpl.setValue("ur_sign_date",yy.getTime(),CDataImpl.DATE);	
	dImpl.update();

dImpl.closeStmt();
  dCn.closeCn();

session.putValue("UserName",User_Name);

session.putValue("UserLevel","新手上路");
//out.println(session.getValue("UserName"));
out.println("<font size=2 color=blue>谢谢您的注册，正在处理您的用户信息，稍后会自动登陆...</font><meta http-equiv='refresh' content='2;url=index.jsp'>");

}

%>
<jsp:include page="inc/online.jsp" flush="true"/>


<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}

%>
