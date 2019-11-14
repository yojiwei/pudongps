<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>

<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);		//新建数据接口对象

String age_count_1="";
String age_count_2="";
String age_count_3="";
String age_count_4="";
double agecount1=0;
double agecount2=0;
double agecount3=0;
double agecount4=0;
double age_count_all=0;
double percent_age_1=0;
double percent_age_2=0;
double percent_age_3=0;
double percent_age_4=0;

String sql_age_1 = " select count(em_age) from tb_examine where em_age='1' ";
String sql_age_2 = " select count(em_age) from tb_examine where em_age='2' ";
String sql_age_3 = " select count(em_age) from tb_examine where em_age='3' ";
String sql_age_4 = " select count(em_age) from tb_examine where em_age='4' ";
Hashtable content_age_1 = dImpl.getDataInfo(sql_age_1);
if(content_age_1!=null)
{
	age_count_1 = content_age_1.get("count(em_age)").toString();
}
Hashtable content_age_2 = dImpl.getDataInfo(sql_age_2);
if(content_age_2!=null)
{
	age_count_2 = content_age_2.get("count(em_age)").toString();
}
Hashtable content_age_3 = dImpl.getDataInfo(sql_age_3);
if(content_age_3!=null)
{
	age_count_3 = content_age_3.get("count(em_age)").toString();
}
Hashtable content_age_4 = dImpl.getDataInfo(sql_age_4);
if(content_age_4!=null)
{
	age_count_4 = content_age_4.get("count(em_age)").toString();
}
agecount1 = Double.parseDouble(age_count_1);
agecount2 = Double.parseDouble(age_count_2);
agecount3 = Double.parseDouble(age_count_3);
agecount4 = Double.parseDouble(age_count_4);
age_count_all = agecount1+agecount2+agecount3+agecount4;
if(age_count_all!=0)
{
	percent_age_1 = agecount1/age_count_all;
	percent_age_2 = agecount2/age_count_all;
	percent_age_3 = agecount3/age_count_all;
	percent_age_4 = agecount4/age_count_all;
}

String education_count_1="";
String education_count_2="";
String education_count_3="";
double educationcount1=0;
double educationcount2=0;
double educationcount3=0;
double education_count_all=0;
double percent_education_1=0;
double percent_education_2=0;
double percent_education_3=0;

String sql_education_1 = " select count(em_education) from tb_examine where em_education='1' ";
String sql_education_2 = " select count(em_education) from tb_examine where em_education='2' ";
String sql_education_3 = " select count(em_education) from tb_examine where em_education='3' ";
Hashtable content_education_1 = dImpl.getDataInfo(sql_education_1);
if(content_education_1!=null)
{
	education_count_1 = content_education_1.get("count(em_education)").toString();
}
Hashtable content_education_2 = dImpl.getDataInfo(sql_education_2);
if(content_education_2!=null)
{
	education_count_2 = content_education_2.get("count(em_education)").toString();
}
Hashtable content_education_3 = dImpl.getDataInfo(sql_education_3);
if(content_education_3!=null)
{
	education_count_3 = content_education_3.get("count(em_education)").toString();
}
educationcount1 = Double.parseDouble(education_count_1);
educationcount2 = Double.parseDouble(education_count_2);
educationcount3 = Double.parseDouble(education_count_3);
education_count_all = educationcount1+educationcount2+educationcount3;
if(education_count_all!=0)
{
	percent_education_1 = educationcount1/education_count_all;
	percent_education_2 = educationcount2/education_count_all;
	percent_education_3 = educationcount3/education_count_all;
}

String dept_count_1="";
String dept_count_2="";
String dept_count_3="";
String dept_count_4="";
String dept_count_5="";
String dept_count_6="";
String dept_count_7="";
double deptcount1=0;
double deptcount2=0;
double deptcount3=0;
double deptcount4=0;
double deptcount5=0;
double deptcount6=0;
double deptcount7=0;
double dept_count_all=0;
double percent_dept_1=0;
double percent_dept_2=0;
double percent_dept_3=0;
double percent_dept_4=0;
double percent_dept_5=0;
double percent_dept_6=0;
double percent_dept_7=0;

