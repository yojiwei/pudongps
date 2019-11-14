<%@page contentType="text/html; charset=GBK"%>
<%@ page import="org.apache.commons.lang.StringUtils.*" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String sort_id = " ";
	String setSequence="";

	
	String sqlStr="";
Hashtable content=null;
Vector vPage=null;
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn); 
		dCn.beginTrans();//事务开始
sqlStr="select sort_id from forum_sort order by sort_sequence,SORT_ID";
vPage = dImpl.splitPage(sqlStr,request,100);
if(vPage!=null)
			{
			 for(int i=0;i<vPage.size();i++)
							{
									 content = (Hashtable)vPage.get(i);							
									 sort_id = content.get("sort_id").toString(); 
									 dImpl.edit("forum_sort","sort_id",sort_id);
									setSequence=CTools.dealString(request.getParameter(sort_id));				
									 dImpl.setValue("sort_sequence",setSequence,CDataImpl.STRING);
									dImpl.update();
							}
			}
				if("".equals(dCn.getLastErrString()))
			{
				dCn.commitTrans();	
	%>
				<script language="javascript">						
					window.location="sortList.jsp";
				</script>
	<%
			}else{
				dCn.rollbackTrans();
	%>
				<script language="javascript"  >
					alert("发生错误，修改失败");
					window.history.go(-1);
				</script>
	<%
			}
			
	}catch(Exception e){
		out.print(e.toString());
	}finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
	}
%> 