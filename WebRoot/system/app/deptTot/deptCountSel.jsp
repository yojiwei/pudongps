<%@ page contentType="text/html; charset=GBK" %>
<%@include file="/system/app/skin/head.jsp"%>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="javascript">
<!--
function del() {
  if (!confirm("您确定要删除该数据吗？")) return;
  formData.action = "deptCountDel.jsp";
  formData.submit();
}

function doDisplay(obj) {
	document.getElementById(obj).style.display = document.getElementById(obj).style.display == "none" ? "" : "none";
}

function  selCheckBox(obj,ids) {
	if(document.getElementById("dt_id" + obj).checked) {
		document.getElementById(ids).value = document.getElementById(ids).value + obj + ",";
	}
	else {
		document.getElementById(ids).value = (document.getElementById(ids).value).replace(obj + ",","");
	}
	//alert(document.getElementById(ids).value);
}

function selectAll(objStr,ids) {
	var sform = document.formData;
	//ids.value = ","
	for (i = 0;i < sform.length;i++) {
		if ((sform[i].name).indexOf(objStr) > -1 && sform[i].type == "checkbox") {
			ids.value = ids.value + sform[i].value+",";
			sform[i].checked = true;
		}
	}
	//alert(ids.value);
}

function delselectAll(objStr,ids) {
	var sform = document.formData;
	ids.value = ""
	for (i = 0;i < sform.length;i++) {
		if ((sform[i].name).indexOf(objStr) > -1 && sform[i].type == "checkbox") {				
			sform[i].checked = false;
		}
	}
	//alert(ids.value);
}

function check() {
	var sform = document.formData;
	sform.submit();
}
//-->
</script>
<%
	String tt_id = CTools.dealString(request.getParameter("tt_id"));
	String tt_type = CTools.dealString(request.getParameter("tt_type"));
	String display = CTools.dealString(request.getParameter("display"));
	
	String sqlStr = "select tt_dtids,tt_dtname from tb_totdept where tt_id = " + tt_id;
	
	String tt_dtname = "";
	String tt_dir = "";
	String deptids = "";
	String deptid[] = null;
	String title = "部门选择";
	
	Hashtable hash_dtids = null;
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 

	
	//if (display.equals("nonDisplay")) {
	//	title = "请选择部门";
		hash_dtids = dImpl.getDataInfo(sqlStr);
	//}
	if (hash_dtids != null) {
		title = hash_dtids.get("tt_dtname").toString();
		deptids = hash_dtids.get("tt_dtids").toString();
	}
	
	if (!"".equals(deptids)) deptid = deptids.split(",");
%>
<table class="main-table" width="100%">
<form action="deptCountSelResult.jsp" method="post" name="formData">
<input type="hidden" name="tt_id" value="<%=tt_id%>">
<input type="hidden" name="tt_type" value="<%=tt_type%>">
<input type="hidden" name="display" value="<%=display%>">
<input id="deptids" type="hidden" name="deptids" value="<%=deptids%>">
 <tr>
  <td width="100%">
   <div align="center">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
	  <tr valign="bottom" class="bttn">
	   <td width="100%" align="left" colspan="4">
		 <table width="100%">
		  <tr>
			<td id="TitleTd" width="100%" align="left"><%=title %></td>
			<td valign="top" align="right" nowrap>
			<img src="/system/images/dialog/split.gif" align="middle" border="0">
			<img src="/system/images/dialog/return.gif" border="0" onclick="javascirpt:history.go(-1);" title="返回" style="cursor:hand" align="absmiddle" id="image3" name="image3" WIDTH="14" HEIGHT="14">
			<img src="/system/images/dialog/split.gif" align="middle" border="0">
			</td>
		  </tr>
		</table>
	   </td>
	  </tr>
      <tr>
        <td width="100%" align="left" valign="top">
	  	 <table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	 <%
	  	 	String dt_id = "";
	  	 	String dt_name = "";
	  	 	String dt_id1 = "";
	  	 	String dt_name1 = "";
	  	 	String checked = "";
	  	 	sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_parent_id = 1 order by dt_sequence";
			Vector vPage = null;
			Hashtable content = null;
	  	 	Vector vPage1 = null;
	  	 	Hashtable content1 = null;
	  	 	vPage = dImpl.splitPageOpt(sqlStr,1000,1);
			if (vPage != null) {
				for(int i = 0; i < vPage.size(); i++) {
					content = (Hashtable)vPage.get(i);
					dt_id = content.get("dt_id").toString();
					dt_name = content.get("dt_name").toString();
	  	 %>
	  	  <tr class="<%=i % 2 == 0 ? "line-odd" : "line-even"%>" colspan="8">
	  	    <td align="left">
	  	    <div style="cursor:hand" onClick="doDisplay('div<%=dt_id%>')">&nbsp;&nbsp;<b><%=dt_name%></b></div>
	  	    </td>
		  </tr>
	  	  <tr>
			<td valign="left">
			  <table id="div<%=dt_id%>" width="100%" border="0" cellspacing="0" cellpadding="0" style="display:">	
				<tr>	
		 <%
		 	  	 	sqlStr = "select dt_id,dt_name,dt_parent_id from tb_deptinfo connect by prior " + 
		 	  	 			 "dt_id = dt_parent_id start with dt_id = " + dt_id;
		 	  	 	vPage1 = dImpl.splitPageOpt(sqlStr,1000,1);
				 	if (vPage1 != null) {
						for(int j = 0; j < vPage1.size(); j++) {
							content1 = (Hashtable)vPage1.get(j);
							dt_id1 = content1.get("dt_id").toString();
							dt_name1 = content1.get("dt_name").toString();
							//循环已选中的部门，若已选中的打沟
							
							if (deptid != null) {
								for (int k = 0; k < deptid.length; k++) {
									//checked = deptid[k].equals(dt_id1) ? "checked" : "";
									if (deptid[k].equals(dt_id1)) {
										checked = "checked";
										break;
									}
								}
							}
		 %>
	  	    <td align="left">
	  	    <input id="dt_id<%=dt_id1%>" type="checkbox" <%=checked%> name="dt_id<%=dt_id1%>" value="<%=dt_id1%>" onClick="selCheckBox('<%=dt_id1%>','deptids')" >
	  	    &nbsp;<%=dt_name1%>
	  	    </td>
		 <%
		 					if (j % 4 == 0) out.println("</tr><tr>");
		 					checked = "";
		 				}
		 			}
		 %>
	  	  </table>
		 <%
		 		}
		 	}
		 %>
	  	</table>
        </td>
       </tr>
       <tr>
          <td height="18" align="left" >
          	<input name="button" type="button"  value="全选" onClick="selectAll('dt_id',deptids);">
                <input name="button" type="button"  value="全不选" onClick="delselectAll('dt_id',deptids);"></td>
       </tr>
	   <tr>
		  <td width="100%" align="right" colspan="2" class="title1">
		    <p align="center">
	  		<input class="bttn" value="提交" type="button" onclick="check()" size="6">&nbsp;
	  		<input class="bttn" value="返回" type="button" onclick="history.back()" size="6">&nbsp;
			</p>
		    </td>
		</tr>
    </table>
  </div>
</td>
</tr>
</form>
</table>
<%
	dImpl.closeStmt();
	dCn.closeCn();
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
<%@ include file="/system/app/skin/bottom.jsp"%>