String sql_dept_1 = " select count(em_dept) from tb_examine where em_dept='1' ";
String sql_dept_2 = " select count(em_dept) from tb_examine where em_dept='2' ";
String sql_dept_3 = " select count(em_dept) from tb_examine where em_dept='3' ";
String sql_dept_4 = " select count(em_dept) from tb_examine where em_dept='4' ";
String sql_dept_5 = " select count(em_dept) from tb_examine where em_dept='5' ";
String sql_dept_6 = " select count(em_dept) from tb_examine where em_dept='6' ";
String sql_dept_7 = " select count(em_dept) from tb_examine where em_dept='7' ";
Hashtable content_dept_1 = dImpl.getDataInfo(sql_dept_1);
if(content_dept_1!=null)
{
	dept_count_1 = content_dept_1.get("count(em_dept)").toString();
}
Hashtable content_dept_2 = dImpl.getDataInfo(sql_dept_2);
if(content_dept_2!=null)
{
	dept_count_2 = content_dept_2.get("count(em_dept)").toString();
}
Hashtable content_dept_3 = dImpl.getDataInfo(sql_dept_3);
if(content_dept_3!=null)
{
	dept_count_3 = content_dept_3.get("count(em_dept)").toString();
}
Hashtable content_dept_4 = dImpl.getDataInfo(sql_dept_4);
if(content_dept_4!=null)
{
	dept_count_4 = content_dept_4.get("count(em_dept)").toString();
}
Hashtable content_dept_5 = dImpl.getDataInfo(sql_dept_5);
if(content_dept_5!=null)
{
	dept_count_5 = content_dept_5.get("count(em_dept)").toString();
}
Hashtable content_dept_6 = dImpl.getDataInfo(sql_dept_6);
if(content_dept_6!=null)
{
	dept_count_6 = content_dept_6.get("count(em_dept)").toString();
}
Hashtable content_dept_7 = dImpl.getDataInfo(sql_dept_7);
if(content_dept_7!=null)
{
	dept_count_7 = content_dept_7.get("count(em_dept)").toString();
}
deptcount1 = Double.parseDouble(dept_count_1);
deptcount2 = Double.parseDouble(dept_count_2);
deptcount3 = Double.parseDouble(dept_count_3);
deptcount4 = Double.parseDouble(dept_count_4);
deptcount5 = Double.parseDouble(dept_count_5);
deptcount6 = Double.parseDouble(dept_count_6);
deptcount7 = Double.parseDouble(dept_count_7);
dept_count_all = deptcount1+deptcount2+deptcount3+deptcount4+deptcount5+deptcount6+deptcount7;
if(dept_count_all!=0)
{
	percent_dept_1 = deptcount1/dept_count_all;
	percent_dept_2 = deptcount2/dept_count_all;
	percent_dept_3 = deptcount3/dept_count_all;
	percent_dept_4 = deptcount4/dept_count_all;
	percent_dept_5 = deptcount5/dept_count_all;
	percent_dept_6 = deptcount6/dept_count_all;
	percent_dept_7 = deptcount7/dept_count_all;
}

String question1_count_1="";
String question1_count_2="";
double question1count1=0;
double question1count2=0;
double question1_count_all=0;
double percent_question1_1=0;
double percent_question1_2=0;

String sql_question1_1 = " select count(em_queation1) from tb_examine where em_queation1='1' ";
String sql_question1_2 = " select count(em_queation1) from tb_examine where em_queation1='2' ";
Hashtable content_question1_1 = dImpl.getDataInfo(sql_question1_1);
if(content_question1_1!=null)
{
	question1_count_1 = content_question1_1.get("count(em_queation1)").toString();
}
Hashtable content_question1_2 = dImpl.getDataInfo(sql_question1_2);
if(content_question1_2!=null)
{
	question1_count_2 = content_question1_2.get("count(em_queation1)").toString();
}
question1count1 = Double.parseDouble(question1_count_1);
question1count2 = Double.parseDouble(question1_count_2);
question1_count_all = question1count1+question1count2;
if(question1_count_all!=0)
{
	percent_question1_1 = question1count1/question1_count_all;
	percent_question1_2 = question1count2/question1_count_all;
}

String question2_count_1="";
String question2_count_2="";
double question2count1=0;
double question2count2=0;
double question2_count_all=0;
double percent_question2_1=0;
double percent_question2_2=0;

String sql_question2_1 = " select count(em_queation2) from tb_examine where em_queation2='1' ";
String sql_question2_2 = " select count(em_queation2) from tb_examine where em_queation2='2' ";
Hashtable content_question2_1 = dImpl.getDataInfo(sql_question2_1);
if(content_question2_1!=null)
{
	question2_count_1 = content_question2_1.get("count(em_queation2)").toString();
}
Hashtable content_question2_2 = dImpl.getDataInfo(sql_question2_2);
if(content_question2_2!=null)
{
	question2_count_2 = content_question2_2.get("count(em_queation2)").toString();
}
question2count1 = Double.parseDouble(question2_count_1);
question2count2 = Double.parseDouble(question2_count_2);
question2_count_all = question2count1+question2count2;
if(question2_count_all!=0)
{
	percent_question2_1 = question2count1/question2_count_all;
	percent_question2_2 = question2count2/question2_count_all;
}

String question3_count_1="";
String question3_count_2="";
String question3_count_3="";
double question3count1=0;
double question3count2=0;
double question3count3=0;
double question3_count_all=0;
double percent_question3_1=0;
double percent_question3_2=0;
double percent_question3_3=0;

