<%@page pageEncoding="GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%@page import="com.app.*,java.util.*,com.util.*"%>

<%
//update by yo 20090318
//session丢失处理
response.addHeader("P3P","CP=CAO PSA OUR");

CDataCn dCnYo = null;
com.app.CMySelf mySelfYo = (com.app.CMySelf)session.getAttribute("mySelf");
SimpleDateFormat fordate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String userYoUid = "";  //用户登录名
String userYoPas = "";  //用户密码
String userYoIp = "";   //用户的IP地址
String userYoTime = ""; //用户登录时间
String isYologin = CTools.dealString(request.getParameter("Naurl")).trim();  //得到.net的URL
String ClientYoIp = request.getRemoteAddr();                                 //得到客户端IP
String newYologin = "";                                                      //解密后URL
String [] isYoStr = null;

try{
dCnYo = new CDataCn();   	
 if(mySelfYo==null || !mySelfYo.isLogin()){ 	
		mySelfYo = new CMySelf(dCnYo); 

		//先解密
		if(!"".equals(isYologin)){
				char[] login = isYologin.toCharArray();
				for(int c=0;c<login.length;c++){
					newYologin +=""+(char)(login[c]-4);
				}
		
		  if(!"".equals(newYologin)){
				isYoStr = newYologin.split("");
			}
		
		  if(isYoStr.length>0&&isYoStr.length<=4){
				userYoUid  = isYoStr[0];
				userYoPas  = isYoStr[1];
				userYoIp   = isYoStr[2];
				userYoTime = isYoStr[3];
		  }
		  
	   System.out.println("--"+userYoUid+"----"+userYoPas+"--"+userYoIp+"-----"+userYoTime+"-+-"+ClientYoIp);

		  //时间,IP比较
	  	//if(userYoIp.equals(ClientYoIp)){
	       java.util.Date now = new java.util.Date();//现在的时间 
	       java.util.Date date=fordate.parse(userYoTime); //用户传过来的时间
	       long l=now.getTime()-date.getTime();
	       long day=l/(24*60*60*1000);
	       long hour=(l/(60*60*1000)-day*24);
	       long min=((l/(60*1000))-day*24*60-hour*60);
	       //是否区分大小写
	   			userYoUid = userYoUid.toLowerCase();
	   	 		//假登录 
	   	 		boolean b = mySelfYo.login(userYoUid,userYoPas);
	   	 		System.out.println(b+"-------------------------"+mySelfYo);
		   		if(b) {
   			  		session.setAttribute("mySelf",mySelfYo);
							session.setAttribute("skin","4");
		 		  }else{
		   				//out.println("<script>window.history.back();</script>");
		   				return;
					}
		  //}else{
		  	//out.println("<script>window.history.back();</script>");
		  //	return;
		  //}
		}else{
				out.print("<script>top.location.href='http://www.pudong.gov.cn/system/app';</script>");
				return;
		}
}
} catch (Exception ex) {
		System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
		if(mySelfYo != null)
		mySelfYo.closeStmt();
		if(dCnYo != null)
		dCnYo.closeCn();
}
%>