<%@ page language="java" pageEncoding="GBK"%> 
<%@include file="/website/include/import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<body>
<%
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
%>

<%
		String co_showflag= "1";
		String co_webname=new String(request.getParameter("co_webname").getBytes("iso-8859-1"));
		String co_name=new String(request.getParameter("co_name").getBytes("iso-8859-1"));
		String co_id=new String(request.getParameter("co_id").getBytes("iso-8859-1"));
		String sing=new String(request.getParameter("sing").getBytes("iso-8859-1"));
		String actiontype=new String(request.getParameter("actiontype").getBytes("iso-8859-1"));
		if(sing.equals("是"))
		{
		  co_showflag="1";
		}
		else 
		{
		  co_showflag="0";
		}
		Vector vPage = null;
		Hashtable content = null;
	if(actiontype.equals("add"))
	{
		
		
		String sql="select * from tb_count where co_name='"+co_name+"'";
		vPage = dImpl.splitPage(sql,50,1);		
		if(vPage!=null)
			{
				out.println("<p>此权限代码已被使用,请选择其他的权限代码!</p>");
				out.println("<A HREF=javascript:window.history.back()>[重新操作]</A>");
				out.close();
			}
		else {
				sql="insert into tb_count(co_id,co_webname,co_name,co_showflag)";
				sql=sql+" values(tb_count_sequence.nextval,'"+co_webname+"','"+co_name+"','"+co_showflag+"')";
				vPage = dImpl.splitPage(sql,request,1);
			
		%>

		<script language="javascript">
		alert("提交成功");
		window.location.href="countList.jsp";
		</script>

		<%
			 }
	}
	else
	{
	String sql="update tb_count set co_webname='"+co_webname+"',co_name='"+co_name+"',co_showflag='"+co_showflag+"' where co_id='"+co_id+"'";
	vPage = dImpl.splitPage(sql,request,1);		

		%>

		<script language="javascript">
		alert("提交成功");
		window.location.href="countList.jsp";
		</script>

		<%
			
	}
		%>


<%
	}catch(Exception ex)
	{
		out.print("<br>"+ex);
	}
	finally
	{
		if(dImpl!=null)
		{
			dImpl.closeStmt();
		}
		if(dCn!=null)
		{
			dCn.closeCn();
		}
		
	}
%>
</body>