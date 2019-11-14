<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>
<%
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String sqlStr = "";
Hashtable content = null;
String il_id = "";
String[] il_begin = {"","","",""};
String[] il_end = {"","","",""};
String OPType = "";
il_id = CTools.dealString(request.getParameter("il_id"));
OPType = CTools.dealString(request.getParameter("OPType"));

if(OPType.equals("Edit")){
	sqlStr = "select il_begin,il_end from tb_iplist where il_id = " + il_id;
	content = dImpl.getDataInfo(sqlStr);
	if(content!=null){
		il_begin = CTools.split(content.get("il_begin").toString(),".");
		il_end = CTools.split(content.get("il_end").toString(),".");
	}
}

CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
String sjId = CTools.dealString(request.getParameter("sjId"));
String sjName = CTools.dealString(request.getParameter("sjName"));
if(session.getAttribute("temppath")!=null) session.setAttribute("temppath",null);
//mySelf.setSJRole();
String sj_id=CTools.dealNumber(request.getParameter("sj_id")).trim();
if(sj_id.equals("0"))sj_id="";


dImpl.closeStmt();
dCn.closeCn();
%>
<script language=javascript>
function checkFrm(flag)
{
  //formData.sjName.value=formData.Module.value;
  //formData.sjId.value=formData.ModuleDirIds.value;
  if (document.formData.il_begin_1.value == "" || document.formData.il_begin_2.value == "" || document.formData.il_begin_3.value == "" || document.formData.il_begin_4.value == "" || document.formData.il_end_1.value == "" || document.formData.il_end_2.value == "" || document.formData.il_end_3.value == "" || document.formData.il_end_4.value == ""){
  	alert ("请输入完整IP地址！");
  	return false;
  }
  if (parseInt(document.formData.il_end_4.value)<parseInt(document.formData.il_begin_4.value)) {
  	alert ("起始地址不能大于结束地址！");
  	document.formData.il_begin_4.focus();
  	return false;
  }
  document.formData.returnPage.value=flag;
  document.formData.submit();
}

function sv(tar,value){
	eval("document.all."+tar+".value = \""+value+"\";");
}

function checkNum(){
	if (event.keyCode < 45 || event.keyCode > 57)
	event.returnValue = false;
}

function isNum(texNam,str){
  if(""==str){
  return false;
  }
  var form = document.formData
  var reg = /\D/;
  if (str.match(reg) != null){
  alert("请填写0-255之间的整数！");
  var obj=eval ("document.all." + texNam );
  obj.value = '';
  obj.focus();
  //return false;
  }
else
	{
		if (parseInt(str) > 255 || parseInt(str) < 0) {
      alert("请填写0-255之间的整数");
      eval ("form." + texNam + ".value = ''");
      //return false;
		}
	}
}
</script>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
IP地址配置
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%">
<form name="formData" action="ipResult.jsp" method="post">
			          <tr class="line-even" >
			            <td width="19%" align="right">IP地址：</td>
			            <td width="81%" ><input type="text" name="il_begin_1" class="text-line" maxlength="3" size="4" value="<%=il_begin[0]%>" onblur="isNum(this.name,this.value);sv('il_end_1',this.value);" onKeypress="checkNum()">.<input type="text" name="il_begin_2" class="text-line" maxlength="3" size="4" value="<%=il_begin[1]%>" onblur="isNum(this.name,this.value);sv('il_end_2',this.value);" onKeypress="checkNum()">.<input type="text" name="il_begin_3" class="text-line"  maxlength="3" size="4" value="<%=il_begin[2]%>" onblur="isNum(this.name,this.value);sv('il_end_3',this.value);" onKeypress="checkNum()">.<input type="text" name="il_begin_4" class="text-line" size="4" maxlength="3" value="<%=il_begin[3]%>" onblur="isNum(this.name,this.value);" onKeypress="checkNum()"> - <input type="text" name="il_end_1" class="text-line" size="4" value="<%=il_end[0]%>" readonly/>.<input type="text" name="il_end_2" class="text-line" size="4" value="<%=il_end[1]%>" readonly/>.<input type="text" name="il_end_3" class="text-line" size="4" value="<%=il_end[2]%>" readonly/>.<input type="text" name="il_end_4" class="text-line" size="4" value="<%=il_end[3]%>" maxlength="3" onblur="isNum(this.name,this.value);" onKeypress="checkNum()">
			            </td>
			          </tr>
			          		</table>
			          	</TD>
			          </tr>
                              
                                
                                      
                                       </tr>
                                 <tr class=outset-table>
                                           <td align="center" height="20" colspan=2>
										   <input type="button" name="save" class="bttn" onclick="checkFrm('0');" value="保存">
                                           <input type="reset" value="重置" class="bttn" />
										   <input type="reset" value="返回" class="bttn" onclick="javascript:history.back();"/>
                                           </td>
                                 </tr>
</table>
               <input type="hidden" name="dtId" value="<%=Long.toString(mySelf.getDtId())%>"/>
               <INPUT type="hidden" name="urId" value="<%=Long.toString(mySelf.getMyID())%>">
               <input type="hidden" name="returnPage" value="" />
			   <input type="hidden" name="infoStatus" value="" />
			   <input type="hidden" name="il_id" value="<%=il_id%>" />
			   <input type="hidden" name="OPType" value="<%=OPType%>" />
</form>

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
                                     
