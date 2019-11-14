<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%

CDataCn dCn = null;
CDataImpl dImpl = null;

try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn); 
%>



读写最频繁的语句：<br><br>
<%
String sql="select * from (select buffer_gets, sql_text from v$sqlarea where buffer_gets > 50000 order by buffer_gets desc) where rownum<=5";
ResultSet rs=dImpl.executeQuery(sql);
while(rs.next())
{
%>
<li>读写次数：<%=rs.getString("buffer_gets")%><br><%=rs.getString("sql_text")%><hr>
<%
}
rs.close();
%>
<br><br>



<br><br>最消耗瓷盘的语句：<br><br>
<%
sql="select * from (select sql_text,disk_reads from v$sql where disk_reads > 1000 or (executions > 0 and buffer_gets/executions > 30000) order by disk_reads desc) where rownum<=5";
rs=dImpl.executeQuery(sql);
while(rs.next())
{
%>
<li>磁盘读写数：<%=rs.getString("disk_reads")%><br><%=rs.getString("sql_text")%><hr>
<%
}
rs.close();
%>
<br><br>


<br><br>最消耗cpu的语句：<br><br>
<%
sql="select * from (select a.sid,spid,status,substr(a.program,1,40) prog,a.terminal,osuser,value/60/100 value     from v$session a,v$process b,v$sesstat c where c.statistic#=12 and c.sid=a.sid and a.paddr=b.addr order by value desc ) where rownum<=5";
rs=dImpl.executeQuery(sql);
String spid="";
while(rs.next())
{
	spid+=rs.getString("spid")+",";
}
rs.close();

String[] ArrSpid=spid.split(",");

for(int i=0;i<ArrSpid.length;i++)
{
	sql="select sql_text from v$sqltext a where a.hash_value=(select sql_hash_value from v$session b where b.paddr=(select addr from v$process where spid="+ArrSpid[i]+")) ";
	rs=dImpl.executeQuery(sql);
	String sqlText1="",sqlText="";
	while(rs.next())
	{
		sqlText1+=rs.getString("sql_text")+"~";
	}

	String[] ArrSqlText=sqlText1.split("~");
	for(int ii=ArrSqlText.length-1;ii>=0;ii--)
	{
		sqlText+=ArrSqlText[ii]+"";
	}

	rs.close();
	%>
	<li><%=sqlText%><hr>
	<%
}
%>
<br><br>


内存占用情况：
<%
	//System.gc();
	
	Runtime lRuntime = Runtime.getRuntime();
	out.println("***BEGIN MEMERY STATISTICS ***</BR>");
	out.println("Free Momery:"+lRuntime.freeMemory()+"</BR>");
	out.println("Max Momery:"+lRuntime.maxMemory()+"</BR>");
	out.println("Total Momery:"+lRuntime.totalMemory()+"</BR>");
	out.println("Available Processors : "+lRuntime.availableProcessors()+"</BR>");
	out.println("***END MEMERY STATISTICS ***");
%>

<%
	}catch(Exception testexp){
		testexp.printStackTrace();
	}finally{
		//dImpl.closeSmtp();
		dCn.closeCn();
	}
%>