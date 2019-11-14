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
String em_q1_3="";
String em_q1_4="";
String em_q1_4_1="";
String em_q2_1="";
String em_q2_2="";
String em_q3_1="";
String em_q3_2="";
String em_q3_3="";
String em_q3_4="";
String em_q3_5="";
String em_q3_6="";
String em_q3_7="";
String em_q3_8="";
String em_q3_9="";
String em_q3_10="";
String em_q3_11="";
String em_q3_12="";
String em_q4="";
String em_q4_1="";
String em_q5="";

em_id = CTools.dealString(request.getParameter("em_id")).trim();

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String sql_message = " select * from tb_examine2  where em_id='" + em_id + "'";
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
				em_q1_3=content.get("em_q1_3").toString();
				em_q1_4=content.get("em_q1_4").toString();
				em_q1_4_1=content.get("em_q1_4_1").toString();
				em_q2_1=content.get("em_q2_1").toString();
				em_q2_2=content.get("em_q2_2").toString();
				em_q3_1=content.get("em_q3_1").toString();
				em_q3_2=content.get("em_q3_2").toString();
				em_q3_3=content.get("em_q3_3").toString();
				em_q3_4=content.get("em_q3_4").toString();
				em_q3_5=content.get("em_q3_5").toString();
				em_q3_6=content.get("em_q3_6").toString();
				em_q3_7=content.get("em_q3_7").toString();
				em_q3_8=content.get("em_q3_8").toString();
				em_q3_9=content.get("em_q3_9").toString();
				em_q3_10=content.get("em_q3_10").toString();
				em_q3_11=content.get("em_q3_11").toString();
				em_q3_12=content.get("em_q3_12").toString();
				em_q4=content.get("em_q4").toString();
				em_q4_1=content.get("em_q4_1").toString();
				em_q5=content.get("em_q5").toString();

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
	strtemp[1] = "① 18-25周岁";
	strtemp[2] = "② 26-39周岁";
	strtemp[3] = "③ 40-59周岁";
	strtemp[4] = "④ 60周岁以上";
	out.print(evaluate.showRadioDetail(em_q1_1,4,strtemp));
%>	
<%
	strtemp[0] = "2、性别";
	strtemp[1] = "① 男";
	strtemp[2] = "② 女";
	out.print(evaluate.showRadioDetail(em_q1_2,2,strtemp));
%>
<%
	strtemp[0] = "3、文化程度";
	strtemp[1] = "① 大专及以上";
	strtemp[2] = "② 高中、中专、技校、职校";
	strtemp[3] = "③ 初中及以下";
	out.print(evaluate.showRadioDetail(em_q1_3,3,strtemp));
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
	out.print(evaluate.showRadioDetail(em_q1_4,9,strtemp));
%>

										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">其它（请注明）</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="em_q1_4_1" size="20" class="text-area" readonly value="<%=em_q1_4_1%>">
											</td>
										</tr>	
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>									
										<tr width="100%" class="line-odd">
											<td align="left">二、您在教育系统学校就读子女情况（若无子女在教育系统学校就读，此部分可不填）</td>
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
	out.print(evaluate.showRadioDetail(em_q2_1,14,strtemp));
%>
<%
	strtemp[0] = "2、怎样进入目前学校就读：（选④后可复选具体情况）";
	strtemp[1] = "① 正常报考录取";
	strtemp[2] = "② 就近对口入学";
	strtemp[3] = "③ 自行选择民办学校";
	strtemp[4] = "④ 通过熟人找关系自行选择公办学校";
	strtemp[5] = "④ 捐资入学自行选择公办学校";
	out.print(evaluate.showCheckBoxDetail(em_q2_2,5,strtemp));
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
	out.print(evaluate.showRadioDetail(em_q3_1,5, strtemp));
%>	
<%
	strtemp[0] = "2、您认为教育系统在收费问题上的风气同2003年相比";
	strtemp[1] = "① 明显好转";
	strtemp[2] = "② 有好转";
	strtemp[3] = "③ 差不多";
	strtemp[4] = "④ 更差";
	strtemp[5] = "⑤ 不了解";
	out.print(evaluate.showRadioDetail(em_q3_2,5, strtemp));
%>	
<%
	strtemp[0] = "3、您认为教育系统在按规定收费方面做得";
	strtemp[1] = "① 好";
	strtemp[2] = "② 较好";
	strtemp[3] = "③ 一般";
	strtemp[4] = "④ 较差";
	strtemp[5] = "⑤ 差";
	strtemp[6] = "⑥ 不了解";
	out.print(evaluate.showRadioDetail(em_q3_3,6, strtemp));
