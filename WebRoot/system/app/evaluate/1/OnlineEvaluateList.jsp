<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="3"><b>浦东新区环保系统（行业）行风状况调查问卷</b></td>
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
	strtemp[1] = "① 18-25周岁";
	strtemp[2] = "② 26-39周岁";
	strtemp[3] = "③ 40-59周岁";
	strtemp[4] = "④ 60周岁以上";
	out.print(evaluate.showStat("em_q1_1",4,"tb_examine1",strtemp));
%>	
<%
	strtemp[0] = "2、性别";
	strtemp[1] = "① 男";
	strtemp[2] = "② 女";
	out.print(evaluate.showStat("em_q1_2",2,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "3、文化程度";
	strtemp[1] = "① 大专及以上";
	strtemp[2] = "② 高中、中专、技校、职校";
	strtemp[3] = "③ 初中及以下";
	out.print(evaluate.showStat("em_q1_3",3,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "4、所在单位";
	strtemp[1] = "① 工人、营业员、服务员";
	strtemp[2] = "② 农民";
	strtemp[3] = "③ 企业管理人员";
	strtemp[4] = "④ 科技、医务、文体人员";
	strtemp[5] = "⑤ 机关工作者";
	strtemp[6] = "⑥ 教育工作者、学生";
	strtemp[7] = "⑦ 离退休人员";
	strtemp[8] = "⑧ 私营、个体经营者";
	strtemp[9] = "⑨ 环保工作者";
	strtemp[10] = "⑩ 其它";
	out.print(evaluate.showStat("em_q1_4",10,"tb_examine1",strtemp));
%>	
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">二、您对环保系统行业风气的看法</td>
										</tr>
<%
	strtemp[0] = "1、您对环保系统行业风气的评价";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	out.print(evaluate.showStat("em_q2_1",5,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "2、您认为环保系统的行业风气同去年相比";
	strtemp[1] = "① 明显好转";
	strtemp[2] = "② 略有好转";
	strtemp[3] = "③ 没有好转";
	strtemp[4] = "④ 更差";
	out.print(evaluate.showStat("em_q2_2",4,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "3、您认为环保系统在按规定收费方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_3",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "4、您对环保系统在环境监督管理中公正执法方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_4",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "5、按规定，环保系统在审批建设项目时不待强行指定环评、设计、治理单位，您对环保系统在这方面的评价";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_5",6,"tb_examine1",strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">6、您对环保系统下列“窗口”部门的文明礼貌、规范服务的总体评价：</td>
										</tr>
<%
	strtemp[0] = "建设项目审批";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_6_1",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "环境监理";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_6_2",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "环境监测";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_6_3",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "信访接待";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_6_4",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "7、您对环保系统在政务公开，接受社会监督方面的评价";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_7",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "8、您对环保系统在办事效率方面的评价";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_8",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "9、您认为环保系统工作人员在廉洁自律方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_9",6,"tb_examine1",strtemp));
%>
<%
	strtemp[0] = "10、您认为当前环保系统必须重点抓的行风问题是：（请限选三项）";
	strtemp[1] = "① 执法不严、政策法规不熟，执法办事有随意性";
	strtemp[2] = "② 例行监测擅自扩大项目，增加频率";
	strtemp[3] = "③ 违反规定乱收费";
	strtemp[4] = "④ 行政执法人员直接参与环保中介事务";
	strtemp[5] = "⑤ 政务不公开，便民措施不落实";
	strtemp[6] = "⑥ 办事推诿、拖拉、不负责任";
	strtemp[7] = "⑦ 利用职权吃拿卡要报，捞取好处";
	strtemp[8] = "⑧ 办事效率低，工作态度生、硬、冷、推";
	strtemp[9] = "⑨ 其他";
	out.print(evaluate.showCheckBoxStat("em_q2_10",9,"tb_examine1",strtemp));
%>

										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3"><a href="Message.jsp">查看详细投票情况</a></td>
										</tr> 										
</table>

<%@include file="/system/app/skin/bottom.jsp"%>