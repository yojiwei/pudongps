<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String cp_id = "";
String sql = "";
String sql_judge = "";
String sqlStr = "";
String sqlCorr = "";
String cp_name = "";
String dept_name = "";
String dt_name = "";
String dt_id = "";
String dt_id_deal = "";
String actiontype="add";
String pc_id = "";
String deal_time = "";
String ti_id = "";
String tc_id = "";
String dealing_time = "";
String corr_time = "";
Vector vPage = null;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle="新增党务公开领导信箱";
cp_id=CTools.dealString(request.getParameter("cp_id"));
dept_name=CTools.dealString(request.getParameter("dt_name"));
if(!cp_id.equals(""))
{
       sql = "select c.cp_name,c.cp_timelimit,c.dt_id,c.cp_timelimiting,t.ti_id,t.tc_id from tb_connproc c,tb_titlelinkconn t where c.cp_id = t.cp_id and c.cp_id = '" + cp_id + "'";
       Hashtable content = dImpl.getDataInfo(sql);
       if (content!=null)
       {
         cp_name = CTools.dealNull(content.get("cp_name"));
         deal_time = CTools.dealNull(content.get("cp_timelimit"));
         ti_id = CTools.dealNull(content.get("ti_id"));
         tc_id = CTools.dealNull(content.get("tc_id"));
         dealing_time = CTools.dealNull(content.get("cp_timelimiting"));
         dt_id_deal = CTools.dealNull(content.get("dt_id"));
         actiontype = "modify";
         strTitle = "修改党务公开领导信箱";
        }
 }
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle %>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table WIDTH="100%" CELLPADDING="0" BORDER="0">
<form action="ProceedingInfoResult.jsp" method="post" name="formData">
      <tr class="line-even" >
        <td  colspan=2>请填写党务公开领导信箱处理事项资料：（注意带有<font color=red>*</font>的项目必须填写）</td>
                  </tr>
      <tr class="line-odd">
        <td align="right">党务公开领导信箱名称：</td><td align="left"><input type="text" name="cp_name" value="<%=cp_name%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-even" width="100%">
                <td width="20%" align="right">受理单位：</td>
                <td align="left">
              	<select class="select-a" name="commonWork">
                <%
                sqlStr = "select dt_id,dt_name from tb_deptinfo order by dt_id";
                vPage = dImpl.splitPage(sqlStr,request,1000);
                if (vPage!=null)
                {
                        for(int i=0;i<vPage.size();i++)
                        {
                                Hashtable content = (Hashtable)vPage.get(i);
                                dt_id = content.get("dt_id").toString();
                                dt_name = content.get("dt_name").toString();
                                %>
                                <option value="<%=dt_id%>"<%if(dt_id.equals(dt_id_deal)) out.print("selected");%>><%=dt_name%></option>
                                <%
                        }
                }
                %>
                </select> <font color=red>*</font>
                </td>
      </tr>
      <tr class="line-odd">
        <td align="right">受理时限：</td><td align="left"><input type="text" name="deal_time" value="<%=deal_time%>" class="text-line" onKeyDown="floatOnly(value)" maxlength="7"> 天 <font color=red>*</font></td>
      </tr>
      <tr class="line-odd">
        <td align="right">受理中时限：</td>
        <td align="left">
          <input type="text" name="dealing_time" value="<%=dealing_time%>" class="text-line" onKeyDown="floatOnly(value)" maxlength="7"> 天 <font color=red>*</font>
        </td>
      </tr>
      <tr class=outset-table>
    	<td align=center colspan=2>
	    <input type=button name=b1 value="提交" class="bttn" onClick="doAction()">&nbsp;
	    <%if(!cp_id.equals("")) {%>
	    	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
	    <%}%>
	    <input type=reset name=b1 value="重填" class="bttn">&nbsp;
	    <input value="返回" class="bttn" onclick="javascript:history.go(-1);" type="button" size="6">
        </td>
      </tr>
      
<input type="hidden" name = "tc_id" value="<%=tc_id%>"/>
<input type="hidden" name = "ti_id" value="<%=ti_id%>"/>
<input type="hidden" name="actiontype" value="<%=actiontype%>"/>
<input type="hidden" name="cp_id" value="<%=cp_id%>"/>
</form>
</table>
<script language="javascript">
	
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
	   	{ 	}
   		else {
       		event.returnValue=false;
   		}
	}
	
	function  trim(str){
		return  str.replace(/^\s*(.*?)[\s\n]*$/g,  '$1');
	}
	
  function doAction() {
  	if (trim(formData.cp_name.value) == "") {
  		alert("请输入党务公开领导信箱名称！");
  		formData.cp_name.focus();
  		return false;
  	}
  	if (trim(formData.commonWork.value) == "") {
  		alert("请输入受理单位！");
  		formData.commonWork.focus();
  		return false;
  	}
  	if (trim(formData.deal_time.value) == "") {
  		alert("请输入受理时限！");
  		formData.deal_time.focus();
  		return false;
  	}
  	formData.submit();
  }
  
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="ProceedingInfoDel.jsp?cp_id=<%=cp_id%>";
   }
  }
</script>
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
                                     
