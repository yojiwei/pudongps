<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%@page import="Evaluate.*"%>
<%
//String em_id=CTools.dealString(request.getParameter("em_id")).trim();
/*
String em_id="";
String em_workcontent="";
String em_workdept="";
String em_workstation="";
String em_age="";
String em_education="";
String em_dept="";
String em_queation1="";
String em_queation2="";
String em_queation3="";
String em_queation4="";
String em_queation5="";
String em_queation6="";
String em_queation7="";
String em_queation8="";
String em_queation9="";
String em_queation10="";
String em_queation11="";
String em_queation12="";
String em_queation13="";
String em_queation14="";
String em_queation15="";
String em_queation16="";
String em_applypeople="";
String em_idea="";*/

String em_id="";
String em_q1_1="";
String em_q1_2="";
String em_q1_2_1="";
String em_q2="";
String em_q3_1="";
String em_q3_2="";
String em_q3_3="";
String em_q4="";
String em_q5_1_1="";
String em_q5_1_2="";
String em_q5_1_3="";
String em_q5_2_1="";
String em_q5_2_2="";
String em_q5_2_3="";
String em_q5_2_4="";
String em_q5_3_1="";
String em_q5_3_2="";
String em_q5_3_3="";
String em_q5_3_4="";
String em_q5_3_5="";
String em_q5_4_1="";
String em_q5_4_2="";
String em_q5_4_3="";
String em_q5_4_4="";
String em_q5_4_5="";
String em_q5_4_6="";
String em_q5_4_7="";
String em_q5_4_8="";
String em_q6="";

em_id = CTools.dealString(request.getParameter("em_id")).trim();

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String sql_message = " select * from tb_examine4  where em_id='" + em_id + "'";
Hashtable content = dImpl.getDataInfo(sql_message);
if(content!=null)
{
				/*em_id=content.get("em_id").toString();
				em_workcontent=content.get("em_workcontent").toString();
				em_workdept=content.get("em_workdept").toString();
				em_workstation=content.get("em_workstation").toString();
				em_age=content.get("em_age").toString();
				em_education=content.get("em_education").toString();
				em_dept=content.get("em_dept").toString();
				em_queation1=content.get("em_queation1").toString();
				em_queation2=content.get("em_queation2").toString();
				em_queation3=content.get("em_queation3").toString();
				em_queation4=content.get("em_queation4").toString();
				em_queation5=content.get("em_queation5").toString();
				em_queation6=content.get("em_queation6").toString();
				em_queation7=content.get("em_queation7").toString();
				em_queation8=content.get("em_queation8").toString();
				em_queation9=content.get("em_queation9").toString();
				em_queation10=content.get("em_queation10").toString();
				em_queation11=content.get("em_queation11").toString();
				em_queation12=content.get("em_queation12").toString();
				em_queation13=content.get("em_queation13").toString();
				em_queation14=content.get("em_queation14").toString();
				em_queation15=content.get("em_queation15").toString();
				em_queation16=content.get("em_queation16").toString();
				em_applypeople=content.get("em_applypeople").toString();
				em_idea=content.get("em_idea").toString();*/

				em_id=content.get("em_id").toString();
				em_q1_1=content.get("em_q1_1").toString();
				em_q1_2=content.get("em_q1_2").toString();
				em_q1_2_1=content.get("em_q1_2_1").toString();
				em_q2=content.get("em_q2").toString();
				em_q3_1=content.get("em_q3_1").toString();
				em_q3_2=content.get("em_q3_2").toString();
				em_q3_3=content.get("em_q3_3").toString();
				em_q4=content.get("em_q4").toString();
				em_q5_1_1=content.get("em_q5_1_1").toString();
				em_q5_1_2=content.get("em_q5_1_2").toString();
				em_q5_1_3=content.get("em_q5_1_3").toString();
				em_q5_2_1=content.get("em_q5_2_1").toString();
				em_q5_2_2=content.get("em_q5_2_2").toString();
				em_q5_2_3=content.get("em_q5_2_3").toString();
				em_q5_2_4=content.get("em_q5_2_4").toString();
				em_q5_3_1=content.get("em_q5_3_1").toString();
				em_q5_3_2=content.get("em_q5_3_2").toString();
				em_q5_3_3=content.get("em_q5_3_3").toString();
				em_q5_3_4=content.get("em_q5_3_4").toString();
				em_q5_3_5=content.get("em_q5_3_5").toString();
				em_q5_4_1=content.get("em_q5_4_1").toString();
				em_q5_4_2=content.get("em_q5_4_2").toString();
				em_q5_4_3=content.get("em_q5_4_3").toString();
				em_q5_4_4=content.get("em_q5_4_4").toString();
				em_q5_4_5=content.get("em_q5_4_5").toString();
				em_q5_4_6=content.get("em_q5_4_6").toString();
				em_q5_4_7=content.get("em_q5_4_7").toString();
				em_q5_4_8=content.get("em_q5_4_8").toString();
				em_q6=content.get("em_q6").toString();

}
%>

<table class="main-table" width="100%">
    <tr>
  	<td width="100%">
       	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
        	<tr class="title1">
            	<td colspan="10" align="center">
                	评议详细内容
				</td>
			</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>									
										<tr width="100%" class="line-odd">
											<td align="left">一、评议人的基本情况</td>
										</tr>
