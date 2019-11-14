<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>

<script language="javascript">
var parentform = parent.document.formData;
var parentein = parent.document.all.einfo;
var parentpin = parent.document.all.pinfo;
</script>

<%
CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String userSql = "";
String uk_id = "";
String us_id = "";
String pcardnum = "";
String us_name = "";
String us_tel = "";
String us_cellphonenumber = "";
String us_address = "";
String us_zip = "";
String us_email = "";

String ecSql = "";
String ename = ""; //企业名称
String ec_corporation = ""; //法人代表
String ec_mgr = ""; //联系人姓名
String ec_linkman = ""; //联系人电话
String ec_email = ""; //联系人电子邮箱

pcardnum = CTools.dealString(request.getParameter("pcardnum")).trim();
ename = CTools.dealString(request.getParameter("ename")).trim();
if (!"".equals(pcardnum)) {
  userSql = "select us_name,us_tel,us_cellphonenumber,us_address,us_zip,us_email from tb_user where us_idcardnumber = '" + pcardnum + "'";
  Hashtable userContent = dImpl.getDataInfo(userSql);
  if (userContent != null) {
    us_name = userContent.get("us_name").toString();
    us_tel = userContent.get("us_tel").toString();
    us_cellphonenumber = userContent.get("us_cellphonenumber").toString();
    us_address = userContent.get("us_address").toString();
    us_zip = userContent.get("us_zip").toString();
    us_email = userContent.get("us_email").toString();
%>
<script language="javascript">
parentform.proposer[0].checked = true;
parentein.style.display = "none";
parentpin.style.display = "";

parentform.pcard.value = "身份证";
parentform.pname.value = "<%=us_name%>";
parentform.ptele1.value = "<%=us_tel%>";
parentform.ptele2.value = "<%=us_cellphonenumber%>";
parentform.paddress.value = "<%=us_address%>";
parentform.pzipcode.value = "<%=us_zip%>";
parentform.pemail.value = "<%=us_email%>";
</script>
<%
  }
else {
	  out.println("<script language=\"javascript\">alert(\"很抱歉，在门户网站中未能找到该用户！\");parent.document.formData.pcardnumCheck.focus();</script>");
  }
%>
<script language="javascript">
parentform.pcardnum.value = "<%=pcardnum%>";
</script>
<%
}


if (!"".equals(ename)) {
	ecSql = "select ec_corporation,ec_mgr,ec_linkman,ec_email from tb_enterpvisc where ec_name = '"+ ename +"'";
	Hashtable ecContent = dImpl.getDataInfo(ecSql);
  if (ecContent != null)
  {
    ec_corporation = ecContent.get("ec_corporation").toString();
    ec_mgr = ecContent.get("ec_mgr").toString();
    ec_linkman = ecContent.get("ec_linkman").toString();
    ec_email = ecContent.get("ec_email").toString();
%>
<script language="javascript">
parentform.proposer[1].checked = true;
parentpin.style.display = "none";
parentein.style.display = "";

parentform.edeputy.value = "<%=ec_corporation%>";
parentform.elinkman.value = "<%=ec_mgr%>";
parentform.etele1.value = "<%=ec_linkman%>";
parentform.eemail.value = "<%=ec_email%>";
</script>
<%
  }
else {
	  out.println("<script language=\"javascript\">alert(\"很抱歉，在门户网站中未能找到该用户！\");parent.document.formData.pcardnumCheck.focus();</script>");
  }
%>
<script language="javascript">
parentform.ename.value = "<%=ename%>";
</script>
<%
}

//out.println(pcardnum);
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