String sql_question3_1 = " select count(em_queation3) from tb_examine where em_queation3='1' ";
String sql_question3_2 = " select count(em_queation3) from tb_examine where em_queation3='2' ";
String sql_question3_3 = " select count(em_queation3) from tb_examine where em_queation3='3' ";
Hashtable content_question3_1 = dImpl.getDataInfo(sql_question3_1);
if(content_question3_1!=null)
{
	question3_count_1 = content_question3_1.get("count(em_queation3)").toString();
}
Hashtable content_question3_2 = dImpl.getDataInfo(sql_question3_2);
if(content_question3_2!=null)
{
	question3_count_2 = content_question3_2.get("count(em_queation3)").toString();
}
Hashtable content_question3_3 = dImpl.getDataInfo(sql_question3_3);
if(content_question3_3!=null)
{
	question3_count_3 = content_question3_3.get("count(em_queation3)").toString();
}
question3count1 = Double.parseDouble(question3_count_1);
question3count2 = Double.parseDouble(question3_count_2);
question3count3 = Double.parseDouble(question3_count_3);
question3_count_all = question3count1+question3count2+question3count3;
if(question3_count_all!=0)
{
	percent_question3_1 = question3count1/question3_count_all;
	percent_question3_2 = question3count2/question3_count_all;
	percent_question3_3 = question3count3/question3_count_all;
}

String question4_count_1="";
String question4_count_2="";
String question4_count_3="";
double question4count1=0;
double question4count2=0;
double question4count3=0;
double question4_count_all=0;
double percent_question4_1=0;
double percent_question4_2=0;
double percent_question4_3=0;

String sql_question4_1 = " select count(em_queation4) from tb_examine where em_queation4='1' ";
String sql_question4_2 = " select count(em_queation4) from tb_examine where em_queation4='2' ";
String sql_question4_3 = " select count(em_queation4) from tb_examine where em_queation4='3' ";
Hashtable content_question4_1 = dImpl.getDataInfo(sql_question4_1);
if(content_question4_1!=null)
{
	question4_count_1 = content_question4_1.get("count(em_queation4)").toString();
}
Hashtable content_question4_2 = dImpl.getDataInfo(sql_question4_2);
if(content_question4_2!=null)
{
	question4_count_2 = content_question4_2.get("count(em_queation4)").toString();
}
Hashtable content_question4_3 = dImpl.getDataInfo(sql_question4_3);
if(content_question4_3!=null)
{
	question4_count_3 = content_question4_3.get("count(em_queation4)").toString();
}
question4count1 = Double.parseDouble(question4_count_1);
question4count2 = Double.parseDouble(question4_count_2);
question4count3 = Double.parseDouble(question4_count_3);
question4_count_all = question4count1+question4count2+question4count3;
if(question4_count_all!=0)
{
	percent_question4_1 = question4count1/question4_count_all;
	percent_question4_2 = question4count2/question4_count_all;
	percent_question4_3 = question4count3/question4_count_all;
}

String question5_count_1="";
String question5_count_2="";
double question5count1=0;
double question5count2=0;
double question5_count_all=0;
double percent_question5_1=0;
double percent_question5_2=0;

String sql_question5_1 = " select count(em_queation5) from tb_examine where em_queation5='1' ";
String sql_question5_2 = " select count(em_queation5) from tb_examine where em_queation5='2' ";
Hashtable content_question5_1 = dImpl.getDataInfo(sql_question5_1);
if(content_question5_1!=null)
{
	question5_count_1 = content_question5_1.get("count(em_queation5)").toString();
}
Hashtable content_question5_2 = dImpl.getDataInfo(sql_question5_2);
if(content_question5_2!=null)
{
	question5_count_2 = content_question5_2.get("count(em_queation5)").toString();
}
question5count1 = Double.parseDouble(question5_count_1);
question5count2 = Double.parseDouble(question5_count_2);
question5_count_all = question5count1+question5count2;
if(question5_count_all!=0)
{
	percent_question5_1 = question5count1/question5_count_all;
	percent_question5_2 = question5count2/question5_count_all;
}

String question6_count_1="";
String question6_count_2="";
double question6count1=0;
double question6count2=0;
double question6_count_all=0;
double percent_question6_1=0;
double percent_question6_2=0;

String sql_question6_1 = " select count(em_queation6) from tb_examine where em_queation6='1' ";
String sql_question6_2 = " select count(em_queation6) from tb_examine where em_queation6='2' ";
Hashtable content_question6_1 = dImpl.getDataInfo(sql_question6_1);
if(content_question6_1!=null)
{
	question6_count_1 = content_question6_1.get("count(em_queation6)").toString();
}
Hashtable content_question6_2 = dImpl.getDataInfo(sql_question6_2);
if(content_question6_2!=null)
{
	question6_count_2 = content_question6_2.get("count(em_queation6)").toString();
}
question6count1 = Double.parseDouble(question6_count_1);
question6count2 = Double.parseDouble(question6_count_2);
question6_count_all = question6count1+question6count2;
if(question6_count_all!=0)
{
	percent_question6_1 = question6count1/question6_count_all;
	percent_question6_2 = question6count2/question6_count_all;
}

String question7_count_1="";
String question7_count_2="";
double question7count1=0;
double question7count2=0;
double question7_count_all=0;
double percent_question7_1=0;
double percent_question7_2=0;

