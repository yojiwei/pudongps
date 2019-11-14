<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/system/app/skin/import.jsp"%>
<table width=100% border=0>
<tr>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;

try{
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	String key = CTools.dealString(request.getParameter("key")).trim();
	String sqlWhere = "";
	if(!key.equals("")) sqlWhere += " and f.dfunction like '%"+key+"%'";
	String sqlStr = "select d.dt_id,d.dt_name from tb_deptinfo d,deptfunction f where d.dt_id = f.did and d.dt_infoopendept = 1"+sqlWhere+" order by d.dt_id";
	Vector vPage = dImpl.splitPage(sqlStr,30,1);
	if(vPage!=null){
		for(int i=0; i<vPage.size(); i++){
			Hashtable content = (Hashtable)vPage.get(i);
			out.println("<td><input name=did type=radio value="+content.get("dt_id").toString()+">"+content.get("dt_name").toString()+"</td>");
			if((i+1)%4==0) out.println("</tr>");
			//out.println("<option value=\""+content.get("dt_id").toString()+"\">"+content.get("dt_name").toString()+"</option>");
		}
	}else{
		out.println("<td>没有检索到符合条件的记录！</td></tr>");
	}
}
catch(Exception e){
	out.print(e.toString());
}finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
</table>