<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
		String title,bbs_content,stype,face,uiname,writetime,strSql,sequence,bc_sequence;
		String bcid,child,px;
		title=CTools.dealString(request.getParameter("title")).trim();
		bbs_content=CTools.dealString(request.getParameter("bbs_content"));
		stype=CTools.dealNumber(request.getParameter("stype"));
		face=CTools.dealString(request.getParameter("face"));
		uiname=CTools.dealString(request.getParameter("uiname"));
		writetime=(new java.util.Date()).toLocaleString();
		////////////////////////////
		bcid=CTools.dealNumber(request.getParameter("bcid"))		;
		child=CTools.dealNumber(request.getParameter("child"));
		px=CTools.dealNumber(request.getParameter("sequence"));

	if(bcid.equals("0"))
	{
		strSql="select min(bc_sequence) as sequence from tb_bbscontent where bc_type="+stype;
		Hashtable content = dImpl.getDataInfo(strSql);
		sequence=content.get("sequence").toString();
		if(sequence.equals(""))
		{
			bc_sequence="99999";
		}
		else
		{
			bc_sequence=Integer.toString(Integer.parseInt(sequence)-1);
		}
		//out.print(bc_sequence);
		dImpl.addNew("tb_bbscontent","bc_id");
			dImpl.setValue("bc_parentid","0",CDataImpl.STRING);
			
	}
	else		//回复文章
	{
		int childlen=child.length();
		for(int i=1;i<=3-childlen;i++)
		{
			child="0"+child;
		}
		bc_sequence=px+child;

		strSql="update tb_bbscontent set bc_child=bc_child+1 where bc_id="+bcid;
		dImpl.executeUpdate(strSql);//父级别的child加1

		dImpl.addNew("tb_bbscontent","bc_id");
		dImpl.setValue("bc_parentid",bcid,CDataImpl.STRING);	
	}
			
			dImpl.setValue("bc_title",title,CDataImpl.STRING);
			dImpl.setValue("bc_face",face,CDataImpl.STRING);
			dImpl.setValue("bc_user",uiname,CDataImpl.STRING);
			dImpl.setValue("bc_userflag","1",CDataImpl.INT);
			dImpl.setValue("bc_type",stype,CDataImpl.INT);
			dImpl.setValue("bc_child","0",CDataImpl.INT);
			dImpl.setValue("bc_hit","0",CDataImpl.INT);
			dImpl.setValue("bc_writetime",writetime,CDataImpl.DATE);
			dImpl.setValue("bc_content",bbs_content,CDataImpl.SLONG);
			dImpl.setValue("bc_sequence",bc_sequence,CDataImpl.STRING);

	  dImpl.update() ;

		dImpl.closeStmt();
		dCn.closeCn();
		response.sendRedirect("bbscontentDetail.jsp?stype="+stype);
		
%>
<%


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