String sql_question7_1 = " select count(em_queation7) from tb_examine where em_queation7='1' ";
String sql_question7_2 = " select count(em_queation7) from tb_examine where em_queation7='2' ";
Hashtable content_question7_1 = dImpl.getDataInfo(sql_question7_1);
if(content_question7_1!=null)
{
	question7_count_1 = content_question7_1.get("count(em_queation7)").toString();
}
Hashtable content_question7_2 = dImpl.getDataInfo(sql_question7_2);
if(content_question7_2!=null)
{
	question7_count_2 = content_question7_2.get("count(em_queation7)").toString();
}
question7count1 = Double.parseDouble(question7_count_1);
question7count2 = Double.parseDouble(question7_count_2);
question7_count_all = question7count1+question7count2;
if(question7_count_all!=0)
{
	percent_question7_1 = question7count1/question7_count_all;
	percent_question7_2 = question7count2/question7_count_all;
}

String question8_count_1="";
String question8_count_2="";
String question8_count_3="";
double question8count1=0;
double question8count2=0;
double question8count3=0;
double question8_count_all=0;
double percent_question8_1=0;
double percent_question8_2=0;
double percent_question8_3=0;

String sql_question8_1 = " select count(em_queation8) from tb_examine where em_queation8='1' ";
String sql_question8_2 = " select count(em_queation8) from tb_examine where em_queation8='2' ";
String sql_question8_3 = " select count(em_queation8) from tb_examine where em_queation8='3' ";
Hashtable content_question8_1 = dImpl.getDataInfo(sql_question8_1);
if(content_question8_1!=null)
{
	question8_count_1 = content_question8_1.get("count(em_queation8)").toString();
}
Hashtable content_question8_2 = dImpl.getDataInfo(sql_question8_2);
if(content_question8_2!=null)
{
	question8_count_2 = content_question8_2.get("count(em_queation8)").toString();
}
Hashtable content_question8_3 = dImpl.getDataInfo(sql_question8_3);
if(content_question8_3!=null)
{
	question8_count_3 = content_question8_3.get("count(em_queation8)").toString();
}
question8count1 = Double.parseDouble(question8_count_1);
question8count2 = Double.parseDouble(question8_count_2);
question8count3 = Double.parseDouble(question8_count_3);
question8_count_all = question8count1+question8count2+question8count3;
if(question8_count_all!=0)
{
	percent_question8_1 = question8count1/question8_count_all;
	percent_question8_2 = question8count2/question8_count_all;
	percent_question8_3 = question8count3/question8_count_all;
}

String question9_count_1="";
String question9_count_2="";
double question9count1=0;
double question9count2=0;
double question9_count_all=0;
double percent_question9_1=0;
double percent_question9_2=0;

String sql_question9_1 = " select count(em_queation9) from tb_examine where em_queation9='1' ";
String sql_question9_2 = " select count(em_queation9) from tb_examine where em_queation9='2' ";
Hashtable content_question9_1 = dImpl.getDataInfo(sql_question9_1);
if(content_question9_1!=null)
{
	question9_count_1 = content_question9_1.get("count(em_queation9)").toString();
}
Hashtable content_question9_2 = dImpl.getDataInfo(sql_question9_2);
if(content_question9_2!=null)
{
	question9_count_2 = content_question9_2.get("count(em_queation9)").toString();
}
question9count1 = Double.parseDouble(question9_count_1);
question9count2 = Double.parseDouble(question9_count_2);
question9_count_all = question9count1+question9count2;
if(question9_count_all!=0)
{
	percent_question9_1 = question9count1/question9_count_all;
	percent_question9_2 = question9count2/question9_count_all;
}

String question10_count_1="";
String question10_count_2="";
double question10count1=0;
double question10count2=0;
double question10_count_all=0;
double percent_question10_1=0;
double percent_question10_2=0;

String sql_question10_1 = " select count(em_queation10) from tb_examine where em_queation10='1' ";
String sql_question10_2 = " select count(em_queation10) from tb_examine where em_queation10='2' ";
Hashtable content_question10_1 = dImpl.getDataInfo(sql_question10_1);
if(content_question10_1!=null)
{
	question10_count_1 = content_question10_1.get("count(em_queation10)").toString();
}
Hashtable content_question10_2 = dImpl.getDataInfo(sql_question10_2);
if(content_question10_2!=null)
{
	question10_count_2 = content_question10_2.get("count(em_queation10)").toString();
}
question10count1 = Double.parseDouble(question10_count_1);
question10count2 = Double.parseDouble(question10_count_2);
question10_count_all = question10count1+question10count2;
if(question10_count_all!=0)
{
	percent_question10_1 = question10count1/question10_count_all;
	percent_question10_2 = question10count2/question10_count_all;
}

String question11_count_1="";
String question11_count_2="";
String question11_count_3="";
double question11count1=0;
double question11count2=0;
double question11count3=0;
double question11_count_all=0;
double percent_question11_1=0;
double percent_question11_2=0;
double percent_question11_3=0;

