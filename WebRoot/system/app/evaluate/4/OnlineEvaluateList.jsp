<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="3"><b>浦东新区居住物业管理行业--社区行风评议问卷调查表</b></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3"><a href="Message.jsp">查看详细投票情况</a></td>
										</tr> 
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>										
										<tr width="100%" class="line-odd">	
										  <td align="left" colspan="3">一、您的基本情况</td>
										</tr>
<%
	Evaluate evaluate = new Evaluate();
	String [] strtemp = new String [20];
	strtemp[0] = "1、年龄";
	strtemp[1] = "① 18-35周岁";
	strtemp[2] = "② 36-45周岁";
	strtemp[3] = "② 45周岁以上";
	out.print(evaluate.showStat("em_q1_1",3,"tb_examine4",strtemp));
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
	out.print(evaluate.showStat("em_q1_2",10,"tb_examine4",strtemp));
%>
<%
	strtemp[0] = "二、您所居住的房型和居住小区管理形式";
	strtemp[1] = "① 高层";
	strtemp[2] = "② 多层";
	strtemp[3] = "③ 新建小区";
	strtemp[4] = "④ 直管房";
	strtemp[5] = "⑤ 系统房";
	strtemp[6] = "⑥ 商品房";
	out.print(evaluate.showStat("em_q2",6,"tb_examine4",strtemp));
%>
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
	out.print(evaluate.showStat("em_q5_1_1",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "2、办公场所整洁有序";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_1_2",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "3、接待人员态度和蔼用语文明";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_1_3",4,"tb_examine4",strtemp));
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
	out.print(evaluate.showStat("em_q5_2_1",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "2、公开办事纪律";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_2_2",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "3、公开各种业务办理手续、办理程序和办理时限";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_2_3",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "4、公开收费项目和标准";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_2_4",4,"tb_examine4",strtemp));
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
	out.print(evaluate.showStat("em_q5_3_1",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "2、办理业务不推诿扯皮";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_3_2",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "3、24小时接待居民报修";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_3_3",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "4、小修在3天内修复";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_3_4",4,"tb_examine4",strtemp));
%>
<%
	strtemp[0] = "5、急修在2小时内到现场，24小时内修复";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_3_5",4,"tb_examine4",strtemp));
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
	out.print(evaluate.showStat("em_q5_4_1",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "2、执行维修回访制度";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_4_2",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "3、维修质量达到要求";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_4_3",4,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "4、严格按规定和标准收费";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_4_4",4,"tb_examine4",strtemp));
%>
<%
	strtemp[0] = "5、高层住宅保证一台电梯正常运行";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_4_5",4,"tb_examine4",strtemp));
%>
<%
	strtemp[0] = "6、电梯驾驶员坚守岗位";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	strtemp[5] = "⑤ 无电梯驾驶员";
	out.print(evaluate.showStat("em_q5_4_6",5,"tb_examine4",strtemp));
%>	
<%
	strtemp[0] = "7、保安员安全防范到位";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_4_7",4,"tb_examine4",strtemp));
%>
<%
	strtemp[0] = "8、保洁员保持环境整洁";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	out.print(evaluate.showStat("em_q5_4_8",4,"tb_examine4",strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3"><a href="Message.jsp">查看详细投票情况</a></td>
										</tr> 										
</table>

<%@include file="/system/app/skin/bottom.jsp"%>