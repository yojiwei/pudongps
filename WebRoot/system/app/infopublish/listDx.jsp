<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/system/app/skin/head.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>短信列表</title>
</head>
<link href="/system/app/skin/skin3/images/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function addMessages(ctId){
window.open("sendDx.jsp?ctId="+ctId,"新增短信发送","Top=200px,Left=200px,Width=580px,Height=230px,toolbar=no,location=no,derectories=no,status=no,menubar=no,resizable=no,scrollbars=no");
}
</script>
<body>
<%
 String ctId = "";
 String sm_con = "";
 String sj_name = "";
 String sm_check = "";
 String sm_flag = "";
 CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
 CDataCn dCn = null;
 CDataImpl dImpl = null;
 Hashtable content = null;
 Vector vPage = null;
 try{
 dCn = new CDataCn();
 dImpl = new CDataImpl(dCn);
 ctId = CTools.dealNumber(request.getParameter("ctId"));

%>
<table class="FindAreaTable1" cellspacing="1" rules="cols" border="0" id="ctl00_DataGrid_DataGrid1" style="border-width:0px;">
<%
	String strSql="select s.sm_con,s.sm_check,sm_flag,d.sj_name from tb_sms s,tb_subject d where s.sm_sj_id = d.sj_id and s.sm_ct_id="+ctId;
	  vPage = dImpl.splitPage(strSql,20,1);
	  if(vPage!=null)
	  {
		for(int w=0;w<vPage.size();w++)
		{
		    content = (Hashtable)vPage.get(w);
			if (content!=null)
			{
%>
 <tr class="<%out.print(w%2==0?"line-even":"line-odd");%>">
 <td width="11%" align="left">短信信息：</td>
  <td width="89%" align='left'>
<%
				sm_con = CTools.dealNull(content.get("sm_con"));
				sj_name = CTools.dealNull(content.get("sj_name"));
				sm_check = CTools.dealNull(content.get("sm_check"));//1待审核 2 通过了 3 没有通过
				sm_flag = CTools.dealNull(content.get("sm_flag"));//1 发送了 2 没有发送
				sm_con = sm_con .length() > 30 ? sm_con .substring(0,29) + "..": sm_con;
				out.print(sm_con+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+sj_name+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				switch (Integer.parseInt(sm_check))
				{
					case 1: out.print("待审核");break;
					case 2: out.print("审核通过");break;
					case 3: out.print("没有通过审核");break;
				}
%>	
</td>
</tr>
<%
			}
		}
	}
%>
<tr class="line-even">
 <td width="11%" align="left">&nbsp;</td>
  <td width="89%" align='left'><input type="button" onClick="addMessages(<%=ctId%>)" value = "新增"/></td>
</tr>
</table>
</body>
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}

%>
</html>
