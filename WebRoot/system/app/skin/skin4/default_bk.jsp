<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/islogin.jsp"%>
<%@ page import="com.component.database.*" %>
<%@ page import="com.component.treeview.*" %>
<%@ page import="com.platform.meta.*" %>
<%@ page import="com.platform.module.*" %>
<%@ page import="com.platform.subject.*" %>
<%@ page import="com.platform.user.*" %>
<%@ page import="com.platform.role.*" %>
<%@ page import="com.platform.log.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.util.CTools" %>
<%@ page import="com.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.app.CMySelf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%

CDataCn dCn = null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
try{
	dCn = new CDataCn(); //新建数据库连接对象
	dImpl = new CDataImpl(dCn); //新建数据接口对象
    CMySelf self = (CMySelf)session.getAttribute("mySelf");
    if(self==null)response.sendRedirect("login.jsp");
    String user_name = CTools.dealNull(String.valueOf(self.getMyName()));
    String user_dept =CTools.dealNull(String.valueOf(self.getDtId()));
		
		String sql="select dt_name from tb_deptinfo where dt_id=" + user_dept;
		String Module_name = "";
		Hashtable content1=dImpl.getDataInfo(sql);
		if(content1!=null){
		    Module_name=CTools.dealNull(content1.get("dt_name"));
		}

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>上海浦东网站后台管理系统 (Ver 3.0)--[<%=Module_name%>：<%=user_name%>]</title>
</head>

<script>
var y=100;
function expend(){
    main_frm.cols="145,25,*";
}
function close(){
    main_frm.cols="0,25,*";
}

function goUp(){
        y=y-100;
        if (y<=0) y=0;
        for (var I=y; I>=0; I--){
                window.nav.scroll(1,I);
  }
}
function goDown(){
        y=y+100;
        for (var I=1; I<=y; I++){
                window.nav.scroll(1,I);
  }

}
        function unloads()
        {
                PopupForm.navigate ("common/callcenter/clearUser.jsp");
        }


</script>
<frameset rows="109,*,25" frameborder="no" border="0" framespacing="0">
  <frame name="topFrame" src="top.jsp" scrolling="NO"/>
  <frameset name="main_frm" cols="145,25,*" frameborder="no" border="0" framespacing="0">
	<frame NAME="nav" src="left.jsp" scrolling="NO">
	<frame NAME="menu" src="function.jsp" scrolling="NO"  />
	<frame NAME="main" src="/system/app/navigator/todayaffair/AffairList.jsp?Menu=今日事务&Module=今日事务&SubMenuID=704" scrolling="auto"  />
  </frameset>
  <frame src="bottom.jsp" scrolling="NO" name="bottom"  />
</frameset>
<noframes><body>
</body>
</noframes></html>
<%}catch(Exception budex){
	
}finally{
	dImpl.closeStmt();
	dCn.closeCn();
} %>
