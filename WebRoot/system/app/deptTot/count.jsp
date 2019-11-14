<%@page contentType="text/html; charset=GBK"%>
<body style="overflow-x:hidden;">
<%
String strTitle = "新闻查询";
%>
<%@ include file="../skin/head.jsp"%>
<%
String subjectCode="";//获得栏目代码
subjectCode=CTools.dealString(request.getParameter("subjectCode")).trim();
%>
<script language=javascript>
<!--  
  function showCal(obj)
  {
      if (!obj) var obj = event.srcElement;
      var obDate;
      if ( obj.value == "" ) {
          obDate = new Date();
      } else {
          var obList = obj.value.split( "-" );
          obDate = new Date( obList[0], obList[1]-1, obList[2] );
      }

      var retVal = showModalDialog( "../../common/calendar/calendar.htm", obDate,
          "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

      if ( typeof(retVal) != "undefined" ) {
          var year = retVal.getFullYear();
          var month = retVal.getMonth()+1;
          var day = retVal.getDate();
          obj.value =year + "-" + month + "-" + day;
      }
}
 
var CommonSort = new Array();
var CommonSort1 = new Array();
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
CDataImpl dImpl1 = null;
Hashtable content = null;
Vector vPage = null;
ResultSet rs = null;
ResultSet rs1 = null;
String tt_type = "";
String tt_id = "";
String tt_dtname = "";
String strSort = "";
String strSort1 = "";
String strJs = "";
String strJs1 = "";
String tt_parentName = "";
String sType = "";
String percent = "";
String tt_dir = "";
try {
	dCn = new CDataCn();
	dImpl = new CDataImpl(dCn);
	dImpl1 = new CDataImpl(dCn);
	rs = dImpl.executeQuery("select tt_id,tt_dir,tt_dtids,tt_dtname,tt_type from tb_totdept where tt_type = 0 and tt_flag = 0");
	while (rs.next()) {
		percent = rs.getString("tt_dtids") == null ? "0" : "1";
		tt_parentName = rs.getString("tt_dtname");
		tt_type = rs.getString("tt_id"); 
		tt_dir = rs.getString("tt_dir");
		sType += "<option value=\"" + tt_type + "," + percent + "," + tt_dir + "\">" + tt_parentName + "</option>\r\n";
		strSort = tt_type + ",";
		strSort1 = tt_type + ",";
		String sqlStr = "select tt_id,tt_dtname,tt_dtids,tt_type from tb_totdept where tt_flag = 0 and tt_type = " + tt_type;
		vPage = dImpl1.splitPage(sqlStr,request,100);
		if (vPage != null) {
			for (int i = 0 ; i < vPage.size() ; i++) {
				content = (Hashtable)vPage.get(i);
				tt_id = content.get("tt_id").toString();
				tt_dtname = content.get("tt_dtname").toString();
				strSort += tt_dtname + ",";
				strSort1 += tt_id + ",";
			}
		}
		strJs += "CommonSort.push(\"" + strSort.substring(0,strSort.length() - 1) + "\");\r\n";
		strJs1 += "CommonSort1.push(\"" + strSort1.substring(0,strSort1.length() - 1) + "\");\r\n";
		strSort = "";
		strSort1 = "";
	}
}
catch(Exception e) {
	//e.printStackTrace();
	out.print(e.toString());
}
finally {
	rs.close();
	dImpl.closeStmt();
	dImpl1.closeStmt();
	dCn.closeCn(); 
}
%>

<%=strJs%>
<%=strJs1%>

function changeSort1() {

	var sType = formData.sType.value;
    var objBig = sType.split(",")[0];
    formData.percent.value = sType.split(",")[1];
    formData.tt_dir.value = sType.split(",")[2];
    
   	var objSmall = formData.sValue;
        
    document.formData.sValue.length = 1;
    document.formData.sValue.options[0].text = "请统计单位";
    document.formData.sValue.options[0].value = "";
    
    for(var i = 0;i < CommonSort.length;i++) {
        var va = CommonSort[i].split(",");
        var va1 = CommonSort1[i].split(",");
        if (va[0] == objBig) {
            for(var j = 1;j < va.length;j++) {
                if (va[j].length > 0) {
                    document.formData.sValue.length++;
                    document.formData.sValue.options[j].text = va[j];
                    document.formData.sValue.options[j].value = va1[j];
                }
			}
        }
    }
}

function doAction() {
	if (formData.sType.value == 0) {
		alert("请选择统计类型!");
		formData.sType.focus();
		return false;
	}
	if (formData.sValue.value == 0) {
		alert("请选择统计单位!");
		formData.sValue.focus();
		return false;
	}
	formData.submit();
}

//-->
</script>

<%
/*得到当前登陆的用户id  开始*/
String uiid="";
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");
  if(myProject!=null && myProject.isLogin())
  {
    uiid = Long.toString(myProject.getMyID());
  }
  else
  {
    uiid= "2";
  }
%>
<table class="main-table" width="100%">

<form name="formData" method="post" action="countListFrm.jsp"  target="subFrm">
<INPUT TYPE="hidden" name="subjectCode" value="<%=subjectCode%>">
<INPUT TYPE="hidden" name="percent" value="">
<INPUT TYPE="hidden" name="tt_dir" value="">
 <tr class="title1" align=center>
      <td>查询界面</td>
    </tr>
  <tr>
     <td width="100%">

         <table width="100%" class="content-table" height="1">          
          <tr class="line-even">
            <td  align="right">统计类型：</td>
            <td align="left" >
	          <select name="sType" class="select-01" style="width:130px" onchange="javascript:changeSort1();">
					<option value="0">请选择统计类型</option>
					<%=sType%>
			  </select>
           </td>
          </tr>     
          <tr class="line-odd">
            <td  align="right">统计单位：</td>
            <td align="left" >
              <select name="sValue" class="select-01" style="width:130px">
              		<option value="0">请选择统计单位</option>
			  </select>
            </td>
          </tr>     
          <tr class="line-even">
            <td  align="right">发布时间：</td>
            <td align="left" >
              开始时间:<input type="date" size=13 name="start_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
              &nbsp;-&nbsp;
              结束时间:<input type="date" size=13 name="end_date" onclick="javascript:showCal()" class=text-line style="cursor:hand" readonly >
             </td>
          </tr>
        </table>
     </td>
   </tr>

   <tr class="title1" align="center">
       <td colspan="2">
<input type="button" class="bttn" onclick="doAction()" name="fsubmit" value="查 询" >&nbsp;
<input type="reset" class="bttn" name="fsubmit" value="重 写">&nbsp;
<input type="button" class="bttn" name="back" value="返 回" onclick="history.back();">
 </td>
   </tr>

</form>
</table><center>
<iframe id=subFrm name=subFrm src="countListFrm.jsp?percent=1&tt_dir=0&subjectCode=<%=subjectCode%>&sType=10,1,0&sValue=16&start_date=<%=(CDate.getNowYear()==2007)?"2007-4-5":CDate.getNowYear()+"-1-1"%>&end_date=<%=CDate.getThisday()%>" 
	width="98%" frameborder=0></iframe>
</body>
<%@ include file="/system/app/skin/bottom.jsp"%>


