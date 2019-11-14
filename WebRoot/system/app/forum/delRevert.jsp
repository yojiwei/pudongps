<%@page contentType="text/html; charset=GBK"%>
<%@ page import="org.apache.commons.lang.StringUtils.*" %>
<%@include file="/system/app/skin/head.jsp"%>
<%
	String revert_id = " ";
	String post_id = " ";
	String strPage = CTools.dealString(request.getParameter("strPage")).trim();    //当前页
	String strSql="";
	String sqlStr="";
	String sort_id = CTools.dealString(request.getParameter("sort_id")).trim(); 
	String board_id = CTools.dealString(request.getParameter("board_id")).trim(); 
	revert_id = CTools.dealString(request.getParameter("revert_id")).trim(); 
	post_id = CTools.dealString(request.getParameter("post_id")).trim(); 
	strPage = CTools.dealString(request.getParameter("strPage")).trim(); 

String post_revert_count="";//forum_post_pd中的跟贴数

Hashtable content=null;
Vector vPage=null;
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn); 

sqlStr="select count(*) as total from forum_revert where post_id="+post_id;
vPage = dImpl.splitPage(sqlStr,request,1);
if(vPage!=null)
	{
     for(int i=0;i<vPage.size();i++)
					{
							 content = (Hashtable)vPage.get(i);							
							 post_revert_count = content.get("total").toString();
					}
}

if(post_revert_count.equals(null)||post_revert_count.equals("")||post_revert_count.equals("0"))
			  {
			post_revert_count ="0";	
			  }
			else{
			post_revert_count = String.valueOf(Integer.parseInt(post_revert_count)-1);	
			    }

		
		dCn.beginTrans();//事务开始
		//主表保存
		//回复后更新主题
dImpl.edit("forum_post_pd","post_id",post_id);
dImpl.setValue("post_revert_count",post_revert_count,CDataImpl.STRING);//更forum_post_pd表中的话题的跟贴数
dImpl.update();


		if(!"".equals(revert_id)){
			strSql = "delete from forum_revert where revert_id = " + revert_id;
			dImpl.executeUpdate(strSql);


			if("".equals(dCn.getLastErrString())){
				dCn.commitTrans();	
	%>
				<script language="javascript">						
					window.location="revertList.jsp?strPage=<%=strPage%>&sort_id=<%=sort_id%>&board_id=<%=board_id%>&post_id=<%=post_id%>";
				</script>
	<%
			}else{
				dCn.rollbackTrans();
	%>
				<script language="javascript"  >
					alert("发生错误，删除失败");
					window.history.go(-1);
				</script>
	<%
			}
		}	
	}catch(Exception e){
		//e.printStackTrace();
		out.print(e.toString());
	}finally{
		dImpl.closeStmt();
		dCn.closeCn(); 
	}
%> 