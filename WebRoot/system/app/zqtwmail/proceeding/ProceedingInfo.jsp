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
String dealing_time = "";
String corr_time = "";
Vector vPage = null;
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

String strTitle="新增走千听万处理类型";
        cp_id=CTools.dealString(request.getParameter("cp_id"));
        dept_name=CTools.dealString(request.getParameter("dt_name"));
        if(!cp_id.equals(""))
        {
               sql = "select cp_name,cp_timelimit,dt_id,cp_timelimiting from tb_connproc where cp_id = '" + cp_id + "'";
               Hashtable content = dImpl.getDataInfo(sql);
               if (content!=null)
               {
                 cp_name = content.get("cp_name").toString();
                 deal_time = content.get("cp_timelimit").toString();
                 dealing_time = content.get("cp_timelimiting").toString();
                 dt_id_deal = content.get("dt_id").toString();
                 actiontype = "modify";
                 strTitle = "修改走千听万处理类型";
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
<table WIDTH="100%" CELLPADDING="0" BORDER="0" >
<form action="ProceedingInfoResult.jsp" method="post" name="formData">
      <tr class="line-even" >
        <td  colspan=2>请填写走千听万处理事项资料：（注意带有<font color=red>*</font>的项目必须填写）</td>
                  </tr>
      <tr class="line-odd">
        <td align="right">走千听万处理事项名称：</td><td align="left"><input type="text" name="cp_name" value="<%=cp_name%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-even" width="100%">
                <td width="20%" align="right">受理单位：</td>
                <td align="left"><select class="select-a" name="commonWork">
                        <%
                        sqlStr = "select * from tb_deptinfo order by dt_id";
                        vPage = dImpl.splitPage(sqlStr,request,150);
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

<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=cp_id value=<%=cp_id%>>
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
	
  function doAction() {
  	if (formData.cp_name.value == "") {
  		alert("请输入走千听万处理事项名称！");
  		formData.cp_name.focus();
  		return false;
  	}
  	if (formData.commonWork.value == "") {
  		alert("请输入受理单位！");
  		formData.commonWork.focus();
  		return false;
  	}
  	if (formData.deal_time.value == "") {
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
                                     