String sql_question11_1 = " select count(em_queation11) from tb_examine where em_queation11='1' ";
String sql_question11_2 = " select count(em_queation11) from tb_examine where em_queation11='2' ";
String sql_question11_3 = " select count(em_queation11) from tb_examine where em_queation11='3' ";
Hashtable content_question11_1 = dImpl.getDataInfo(sql_question11_1);
if(content_question11_1!=null)
{
	question11_count_1 = content_question11_1.get("count(em_queation11)").toString();
}
Hashtable content_question11_2 = dImpl.getDataInfo(sql_question11_2);
if(content_question11_2!=null)
{
	question11_count_2 = content_question11_2.get("count(em_queation11)").toString();
}
Hashtable content_question11_3 = dImpl.getDataInfo(sql_question11_3);
if(content_question11_3!=null)
{
	question11_count_3 = content_question11_3.get("count(em_queation11)").toString();
}

question11count1 = Double.parseDouble(question11_count_1);
question11count2 = Double.parseDouble(question11_count_2);
question11count3 = Double.parseDouble(question11_count_3);
question11_count_all = question11count1+question11count2+question11count3;
if(question11_count_all!=0)
{
	percent_question11_1 = question11count1/question11_count_all;
	percent_question11_2 = question11count2/question11_count_all;
	percent_question11_3 = question11count3/question11_count_all;
}

String question12_count_1="";
String question12_count_2="";
double question12count1=0;
double question12count2=0;
double question12_count_all=0;
double percent_question12_1=0;
double percent_question12_2=0;

String sql_question12_1 = " select count(em_queation12) from tb_examine where em_queation12='1' ";
String sql_question12_2 = " select count(em_queation12) from tb_examine where em_queation12='2' ";
Hashtable content_question12_1 = dImpl.getDataInfo(sql_question12_1);
if(content_question12_1!=null)
{
	question12_count_1 = content_question12_1.get("count(em_queation12)").toString();
}
Hashtable content_question12_2 = dImpl.getDataInfo(sql_question12_2);
if(content_question12_2!=null)
{
	question12_count_2 = content_question12_2.get("count(em_queation12)").toString();
}
question12count1 = Double.parseDouble(question12_count_1);
question12count2 = Double.parseDouble(question12_count_2);
question12_count_all = question12count1+question12count2;
if(question12_count_all!=0)
{
	percent_question12_1 = question12count1/question12_count_all;
	percent_question12_2 = question12count2/question12_count_all;
}

String question13_count_1="";
String question13_count_2="";
double question13count1=0;
double question13count2=0;
double question13_count_all=0;
double percent_question13_1=0;
double percent_question13_2=0;

String sql_question13_1 = " select count(em_queation13) from tb_examine where em_queation13='1' ";
String sql_question13_2 = " select count(em_queation13) from tb_examine where em_queation13='2' ";
Hashtable content_question13_1 = dImpl.getDataInfo(sql_question13_1);
if(content_question13_1!=null)
{
	question13_count_1 = content_question13_1.get("count(em_queation13)").toString();
}
Hashtable content_question13_2 = dImpl.getDataInfo(sql_question13_2);
if(content_question13_2!=null)
{
	question13_count_2 = content_question13_2.get("count(em_queation13)").toString();
}
question13count1 = Double.parseDouble(question13_count_1);
question13count2 = Double.parseDouble(question13_count_2);
question13_count_all = question13count1+question13count2;
if(question13_count_all!=0)
{
	percent_question13_1 = question13count1/question13_count_all;
	percent_question13_2 = question13count2/question13_count_all;
}

String question14_count_1="";
String question14_count_2="";
double question14count1=0;
double question14count2=0;
double question14_count_all=0;
double percent_question14_1=0;
double percent_question14_2=0;

String sql_question14_1 = " select count(em_queation14) from tb_examine where em_queation14='1' ";
String sql_question14_2 = " select count(em_queation14) from tb_examine where em_queation14='2' ";
Hashtable content_question14_1 = dImpl.getDataInfo(sql_question14_1);
if(content_question14_1!=null)
{
	question14_count_1 = content_question14_1.get("count(em_queation14)").toString();
}
Hashtable content_question14_2 = dImpl.getDataInfo(sql_question14_2);
if(content_question14_2!=null)
{
	question14_count_2 = content_question14_2.get("count(em_queation14)").toString();
}
question14count1 = Double.parseDouble(question14_count_1);
question14count2 = Double.parseDouble(question14_count_2);
question14_count_all = question14count1+question14count2;
if(question14_count_all!=0)
{
	percent_question14_1 = question14count1/question14_count_all;
	percent_question14_2 = question14count2/question14_count_all;
}

String question15_count_1="";
String question15_count_2="";
String question15_count_3="";
String question15_count_4="";
double question15count1=0;
double question15count2=0;
double question15count3=0;
double question15count4=0;
double question15_count_all=0;
double percent_question15_1=0;
double percent_question15_2=0;
double percent_question15_3=0;
double percent_question15_4=0;

