  <%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

	String sql = "select sj_id,sj_dir from tb_subject where sj_parentid = (select sj_id from tb_subject where sj_dir='shpd')";
	Vector vect = dImpl.splitPage(sql,request,30);
	WebLeftNavigate barObj = null;

%>
<!--link href="/website/images/newWebMain.css" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" /-->
<!--table width="173" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td height="7"></td>
</tr>
</table-->


<script language='javascript'>


	function expandGrid(gridId)
    {
      currentGrid=gridId;
	 
      //var objTRs=document.getElementsByTagName("tr");
      
		
		//var obj11 = document.getElementById(gridId);
		//obj11.className="btOneChecked-bg"
		//alert(gridId);
		var classid = gridId.split("-");

		//alert(classid[1]);

		changeClass(classid[1]);
		document.all.oldClass.value="class" + gridId;
	    changeColor(gridId);
		document.all.oldBg.value=gridId;

    }
	function changeClass(id){
		var obj = document.getElementById("classfir-" + id + "-");
		var objName = document.all.oldClass.value;
		if(objName!="")
		{
		    var oldObj = document.getElementById(objName);
			oldObj.className="btOne-bg";
		}
		obj.className="btOneChecked-bg";
	}

	
	function changeColor(id){
		var obj = document.getElementById("bg-" + id);
		var objName = document.all.oldBg.value;
		if(objName!="")
		{
			
		var oldObj = document.getElementById("bg-" + document.all.oldBg.value);
			if(document.all.oldBg.value.indexOf("fir")!=-1)
				oldObj.bgColor="#999999"
			else
				oldObj.bgColor="#DDDDDD"
		}
		obj.bgColor = "#FF0000";
	}

	function expandSecGrid(gridId)
	{
		  currentGrid=gridId;
		  var objTRs=document.getElementsByTagName("tr");
		  changeColor(gridId);
			document.all.oldBg.value=gridId;
	}

	
	function expandThdGrid(gridId)
	{
		  
	   changeColor(gridId);
	   document.all.oldBg.value=gridId;
	}
</script>
<input type="hidden" id="oldBg" value="">
<input type="hidden" id="oldClass" value="">
<%
	out.print("<"+"%	String sj_dir_col=\"govOpen\";	String domain=request.getRequestURL().toString().toLowerCase();	if(domain.indexOf(\"/website/\")!=-1)	{		sj_dir_col=domain.substring(domain.indexOf(\"/website/\")+9);		sj_dir_col=sj_dir_col.substring(0,sj_dir_col.indexOf(\"/\"));	}%"+">");
%>
<%out.println("<"+"%sj_dir_col=sj_dir_col.toLowerCase();%"+">");%>
<%
	if(vect!=null){
		for(int i=0;i<vect.size();i++){
			Hashtable content11 = (Hashtable)vect.get(i);
			String sj_dir_now=content11.get("sj_dir").toString();
			out.println("<"+"%if (\""+sj_dir_now+"\".toLowerCase().equals(sj_dir_col)){%"+"><div id='par" + sj_dir_now +"'>");
			barObj = new ZXWebLeftBarDir(sj_dir_now,dCn,"index.jsp");
			barObj.setParDir(sj_dir_now);
			out.println(CTools.replace(barObj.createFirstLeftBar(),"特别关爱","<font color=\"#ff0000\" style=\"font-family:仿宋_GB2312\">特别关爱</font>"));
			out.println("</div><"+"%}%"+">");
		}
	}
}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>