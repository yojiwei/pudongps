<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

String id = CTools.dealString(request.getParameter("id")).trim();
String sj_acdid = "";
String sj_copytoid = "";
String sj_ids = "";


String sj_id = "";
String sj_name = "";
String sj_dir = "";
String strs = "";

Vector vect = null;
Hashtable content = null;

String sql = "select sj_acdid,sj_copytoid from tb_subject where sj_id = " + id;
content = dImpl.getDataInfo(sql);
if (content != null) {
	sj_acdid = content.get("sj_acdid").toString();
	sj_copytoid = content.get("sj_copytoid").toString();
}
if ("".equals(sj_acdid) && "".equals(sj_copytoid)) {
	out.print("no");
}
else {
	content = null;
	if (!"".equals(sj_acdid)) {
		sj_ids += "," + sj_acdid;
	}
	if (!"".equals(sj_copytoid)) {
		sj_ids += sj_copytoid.substring(0,sj_copytoid.length()-1);
	}
	//sql = "select sj_id,sj_acdid,sj_name,sj_dir from tb_subject where sj_id = " + sj_acdid;
	sql = "select sj_id,sj_name,sj_dir from tb_subject where sj_id in ("+ sj_ids.substring(1,sj_ids.length()) +")";
	vect = dImpl.splitPage(sql,20,1);
	if (vect != null) {
		int vsize = vect.size();
		for (int k=0;k<vsize;k++) {
			content = (Hashtable)vect.get(k);
			sj_id = content.get("sj_id").toString();
			sj_name = content.get("sj_name").toString();
			sj_dir = content.get("sj_dir").toString();
			strs += sj_name + ",sj_dir=" + sj_dir + ",sj_id=" + sj_id + "##";
		}
	}
		out.print("yes");
		out.print("<br>");
		out.print(strs);
}
dImpl.closeStmt();
dCn.closeCn();

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