<%
	Evaluate evaluate = new Evaluate();
	String [] strtemp = new String [20];
	strtemp[0] = "1、年龄";
	strtemp[1] = "① 18-35周岁";
	strtemp[2] = "② 36-45周岁";
	strtemp[3] = "② 45周岁以上";
	out.print(evaluate.showRadioDetail(em_q1_1,3, strtemp));
%>	
<%
	strtemp[0] = "4、所在单位";
	strtemp[1] = "① 工人、营业员、服务员";
	strtemp[2] = "② 服务人员";
	strtemp[3] = "③ 企业管理人员";
	strtemp[4] = "④ 科技、医务、文体人员";
	strtemp[5] = "⑤ 机关工作者";
	strtemp[6] = "⑥ 教育工作者、学生";
	strtemp[7] = "⑦ 离退休人员";
	strtemp[8] = "⑧ 私营、个体经营者";
	strtemp[9] = "⑨ 农民";
	strtemp[10] = "⑩ 其它";
	out.print(evaluate.showRadioDetail(em_q1_2,10, strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">其它（请注明）</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="em_q1_2_1" size="20" class="text-area" readonly value="<%=em_q1_2_1%>">
											</td>
										</tr>	
<%
	strtemp[0] = "二、您所居住的房型和居住小区管理形式";
	strtemp[1] = "① 高层";
	strtemp[2] = "② 多层";
	strtemp[3] = "③ 新建小区";
	strtemp[4] = "④ 直管房";
	strtemp[5] = "⑤ 系统房";
	strtemp[6] = "⑥ 商品房";
	out.print(evaluate.showRadioDetail(em_q2,6, strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">三、所属的小区</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="em_q3_1" size="20" class="text-area" readonly value="<%=em_q3_1%>">街道（镇），<input type="text" name="em_q3_2" size="20" class="text-area" readonly value="<%=em_q3_2%>">路，<input type="text" name="em_q3_3" size="20" class="text-area" readonly value="<%=em_q3_3%>"> 弄
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">四、所属的物业管理单位</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="em_q4" size="20" class="text-area" readonly value="<%=em_q4%>">
											</td>
										</tr>										
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">五、您对当前居住物业管理公司的行风状况在社会上的总体印象</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">窗口形象</td>
										</tr>
<%
	strtemp[0] = "1、办公人员挂牌上岗";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_1_1,4, strtemp));
%>	
<%
	strtemp[0] = "2、办公场所整洁有序";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_1_2,4, strtemp));
%>	
<%
	strtemp[0] = "3、接待人员态度和蔼用语文明";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_1_3,4, strtemp));
%>	
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">事务公开</td>
										</tr>
<%
	strtemp[0] = "1、公开办事制度";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_2_1,4, strtemp));
%>	
<%
	strtemp[0] = "2、公开办事纪律";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_2_2,4, strtemp));
%>	
<%
	strtemp[0] = "3、公开各种业务办理手续、办理程序和办理时限";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_2_3,4, strtemp));
%>	
<%
	strtemp[0] = "4、公开收费项目和标准";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_2_4,4, strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">工作效率</td>
										</tr>
<%
	strtemp[0] = "1、周一至周日全天业务接待";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_3_1,4, strtemp));
%>	
<%
	strtemp[0] = "2、办理业务不推诿扯皮";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_3_2,4, strtemp));
%>	
<%
	strtemp[0] = "3、24小时接待居民报修";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_3_3,4, strtemp));
%>	
<%
	strtemp[0] = "4、小修在3天内修复";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_3_4,4, strtemp));
%>
<%
	strtemp[0] = "5、急修在2小时内到现场，24小时内修复";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_3_5,4, strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">服务质量</td>
										</tr>
<%
	strtemp[0] = "1、维修在约定时间上门，工完料清";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_1,4, strtemp));
%>	
<%
	strtemp[0] = "2、执行维修回访制度";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_2,4, strtemp));
%>	
<%
	strtemp[0] = "3、维修质量达到要求";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_3,4, strtemp));
%>	
<%
	strtemp[0] = "4、严格按规定和标准收费";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_4,4, strtemp));
%>
<%
	strtemp[0] = "5、高层住宅保证一台电梯正常运行";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_5,4, strtemp));
%>
<%
	strtemp[0] = "6、电梯驾驶员坚守岗位";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	strtemp[5] = "⑤ 无电梯驾驶员";
	out.print(evaluate.showRadioDetail(em_q5_4_6,5, strtemp));
%>	
<%
	strtemp[0] = "7、保安员安全防范到位";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_7,4, strtemp));
%>
<%
	strtemp[0] = "8、保洁员保持环境整洁";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showRadioDetail(em_q5_4_8,4, strtemp));
%>

										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">意见和建议：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<textarea name="" class="text-area" rows="5" cols="60%" readonly><%=em_q6%></textarea>
											</td>
										</tr>								

    </table>
    </td>
    </tr>
	<tr class=title1>
	<td>
		<input class="bttn" value="返回" type="button"  size="6" id="button6" name="button6" onclick="javascript:history.go(-1)">
	</td>
	</tr>
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>