String sql_question15_1 = " select count(em_queation15) from tb_examine where em_queation15='1' ";
String sql_question15_2 = " select count(em_queation15) from tb_examine where em_queation15='2' ";
String sql_question15_3 = " select count(em_queation15) from tb_examine where em_queation15='3' ";
String sql_question15_4 = " select count(em_queation15) from tb_examine where em_queation15='4' ";
Hashtable content_question15_1 = dImpl.getDataInfo(sql_question15_1);
if(content_question15_1!=null)
{
	question15_count_1 = content_question15_1.get("count(em_queation15)").toString();
}
Hashtable content_question15_2 = dImpl.getDataInfo(sql_question15_2);
if(content_question15_2!=null)
{
	question15_count_2 = content_question15_2.get("count(em_queation15)").toString();
}
Hashtable content_question15_3 = dImpl.getDataInfo(sql_question15_3);
if(content_question15_3!=null)
{
	question15_count_3 = content_question15_3.get("count(em_queation15)").toString();
}
Hashtable content_question15_4 = dImpl.getDataInfo(sql_question15_4);
if(content_question15_4!=null)
{
	question15_count_4 = content_question15_4.get("count(em_queation15)").toString();
}
question15count1 = Double.parseDouble(question15_count_1);
question15count2 = Double.parseDouble(question15_count_2);
question15count3 = Double.parseDouble(question15_count_3);
question15count4 = Double.parseDouble(question15_count_4);
question15_count_all = question15count1+question15count2+question15count3+question15count4;
if(question15_count_all!=0)
{
	percent_question15_1 = question15count1/question15_count_all;
	percent_question15_2 = question15count2/question15_count_all;
	percent_question15_3 = question15count3/question15_count_all;
	percent_question15_4 = question15count4/question15_count_all;
}

String question16_count_1="";
String question16_count_2="";
String question16_count_3="";
String question16_count_4="";
double question16count1=0;
double question16count2=0;
double question16count3=0;
double question16count4=0;
double question16_count_all=0;
double percent_question16_1=0;
double percent_question16_2=0;
double percent_question16_3=0;
double percent_question16_4=0;

