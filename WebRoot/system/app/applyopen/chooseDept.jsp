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
	String sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_infoopendept = 1 order by dt_sequence";
	//out.print(sqlStr);
	//if(true)return;
	Vector vPage = dImpl.splitPage(sqlStr,130,1);
	if(vPage!=null){
		for(int i=0; i<vPage.size(); i++){
			Hashtable content = (Hashtable)vPage.get(i);
			out.println("<td width=\"25%\"><input name=did type=radio value="+content.get("dt_id").toString()+">"+content.get("dt_name").toString()+"</td>");
			if((i+1)%4==0) out.println("</tr>");
			//out.println("<option value=\""+content.get("dt_id").toString()+"\">"+content.get("dt_name").toString()+"</option>");
		}
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