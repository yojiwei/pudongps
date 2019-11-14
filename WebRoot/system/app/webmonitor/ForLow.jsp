<%@ page contentType="text/html;charset=gb2312" %>
<%@include file="/system/app/skin/import.jsp"%>
<%
String down = CTools.dealString(request.getParameter("down")).trim();
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
String dtid=CTools.dealString(request.getParameter("commonWork"));
String dt_str = "";
if(!dtid.equals(""))
{
	dt_str = "dt_id="+dtid+" and";
}
String dt_id = "";
String dt_name = "";
String lawName = "";
String sjName_1 = "";	//法律法规的一级栏目
String sjId_1 = "";
String sjName_2 = "";	//二级栏目
String sjId_2 = "";
String sqlStr = "";
String [] sjDirs = {"countryLaw","shanghaiLaw","xuhuiLaw"};
StringBuffer outputStr = new StringBuffer();
//sqlStr = "select dt_id, dt_name from tb_deptinfo where dt_id=184 order by dt_sequence";
//限制只取一个部门
sqlStr = "select dt_id, dt_name from tb_deptinfo where "+dt_str+" dt_iswork=1 order by dt_sequence";
Vector deptPage = dImpl.splitPage(sqlStr,300,1);
if (deptPage!=null)
{
	for (int i=0;i<deptPage.size();i++)
	{
		Hashtable deptContent = (Hashtable)deptPage.get(i);
		dt_id = deptContent.get("dt_id").toString();
		dt_name = deptContent.get("dt_name").toString();

		//***
		outputStr.append("<font color=\"red\">" + dt_name + "</font>");
		outputStr.append("<br>");
		outputStr.append("<table width='100%' border=1>");
		//
		//表头部分
		//
		outputStr.append("	<tr>");
		outputStr.append("		<td width='15%'>&nbsp;</td>");
		outputStr.append("		<td>");
		outputStr.append("			<table width='100%'><tr><td width='40%' align=center>所属栏目</td><td align=center>法规名称</td></tr></table>");
		outputStr.append("		</td");
		outputStr.append("	</tr>");
		//
		//分栏目列出该部门上传的法律法规
		//
		for (int j=0;j<sjDirs.length;j++)
		{
			sqlStr = "select sj_id, sj_name from tb_subject where sj_dir='" + sjDirs[j] + "'";
			Hashtable sjContent_1 = dImpl.getDataInfo(sqlStr);
			if (sjContent_1!=null)
			{
				sjId_1 = sjContent_1.get("sj_id").toString();
				sjName_1 = sjContent_1.get("sj_name").toString();
				outputStr.append("	<tr width='100%'>");
				outputStr.append("		<td width='15%'>" + sjName_1 + "</td>");
				outputStr.append("		<td>");
				outputStr.append("			<table width='100%' border='1'>");
				sqlStr = "select sj_id, sj_name from tb_subject where sj_parentid="+sjId_1;
				Vector sjPage_2 = dImpl.splitPage(sqlStr,10,1);
				if (sjPage_2!=null)
				{
					for (int m=0;m<sjPage_2.size();m++)
					{
						Hashtable sjContent_2 = (Hashtable)sjPage_2.get(m);
						sjId_2 = sjContent_2.get("sj_id").toString();
						sjName_2 = sjContent_2.get("sj_name").toString();
						outputStr.append("<tr>");
						outputStr.append("	<td width='40%'>" + sjName_2 + "</td>");
						outputStr.append("	<td>");
						sqlStr = "select ct_title from tb_content where dt_id=" + dt_id + "and sj_id=" + sjId_2 + " and ct_sequence<10000 order by ct_sequence";
						Vector lawPage = dImpl.splitPage(sqlStr,300,1);
						if (lawPage!=null)
						{
							outputStr.append("<table width=100% border=1>");
							for(int k=0;k<lawPage.size();k++)
							{
								Hashtable lawContent = (Hashtable)lawPage.get(k);
								lawName = lawContent.get("ct_title").toString();
								outputStr.append("<tr><td>" + lawName + "</td></tr>");
							}
							outputStr.append("</table>");
						}
						outputStr.append("	</td>");
						outputStr.append("</tr>");
					}
				}
				outputStr.append("			</table>");
				outputStr.append("		</td>");
				outputStr.append("	</tr>");
			}
		}

		//~~~
		outputStr.append("</table>");
		outputStr.append("<br>");
	}
}
dImpl.closeStmt();
dCn.closeCn();
if (down.equals("download"))
{
	response.setContentType("application/download");
	response.setHeader("Content-Disposition","attachment;filename=法律法规统计.xls");
}
out.print(outputStr.toString());
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