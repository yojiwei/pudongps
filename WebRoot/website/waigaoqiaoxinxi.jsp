<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%

out.println("-------------------------------------start-------------");

try{
  
	WGQMessageReceive fetchMail  = new WGQMessageReceive();
	  Calendar calendar = Calendar.getInstance();
	  calendar.set(Calendar.MONTH,6);
	  calendar.set(Calendar.DAY_OF_MONTH,13);
	  //从7月29号到9月4号的信息抓取
	  Calendar calendar1 = Calendar.getInstance();
	  calendar1.set(Calendar.MONTH,6);
	  calendar1.set(Calendar.DAY_OF_MONTH,28);
	  //calendar.set();
	  String dayStr = getTodayStr(calendar);
	  while(!calendar.after(calendar1)){
		  fetchMail.receiveWGQ(dayStr);
		  calendar.add(Calendar.DAY_OF_MONTH,1);
		  dayStr = getTodayStr(calendar);
	  }
out.println("-------------------------------------end-------------");

}catch(Exception testexp){
	out.println(testexp.printStackTrace());
}finally{
	dImpl.closeSmtp();
	dCn.closeCn();
}