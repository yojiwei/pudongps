<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="3"><b>浦东新区卫生（医疗）系统行风状况调查问卷</b></td>
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
	out.print(evaluate.showStat("em_q1_1",4,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "2、性别";
	strtemp[1] = "① 男";
	strtemp[2] = "② 女";
	out.print(evaluate.showStat("em_q1_2",2,"tb_examine3",strtemp));
%>
<%
	strtemp[0] = "3、文化程度";
	strtemp[1] = "① 大专及以上";
	strtemp[2] = "② 高中、中专、技校、职校";
	strtemp[3] = "③ 初中及以下";
	out.print(evaluate.showStat("em_q1_3",3,"tb_examine3",strtemp));
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
	strtemp[9] = "⑨ 其它";
	out.print(evaluate.showStat("em_q1_4",9,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "5、您就诊最多的医院";
	strtemp[1] = "① 市级医院";
	strtemp[2] = "② 市级医院浦东分院";
	strtemp[3] = "③ 区级医院";
	strtemp[4] = "④ 街道医院";
	strtemp[5] = "⑤ 镇卫生院";
	out.print(evaluate.showStat("em_q1_5",5,"tb_examine3",strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">二、您对卫生部门行业风气的看法</td>
										</tr>
<%
	strtemp[0] = "1、您对卫生部门行业风气的评价";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	out.print(evaluate.showStat("em_q2_1",5,"tb_examine3",strtemp));
%>
<%
	strtemp[0] = "2、您认为卫生部门的行业风气同2003年相比";
	strtemp[1] = "① 明显好转";
	strtemp[2] = "② 略有好转";
	strtemp[3] = "③ 没有好转";
	strtemp[4] = "④ 更差";
	out.print(evaluate.showStat("em_q2_2",4,"tb_examine3",strtemp));
%>
<%
	strtemp[0] = "3、您认为卫生部门在按规定收费方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_3",6,"tb_examine3",strtemp));
%>
<%
	strtemp[0] = "4、你对卫生部门的服务态度";
	strtemp[1] = "① 满意";
	strtemp[2] = "② 较满意";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 不满意";
	strtemp[5] = "⑤ 很不满意";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_4",6,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "5、您是否因看病或推销药品，给医院工作人员送钱物";
	strtemp[1] = "① 是";
	strtemp[2] = "② 否";
	out.print(evaluate.showStat("em_q2_5",2,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "6、价值";
	strtemp[1] = "① 500元以下";
	strtemp[2] = "② 500—1000元";
	strtemp[3] = "③ 1000-2000元";
	strtemp[4] = "④ 2000元以上";
	strtemp[5] = "⑤ 其它方式（旅游等）";
	out.print(evaluate.showStat("em_q2_6",5,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "7、您给医院工作人员送钱物的原因是";
	strtemp[1] = "① 想得到方便";
	strtemp[2] = "② 医务人员暗示索要";
	strtemp[3] = "③ 出于感谢";
	strtemp[4] = "④ 其他";
	out.print(evaluate.showStat("em_q2_7",4,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "8、您给医院工作人员送钱物时，他们的态度和做法是";
	strtemp[1] = "① 拒绝";
	strtemp[2] = "② 退回";
	strtemp[3] = "③ 收下";
	strtemp[4] = "④ 其他";
	out.print(evaluate.showStat("em_q2_8",4,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "9、您认为卫生监督执法部门公开办事制度廉洁执法方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q2_9",6,"tb_examine3",strtemp));
%>	
<%
	strtemp[0] = "10、您认为当前卫生系统（行业）必须重点抓的行风问题是：（请限选三项）";
	strtemp[1] = "① 服务态度生冷硬";
	strtemp[2] = "② 违反规定乱收费、乱罚款";
	strtemp[3] = "③ 收受钱物";
	strtemp[4] = "④ 以物代药";
	strtemp[5] = "⑤ 卫生监督执法部门吃拿卡要报";
	strtemp[6] = "⑥ 卫生监督执法部门执法随意性";
	strtemp[7] = "⑦ 卫生监督执法部门办事效率低";
	strtemp[8] = "⑧ 其他";
	out.print(evaluate.showCheckBoxStat("em_q2_10",8,"tb_examine3",strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3"><a href="Message.jsp">查看详细投票情况</a></td>
										</tr> 										
</table>

<%@include file="/system/app/skin/bottom.jsp"%>