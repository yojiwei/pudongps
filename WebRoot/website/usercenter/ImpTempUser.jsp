<%@include file="/website/include/import.jsp"%>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 

String userUid = "";
String userPwd = "";
String userKind = "";
String webSite = "";
String sqlStr = "";
String userIsTemp = "1";
Hashtable content = null;
int numeral1 = 0; //用于生成临时用户

//String sqlStr = "select uk_id from tb_userkind where uk_id in";
//sqlStr += " (select b.uk_id from tb_proceeding a,tb_commonwork b where a.pr_id='"+pr_id+"' and a.cw_id=b.cw_id)";


CDataImpl imp_dImpl = new CDataImpl(dCn);

//Hashtable content = imp_dImpl.getDataInfo(sqlStr);
//if(content!=null)
//{
//	userKind = content.get("uk_id").toString();
//}
userKind = "o1"; 
sqlStr = "select ws_id from tb_website where ws_name='上海浦东'";
content = imp_dImpl.getDataInfo(sqlStr);
if(content!=null)
{
	webSite = content.get("ws_id").toString();
}
CDate imp_oDate = new CDate();
String imp_sToday = imp_oDate.getThisday();

numeral1 =(int)(Math.random()*100000);
userUid = "user" + imp_sToday + Integer.toString(numeral1);
userPwd = Integer.toString((int)(Math.random()*100000));

User us = new User(dCn);
us.setAddress(address);
us.setIstemp(userIsTemp);
us.setPwd(userPwd);
us.setTel(tel);
us.setUid(userUid);
us.setActiveFlag(1);
us.setUserKind(userKind);
us.setUserName(userName);
us.setIdCardNumber(IdCard);
us.setWsid(webSite);
us.setZip(zipcode);
us.newUser();

user = new User(dCn); //新建用户登陆对象
boolean b = user.login(userUid,userPwd,webSite);
session.setAttribute("user",user);

imp_dImpl.closeStmt();

}
catch(Exception e){
//e.printStackTrace();
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}

%>
<script language="javascript">
window.open("/website/usercenter/UserDetail.jsp?uid=<%=userUid%>&pwd=<%=userPwd%>","user","width=450px,height=250px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
</script>