<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<script LANGUAGE="javascript" src="/system/common/treeview/chooseTreeJs.jsp"></script>
<script language="javascript">
function doCheck(){
	var formdata = document.formData1;
	if(formdata.EC_NAME.value==""){
		alert("查询条件不能为空！");
		return false;
	}else{
		return true;
	}
}


</script>
<%
String strTitle = "企业信息列表";
String subjectCode="";//获得栏目代码
String ec_name = "",ec_nameEn="",us_name="",ec_corporation="",ec_tel="",ec_enroladd="";
String ec_linkman="",ec_email="",ec_fax="",ec_enrolzip="",ec_produceadd="",ec_other="",ec_cmmi="";
String sqlStr="",strat_time="",end_time="",addSql="",ec_personnel="",ec_personnel_o="";
String old_money="",old_money_en="",oldout_money="",oldout_money_en="",ec_organ="";
String ec_money="",ec_money_en="",out_money="",out_money_en="",manage_area="",ec_time="",tz_cn="",tz_en="";
String ec_type="",ec_profession="",ec_mgr="";
String today = new CDate().getThisday();
String ec_id=CTools.dealString(request.getParameter("ec_id")).trim();

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象
Vector vPage = null;
Hashtable content = null;

try {
dCn = new CDataCn(); 
dImpl = new CDataImpl(dCn); 
CMySelf myProject = (CMySelf)session.getAttribute("mySelf");


sqlStr="select e.*,u.us_name,u.us_nameen from TB_ENTERPVISC e,tb_user u where e.us_id = u.us_id  and e.ec_id="+ec_id;
//out.println(sqlStr);
content = dImpl.getDataInfo(sqlStr);
if(content!=null)
{
	us_name=content.get("us_name").toString();
	ec_name=content.get("ec_name").toString();
	ec_nameEn=content.get("us_nameen").toString();
	ec_produceadd=content.get("ec_produceadd").toString();
	ec_corporation=content.get("ec_corporation").toString();
	ec_tel=content.get("ec_tel").toString();
	ec_enroladd=content.get("ec_enroladd").toString();
	ec_linkman=content.get("ec_linkman").toString();
	ec_email=content.get("ec_email").toString();
	ec_fax=content.get("ec_fax").toString();
	ec_enrolzip=content.get("ec_enrolzip").toString();
	ec_profession=content.get("ec_profession").toString();
	ec_type=content.get("ec_type").toString();
	ec_other=content.get("ec_other").toString();
	tz_cn=content.get("tz_cn").toString();
	tz_en=content.get("tz_en").toString();
	old_money=content.get("old_money").toString();
	old_money_en=content.get("old_money_en").toString();
	oldout_money=content.get("oldout_money").toString();
	oldout_money_en=content.get("oldout_money_en").toString();
	ec_personnel=content.get("ec_personnel").toString();
	ec_personnel_o=content.get("ec_personnel_o").toString();
	ec_corporation=content.get("ec_corporation").toString();
	ec_organ=content.get("ec_organ").toString();
	manage_area=content.get("manage_area").toString();
	ec_mgr=content.get("ec_mgr").toString();
	ec_time=content.get("ec_time").toString();
	ec_cmmi=content.get("ec_cmmi").toString();
	out_money=content.get("out_money").toString();
	out_money_en=content.get("out_money_en").toString();
	ec_money_en=content.get("ec_money_en").toString();
	ec_money=content.get("ec_money").toString();

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
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" class="main-table">
<tr class="line-even">
                    <td width="22%" height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>登录账号：</div></td>
                    <td width="78%" height="40" class="Bk_bottom" style="padding-left:20px;"><%=us_name%></td>
                  </tr>
                  <tr class="line-odd">
                    <td rowspan="2" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>企业名称：</div>                      </td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">中文&nbsp;<%=ec_name%></td>
                  </tr>
                  <tr class="line-even">
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">
                      英文&nbsp;<%=ec_nameEn%></td>
                  </tr>
                  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>经营范围：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=manage_area%> </td>
                  </tr>
                  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>企业合同审核单位：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_corporation%>                </td>
                  </tr>
                  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>注册地：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_enroladd%>
&nbsp;&nbsp;<span class="red_12">*</span>注册时间：<%=ec_time%>
 </td>
                  </tr>
                  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>注册资本(万元)：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">
                     <%=ec_money%>&nbsp;&nbsp;<span class="red_12">*</span>折万美元：<%=ec_money_en%></td>
                  </tr>
                  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>投资总额(万元)：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">
                      <%=out_money%>&nbsp;&nbsp;<span class="red_12">*</span>折万美元：<%=out_money_en%></td>
                  </tr>
                    <td height="40" class="Bk_bottom_right"><div align="right">投资者设置：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">&nbsp;中方投资者个数
                      <%=tz_cn%>
                      外方投资者个数
                      <%=tz_en%>                     </td>
                  </tr>
                  <tr class="line-even">
                    <td height="40" class="Bk_right">&nbsp;</td>
                    <td height="40" style="padding-left:20px;">投资者名称&nbsp;&nbsp;&nbsp;&nbsp;注册地&nbsp;&nbsp;&nbsp;&nbsp;出资额(万元)&nbsp;&nbsp;&nbsp;&nbsp;折万美元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所占比例(%)</td>
                  </tr>
				  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>上年度营业额(万元)：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">
                      <%=old_money%>&nbsp;&nbsp;<span class="red_12">*</span>折万美元：<%=old_money_en%> </td>
                  </tr>
				  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right">上年度出资额(万元)：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">
                      <%=oldout_money%>&nbsp;&nbsp;折万美元：<%=oldout_money_en%></td>
                  </tr>
				  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>法人代表名称：</div></td>
                    <td height="40" class="Bk_bottom" style="padding-left:20px;">
                     <%=ec_corporation%>&nbsp;&nbsp;<span class="red_12">*</span>组织机构代码： <%=ec_organ%></td>
                  </tr>
				  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>企业类型：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;">
<%=ec_type%>
					</td>
				    </tr>
				  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>行业类别：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;">
<%=ec_profession%>
&nbsp;&nbsp;                    </td>
				    </tr>
				  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>年末从业人员数：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_personnel%> </td>
				    </tr>
				  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>年末大学(含大专)以上学历人员数：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_personnel_o%>                    </td>
				    </tr>
				  <tr class="line-even">
                    <td rowspan="2" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>通过认证情况：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;">CMM(I):
				      <%=ec_cmmi%></td>
				    </tr>
				  <tr class="line-odd">
                    <td height="40" style="padding-left:20px;">其它:
                      <%=ec_other%></td>
                  </tr>
				  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>通讯地址：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_produceadd%>
				      &nbsp;&nbsp;<span class="red_12">*</span>邮政编码：
				      <%=ec_enrolzip%></td>
				    </tr>
				  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>联系人：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_linkman%>
				      &nbsp;&nbsp;<span class="red_12">*</span>电话：
				      <%=ec_tel%></td>
				    </tr>
				  <tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>传真：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_fax%>
				      &nbsp;&nbsp;<span class="red_12">*</span>邮箱：
				      <%=ec_email%></td>
				    </tr>
				  <tr class="line-odd">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>单位负责人：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_mgr%>
				      &nbsp;&nbsp;<span class="red_12">*</span>填表人：
				      <%=ec_linkman%></td>
				    </tr>
					<tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>报出时间：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><%=ec_time%></td>
				    </tr>
					<tr class="line-even">
                    <td height="40" class="Bk_bottom_right"><div align="right"><span class="red_12">*</span>返回：</div></td>
				    <td height="40" class="Bk_bottom" style="padding-left:20px;"><input type="button" name="返回" value="返回" class="bttn" onClick="javascript:history.go(-1)"></td>
				    </tr>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
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
                                     
