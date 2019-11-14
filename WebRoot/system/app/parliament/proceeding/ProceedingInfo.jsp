<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
String cp_id = "";
String sql = "";
String sql_judge = "";
String sqlStr = "";
String sqlCorr = "";
String cp_name = "";
String dept_name = "区府办";
String dt_name = "";
String dt_id = "";
String dt_id_deal = "";
String actiontype="add";
String actiontype_corr="add";
String pc_id = "";
String deal_time = "30";
String corr_time = "15";
Vector vPage = null;

CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String strTitle="新增信箱处理类型";
cp_id=CTools.dealString(request.getParameter("cp_id"));
dept_name=CTools.dealString(request.getParameter("dt_name"));
if(!cp_id.equals(""))
{
       sql_judge = "select pc_id from tb_connproccorr where cp_id='" + cp_id + "'";
       Hashtable content_judge = dImpl.getDataInfo(sql_judge);
       if (content_judge!=null)
       {
         pc_id = content_judge.get("pc_id").toString();
       }
       sql = "select cp_name,cp_timelimit from tb_connproc where cp_id = '" + cp_id + "'";
       Hashtable content = dImpl.getDataInfo(sql);
       if (content!=null)
       {
         cp_name = content.get("cp_name").toString();
         deal_time = content.get("cp_timelimit").toString();
         actiontype = "modify";
         strTitle = "修改信件处理类型";
        }
       if(!pc_id.equals(""))
       {
        sqlCorr = "select c.dt_id,c.pc_timelimit,d.dt_name from tb_connproccorr c,tb_deptinfo d where c.dt_id=d.dt_id and c.pc_id='" + pc_id + "'";
        Hashtable content_corr = dImpl.getDataInfo(sqlCorr);
        if (content_corr!=null)
        {
         dt_id_deal = content_corr.get("dt_id").toString();
         corr_time = content_corr.get("pc_timelimit").toString();
         actiontype_corr="modify";
         }
   }
 }
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<form action="ProceedingInfoResult.jsp" method="post" name="formData">
<table WIDTH="100%" CELLPADDING="0" BORDER="0" cellspacing="1">
    <tr class="line-even" >
        <td  colspan=2>请填写信箱处理事项资料：（注意带有<font color=red>*</font>的项目必须填写）</td></tr>
      <tr class="line-odd">
        <td align="right">信箱处理事项名称：</td>
        <td align="left"><input type="text" name="cp_name" value="<%=cp_name%>" class="text-line"> <font color=red>*</font></td>
      </tr>
      <tr class="line-odd">
        <td align="right">受理单位：</td><td align="left"><input type="text" name="dt_name" value="<%=dept_name%>" class="text-line" disabled=false></td>
      </tr>
      <tr class="line-odd">
        <td align="right">受理时限：</td><td align="left"><input type="text" name="deal_time" value="<%=deal_time%>" class="text-line"> 天 <font color=red>*</font></td>
      </tr>
      <tr class="line-even" width="100%">
        <td width="20%" align="right">转办单位：</td>
        <td align="left"><select class="select-a" name="commonWork" onchange="change()">
          <%
          sqlStr = "select * from tb_deptinfo where dt_iswork=1 order by dt_id";
          vPage = dImpl.splitPage(sqlStr,request,100);
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
        <td align="right">转办时限：</td><td align="left"><input type="text" name="corr_time" value="<%=corr_time%>" class="text-line"> 天 <font color=red>*</font></td>
      </tr>
      <tr class=outset-table>
    <td align=center colspan=2>
    <input type=submit name=b1 value="提交" class="bttn" >&nbsp;
    <%
	if(actiontype.equals("modify"))
	{
	%>
	<input value="删除" class="bttn" onclick="javascript:del()" type="button" size="6">&nbsp;
    <%
	}	
	%>
    <input type=reset name=b1 value="重填" class="bttn">
  </td>
 </tr>
</table>
<input type=hidden name=actiontype value=<%=actiontype%>>
<input type=hidden name=actiontype_corr value=<%=actiontype_corr%>>
<input type=hidden name=cp_id value=<%=cp_id%>>
<input type=hidden name=pc_id value=<%=pc_id%>>
<input type=hidden name=dt_id value=<%=dt_id%>>
<input type=hidden name=dt_name value=<%=dept_name%>>
</form>

<script language="javascript">
  function  del()
  {
    if(window.confirm('确认要删除该记录么?'))
   {
    window.location="ProceedingInfoDel.jsp?cp_id=<%=cp_id%>";
   }
  }
 function change()
 {
	formData.cp_name.value="办理信件－"+formData.commonWork.options(formData.commonWork.selectedIndex).text;
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
                                     