String sql_question16_1 = " select count(em_queation16) from tb_examine where em_queation16='1' ";
String sql_question16_2 = " select count(em_queation16) from tb_examine where em_queation16='2' ";
String sql_question16_3 = " select count(em_queation16) from tb_examine where em_queation16='3' ";
String sql_question16_4 = " select count(em_queation16) from tb_examine where em_queation16='4' ";
Hashtable content_question16_1 = dImpl.getDataInfo(sql_question16_1);
if(content_question16_1!=null)
{
	question16_count_1 = content_question16_1.get("count(em_queation16)").toString();
}
Hashtable content_question16_2 = dImpl.getDataInfo(sql_question16_2);
if(content_question16_2!=null)
{
	question16_count_2 = content_question16_2.get("count(em_queation16)").toString();
}
Hashtable content_question16_3 = dImpl.getDataInfo(sql_question16_3);
if(content_question16_3!=null)
{
	question16_count_3 = content_question16_3.get("count(em_queation16)").toString();
}
Hashtable content_question16_4 = dImpl.getDataInfo(sql_question16_4);
if(content_question16_4!=null)
{
	question16_count_4 = content_question16_4.get("count(em_queation16)").toString();
}
question16count1 = Double.parseDouble(question16_count_1);
question16count2 = Double.parseDouble(question16_count_2);
question16count3 = Double.parseDouble(question16_count_3);
question16count4 = Double.parseDouble(question16_count_4);
question16_count_all = question16count1+question16count2+question16count3+question16count4;
if(question16_count_all!=0)
{
	percent_question16_1 = question16count1/question16_count_all;
	percent_question16_2 = question16count2/question16_count_all;
	percent_question16_3 = question16count3/question16_count_all;
	percent_question16_4 = question16count4/question16_count_all;
}
%>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="3"><b>浦东新区审改效能情况调查问卷</b></td>
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
											<td align="left" colspan="3">一、评议人的基本情况</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">年龄</td>
										</tr> 
										<tr class="line-odd">
											<td align="left" width="60%">18-25周岁</td>
											<td align="left"><%=(new java.lang.Double(percent_age_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_age_1*20%>' height="5">&nbsp;&nbsp;<%=age_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">26-39周岁</td>
											<td align="left"><%=(new java.lang.Double(percent_age_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_age_2*20%>' height="5">&nbsp;&nbsp;<%=age_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">40-59周岁</td>
											<td align="left"><%=new java.lang.Double(percent_age_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_age_3*20%>' height="5">&nbsp;&nbsp;<%=age_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">60周岁以上</td>
											<td align="left"><%=new java.lang.Double(percent_age_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_age_4*20%>' height="5">&nbsp;&nbsp;<%=age_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">文化程度</td>
										</tr> 
										<tr class="line-odd">
											<td align="left" width="60%">大专及以上</td>
											<td align="left"><%=(new java.lang.Double(percent_education_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_education_1*20%>' height="5">&nbsp;&nbsp;<%=education_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">高中、中专、技校、职校</td>
											<td align="left"><%=(new java.lang.Double(percent_education_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_education_2*20%>' height="5">&nbsp;&nbsp;<%=education_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">初中及以下</td>
											<td align="left"><%=new java.lang.Double(percent_education_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_education_3*20%>' height="5">&nbsp;&nbsp;<%=education_count_3%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">所在单位</td>
										</tr> 
										<tr class="line-odd">
											<td align="left" width="60%">个体工商户</td>
											<td align="left"><%=(new java.lang.Double(percent_dept_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_1*20%>' height="5">&nbsp;&nbsp;<%=dept_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">私营企业</td>
											<td align="left"><%=(new java.lang.Double(percent_dept_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_2*20%>' height="5">&nbsp;&nbsp;<%=dept_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">国有企业</td>
											<td align="left"><%=new java.lang.Double(percent_dept_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_3*20%>' height="5">&nbsp;&nbsp;<%=dept_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">事业单位</td>
											<td align="left"><%=new java.lang.Double(percent_dept_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_4*20%>' height="5">&nbsp;&nbsp;<%=dept_count_4%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">外商独资企业</td>
											<td align="left"><%=new java.lang.Double(percent_dept_5*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_5*20%>' height="5">&nbsp;&nbsp;<%=dept_count_5%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">中外合资企业</td>
											<td align="left"><%=new java.lang.Double(percent_dept_6*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_6*20%>' height="5">&nbsp;&nbsp;<%=dept_count_6%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">其他</td>
											<td align="left"><%=new java.lang.Double(percent_dept_7*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_dept_7*20%>' height="5">&nbsp;&nbsp;<%=dept_count_7%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">二、对实施行政审批制度改革工作效能情况的评价</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">是否有告知以外的（不再审批）事项仍然在审批</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">是</td>
											<td align="left"><%=(new java.lang.Double(percent_question1_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question1_1*20%>' height="5">&nbsp;&nbsp;<%=question1_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">否</td>
											<td align="left"><%=(new java.lang.Double(percent_question1_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question1_2*20%>' height="5">&nbsp;&nbsp;<%=question1_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">在办理审批事项时，有关部门和工作人员是否按规定做到："一次     讲清、两次受理、三次上门服务、限期办结和差错投诉登门道歉"</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">是</td>
											<td align="left"><%=(new java.lang.Double(percent_question2_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question2_1*20%>' height="5">&nbsp;&nbsp;<%=question2_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">否</td>
											<td align="left"><%=(new java.lang.Double(percent_question2_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question2_2*20%>' height="5">&nbsp;&nbsp;<%=question2_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">是否运用告知单、告知栏、触摸屏、电子屏及计算机信息网络等各类媒介，将审批事项、政策法规、办事指南、运作规程、管理要求、政务动态、办事结果等及时向社会公开</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">全部运用</td>
											<td align="left"><%=(new java.lang.Double(percent_question3_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question3_1*20%>' height="5">&nbsp;&nbsp;<%=question3_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">部分运用</td>
											<td align="left"><%=(new java.lang.Double(percent_question3_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question3_2*20%>' height="5">&nbsp;&nbsp;<%=question3_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">没有</td>
											<td align="left"><%=(new java.lang.Double(percent_question3_3*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question3_3*20%>' height="5">&nbsp;&nbsp;<%=question3_count_3%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">是否实行"一站式"网上审批，网上受理、流转、下载、咨询等</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">全部实行</td>
											<td align="left"><%=(new java.lang.Double(percent_question4_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question4_1*20%>' height="5">&nbsp;&nbsp;<%=question4_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">部分实行</td>
											<td align="left"><%=(new java.lang.Double(percent_question4_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question4_2*20%>' height="5">&nbsp;&nbsp;<%=question4_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">未实行</td>
											<td align="left"><%=(new java.lang.Double(percent_question4_3*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question4_3*20%>' height="5">&nbsp;&nbsp;<%=question4_count_3%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">您的申请事项，有关部门是否按公开的办事程序办理</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">全部按程序办理</td>
											<td align="left"><%=(new java.lang.Double(percent_question5_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question5_1*20%>' height="5">&nbsp;&nbsp;<%=question5_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">不按规定的程序办理</td>
											<td align="left"><%=(new java.lang.Double(percent_question5_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question5_2*20%>' height="5">&nbsp;&nbsp;<%=question5_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">是否在告知的时限内办结您的申请事项</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">是</td>
											<td align="left"><%=(new java.lang.Double(percent_question6_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question6_1*20%>' height="5">&nbsp;&nbsp;<%=question6_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">否</td>
											<td align="left"><%=(new java.lang.Double(percent_question6_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question6_2*20%>' height="5">&nbsp;&nbsp;<%=question6_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">办理的事项被否定时是否向您出具不予受理或不予批准的文书并说明理由和告知救济途径</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">是</td>
											<td align="left"><%=(new java.lang.Double(percent_question7_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question7_1*20%>' height="5">&nbsp;&nbsp;<%=question7_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">否</td>
											<td align="left"><%=(new java.lang.Double(percent_question7_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question7_2*20%>' height="5">&nbsp;&nbsp;<%=question7_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">窗口接待人员是否有缺岗、离岗现象</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">有</td>
											<td align="left"><%=(new java.lang.Double(percent_question8_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question8_1*20%>' height="5">&nbsp;&nbsp;<%=question8_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">没有</td>
											<td align="left"><%=(new java.lang.Double(percent_question8_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question8_2*20%>' height="5">&nbsp;&nbsp;<%=question8_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">未发现</td>
											<td align="left"><%=(new java.lang.Double(percent_question8_3*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question8_3*20%>' height="5">&nbsp;&nbsp;<%=question8_count_3%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">工作中是否有推诿、扯皮等现象</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">有</td>
											<td align="left"><%=(new java.lang.Double(percent_question9_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question9_1*20%>' height="5">&nbsp;&nbsp;<%=question9_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">无</td>
											<td align="left"><%=(new java.lang.Double(percent_question9_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question9_2*20%>' height="5">&nbsp;&nbsp;<%=question9_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">工作人员是否有暗示给好处或吃请等行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">有</td>
											<td align="left"><%=(new java.lang.Double(percent_question10_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question10_1*20%>' height="5">&nbsp;&nbsp;<%=question10_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">无</td>
											<td align="left"><%=(new java.lang.Double(percent_question10_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question10_2*20%>' height="5">&nbsp;&nbsp;<%=question10_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">您所接触的部门是否存在"门难进、脸难看、话难听、事难办"现象</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">不存在</td>
											<td align="left"><%=(new java.lang.Double(percent_question11_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question11_1*20%>' height="5">&nbsp;&nbsp;<%=question11_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">存在</td>
											<td align="left"><%=(new java.lang.Double(percent_question11_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question11_2*20%>' height="5">&nbsp;&nbsp;<%=question11_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">严重存在</td>
											<td align="left"><%=(new java.lang.Double(percent_question11_3*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question11_3*20%>' height="5">&nbsp;&nbsp;<%=question11_count_3%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">属于"零收费"规定事项是否有收费行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">有</td>
											<td align="left"><%=(new java.lang.Double(percent_question12_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question12_1*20%>' height="5">&nbsp;&nbsp;<%=question12_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">无</td>
											<td align="left"><%=(new java.lang.Double(percent_question12_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question12_2*20%>' height="5">&nbsp;&nbsp;<%=question12_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">属于"联合年检"规定的事项是否有其他年检行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">有</td>
											<td align="left"><%=(new java.lang.Double(percent_question13_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question13_1*20%>' height="5">&nbsp;&nbsp;<%=question13_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">无</td>
											<td align="left"><%=(new java.lang.Double(percent_question13_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question13_2*20%>' height="5">&nbsp;&nbsp;<%=question13_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">属于"告知承诺"规定的事项是否有实质性审批行为</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">有</td>
											<td align="left"><%=(new java.lang.Double(percent_question13_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question13_1*20%>' height="5">&nbsp;&nbsp;<%=question13_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">无</td>
											<td align="left"><%=(new java.lang.Double(percent_question13_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question13_2*20%>' height="5">&nbsp;&nbsp;<%=question13_count_2%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">您对新区机关的办事工作效率、工作质量的评价</td>
										</tr> 
										<tr class="line-odd">
											<td align="left" width="60%">满意</td>
											<td align="left"><%=(new java.lang.Double(percent_question15_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question15_1*20%>' height="5">&nbsp;&nbsp;<%=question15_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">较满意</td>
											<td align="left"><%=(new java.lang.Double(percent_question15_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question15_2*20%>' height="5">&nbsp;&nbsp;<%=question15_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_question15_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question15_3*20%>' height="5">&nbsp;&nbsp;<%=question15_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">不满意</td>
											<td align="left"><%=new java.lang.Double(percent_question15_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question15_4*20%>' height="5">&nbsp;&nbsp;<%=question15_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3">您对新区审改效能监察工作的总体评价</td>
										</tr> 
										<tr class="line-odd">
											<td align="left" width="60%">满意</td>
											<td align="left"><%=(new java.lang.Double(percent_question16_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question16_1*20%>' height="5">&nbsp;&nbsp;<%=question16_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">较满意</td>
											<td align="left"><%=(new java.lang.Double(percent_question16_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question16_2*20%>' height="5">&nbsp;&nbsp;<%=question16_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_question16_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question16_3*20%>' height="5">&nbsp;&nbsp;<%=question16_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-odd">
											<td align="left" width="60%">不满意</td>
											<td align="left"><%=new java.lang.Double(percent_question16_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_question16_4*20%>' height="5">&nbsp;&nbsp;<%=question16_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-even">
											<td align="left" colspan="3"><a href="Message.jsp">查看详细投票情况</a></td>
										</tr> 										
</table>
<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>