<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/system/app/skin/head.jsp"%>
<%@page import="com.component.database.*"%>
<%
//String em_id=CTools.dealString(request.getParameter("em_id")).trim();

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
String em_idea="";

//String em_id = "";
em_id = CTools.dealString(request.getParameter("em_id")).trim();
//String em_workcontent="";
//String em_workdept="";
//String em_workstation="";
//String em_applypeople="";
//String em_idea="";

CDataCn dCn = new CDataCn(); //新建数据库连接对象
CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

String sql_message = " select * from tb_examine  where em_id='" + em_id + "'";
Hashtable content = dImpl.getDataInfo(sql_message);
if(content!=null)
{
	/*
	em_workcontent = content.get("em_workcontent").toString();
	em_workdept = content.get("em_workdept").toString();
	em_workstation = content.get("em_workstation").toString();
	em_applypeople = content.get("em_applypeople").toString();
	em_idea = content.get("em_idea").toString();*/

				em_id=content.get("em_id").toString();
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
				em_idea=content.get("em_idea").toString();
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
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>										
										<tr width="100%" class="line-odd">
											<td align="left">一、评议人的基本情况</td>
										</tr>

										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">办理的内容：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="" size="20" class="text-area" value="<%=em_workcontent%>" readonly>
											</td>
										</tr>

										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">涉及部门：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="" size="20" class="text-area" value="<%=em_workdept%>">
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">涉及岗位：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<input type="text" name="" size="20" class="text-area" value="<%=em_workstation%>">
											</td>
										</tr>






										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">1、年龄</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<%if(em_age.equals("1")){%>
											<span style="background-color: #FFFF00">18-25周岁</span>
											<%}else{%>18-25周岁<%}%>
											</td>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left">																	<%if(em_age.equals("2")){%>
											<span style="background-color: #FFFF00">26-39周岁</span>
											<%}else{%>26-39周岁<%}%>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_age.equals("3")){%>
											<span style="background-color: #FFFF00">40-59周岁</span>
											<%}else{%>40-59周岁<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_age.equals("4")){%>
											<span style="background-color: #FFFF00">60周岁以上</span>
											<%}else{%>60周岁以上<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >2、文化程度</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">										
											<%if(em_education.equals("1")){%>
											<span style="background-color: #FFFF00">大专及以上</span>
											<%}else{%>大专及以上<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_education.equals("2")){%>
											<span style="background-color: #FFFF00">高中、中专、技校、职校</span>
											<%}else{%>高中、中专、技校、职校<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_education.equals("3")){%>
											<span style="background-color: #FFFF00">初中及以下</span>
											<%}else{%>初中及以下<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >3、所在单位</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("1")){%>
											<span style="background-color: #FFFF00">个体工商户</span>
											<%}else{%>个体工商户<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("2")){%>
											<span style="background-color: #FFFF00">私营企业</span>
											<%}else{%>私营企业<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("3")){%>
											<span style="background-color: #FFFF00">国有企业</span>
											<%}else{%>国有企业<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("4")){%>
											<span style="background-color: #FFFF00">事业单位</span>
											<%}else{%>事业单位<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("5")){%>
											<span style="background-color: #FFFF00">外商独资企业</span>
											<%}else{%>外商独资企业<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("6")){%>
											<span style="background-color: #FFFF00">中外合资企业</span>
											<%}else{%>中外合资企业<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_dept.equals("7")){%>
											<span style="background-color: #FFFF00">其他</span>
											<%}else{%>其他<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" >二、对实施行政审批制度改革工作效能情况的评价</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >1、是否有告知以外的（不再审批）事项仍然在审批</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation1.equals("1")){%>
											<span style="background-color: #FFFF00">是</span>
											<%}else{%>是<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation1.equals("2")){%>
											<span style="background-color: #FFFF00">否</span>
											<%}else{%>否<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >2、在办理审批事项时，有关部门和工作人员是否按规定做到："一次讲清、两次受理、三次上门服务、限期办结和差错投诉登门道歉"</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation2.equals("1")){%>
											<span style="background-color: #FFFF00">是</span>
											<%}else{%>是<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation2.equals("2")){%>
											<span style="background-color: #FFFF00">否</span>
											<%}else{%>否<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >3、是否运用告知单、告知栏、触摸屏、电子屏及计算机信息网络等各类媒介，将审批事项、政策法规、办事指南、运作规程、管理要求、政务动态、办事结果等及时向社会公开</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation3.equals("1")){%>
											<span style="background-color: #FFFF00">全部运用</span>
											<%}else{%>全部运用<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation3.equals("2")){%>
											<span style="background-color: #FFFF00">部分运用</span>
											<%}else{%>部分运用<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation3.equals("3")){%>
											<span style="background-color: #FFFF00">没有</span>
											<%}else{%>没有<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >4、是否实行"一站式"网上审批，网上受理、流转、下载、咨询等</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation4.equals("1")){%>
											<span style="background-color: #FFFF00">全部实行</span>
											<%}else{%>全部实行<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation4.equals("2")){%>
											<span style="background-color: #FFFF00">部分实行</span>
											<%}else{%>部分实行<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation4.equals("3")){%>
											<span style="background-color: #FFFF00">未实行</span>
											<%}else{%>未实行<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation5.equals("2")){%>
											<span style="background-color: #FFFF00">全部按程序办理</span>
											<%}else{%>全部按程序办理<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation5.equals("3")){%>
											<span style="background-color: #FFFF00">不按规定的程序办理</span>
											<%}else{%>不按规定的程序办理<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >6、是否在告知的时限内办结您的申请事项</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation6.equals("1")){%>
											<span style="background-color: #FFFF00">是</span>
											<%}else{%>是<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation6.equals("2")){%>
											<span style="background-color: #FFFF00">否</span>
											<%}else{%>否<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >7、办理的事项被否定时是否向您出具不予受理或不予批准的文书并说明理由和告知救济途径</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation7.equals("1")){%>
											<span style="background-color: #FFFF00">是</span>
											<%}else{%>是<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation7.equals("2")){%>
											<span style="background-color: #FFFF00">否</span>
											<%}else{%>否<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >8、窗口接待人员是否有缺岗、离岗现象</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation8.equals("1")){%>
											<span style="background-color: #FFFF00">有</span>
											<%}else{%>是<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation8.equals("2")){%>
											<span style="background-color: #FFFF00">没有</span>
											<%}else{%>否<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation8.equals("3")){%>
											<span style="background-color: #FFFF00">没有发现</span>
											<%}else{%>没有发现<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >9、工作中是否有推诿、扯皮等现象</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation9.equals("1")){%>
											<span style="background-color: #FFFF00">有</span>
											<%}else{%>有<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation9.equals("2")){%>
											<span style="background-color: #FFFF00">无</span>
											<%}else{%>无<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >10、工作人员是否有暗示给好处或吃请等行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation10.equals("1")){%>
											<span style="background-color: #FFFF00">有</span>
											<%}else{%>有<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation10.equals("2")){%>
											<span style="background-color: #FFFF00">无</span>
											<%}else{%>无<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >11、您所接触的部门是否存在"门难进、脸难看、话难听、事难办"现象</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation11.equals("1")){%>
											<span style="background-color: #FFFF00">不存在</span>
											<%}else{%>不存在<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation11.equals("2")){%>
											<span style="background-color: #FFFF00">存在</span>
											<%}else{%>存在<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation11.equals("3")){%>
											<span style="background-color: #FFFF00">严重存在</span>
											<%}else{%>严重存在<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >12、属于"零收费"规定事项是否有收费行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation12.equals("1")){%>
											<span style="background-color: #FFFF00">有</span>
											<%}else{%>有<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation12.equals("2")){%>
											<span style="background-color: #FFFF00">无</span>
											<%}else{%>无<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >13、属于"联合年检"规定的事项是否有其他年检行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation13.equals("1")){%>
											<span style="background-color: #FFFF00">有</span>
											<%}else{%>有<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation13.equals("2")){%>
											<span style="background-color: #FFFF00">无</span>
											<%}else{%>无<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >14、属于"告知承诺"规定的事项是否有实质性审批行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation14.equals("1")){%>
											<span style="background-color: #FFFF00">有</span>
											<%}else{%>有<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation14.equals("2")){%>
											<span style="background-color: #FFFF00">无</span>
											<%}else{%>无<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >15、您对新区机关的办事工作效率、工作质量的评价</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation15.equals("1")){%>
											<span style="background-color: #FFFF00">满意</span>
											<%}else{%>满意<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation15.equals("2")){%>
											<span style="background-color: #FFFF00">较满意</span>
											<%}else{%>较满意<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation15.equals("3")){%>
											<span style="background-color: #FFFF00">一般</span>
											<%}else{%>一般<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation15.equals("4")){%>
											<span style="background-color: #FFFF00">不满意</span>
											<%}else{%>不满意<%}%></td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" >16、您对新区审改效能监察工作的总体评价</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation16.equals("1")){%>
											<span style="background-color: #FFFF00">满意</span>
											<%}else{%>满意<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation16.equals("2")){%>
											<span style="background-color: #FFFF00">较满意</span>
											<%}else{%>较满意<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation16.equals("3")){%>
											<span style="background-color: #FFFF00">一般</span>
											<%}else{%>一般<%}%></td>
										</tr>
										<tr class="line-odd">
											<td align="left">										
											<%if(em_queation16.equals("4")){%>
											<span style="background-color: #FFFF00">不满意</span>
											<%}else{%>不满意<%}%></td>
										</tr>


										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">表扬或提出批评的部门、工作人员：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<textarea name="" class="text-area" rows="5" cols="60%" readonly><%=em_applypeople%></textarea>
											</td>
										</tr>

										<tr>
										 <td background="/website/images/mid10.gif" width="1" ><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left">意见和建议：</td>
										</tr> 
										<tr class="line-odd">
											<td align="left">
											<textarea name="" class="text-area" rows="5" cols="60%" readonly><%=em_idea%></textarea>
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