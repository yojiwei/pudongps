<%@ include file="/website/include/import.jsp" %>
<ul>
<%
	String id=request.getParameter("id");
	if(id==null) id="0";


	CDataCn dCn = null;
	CDataImpl dImpl = null;

	String sqlStr = "";
	ResultSet rs = null;
	Hashtable content = null;

	try {
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		String sql="";
		String sql1="";
		
		CRoleAccess ado=new CRoleAccess(dCn);
		CMySelf self = (CMySelf)session.getAttribute("mySelf");
		String user_id = String.valueOf(self.getMyID());
		if(!ado.isAdmin(user_id))
		{
			sql1=CTools.dealNull(session.getAttribute("_InfoSubjectIdsInfo"));
			if(sql1.equals(""))
			{
					sql1=ado.getAccessSqlByUser(user_id,ado.ColumnAccess);
					session.setAttribute("_InfoSubjectIdsInfo",sql1);
			}
		}
		sql="select sj_sequence,sj_id,sj_name,sj_parentid,sj_url,sj_dir,sj_lastid,(select count(sj_id) from tb_subject where sj_parentid=a.sj_id " +sql1+") as sj_child from(select sj_sequence,sj_id,sj_name,sj_parentid,sj_url,sj_dir,(select * from(select sj_id from tb_subject where sj_parentid="+id+"  "+sql1+" order by sj_sequence desc,sj_id asc)where rownum=1)  as  sj_lastid from tb_subject where sj_parentid="+id+" "+sql1+" ) a order by sj_sequence,sj_id desc ";

		rs = dImpl.executeQuery(sql);	
		while(rs.next())
		{
			int sj_id=rs.getInt("sj_id");
			String sj_name=rs.getString("sj_name");
			String sj_parentid=rs.getString("sj_parentid");
			String sj_url=rs.getString("sj_url");
			String sj_dir=rs.getString("sj_dir");
			int sj_lastid=rs.getInt("sj_lastid"); //同一级别的第一个id
			int sj_child=rs.getInt("sj_child"); //是否有子节点

			//edit by phayzy 2008-10-10
			if(sj_dir!=null){
				if(sj_dir.equals("newgovOpen_BMXXGK")||sj_dir.equals("affairUpdate_new")) sj_name = "<font color='red'>" + sj_name + "</font>";
			}
			//end

			if (sj_id==sj_lastid){
				if (sj_child>0){
					out.println("<li><img id='p"+sj_id+"' src=\"../../common/tree/images/lastclosed.gif\" onclick=\"DivDisplay2('c"+sj_id+"','"+sj_id+"','p"+sj_id+"','f"+ sj_id +"')\" style=\"cursor : hand;\" align=\"absmiddle\">");
					out.println("<img src=\"../../common/tree/images/folder.gif\" align=\"absmiddle\" id='f"+ sj_id +"' /> <span id='s"+ sj_id +"'  onclick=\"BrowseRight("+ sj_id +")\" ondblclick=\"DivDisplay2('c"+sj_id+"','"+sj_id+"','p"+sj_id+"','f"+ sj_id +"')\">"+ sj_name +"</span>");
				}
				else
				{
					out.println("<li><img id='p"+ sj_id +"' src=\"../../common/tree/images/lastnochild.gif\" align=\"absmiddle\" />");
					out.println("<img src=\"../../common/tree/images/folder.gif\" align=\"absmiddle\" id='f"+ sj_id +"' /> <span id='s"+ sj_id +"'  onclick=\"BrowseRight("+ sj_id +")\">"+ sj_name +"</span>");
				}
			}
			else
			{
				if (sj_child>0){
					out.println("<li><img id='p"+sj_id+"' src=\"../../common/tree/images/closed.gif\" onclick=\"DivDisplay('c"+sj_id+"','"+sj_id+"','p"+sj_id+"','f"+ sj_id +"')\" style=\"cursor : hand;\" align=\"absmiddle\">");
					out.println("<img src=\"../../common/tree/images/folder.gif\" align=\"absmiddle\" id='f"+ sj_id +"' /> <span id='s"+ sj_id +"'  onclick=\"BrowseRight("+ sj_id +")\" ondblclick=\"DivDisplay('c"+sj_id+"','"+sj_id+"','p"+sj_id+"','f"+ sj_id +"')\">"+ sj_name +"</span>");
				}
				else
				{
					out.println("<li><img id='p"+ sj_id +"' src=\"../../common/tree/images/nofollow2.gif\" align=\"absmiddle\" />");
					out.println("<img src=\"../../common/tree/images/folder.gif\" align=\"absmiddle\" id='f"+ sj_id +"' /> <span id='s"+ sj_id +"'  onclick=\"BrowseRight("+ sj_id +")\">"+ sj_name +"</span>");
				}
			}

			if (sj_id==sj_lastid){
				out.println("<div id='c"+sj_id+"' style='display:none;'></div>");
			}
			else
			{
				out.println("<div id='c"+sj_id+"' style='display:none;' class=\"childdiv\"></div>");
			}

			out.println("</li>"+"\r\n");
		}
		rs.close();
	}
	catch(Exception e){
		out.print(e.toString());
	}
	finally{
		dImpl.closeStmt();
		dCn.closeCn();
	}
%>
</ul>