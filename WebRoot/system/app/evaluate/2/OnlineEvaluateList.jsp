<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>
<%@page import="Evaluate.*"%>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="3"><b>浦东新区教育系统行风状况调查问卷</b></td>
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
	out.print(evaluate.showStat("em_q1_1",4,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "2、性别";
	strtemp[1] = "① 男";
	strtemp[2] = "② 女";
	out.print(evaluate.showStat("em_q1_2",2,"tb_examine2",strtemp));
%>
<%
	strtemp[0] = "3、文化程度";
	strtemp[1] = "① 大专及以上";
	strtemp[2] = "② 高中、中专、技校、职校";
	strtemp[3] = "③ 初中及以下";
	out.print(evaluate.showStat("em_q1_3",3,"tb_examine2",strtemp));
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
	out.print(evaluate.showStat("em_q1_4",9,"tb_examine2",strtemp));
%>	
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">二、您对环保系统行业风气的看法</td>
										</tr>
<%
	strtemp[0] = "1、目前在哪类学校及幼儿园就读";
	strtemp[1] = "a、市重点高中";
	strtemp[2] = "b、区（县）重点高中";
	strtemp[3] = "c 、公办普通高中";
	strtemp[4] = "d、民办高中";
	strtemp[5] = "e、转制高中";
	strtemp[6] = "f 、公办初级中学";
	strtemp[7] = "g、民办初级中学";
	strtemp[8] = "h、转制初级中学";
	strtemp[9] = "i、公办小学";
	strtemp[10] = "j、民办小学";
	strtemp[11] = "k、转制小学";
	strtemp[12] = "l、公办幼儿园";
	strtemp[13] = "m、民办幼儿园";
	strtemp[14] = "n、其他";
	out.print(evaluate.showStat("em_q2_1",14,"tb_examine2",strtemp));
%>
<%
	strtemp[0] = "2、怎样进入目前学校就读：（选④后可复选具体情况）";
	strtemp[1] = "① 正常报考录取";
	strtemp[2] = "② 就近对口入学";
	strtemp[3] = "③ 自行选择民办学校";
	strtemp[4] = "④ 通过熟人找关系自行选择公办学校";
	strtemp[5] = "④ 捐资入学自行选择公办学校";
	out.print(evaluate.showCheckBoxStat("em_q2_2",5,"tb_examine2",strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">三、您对教育系统行业风气的看法</td>
										</tr>
<%
	strtemp[0] = "1、你对教育系统行业风气的评价";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	out.print(evaluate.showStat("em_q3_1",5,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "2、您认为教育系统在收费问题上的风气同2003年相比";
	strtemp[1] = "① 明显好转";
	strtemp[2] = "② 有好转";
	strtemp[3] = "③ 差不多";
	strtemp[4] = "④ 更差";
	strtemp[5] = "⑤ 不了解";
	out.print(evaluate.showStat("em_q3_2",5,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "3、您认为教育系统在按规定收费方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showStat("em_q3_3",6,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "4、您在缴费时是否知道市统一规定的收费标准";
	strtemp[1] = "① 是";
	strtemp[2] = "② 否";
	out.print(evaluate.showStat("em_q3_4",2,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "5、您是怎样知道上述统一规定标准的（可复选）";
	strtemp[1] = "① 通过《收费联系册》";
	strtemp[2] = "② 学校公告";
	strtemp[3] = "③ 其他途径";
	out.print(evaluate.showCheckBoxStat("em_q3_5",3,"tb_examine2",strtemp));
%>
<%
	strtemp[0] = "6、您对目前市、区统一规定的学校收费项目";
	strtemp[1] = "① 能承受";
	strtemp[2] = "② 基本能承受";
	strtemp[3] = "③ 不能承受";
	out.print(evaluate.showStat("em_q3_6",3,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "7、您认为当前学校乱收费主要表现在什么问题上（可复选）";
	strtemp[1] = "① 对不到录取线或不属本地段的学生收取高额赞助费（包括实物）";
	strtemp[2] = "② 学校通过组织补课乱收费";
	strtemp[3] = "③ 在代办伙食、代订牛奶、统一订购书报（包括练习资料、书籍及其他学习用品）、组织参观（包括春游、秋游等）等方面进行收费";
	out.print(evaluate.showCheckBoxStat("em_q3_7",3,"tb_examine2",strtemp));
%>
<%
	strtemp[0] = "8、学校在代办、代购和组织活动中的收费是否坚持自愿的原则";
	strtemp[1] = "① 是";
	strtemp[2] = "② 否";
	out.print(evaluate.showStat("em_q3_8",2,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "9、您认为学校是否存在乱收费现象。若有，你是从何途径得知的";
	strtemp[1] = "① 存在乱收费，直接感受到的";
	strtemp[2] = "② 存在乱收费，听别人告知或议论的";
	strtemp[3] = "③ 不存在乱收费";
	out.print(evaluate.showStat("em_q3_9",3,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "10、您是否交过与入学挂钩的赞助费或实物。若有，是否出于自愿";
	strtemp[1] = "① 是，自愿";
	strtemp[2] = "② 是，不自愿";
	strtemp[3] = "③ 否";
	out.print(evaluate.showStat("em_q3_10",3,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "11、您捐款（实物）后，教育行政部门是否开具统一收据、荣誉证书和意向书（协议书）";
	strtemp[1] = "① 有";
	strtemp[2] = "② 无";
	strtemp[3] = "③ 开具三项中的一项";
	out.print(evaluate.showStat("em_q3_11",3,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "12、您捐赠的钱款（或实物）的价值：（人民币）";
	strtemp[1] = "① 5000元以下";
	strtemp[2] = "② 5000—10000元";
	strtemp[3] = "③ 10000—30000元";
	strtemp[4] = "④ 30000—50000元";
	strtemp[5] = "⑤ 50000元以上";
	out.print(evaluate.showStat("em_q3_12",5,"tb_examine2",strtemp));
%>	
<%
	strtemp[0] = "四、您认为当前教育系统必须重点抓的行风问题是（限选3项）";
	strtemp[1] = "① 有些教师热衷于搞有偿家教";
	strtemp[2] = "② 学校变相硬性规定学生订书、订报或参加缴费的活动";
	strtemp[3] = "③ 捐资（赞助费）与入学或择校挂钩";
	strtemp[4] = "④ 学校把举办各种补习班、特色班、提高班作为创收的渠道";
	strtemp[5] = "⑤ 其他";
	out.print(evaluate.showCheckBoxStat("em_q4",5,"tb_examine2",strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3"><a href="Message.jsp">查看详细投票情况</a></td>
										</tr> 										
</table>

<%@include file="/system/app/skin/bottom.jsp"%>