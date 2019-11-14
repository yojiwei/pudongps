<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>
<%
String sqlStr="";
String dt_id="";
String dt_name="";
String dt_addr="";
String dt_phone="";
String dt_create_time="";
String dt_email="";
String dt_postnum="";
String dt_postaddr="";
String dt_fax="";
String dt_principal="";//负责人
String dt_officehours="";
String dt_x="";
String dt_y="";

dt_id = CTools.dealString(request.getParameter("dt_id"));
String OPType = CTools.dealString(request.getParameter("OPType"));
//
CDataCn dCn = null;
CDataImpl dImpl = null;
Hashtable content = null; 
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
sqlStr = "select d.*,to_char(d.dt_create_time,'yyyy-mm-dd') as indate from tb_departinfo d where dt_id =" + dt_id ;
content = dImpl.getDataInfo(sqlStr);
if(content!=null){
	dt_id = content.get("dt_id").toString();
	dt_name=content.get("dt_name").toString();
	dt_addr = content.get("dt_addr").toString();
	dt_phone = content.get("dt_phone").toString();
	dt_create_time=content.get("indate").toString();
	dt_postnum=content.get("dt_postnum").toString();	
    dt_postaddr = content.get("dt_postaddr").toString();
	dt_fax = content.get("dt_fax").toString();
	dt_principal = content.get("dt_principal").toString();
	dt_officehours = content.get("dt_officehours").toString();
	dt_x = content.get("dt_x").toString();
	dt_y = content.get("dt_y").toString();
	dt_email = content.get("dt_email").toString();
	OPType = "Edit";
}else{
	dt_create_time = new CDate().getThisday();
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
受理机构信息编辑
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->

<table WIDTH="100%" CELLPADDING="0" cellspacing="1"  BORDER="0">
<form name="formData" action="deptResult.jsp" method="post" >
			<tr class="line-even" >
            <td width="19%" align="right">机构名称：</td>
            <td width="81%" align="left"><input type="text" name="dt_name"  class="text-line" size="40" value="<%=dt_name%>" maxlength="200"/>
            </td>
        </tr>			          
      <tr class="line-even" >
            <td width="19%" align="right">机构地址：</td>
            <td width="81%" align="left"><input type="text" name="dt_addr"  class="text-line" size="40" value="<%=dt_addr%>" maxlength="200"/>
            </td>
      </tr>
	  <tr class="line-even" >
            <td width="19%" align="right">机构办公时间：</td>
            <td width="81%" align="left"><input type="text" name="dt_officehours"  class="text-line" size="40" value="<%=dt_officehours%>" maxlength="200"/>
            </td>
      </tr>
	   <tr class="line-even" >
            <td width="19%" align="right">联系电话：</td>
            <td width="81%" align="left"><input type="text" name="dt_phone"  class="text-line" size="20" value="<%=dt_phone%>" maxlength="50"/>
            </td>
      </tr>
	  <tr class="line-even" >
            <td width="19%" align="right">传真号码：</td>
            <td width="81%" align="left"><input type="text" name="dt_fax"  class="text-line" size="20" value="<%=dt_fax%>" maxlength="50"/>
            </td>
      </tr>
	  <tr class="line-even" >
            <td width="19%" align="right">信函地址：</td>
            <td width="81%" align="left"><input type="text" name="dt_postaddr"  class="text-line" size="40" value="<%=dt_postaddr%>" maxlength="200"/>
            </td>
      </tr>
	  <tr class="line-even" >
            <td width="19%" align="right">邮编：</td>
            <td width="81%" align="left"><input type="text" name="dt_postnum"  class="text-line" size="20" value="<%=dt_postnum%>" maxlength="50"/>
            </td>
      </tr>
	  <tr class="line-even" >
            <td width="19%" align="right">Email地址：</td>
            <td width="81%" align="left"><input type="text" name="dt_email"  class="text-line" size="40" value="<%=dt_email%>" maxlength="200"/>
            </td>
      </tr>
	   <tr class="line-even" >
            <td width="19%" align="right">负责人：</td>
            <td width="81%" align="left"><input type="text" name="dt_officehours"  class="text-line" size="20" value="<%=dt_officehours%>" maxlength="50"/>
            </td>
      </tr>
	  <tr class="line-even" >
            <td width="19%" align="right">生成日期：</td>
            <td width="81%" align="left"><input type="text" name="dt_create_time"  class="text-line" size="20" value="<%=dt_create_time%>" maxlength="50"/>
            </td>
      </tr>	
	   <tr class="line-even" >
            <td width="19%" align="right">地图x轴：</td>
            <td width="81%" align="left"><input type="text" name="mp_x" class="text-line" size="10" value="<%=dt_x%>" maxlength="5"/>
            </td>
      </tr>	
	  <tr class="line-even" >
            <td width="19%" align="right">地图y轴：</td>
            <td width="81%" align="left"><input type="text" name="mp_y"  class="text-line" size="10" value="<%=dt_y%>" maxlength="5"/>
            </td>
      </tr>	
	  <tr class="line-even" >
            <td width="19%" align="right">查看坐标：</td>
            <td width="81%" align="left"><input type="button" class="bttn" onclick="javascript:window.open('showMap01.jsp')" value="显示地图" style="cursor:hand">
            </td>
      </tr>
	   <tr class="outset-table">
		   <td align="center" height="20" colspan=2>
		   <input type="button"   onclick="checkFrm()" value="保存">
		   <input type="button" 　 onclick="delfrm()" value="删除">
		   <input type="button" 　 onclick="javascript:history.go(-1);" value="返回"　>	
	</td>
  </tr>
  		<input type="hidden" name="dt_id" value="<%=dt_id%>">
<input type="hidden" name="OPType" value="<%=OPType%>">
</form>
</table>

<script  language="javascript">
		function checkFrm(){
			if(formData.dt_name.value =="")
			{
				alert("请填写机构名称!");
				formData.dt_name.focus();
				return false;
			}
			if(formData.mp_x.value =="")
			{
				alert("请填写地图x轴!");
				formData.mp_x.focus();
				return false;
			}
			if(isNaN(formData.mp_x.value)){
				alert("地图x轴不能为非数值");
				formData.mp_x.focus();
				return false;
			}
			if(formData.mp_y.value =="")
			{
				alert("请填写地图y轴!");
				formData.mp_y.focus();
				return false;
			}
			if(isNaN(formData.mp_y.value)){
				alert("地图y轴不能为非数值");
				formData.mp_y.focus();
				return false;
			}
			document.formData.submit();
		}
		function delfrm(){
		  
		   if(confirm("确实要删除吗?")){	
			  document.formData.action="deptDel.jsp";
			  document.formData.submit();
		   }
		}
		</script>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception ex){
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
