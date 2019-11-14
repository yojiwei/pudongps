<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="/system/app/infopublish/editor/fckeditor.js"></script>
<script language='javascript'>
	/**function checkSess() {
		<%
		String gsVal = (String)session.getAttribute("_gisVal");
		if (gsVal != null) {
		%>
			formData.gsPosition.readOnly = false;
			alert(<%=gsVal%>);
			formData.gsPosition.value = <%=gsVal%>;
			formData.gsPosition.readOnly = true;
		<%
			session.removeAttribute("_gisVal");
		}
		%>
	}**/
	function doDel(obj) {
		if (confirm("确实要删除此记录吗？")) {
			location.href="gisDel.jsp?gisId="+obj+"&bigSort="+document.formData.BigSort.value+"&smallSort="+document.formData.SmallSort.value;
		}
	}
	function getVal() {
		var dW = 800;
		var dH = 600;
		var url = "request.jsp?bigSortID="+formData.BigSort.item(formData.BigSort.selectedIndex).code+"&SmallSort="+formData.SmallSort.value;
		formData.gsPosition.readOnly = false;
		document.all.vvv.src = "refresh.jsp";
		var res = window.showModalDialog(url,'',"dialogWidth: "+dW+"px; dialogHeight: "+dH+"px; help=no; status=no; scroll=yes; resizable=no; ");
		setTimeout("setRefresh()",1000); 
		setTimeout("stopRefresh()",2000);
		//document.all.vvv.src="refresh.jsp";
		<%
			if (session.getAttribute("_gisVal") != null)
				session.removeAttribute("_gisVal");
		%>	
		formData.gsPosition.readOnly = true;
		document.all.vvv.src="#";
	}
	
	function setRefresh() {
		document.all.vvv.src="refresh.jsp";
	}
	function stopRefresh() {
		document.all.vvv.src="#";
	}
	
	function doChkComm() {
		var form1 = document.formData;
		switch (form1.type1.value) {
		case "1":
			if (!chkComm1()) {
				return;
			}
			break;
		case "2":
			if (!chkComm2()) {
				return;
			}
			break;
		case "3":
			if (!chkComm3()) {
				return;
			}
			break;
		case "4":
			if (!chkComm4()) {
				return;
			}
			break;
		case "5":
			if (!chkComm5()) {
				return;
			}
			break;
		case "6":
			if (!chkComm6()) {
				return;
			}
			break;
		case "7":
			if (!chkComm7()) {
				return;
			}
			break;
		case "8":
			if (!chkComm8()) {
				return;
			}
			break;
		case "9":
			if (!chkComm9()) {
				return;
			}
			break;
		default:
			alert("请选择您要大类！");
			form1.BigSort.focus();
			return false;
			break;
		}
		/*if (form1.gsPosition.value == "") {
			alert("请选择坐标位！");
			form1.gsPosition.focus();
			return false;
		}*/
		form1.submit();
	}
	
	function doChk() {
		var form1 = document.formData;
		if (form1.BigSort.value == "") {
			alert("请选择大类！");
			form1.BigSort.focus();
			return false;
		}
		if (form1.SmallSort.value == "") {
			alert("请选择小类！");
			form1.SmallSort.focus();
			return false;
		}
		doChkComm();
	}
	
	function doChk1() {
		var form1 = document.formData;
		if (form1.gisType.value != "" && form1.upFile.value != "") {
			if (!confirm("确定要替换当前图片吗?")) {
				return false;
			}
		}
		doChkComm();
	}
	
	function chkComm1() {
		var form1 = document.formData;
		if (form1.gsName1.value == "") {
			alert("请输入名称！");
			form1.gsName1.focus();
			return false;
		}
		if (form1.gsAddr1.value == "") {
			alert("请输入地址！");
			form1.gsAddr1.focus();
			return false;
		}
		/*if (form1.gsTel1.value == "") {
			alert("请输入电话！");
			form1.gsTel1.focus();
			return false;
		}
		if (form1.gsPost1.value == "") {
			alert("请输入邮编！");
			form1.gsPost1.focus();
			return false;
		}*/
		if (form1.gsTel1.value != "") {
			if (isNaN(form1.gsTel1.value)) {
				alert("请输入数字！");
				form1.gsTel1.focus();
				return false;
			}
		}
		if (form1.gsPost1.value != "") {
			if (isNaN(form1.gsPost1.value)) {
				alert("请输入数字！");
				form1.gsPost1.focus();
				return false;
			}
		}
		return true;
	}
	function chkComm2() {
		var form1 = document.formData;
		if (form1.gsName2.value == "") {
			alert("请输入名称！");
			form1.gsName2.focus();
			return false;
		}
		if (form1.gsAddr2.value == "") {
			alert("请输入地址！");
			form1.gsAddr2.focus();
			return false;
		}
		/*if (form1.gsTel2.value == "") {
			alert("请输入电话！");
			form1.gsTel2.focus();
			return false;
		}
		if (form1.gsPost2.value == "") {
			alert("请输入邮编！");
			form1.gsPost2.focus();
			return false;
		}
		if (form1.gsCharger2.value == "") {
			alert("请输入负责人！");
			form1.gsCharger2.focus();
			return false;
		}*/
		if (form1.gsTel2.value != "") {
			if (isNaN(form1.gsTel2.value)) {
				alert("请输入数字！");
				form1.gsTel2.focus();
				return false;
			}
		}
		if (form1.gsPost2.value != "") {
			if (isNaN(form1.gsPost2.value)) {
				alert("请输入数字！");
				form1.gsPost2.focus();
				return false;
			}
		}
		return true;
	}
	function chkComm3() {
		var form1 = document.formData;
		if (form1.gsUpDown3.value == "") {
			alert("请输入上下行！");
			form1.gsUpDown3.focus();
			return false;
		}
		if (form1.gsLineName3.value == "") {
			alert("请输入线路名！");
			form1.gsLineName3.focus();
			return false;
		}
		return true;
	}
	function chkComm4() {
		var form1 = document.formData;
		if (form1.gsName4.value == "") {
			alert("请输入名称！");
			form1.gsName4.focus();
			return false;
		}
		if (form1.gsLine4.value == "") {
			alert("请输入所属线路！");
			form1.gsLine4.focus();
			return false;
		}
		return true;
	}
	function chkComm5() {
		var form1 = document.formData;
		if (form1.gsName5.value == "") {
			alert("请输入单位全称！");
			form1.gsName5.focus();
			return false;
		}
		if (form1.gsLinkAddr5.value == "") {
			alert("请输入联系地址！");
			form1.gsLinkAddr5.focus();
			return false;
		}
		if (form1.gsLinkTel5.value != "") {
			if (isNaN(form1.gsLinkTel5.value)) {
				alert("请输入数字！");
				form1.gsLinkTel5.focus();
				return false;
			}
		}
		if (form1.gsPost5.value != "") {
			if (isNaN(form1.gsPost5.value)) {
				alert("请输入数字！");
				form1.gsPost5.focus();
				return false;
			}
		}
		/*if (form1.gsLinkTel5.value == "") {
			alert("请输入联系电话！");
			form1.gsLinkTel5.focus();
			return false;
		}
		if (form1.gsPost5.value == "") {
			alert("请输入邮编！");
			form1.gsPost5.focus();
			return false;
		}
		if (form1.gsFounder5.value == "") {
			alert("请输入法人！");
			form1.gsFounder5.focus();
			return false;
		}
		if (form1.gsLinkMan5.value == "") {
			alert("请输入联系人！");
			form1.gsLinkMan5.focus();
			return false;
		}
		if (form1.gsRegAddr5.value == "") {
			alert("请输入注册地址！");
			form1.gsRegAddr5.focus();
			return false;
		}*/
		return true;
	}
	function chkComm6() {
		var form1 = document.formData;
		if (form1.gsName6.value == "") {
			alert("请输入名称！");
			form1.gsName6.focus();
			return false;
		}
		/*if (form1.gsCharger6.value == "") {
			alert("请输入负责人！");
			form1.gsCharger6.focus();
			return false;
		}*/
		if (form1.gsLinkAddr6.value == "") {
			alert("请输入经营地址！");
			form1.gsLinkAddr6.focus();
			return false;
		}
		/*if (form1.gsLinkTel6.value == "") {
			alert("请输入电话！");
			form1.gsLinkTel6.focus();
			return false;
		}
		if (form1.gsPost6.value == "") {
			alert("请输入邮编！");
			form1.gsPost6.focus();
			return false;
		}*/
		if (form1.gsLinkTel6.value != "") {
			if (isNaN(form1.gsLinkTel6.value)) {
				alert("请输入数字！");
				form1.gsLinkTel6.focus();
				return false;
			}
		}
		if (form1.gsPost6.value != "") {
			if (isNaN(form1.gsPost6.value)) {
				alert("请输入数字！");
				form1.gsPost6.focus();
				return false;
			}
		}
		return true;
	}
	function chkComm7() {
		var form1 = document.formData;
		if (form1.gsName7.value == "") {
			alert("请输入名称！");
			form1.gsName7.focus();
			return false;
		}
		/*if (form1.gsStreet7.value == "") {
			alert("请输入所属街道！");
			form1.gsStreet7.focus();
			return false;
		}
		if (form1.gsBuild7.value == "") {
			alert("请输入所属房办！");
			form1.gsBuild7.focus();
			return false;
		}
		if (form1.gsJWH7.value == "") {
			alert("请输入居委会！");
			form1.gsJWH7.focus();
			return false;
		}*/
		return true;
	}
	function chkComm8() {
		var form1 = document.formData;
		if (form1.gsName8.value == "") {
			alert("请输入学校名称！");
			form1.gsName8.focus();
			return false;
		}
		if (form1.gsLinkAddr8.value == "") {
			alert("请输入地址！");
			form1.gsLinkAddr8.focus();
			return false;
		}
		/*if (form1.gsLinkTel8.value == "") {
			alert("请输入学校电话！");
			form1.gsLinkTel8.focus();
			return false;
		}
		if (form1.gsPost8.value == "") {
			alert("请输入学校邮编！");
			form1.gsPost8.focus();
			return false;
		}*/
		if (form1.gsLinkTel8.value != "") {
			if (isNaN(form1.gsLinkTel8.value)) {
				alert("请输入数字！");
				form1.gsLinkTel8.focus();
				return false;
			}
		}
		if (form1.gsPost8.value != "") {
			if (isNaN(form1.gsPost8.value)) {
				alert("请输入数字！");
				form1.gsPost8.focus();
				return false;
			}
		}
		return true;
	}
	function chkComm9() {
	alert("29");
		var form1 = document.formData;
		if (form1.gsName9.value == "") {
			alert("请输入医院名称！");
			form1.gsName9.focus();
			return false;
		}
		if (form1.gsAddr9.value == "") {
			alert("请输入地址！");
			form1.gsAddr9.focus();
			return false;
		}
		/*if (form1.gsStreet9.value == "") {
			alert("请输入街道！");
			form1.gsStreet9.focus();
			return false;
		}
		if (form1.gsPost9.value == "") {
			alert("请输入邮编！");
			form1.gsPost9.focus();
			return false;
		}
		if (form1.gsTel9.value == "") {
			alert("请输入电话！");
			form1.gsTel9.focus();
			return false;
		}
		if (form1.gsTel19.value == "") {
			alert("请输入电话分机！");
			form1.gsTel19.focus();
			return false;
		}*/
		if (form1.gsPost9.value != "") {
			if (isNaN(form1.gsPost9.value)) {
				alert("请输入数字！");
				form1.gsPost9.focus();
				return false;
			}
		}
		if (form1.gsTel9.value != "") {
			if (isNaN(form1.gsTel9.value)) {
				alert("请输入数字！");
				form1.gsTel9.focus();
				return false;
			}
		}
		if (form1.gsTel19.value != "") {
			if (isNaN(form1.gsTel19.value)) {
				alert("请输入数字！");
				form1.gsTel19.focus();
				return false;
			}
		}
		return true;
	}
	
	function numOnly(value) {
   		if (((event.keyCode >= 48) & (event.keyCode <= 57))|((event.keyCode <= 105) &
   			  (event.keyCode >= 96)) | (event.keyCode == 8) | (event.keyCode == 37) | (event.keyCode == 39) 
   				 | (event.keyCode == 46) | (event.keyCode == 9)) 
   		{	}
   		else {
       		event.returnValue=false;
   		}
   	}
   	function floatOnly(value) {
	    if ((event.keyCode==110)|(event.keyCode==190)) {
	       if(value.match(/\.\d*/g,'.'))
	           event.returnValue=false;
	    }
   		if(event.keyCode==45){
       		event.returnValue=false;
   		}
   		if(((event.keyCode>=48)&(event.keyCode<=57))|((event.keyCode<=105)&(event.keyCode>=96))
   			|(event.keyCode==110)|(event.keyCode==190)|(event.keyCode==8)|(event.keyCode==37)|(event.keyCode==39)|(event.keyCode==9))
	//               0             9               9             0               .             .            backspace           left         right
	   	{ 	}
   		else {
       		event.returnValue=false;
   		}
	}
   	function telOnly(value) {
	    if ((event.keyCode == 189) | (event.keyCode == 109)) {
	    	if(value.match(/\-\d*/g,'-'))
	        	event.returnValue=false;
	    }
   		if (((event.keyCode >= 48) & (event.keyCode <= 57))|((event.keyCode <= 105) &
   			  (event.keyCode >= 96)) | (event.keyCode == 8) | (event.keyCode == 37) | (event.keyCode == 39 | (event.keyCode == 9)) 
   				| (event.keyCode == 189) | (event.keyCode == 109) | (event.keyCode == 46)) 
   		{	}
	    else {
	    	event.returnValue=false;
	    }
	}
	
	function changeSmallDiv() {
		var form1 = document.formData;
		var sel;
		if (form1.SmallSort.value == "药房" || form1.SmallSort.value == "书店") {
			sel = 2;
		}
		else {
			changeDiv();
			return false;
		}
		form1.type1.value = sel;
		var obj;
		for (var i = 1;i < 10;i++) {
			obj = eval("comm" + i);
			obj.style.display = i==sel ? "" : "none";
		}
	}
	
	function changeDiv() {
		var form1 = document.formData;
		form1.bigSortID.value = form1.BigSort.item(form1.BigSort.selectedIndex).code;
		var sel;
		if (form1.BigSort.value == "学") {
			sel = 8;			
		}
		else if (form1.BigSort.value == "医") {
			sel = 9;			
		}
		else {
			sel = 2;
		}
		form1.type1.value = sel;
		var obj;
		for (var i = 1;i < 10;i++) {
			obj = eval("comm" + i);
			obj.style.display = i==sel ? "" : "none";
		}
	}
