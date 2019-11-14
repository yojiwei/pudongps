<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;

String sqlStr = "";
Hashtable content = null;
Vector vPage = null;
String st = "";
String sv = "";
sv = "0,所有分类;";
st = CTools.dealString(request.getParameter("st")).trim();
try {
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	
	switch(Integer.parseInt(st)) {
		case 1://按部门
			//sqlStr = "select dt_name as name,dt_id as id from tb_deptinfo";
			sqlStr = "select d.dt_name as name,d.dt_id as id from tb_deptinfo d,(select dt_idext from tb_proceeding group by dt_idext) p where d.dt_iswork=1 and d.dt_id = p.dt_idext order by id";
			break;
		case 2://按办事分类
			sqlStr = "select sw_name as name,sw_id as id from tb_sortwork order by sw_sequence";
			break;
	}
	sqlStr = "select sw_name as name,sw_id as id from tb_sortwork order by sw_sequence";
	vPage = dImpl.splitPage(sqlStr,request,200);
	if(vPage!=null) {
		for(int i=0;i<vPage.size();i++) {
			content = (Hashtable)vPage.get(i);
			sv += content.get("id").toString() + "," + content.get("name").toString();
			if((i+1)!=vPage.size()) sv += ";";
		}
	}
	out.println(sv);
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