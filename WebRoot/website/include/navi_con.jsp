<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
//Update 20061231
//申明变量
CDataCn dCn = null;
CDataImpl dImpl = null;

Vector vPage = null;
Hashtable content = null;
String sqlStr = "";

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

sqlStr = "select s1.sj_id,s1.sj_dir,s1.sj_name,s1.sj_url from tb_subject s1,tb_subject s2 where s1.sj_parentid = s2.sj_id and s2.sj_dir='shpd' and s1.sj_display_flag = 0 order by s1.sj_sequence";
vPage = dImpl.splitPageOpt(sqlStr,request,15);
out.println("function go(){");
out.println("this._a=new Array(");
if(vPage!=null)
{
	for(int i=0;i<vPage.size();i++)
	{
		content = (Hashtable)vPage.get(i);	out.println("\""+content.get("sj_name").toString()+","+content.get("sj_dir").toString()+","+content.get("sj_url").toString()+"\"");
		out.println(",");
	}
}
out.println("\"返回首页,index,/website/index.jsp\");");
out.println("this._b = window.location.href;");
out.println("this._c = document.getElementById(\"navi\");");
out.println("this._d = \"\";}");
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