</script>
<%
	String gsType = CTools.dealString(request.getParameter("gsType")).trim();					//是否查询
	String gisId = CTools.dealString(request.getParameter("gisId")).trim();						//查询条件
	
	String gisBigSortName = CTools.dealString(request.getParameter("gisBigSortName")).trim();
	String gisSmallSortName = CTools.dealString(request.getParameter("gisSmallSortName")).trim();
	
	
	String isRead = "";	
	String sql = "";	
	String staus = "";
	
	String bigSort = "";			//大类,
	String smallSort = "";			//小类
	String gsPosition = "";			//坐标位
	String gspicpath = "";			//路径
	String gsType1 = "";			//要修改的大类类型
	int gsType2 = 0;
	
	String field1 = "";
	String field2 = "";
	String field3 = "";
	String field4 = "";
	String field5 = "";
	String field6 = "";
	String field7 = "";
	String field8 = "";
	String field9 = "";
	String field10 = "";
	String field11 = "";
	String field12 = "";
	String field13 = "";
	String field14 = "";
	String field15 = "";
	String field16 = "";
	String field17 = "";
	String field18 = "";
	String field19 = "";
	String field20 = "";
	String field21 = "";
	String field22 = "";
	String field23 = "";
	String field24 = "";
	String field25 = "";
	String field26 = "";
	String field27 = "";
	String field28 = "";
	String field29 = "";
	String field30 = "";
	String field31 = "";
	String field32 = "";
	String field33 = "";
	String field34 = "";
	String field35 = "";
	String field36 = "";
	String field37 = "";
	String field38 = "";
	String field39 = "";
	String field40 = "";
	String field41 = "";
	String field42 = "";
	String field43 = "";
	String field44 = "";
	String field45 = "";
	String field46 = "";
	String field47 = "";
	String field48 = "";
	String field49 = "";
	String field50 = "";
	String field51 = "";
	String field52 = "";
	String field53 = "";
	String field54 = "";
	
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	
	if (!"".equals(gsType)) {
		staus = "Edit";
		isRead = "";
		sql = "select * from tbgis where gsid = " + gisId;
		Hashtable content = dImpl.getDataInfo(sql);
		if(content!=null) {
			bigSort = content.get("gssort").toString();
			smallSort = content.get("smallsort").toString();
			gsPosition = content.get("gsposition").toString();
			gspicpath = content.get("gspicpath").toString();
			gsType1 = content.get("type").toString();
			field1 = content.get("field1").toString();
			field2 = content.get("field2").toString();
			field3 = content.get("field3").toString();
			field4 = content.get("field4").toString();
			field5 = content.get("field5").toString();
			field6 = content.get("field6").toString();
			field7 = content.get("field7").toString();
			field8 = content.get("field8").toString();
			field9 = content.get("field9").toString();
			field10 = content.get("field10").toString();
			field11 = content.get("field11").toString();
			field12 = content.get("field12").toString();
			field13 = content.get("field13").toString();
			field14 = content.get("field14").toString();
			field15 = content.get("field15").toString();
			field16 = content.get("field16").toString();
			field17 = content.get("field17").toString();
			field18 = content.get("field18").toString();
			field19 = content.get("field19").toString();
			field20 = content.get("field20").toString();
			field21 = content.get("field21").toString();
			field22 = content.get("field22").toString();
			field23 = content.get("field23").toString();
			field24 = content.get("field24").toString();
			field25 = content.get("field25").toString();
			field26 = content.get("field26").toString();
			field27 = content.get("field27").toString();
			field28 = content.get("field28").toString();
			field29 = content.get("field29").toString();
			field30 = content.get("field30").toString();
			field31 = content.get("field31").toString();
			field32 = content.get("field32").toString();
			field33 = content.get("field33").toString();
			field34 = content.get("field34").toString();
			field35 = content.get("field35").toString();
			field36 = content.get("field36").toString();
			field37 = content.get("field37").toString();
			field38 = content.get("field38").toString();
			field39 = content.get("field39").toString();
			field40 = content.get("field40").toString();
			field41 = content.get("field41").toString();
			field42 = content.get("field42").toString();
			field43 = content.get("field43").toString();
			field44 = content.get("field44").toString();
			field45 = content.get("field45").toString();
			field46 = content.get("field46").toString();
			field47 = content.get("field47").toString();
			field48 = content.get("field48").toString();
			field49 = content.get("field49").toString();
			field50 = content.get("field50").toString();
			field51 = content.get("field51").toString();
			field52 = content.get("field52").toString();
			field53 = content.get("field53").toString();
			field54 = content.get("field54").toString();
		}
		gsType2 = Integer.parseInt(gsType1);
%>
<script language="javascript" for=window event=onload>
		for (var i = 1;i < 10;i++) {
			var obj = eval("comm" + i);
			obj.style.display = (i==<%=gsType2%>) ? "" : "none";
		}
</script>
<%	
	}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
