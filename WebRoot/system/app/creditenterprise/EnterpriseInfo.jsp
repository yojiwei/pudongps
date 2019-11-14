<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String optype="";
String et_id = "";
String et_name = "";
String et_address = "";
String et_phone = "";
String et_corporation = "";
String et_fund = "";
String et_fare = "";
String et_qualification = "";
String et_records = "";
String et_status = "";
String et_license = "";
String et_licensetime = "";
String et_limittime = "";
String et_qaleader = "";
String et_kind = "";
String OPType = "";

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

et_id=CTools.dealString(request.getParameter("et_id")).trim();
OPType=CTools.dealString(request.getParameter("OPType")).trim();

if(!et_id.equals(""))
{
	optype="修改信息";
	String sql="select * from tb_creditenterprise where et_id = '" + et_id + "'";
	Hashtable content=dImpl.getDataInfo(sql);
	et_name=content.get("et_name").toString();
	et_address=content.get("et_address").toString();
	et_phone = content.get("et_phone").toString();
	et_corporation=content.get("et_corporation").toString();
	et_fund=content.get("et_fund").toString();
	et_fare=content.get("et_fare").toString();
	et_qualification=content.get("et_qualification").toString();
	et_records=content.get("et_records").toString();
	et_status=content.get("et_status").toString();
	et_license=content.get("et_license").toString();
	et_licensetime=content.get("et_licensetime").toString();
	et_qaleader=content.get("et_qaleader").toString();
	et_limittime = content.get("et_limittime").toString();
	et_kind = content.get("et_kind").toString();
	et_licensetime = content.get("et_licensetime").toString();
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=optype%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<script>
	/**
	 * return false 开始时间小于结束时间
	 * return true 开始时间大于结束时间
	**/
	function dateDiff(start_date,end_date){
		var startDt = start_date.split("-");
		var endDt = end_date.split("-");
		var startYr = new Number(startDt[0]);
		var startMon = new Number(startDt[1]);
		var startDay = new Number(startDt[2]);
		var endYr = new Number(endDt[0]);
		var endMon = new Number(endDt[1]);
		var endDay = new Number(endDt[2]);
		if (startYr > endYr) 
			return false;
		if (startMon > endMon)
			return false;
		if (startDay > endDay)
			return false;
		return true;
	}
	
	function  trim(str)
{
return  str.replace(/^\s*(.*?)[\s\n]*$/g,  '$1');
}
	
    function check()
    {
	  if(trim(formData.et_name.value)=="")
      {
		alert("企业名称不能为空！");
		formData.et_name.focus();
        return false;
      }
	  if(trim(formData.et_address.value)=="")
      {
		alert("企业地址不能为空！");
		formData.et_address.focus();
        return false;
      }
	  if(trim(formData.et_corporation.value)=="")
      {
		alert("法人代表不能为空！");
		formData.et_corporation.focus();
        return false;
      }
	  if(trim(formData.et_licensetime.value)=="")
      {
		alert("许可证号不能为空！");
		formData.et_licensetime.focus();
        return false;
      }
	  if(trim(formData.et_name.value)=="")
      {
		alert("企业名称不能为空！");
		formData.et_name.focus();
        return false;
      } 
      if (formData.et_limittime.value != "" && formData.et_license.value) {
      		var start_date = formData.et_license.value;
      		var end_date = formData.et_limittime.value
      		if (dateDiff(start_date,end_date) == false) {
      			alert("发证日期不可以在有效期之后");
      			return false
      		}
      }
      document.formData.submit();
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
</script>

<table width="100%" CELLPADDING="0" cellspacing="0" BORDER="0">
<tr>
<td>
<form action="EnterpriseResult.jsp" method="post" name="formData">
   <tr>
     <td width="100%">
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="content-table">
      	<tr>
        	<td width="100%" align="left" valign="top">
	  		<table border="0" width="100%" cellspacing="1" cellpadding="0">
	  	 		 
	  	  		 <tr class="line-even">
			  	    	<td width="15%" align="right">类型：</td>
                                        <td width="85%">
										<select name="et_kind" class="select-a">
										<option value="0" <%="0".equals(et_kind) ? "selected" : ""%>>工商企业</option>
										<option value="1" <%="1".equals(et_kind) ? "selected" : ""%>>食品卫生许可</option>
										</select>
	  	  		</tr>
                                <tr class="line-odd">
        			<td width="15%" align="right">企业名称：</td>
			        <td width="85%"><input type="text" class="text-line" size="20" name="et_name" maxlength="150"  value="<%=et_name%>" ><font color=red>*</font></td>
                                </tr>
								<tr class="line-even" >
           				 <td width="19%" align="right">企业地址：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="20" name="et_address" maxlength="150"  value="<%=et_address%>" ><font color=red>*</font></td>
          			 </tr>
					 <tr class="line-even" >
           				 <td width="19%" align="right">联系电话：</td>
            				 <td width="81%" ><input type="text" class="text-line" size="20" name="et_phone" onKeyDown="telOnly(value)" maxlength="25"  value="<%=et_phone%>" >							
							 </td>
          			 </tr>
		  		<tr class="line-odd">
	  	    		<td width="15%" align="right">法人代表：</td>
	  	    		<td width="85%"><input name="et_corporation" size="20" class="text-line" value="<%=et_corporation%>" maxlength="30"><font color=red>*</font>	
					</td>
                                </tr>
		  		<tr class="line-even">
	  	    		<td width="15%" align="right">注册资金：</td>
	  	    		<td width="85%"><input name="et_fund" type="input" size="20" class="text-line" value="<%=et_fund%>" onKeyDown="floatOnly(value)" maxlength="50">					
					</td>
		                </tr>
						
                  		<tr class="line-even">
                                <td width="15%" align="right">经营范围：</td>
	  	    		<td width="85%"><input name="et_fare" size="20" class="text-line" value="<%=et_fare%>" maxlength="50"></td>
	  	  		</tr>
                                <tr class="line-odd">
                                <td width="15%" align="right">信用资质：</td>
	  	    		<td width="85%"><input name="et_qualification" size="20" class="text-line" value="<%=et_qualification%>" maxlength="40"></td>
	  	  		</tr>
				<tr class="line-even">
                                <td width="15%" align="right">获奖记录：</td>
	  	    		<td width="85%"><input name="et_records" size="20" class="text-line" value="<%=et_records%>" maxlength="50"></td>
	  	  		</tr>
				<tr class="line-even">
                                <td width="15%" align="right">企业状态：</td>
	  	    		<td width="85%"><input name="et_status" size="20" class="text-line" value="<%=et_status%>" maxlength="50"></td>
	  	  		</tr>
				<tr class="line-even">
                                <td width="15%" align="right">许可证号:</td>
	  	    		<td width="85%"><input name="et_licensetime" size="20" class="text-line" value="<%=et_licensetime%>" maxlength="50"><font color=red>*</font>					
					</td>
			 </tr>	  	  		
				<tr class="line-odd">
	  	    		<td width="15%" align="right"> 发证日期：</td>
	  	    		<td width="85%"><input name="et_license" size="20" class="text-line" value="<%=et_license%>" maxlength="50" onclick="javascript:showCal()" style="cursor:hand" readonly>					
					</td>
		        </tr>
				<tr class="line-odd">
	  	    		<td width="15%" align="right"> 有效期：</td>
	  	    		<td width="85%"><input name="et_limittime" size="20" class="text-line" value="<%=et_limittime%>" maxlength="50" onclick="javascript:showCal()" style="cursor:hand" readonly>					
					</td>
		        </tr>
	  	  		<tr class="line-odd">
	  	    		<td width="15%" align="right">质量负责人：</td>
	  	    		<td width="85%"><input name="et_qaleader" size="20" class="text-line" value="<%=et_qaleader%>" maxlength="50">  	    		
	  	    		</td>
	  	  		</tr>

	  		</table>
        	</td>
      	</tr>
      	<tr colspan="2" class="outset-table">
        <td width="100%" align="center">
          <input class="bttn" value="提交" type="button" onclick="check();" size="6" name="btnSubmit">&nbsp;
          <INPUT TYPE="hidden" name="OPType" value="<%=OPType%>">
          <INPUT TYPE="hidden" name="et_id" value="<%=et_id%>">
          <input class="bttn" value="返回" type="button" onclick="history.back();" size="6" >&nbsp;
        </td>
      </tr>
    </table>
    </td>
  </tr>
</form>
</td>
</tr>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
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
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
