<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String GW_ID = "";
String sql = "";
String GW_NAME = "";
String GW_SEQUENCE = "";
String DT_ID = "";
String actiontype="add";

String sqlStr = "select * from tb_deptinfo where dt_iswork=1 order by dt_id";
String strTitle="新增分类办事";
Hashtable content = null;
Hashtable content_dt = null;
String dt_id = "";
String dt_name = "";
Vector vPage = null;//dImpl.splitPage(sqlStr,request,100);

CDataCn dCn = null; //新建数据库连接对象
CDataImpl dImpl = null; //新建数据接口对象
try{
dCn = new CDataCn(); //新建数据库连接对象
dImpl = new CDataImpl(dCn); //新建数据接口对象

GW_ID=CTools.dealString(request.getParameter("GW_ID"));
if(!GW_ID.equals(""))
{
  sql = "select gw_name,gw_sequence,dt_id from tb_gasortwork where gw_id = '" + GW_ID + "'";
  content = dImpl.getDataInfo(sql);
 if (content!=null)
  {
   GW_NAME=content.get("gw_name").toString();
   GW_SEQUENCE=content.get("gw_sequence").toString();
	 DT_ID=content.get("dt_id").toString();
   actiontype="modify";
   strTitle="修改分类办事";
}
}
vPage = dImpl.splitPage(sqlStr,request,100);
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
<%=strTitle%>
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->

<table WIDTH="100%" CELLPADDING="0" BORDER="0" cellspacing="1">
<form action="SortWorkResult.jsp" method="post" name="formData">      <tr class="line-odd">
        <td width="30%" align="right">事项名称： </td>
        <td align="left"><input type="text" name="GW_NAME" value="<%=GW_NAME%>" class="text-line"></td>
      </tr>
	  <tr class="line-even">
        <td align="right">所属单位： </td>
		<td align="left"><select class="select-a" name="commonWork">
          <%
          if (vPage!=null)
          {
              for(int i=0;i<vPage.size();i++)
              {
                      content_dt = (Hashtable)vPage.get(i);
                      dt_id = content_dt.get("dt_id").toString();
                      dt_name = content_dt.get("dt_name").toString();
                      %>
                      <option value="<%=dt_id%>"<%if(dt_id.equals(DT_ID)) out.print("selected");%>><%=dt_name%></option>
                      <%
              }
          }
          %>
            </select>
			</td>
      </tr>
      <tr class="line-odd">
        <td align="right">事项序号： </td>
        <td align="left"><input type="text" name="GW_SEQUENCE" value="<%=GW_SEQUENCE%>" class="text-line"></td>
      </tr>
      <tr class=outset-table>
    <td align=center colspan=2>
    <input type=submit name=b1 value="提交" class="bttn" >&nbsp;<input type=reset name=b1 value="重填" class="bttn">
  </td>
 </tr><input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=GW_ID value=<%=GW_ID%>>
</form>
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
                                     