%>	
<%
	strtemp[0] = "4、您在缴费时是否知道市统一规定的收费标准";
	strtemp[1] = "① 是";
	strtemp[2] = "② 否";
	out.print(evaluate.showRadioDetail(em_q3_4,2, strtemp));
%>	
<%
	strtemp[0] = "5、您是怎样知道上述统一规定标准的（可复选）";
	strtemp[1] = "① 通过《收费联系册》";
	strtemp[2] = "② 学校公告";
	strtemp[3] = "③ 其他途径";
	out.print(evaluate.showCheckBoxDetail(em_q3_5,3, strtemp));
%>
<%
	strtemp[0] = "6、您对目前市、区统一规定的学校收费项目";
	strtemp[1] = "① 能承受";
	strtemp[2] = "② 基本能承受";
	strtemp[3] = "③ 不能承受";
	out.print(evaluate.showRadioDetail(em_q3_6,3, strtemp));
%>	
<%
	strtemp[0] = "7、您认为当前学校乱收费主要表现在什么问题上（可复选）";
	strtemp[1] = "① 对不到录取线或不属本地段的学生收取高额赞助费（包括实物）";
	strtemp[2] = "② 学校通过组织补课乱收费";
	strtemp[3] = "③ 在代办伙食、代订牛奶、统一订购书报（包括练习资料、书籍及其他学习用品）、组织参观（包括春游、秋游等）等方面进行收费";
	out.print(evaluate.showCheckBoxDetail(em_q3_7,3, strtemp));
%>
<%
	strtemp[0] = "8、学校在代办、代购和组织活动中的收费是否坚持自愿的原则";
	strtemp[1] = "① 是";
	strtemp[2] = "② 否";
	out.print(evaluate.showRadioDetail(em_q3_8,2, strtemp));
%>	
<%
	strtemp[0] = "9、您认为学校是否存在乱收费现象。若有，你是从何途径得知的";
	strtemp[1] = "① 存在乱收费，直接感受到的";
	strtemp[2] = "② 存在乱收费，听别人告知或议论的";
	strtemp[3] = "③ 不存在乱收费";
	out.print(evaluate.showRadioDetail(em_q3_9,3, strtemp));
%>	
<%
	strtemp[0] = "10、您是否交过与入学挂钩的赞助费或实物。若有，是否出于自愿";
	strtemp[1] = "① 是，自愿";
	strtemp[2] = "② 是，不自愿";
	strtemp[3] = "③ 否";
	out.print(evaluate.showRadioDetail(em_q3_10,3, strtemp));
%>	
<%
	strtemp[0] = "11、您捐款（实物）后，教育行政部门是否开具统一收据、荣誉证书和意向书（协议书）";
	strtemp[1] = "① 有";
	strtemp[2] = "② 无";
	strtemp[3] = "③ 开具三项中的一项";
	out.print(evaluate.showRadioDetail(em_q3_11,3, strtemp));
%>	
<%
	strtemp[0] = "12、您捐赠的钱款（或实物）的价值：（人民币）";
	strtemp[1] = "① 5000元以下";
	strtemp[2] = "② 5000—10000元";
	strtemp[3] = "③ 10000—30000元";
	strtemp[4] = "④ 30000—50000元";
	strtemp[5] = "⑤ 50000元以上";
	out.print(evaluate.showRadioDetail(em_q3_12,5, strtemp));
%>	
<%
	strtemp[0] = "四、您认为当前教育系统必须重点抓的行风问题是（限选3项）";
	strtemp[1] = "① 有些教师热衷于搞有偿家教";
	strtemp[2] = "② 学校变相硬性规定学生订书、订报或参加缴费的活动";
	strtemp[3] = "③ 捐资（赞助费）与入学或择校挂钩";
	strtemp[4] = "④ 学校把举办各种补习班、特色班、提高班作为创收的渠道";
	strtemp[5] = "⑤ 其他";
	out.print(evaluate.showCheckBoxDetail(em_q4,5, strtemp));
%>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">其他（请简写内容）</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<textarea name="" class="text-area" rows="5" cols="60%" readonly><%=em_q4_1%></textarea>
											</td>
										</tr>								

										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">意见和建议：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<textarea name="" class="text-area" rows="5" cols="60%" readonly><%=em_q5%></textarea>
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