GIS管理
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->
GIS新增
<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<div align="center">
<form action="gisAddResult.jsp" method="post" name="formData" enctype="multipart/form-data">
<input type="hidden" name="type1" value="<%=gsType2%>">
<input type="hidden" name="staus" value="<%=staus%>">
<input type="hidden" name="gisId" value="<%=gisId%>">
<table class="main-table" width="100%">
	<tr class="title1" align=center>
  	  <td>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" class=outset-table>
           <tr>
            	<td align="left" WIDTH="40%"></td>
                <td align="center" colspan=2 WIDTH="20%"><b>GIS新增</b></td>      
                <td align="right" WIDTH="40%" nowrap>
					<img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
					<img src="../../images/menu_about.gif" border="0" onclick="javascript:location.href='gisSearch.jsp'" title="查询" style="cursor:hand" align="absmiddle">
                    <img src="../../images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                    <img src="../../images/goback.gif" border="0" onclick="javascript:history.back();" title="返回" style="cursor:hand" align="absmiddle">
                    <img src="../..images/split.gif" align="middle" border="0" WIDTH="5" HEIGHT="8">
                </td>
            </tr>
           </table>
       </td>
    </tr>
    <tr>
	 	<td width="100%">
	 	   <table width="100%" class="content-table" height="1">
			 <tr class="line-even" >
				<td width="19%" align="right">分类选择：</td>
				<td width="81%" align="left">
				<input type="hidden" name="bigSortID" value="">
				<%if (!"".equals(gsType)) {%>
						<input type="text" name="BigSort"  class="text-line" size="20" value="<%=bigSort%>" readOnly maxlength="50"/>&nbsp;
						<input type="text" name="SmallSort"  class="text-line" size="20" value="<%=smallSort%>" readOnly maxlength="50"/>
				<%}else{%>
						<%=CTools.replace(CTools.replace(CTools.setSortCommon("formData","","","GIS分类"),"var objBig","changeDiv();var objBig"),"name=\"SmallSort\"","name=\"SmallSort\" onchange=\"changeSmallDiv()\"")%>
				<%}%>
	            <font color="#FF0000">*</font></td>
			 </tr>
			 <table id="comm1" width="100%" style="display:none">
				 <tr class="line-even" >
		            <td width="19%" align="right">名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName1"  class="text-line" size="30" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsAddr1" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电话：</td>
		            <td width="81%" align="left"><input type="text" name="gsTel1" class="text-line" size="20" value="<%=field3%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">邮编：</td>
		            <td width="81%" align="left"><input type="text" name="gsPost1" class="text-line" size="20" value="<%=field4%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr> 		
		     </table>
			 <table id="comm2" width="100%">
				 <tr class="line-even" >
		            <td width="19%" align="right">名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName2"  class="text-line" size="60" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsAddr2" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电话：</td>
		            <td width="81%" align="left"><input type="text" name="gsTel2" class="text-line" size="20" value="<%=field3%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">邮编：</td>
		            <td width="81%" align="left"><input type="text" name="gsPost2" class="text-line" size="20" value="<%=field4%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--><!-- </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">负责人：</td>
		            <td width="81%" align="left"><input type="text" name="gsCharger2" class="text-line" size="20" value="<%=field5%>" <%=isRead%> maxlength="20"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
	          </table>
		     <table id="comm3" width="100%" style="display:none">
				 <tr class="line-even" >
		            <td width="19%" align="right">上下行：</td>
		            <td width="81%" align="left"><input type="text" name="gsUpDown3"  class="text-line" size="60" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">线路名：</td>
		            <td width="81%" align="left"><input type="text" name="gsLineName3" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		     </table>
		     <table id="comm4" width="100%" style="display:none">
				 <tr class="line-even" >
		            <td width="19%" align="right">名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName4"  class="text-line" size="60" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">所属线路：</td>
		            <td width="81%" align="left"><input type="text" name="gsLine4" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		     </table>
		     <table id="comm5" width="100%" style="display:none">
		          <tr class="line-even" >
		            <td width="19%" align="right">许可证号：</td>
		            <td width="81%" align="left"><input type="text" name="gsNum5" class="text-line" size="20" value="<%=field8%>" <%=isRead%> maxlength="20" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
				  <tr class="line-even" >
		            <td width="19%" align="right">单位全称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName5"  class="text-line" size="60" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">联系地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkAddr5" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">联系电话：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkTel5" class="text-line" size="20" value="<%=field3%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">邮编：</td>
		            <td width="81%" align="left"><input type="text" name="gsPost5" class="text-line" size="20" value="<%=field4%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">法人：</td>
		            <td width="81%" align="left"><input type="text" name="gsFounder5" class="text-line" size="20" value="<%=field5%>" <%=isRead%> maxlength="20" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">联系人：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkMan5" class="text-line" size="20" value="<%=field6%>" <%=isRead%> maxlength="20" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">注册地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsRegAddr5" class="text-line" size="20" value="<%=field7%>" <%=isRead%> maxlength="50" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		     </table>
		     <table id="comm6" width="100%" style="display:none">
		          <tr class="line-even" >
		            <td width="19%" align="right">许可证号：</td>
		            <td width="81%" align="left"><input type="text" name="gsNum6" class="text-line" size="20" value="<%=field8%>" <%=isRead%> maxlength="20" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
				  <tr class="line-even" >
		            <td width="19%" align="right">名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName6"  class="text-line" size="30" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">负责人：</td>
		            <td width="81%" align="left"><input type="text" name="gsCharger6" class="text-line" size="20" value="<%=field6%>" <%=isRead%> maxlength="20" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">经营地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkAddr6" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">法定代表人：</td>
		            <td width="81%" align="left"><input type="text" name="gsFounder6" class="text-line" size="20" value="<%=field5%>" <%=isRead%> maxlength="20"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">住所(注册地址)：</td>
		            <td width="81%" align="left"><input type="text" name="gsRegAddr6" class="text-line" size="60" value="<%=field7%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电话：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkTel6" class="text-line" size="20" value="<%=field3%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">特约维修企业备案：</td>
		            <td width="81%" align="left"><input type="text" name="gsSpec6" class="text-line" size="60" value="<%=field9%>" <%=isRead%> maxlength="50" />
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">邮编：</td>
		            <td width="81%" align="left"><input type="text" name="gsPost6" class="text-line" size="20" value="<%=field4%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">核准项目：</td>
		            <td width="81%" align="left"><input type="text" name="gsdt6" class="text-line" size="60" value="<%=field10%>" <%=isRead%> maxlength="30" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">经济性质：</td>
		            <td width="81%" align="left"><input type="text" name="gsKind6" class="text-line" size="20" value="<%=field11%>" <%=isRead%> maxlength="30" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		     </table>
		     <table id="comm7" width="100%" style="display:none">
				  <tr class="line-even" >
		            <td width="19%" align="right">名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName7"  class="text-line" size="30" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">东：</td>
		            <td width="81%" align="left"><input type="text" name="gsEast7" class="text-line"  size="60" value="<%=field5%>" <%=isRead%> maxlength="25"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">西：</td>
		            <td width="81%" align="left"><input type="text" name="gsWest7" class="text-line" size="20" value="<%=field6%>" <%=isRead%> maxlength="20"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">南：</td>
		            <td width="81%" align="left"><input type="text" name="gsSouth7" class="text-line" size="20" value="<%=field7%>" <%=isRead%> maxlength="29"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">北：</td>
		            <td width="81%" align="left"><input type="text" name="gsNorth7" class="text-line" size="20" value="<%=field8%>" <%=isRead%> maxlength="24"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">所属街道：</td>
		            <td width="81%" align="left"><input type="text" name="gsStreet7" class="text-line" size="60" value="<%=field9%>" <%=isRead%> maxlength="50"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">所属房办：</td>
		            <td width="81%" align="left"><input type="text" name="gsBuild7" class="text-line" size="20" value="<%=field10%>" <%=isRead%> maxlength="50"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">建筑数量：</td>
		            <td width="81%" align="left"><input type="text" name="gsBuildNum7" class="text-line" size="20" value="<%=field12%>" <%=isRead%> maxlength="14" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">建筑面积：</td>
		            <td width="81%" align="left"><input type="text" name="gsBuildArea7" class="text-line" size="20" value="<%=field17%>" <%=isRead%> maxlength="27" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">套数：</td>
		            <td width="81%" align="left"><input type="text" name="gsBuildsNum7" class="text-line" size="20" value="<%=field13%>" <%=isRead%> maxlength="10" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">户数：</td>
		            <td width="81%" align="left"><input type="text" name="gsFamilyNum7" class="text-line" size="20" value="<%=field14%>" <%=isRead%> maxlength="14" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">基本描述：</td>
		            <td width="81%" align="left"><input type="text" name="gsBasicSay7" class="text-line" size="60" value="<%=field15%>" <%=isRead%> maxlength="15" />
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">房屋描述：</td>
		            <td width="81%" align="left"><input type="text" name="gsBuildSay7" class="text-line" size="60" value="<%=field16%>" <%=isRead%> maxlength="16"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">居住、非居住分类描述：</td>
		            <td width="81%" align="left"><input type="text" name="gsStaySay7" class="text-line" size="60" value="<%=field11%>" <%=isRead%> maxlength="23"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">高层、多层分类描述：</td>
		            <td width="81%" align="left"><input type="text" name="gsMuchSay7" class="text-line" size="60" value="<%=field18%>" <%=isRead%> maxlength="23"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">性质分类描述：</td>
		            <td width="81%" align="left"><input type="text" name="gsKindSay7" class="text-line" size="60" value="<%=field19%>" <%=isRead%> maxlength="21"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">管理分类描述：</td>
		            <td width="81%" align="left"><input type="text" name="gsManageSay7" class="text-line" size="60" value="<%=field20%>" <%=isRead%> maxlength="20"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">建筑备注：</td>
		            <td width="81%" align="left"><input type="text" name="gsBuileMemo7" class="text-line" size="60" value="<%=field21%>" <%=isRead%> maxlength="23"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">辅助设施备注：</td>
		            <td width="81%" align="left"><input type="text" name="gsAssMemo7" class="text-line" size="60" value="<%=field22%>" <%=isRead%> maxlength="21"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">基金备注：</td>
		            <td width="81%" align="left"><input type="text" name="gsFundMemo7" class="text-line" size="60" value="<%=field23%>" <%=isRead%> maxlength="66"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">收费情况：</td>
		            <td width="81%" align="left"><input type="text" name="gsRecM7" class="text-line" size="60" value="<%=field24%>" <%=isRead%> maxlength="25"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">业委会：</td>
		            <td width="81%" align="left"><input type="text" name="gsYWH7" class="text-line" size="60" value="<%=field25%>" <%=isRead%> maxlength="19"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">居委会：</td>
		            <td width="81%" align="left"><input type="text" name="gsJWH7" class="text-line" size="60" value="<%=field26%>" <%=isRead%> maxlength="23"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">行业管理：</td>
		            <td width="81%" align="left"><input type="text" name="gsWayManage7" class="text-line" size="60" value="<%=field27%>" <%=isRead%> maxlength="25"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">序号：</td>
		            <td width="81%" align="left"><input type="text" name="gsStayId7" class="text-line" size="20" value="<%=field28%>" <%=isRead%> maxlength="11"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">收费：</td>
		            <td width="81%" align="left"><input type="text" name="gsRecMoney7" class="text-line" size="20" value="<%=field29%>" <%=isRead%> maxlength="23"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">环境：</td>
		            <td width="81%" align="left"><input type="text" name="gsEnvir7" class="text-line" size="60" value="<%=field30%>" <%=isRead%> maxlength="23" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		     </table>
		     <table id="comm8" width="100%" style="display:none">
				  <tr class="line-even" >
		            <td width="19%" align="right">学校名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName8"  class="text-line" size="60" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkAddr8" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电话：</td>
		            <td width="81%" align="left"><input type="text" name="gsLinkTel8" class="text-line" size="20" value="<%=field3%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">邮编：</td>
		            <td width="81%" align="left"><input type="text" name="gsPost8" class="text-line" size="20" value="<%=field4%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">城乡：</td>
		            <td width="81%" align="left"><input type="text" name="gsCC8" class="text-line" size="60" value="<%=field5%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">规定年制：</td>
		            <td width="81%" align="left"><input type="text" name="gsGDNZ8" class="text-line" size="60" value="<%=field6%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">入学年龄：</td>
		            <td width="81%" align="left"><input type="text" name="gsJoinAge8" class="text-line" size="20" value="<%=field7%>" <%=isRead%> maxlength="3" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">代码：</td>
		            <td width="81%" align="left"><input type="text" name="gsNum8" class="text-line" size="20" value="<%=field8%>" <%=isRead%> maxlength="16"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">办别：</td>
		            <td width="81%" align="left"><input type="text" name="gsDoKind8" class="text-line" size="20" value="<%=field9%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">类别：</td>
		            <td width="81%" align="left"><input type="text" name="gsKind8" class="text-line" size="20" value="<%=field10%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">校长：</td>
		            <td width="81%" align="left"><input type="text" name="gsMaster8" class="text-line" size="20" value="<%=field11%>" <%=isRead%> maxlength="20"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">班级数：</td>
		            <td width="81%" align="left"><input type="text" name="gsClassNum8" class="text-line" size="20" value="<%=field12%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">学生数：</td>
		            <td width="81%" align="left"><input type="text" name="gsStuNum8" class="text-line" size="20" value="<%=field13%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">教职工：</td>
		            <td width="81%" align="left"><input type="text" name="gsTeacherNum8" class="text-line" size="20" value="<%=field14%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">专任教师：</td>
		            <td width="81%" align="left"><input type="text" name="gsSTNum8" class="text-line" size="20" value="<%=field15%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">类型：</td>
		            <td width="81%" align="left"><input type="text" name="gsKind18" class="text-line" size="20" value="<%=field16%>" <%=isRead%> maxlength="16"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">传真：</td>
		            <td width="81%" align="left"><input type="text" name="gsFax8" class="text-line" size="20" value="<%=field17%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">主页地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsPageAddr8" class="text-line" size="60" value="<%=field18%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电子信箱：</td>
		            <td width="81%" align="left"><input type="text" name="gsEmail8" class="text-line" size="60" value="<%=field19%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		     </table>
		     <table id="comm9" width="100%" style="display:none">
				  <tr class="line-even" >
		            <td width="19%" align="right">医院名称：</td>
		            <td width="81%" align="left"><input type="text" name="gsName9"  class="text-line" size="60" value="<%=field1%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>	
		          <tr class="line-even" >
		            <td width="19%" align="right">地址：</td>
		            <td width="81%" align="left"><input type="text" name="gsAddr9" class="text-line"  size="60" value="<%=field2%>" <%=isRead%> maxlength="50"/>
		            <font color="#FF0000">*</font></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">街道：</td>
		            <td width="81%" align="left"><input type="text" name="gsStreet9" class="text-line" size="60" value="<%=field6%>" <%=isRead%> maxlength="50"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">邮编：</td>
		            <td width="81%" align="left"><input type="text" name="gsPost9" class="text-line" size="20" value="<%=field4%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电话：</td>
		            <td width="81%" align="left"><input type="text" name="gsTel9" class="text-line" size="20" value="<%=field3%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">电话分机：</td>
		            <td width="81%" align="left"><input type="text" name="gsTel19" class="text-line" size="20" value="<%=field8%>" <%=isRead%> maxlength="20" onKeyDown11="telOnly(value)"/>
		            <!-- <font color="#FF0000">*</font>--></td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">主页：</td>
		            <td width="81%" align="left"><input type="text" name="gsPage9" class="text-line" size="20" value="<%=field5%>" <%=isRead%> maxlength="50"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">负责人：</td>
		            <td width="81%" align="left"><input type="text" name="gsCharger9" class="text-line" size="20" value="<%=field7%>" <%=isRead%> maxlength="20"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">编制床位：</td>
		            <td width="81%" align="left"><input type="text" name="gsBZCW9" class="text-line" size="20" value="<%=field9%>" <%=isRead%> maxlength="16"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">实际床位：</td>
		            <td width="81%" align="left"><input type="text" name="gsSJCW9" class="text-line" size="20" value="<%=field10%>" <%=isRead%> maxlength="16" />
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">职工总数：</td>
		            <td width="81%" align="left"><input type="text" name="gsZGZS9" class="text-line" size="20" value="<%=field11%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">卫生技术人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsWSJS9" class="text-line" size="20" value="<%=field12%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">职业医师：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYYS9" class="text-line" size="20" value="<%=field13%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">中医职业医师：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYZYYS9" class="text-line" size="20" value="<%=field14%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">职业助理医师：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYZLYS9" class="text-line" size="20" value="<%=field15%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">中医职业助理医师：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYZYZLYS9" class="text-line" size="20" value="<%=field16%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">注册护士：</td>
		            <td width="81%" align="left"><input type="text" name="gsZCHS9" class="text-line" size="20" value="<%=field17%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">药剂人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsYJRY9" class="text-line" size="20" value="<%=field18%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">职业药师：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYYS9" class="text-line" size="20" value="<%=field19%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">职业中药师：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYZYS9" class="text-line" size="20" value="<%=field20%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">检验人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsJYRY9" class="text-line" size="20" value="<%=field21%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">其他卫生技术人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsQTWSJSRY9" class="text-line" size="20" value="<%=field22%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">其他技术人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsQTJSY9" class="text-line" size="20" value="<%=field23%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">管理人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsGLRY9" class="text-line" size="20" value="<%=field24%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">工勤人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsGQRY9" class="text-line" size="20" value="<%=field25%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">离退休人员：</td>
		            <td width="81%" align="left"><input type="text" name="gsLTXRY9" class="text-line" size="20" value="<%=field26%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">购建房屋建筑面积：</td>
		            <td width="81%" align="left"><input type="text" name="gsGJFWJZMJ9" class="text-line" size="20" value="<%=field27%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">业务用房面积：</td>
		            <td width="81%" align="left"><input type="text" name="gsYWYFMJ9" class="text-line" size="20" value="<%=field28%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">租房面积：</td>
		            <td width="81%" align="left"><input type="text" name="gsZFMJ9" class="text-line" size="20" value="<%=field29%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">租房业务用房面积：</td>
		            <td width="81%" align="left"><input type="text" name="gsZFYWYFMJ9" class="text-line" size="20" value="<%=field30%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">万元以上设备台数：</td>
		            <td width="81%" align="left"><input type="text" name="gsWYYSSBTS9" class="text-line" size="20" value="<%=field31%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">20-100万元设备台数：</td>
		            <td width="81%" align="left"><input type="text" name="gs201009" class="text-line" size="20" value="<%=field32%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">100万元以上设备台数：</td>
		            <td width="81%" align="left"><input type="text" name="gs100YS9" class="text-line" size="20" value="<%=field33%>" <%=isRead%> maxlength="7" onKeyDown11="numOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">总资产：</td>
		            <td width="81%" align="left"><input type="text" name="gsZZC9" class="text-line" size="20" value="<%=field34%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">流动资产：</td>
		            <td width="81%" align="left"><input type="text" name="gsLDZC9" class="text-line" size="20" value="<%=field35%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">对外投资：</td>
		            <td width="81%" align="left"><input type="text" name="gsDWTZ9" class="text-line" size="20" value="<%=field36%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">固定资产：</td>
		            <td width="81%" align="left"><input type="text" name="gsGDZC9" class="text-line" size="20" value="<%=field37%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">无形资产及开办费：</td>
		            <td width="81%" align="left"><input type="text" name="gsWXZCJKBF9" class="text-line" size="20" value="<%=field38%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">负债与净资产：</td>
		            <td width="81%" align="left"><input type="text" name="gsFZYJZC9" class="text-line" size="20" value="<%=field39%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">负债：</td>
		            <td width="81%" align="left"><input type="text" name="gsFZ9" class="text-line" size="20" value="<%=field40%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">净资产：</td>
		            <td width="81%" align="left"><input type="text" name="gsJZC9" class="text-line" size="20" value="<%=field41%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">事业基金：</td>
		            <td width="81%" align="left"><input type="text" name="gsSYJJ9" class="text-line" size="20" value="<%=field42%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">固定资金：</td>
		            <td width="81%" align="left"><input type="text" name="gsGDZJ9" class="text-line" size="20" value="<%=field43%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">专用资金：</td>
		            <td width="81%" align="left"><input type="text" name="gsZYZJ9" class="text-line" size="20" value="<%=field44%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">总收入：</td>
		            <td width="81%" align="left"><input type="text" name="gsZSR9" class="text-line" size="20" value="<%=field45%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">财政补助收入：</td>
		            <td width="81%" align="left"><input type="text" name="gsCZBZSR9" class="text-line" size="20" value="<%=field46%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">专项补助：</td>
		            <td width="81%" align="left"><input type="text" name="gsZXBZ" class="text-line" size="20" value="<%=field47%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">上组补助收入：</td>
		            <td width="81%" align="left"><input type="text" name="gsSZBZSR9" class="text-line" size="20" value="<%=field48%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">业务收入事业收入：</td>
		            <td width="81%" align="left"><input type="text" name="gsYWSRSYSR9" class="text-line" size="20" value="<%=field49%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">经营收入：</td>
		            <td width="81%" align="left"><input type="text" name="gsJYSR9" class="text-line" size="20" value="<%=field50%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">总支出：</td>
		            <td width="81%" align="left"><input type="text" name="gsZZC19" class="text-line" size="20" value="<%=field51%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">业务支出事业支出：</td>
		            <td width="81%" align="left"><input type="text" name="gsYWZCSYZC9" class="text-line" size="20" value="<%=field52%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">财政专项支出：</td>
		            <td width="81%" align="left"><input type="text" name="gsCZZXZC9" class="text-line" size="20" value="<%=field53%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		          <tr class="line-even" >
		            <td width="19%" align="right">人员经费支出：</td>
		            <td width="81%" align="left"><input type="text" name="gsRYJFZC9" class="text-line" size="20" value="<%=field54%>" <%=isRead%> maxlength="16" onKeyDown11="floatOnly(value)"/>
		            </td>
		          </tr>
		     </table>
	          <table width="100%">
	          <tr class="line-even" >
	            <td width="19%" align="right">坐标位：</td>
	            <td width="81%" align="left"><input type="text" name="gsPosition" class="text-line" size="30" value="<%=gsPosition%>" style="cursor:hand" onClick="getVal()" readOnly="true"/>
	            	<input type="button" name="aaa" value="选择坐标位" onClick="getVal()"><!--&nbsp;&nbsp;<input type="button" name="xxx" value="查看" onClick="checkSess();">-->
	            </td>
	          </tr>
	          <tr class="line-even" >
	            <td width="19%" align="right">相关图片上传：</td>
	            <td width="81%" align="left">
	            	<%
	            		//如果有图片显示图片
	            		if (!"".equals(gspicpath)) {
		            		String str[] = gspicpath.split("\\\\");
		            		String pStr = "";
		            		for (int i = str.length - 5;i < str.length ;i++) {
								pStr += str[i] + "/";
							}
							
							pStr = "../../../" + pStr.substring(0,pStr.length() - 1);
		            		
	            			out.print("<img src='" + pStr + "' align='middle' border='0' WIDTH='200' style='cursor:hand' onClick=window.open('" + pStr + "') title='点击查看大图'><br>");
	            	   	}
	            	%>
	            	<input type="hidden" name="gisType" value="pStr">
	            	<input type="file" name="upFile" class="text-line" size="30" <%=isRead%> />
	            </td>
	          </tr>
		   </table>
		</td>
	</tr>
	<tr class=outset-table>
	  <td width="100%" align="center" colspan="2">
		<%if (!"".equals(gsType)) {%>
        <input class="bttn" value="提交" type="button" onclick="doChk1()" size="6" id="button2" name="button2">&nbsp;
		<input class="btnDel" value="删除" type="button" onClick="doDel('<%=gisId%>')" size="6">&nbsp;
		<%}else{%>
        <input class="bttn" value="提交" type="button" onclick="doChk()" size="6" id="button2" name="button2">&nbsp;
        <%}%>
		<input class="bttn" value="返回" type="button"  size="6" id="button3" name="button3" onclick="javascript:history.go(-1)">
    </td>
	</tr>
</table>
</form>
<iframe id="vvv" name="vvv" src="#" height=0 width=0 border=0>
</iframe>
</div>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
<%@include file="/system/app/skin/bottom.jsp"%>