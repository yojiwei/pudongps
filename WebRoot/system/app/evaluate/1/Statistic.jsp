<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*"%>

<%
CDataCn dCn = new CDataCn();
CDataImpl dImpl = new CDataImpl(dCn);		//新建数据接口对象

String zhineng_count_1="";
String zhineng_count_2="";
String zhineng_count_3="";
double zhinengcount1=0;
double zhinengcount2=0;
double zhinengcount3=0;
double zhineng_count_all=0;
double percent_zhineng_1=0;
double percent_zhineng_2=0;
double percent_zhineng_3=0;

String gv_id=CTools.dealString(request.getParameter("gv_id")).trim();
String sql_zhineng_1 = " select count(oe_workfunction) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workfunction='1' ";
String sql_zhineng_2 = " select count(oe_workfunction) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workfunction='2' ";
//out.println(sql_zhineng_2);out.close();
String sql_zhineng_3 = " select count(oe_workfunction) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workfunction='3' ";

Hashtable content_zhineng_1 = dImpl.getDataInfo(sql_zhineng_1);
if(content_zhineng_1!=null)
{
	zhineng_count_1 = content_zhineng_1.get("count(oe_workfunction)").toString();
}
Hashtable content_zhineng_2 = dImpl.getDataInfo(sql_zhineng_2);
if(content_zhineng_2!=null)
{
	zhineng_count_2 = content_zhineng_2.get("count(oe_workfunction)").toString();
}
Hashtable content_zhineng_3 = dImpl.getDataInfo(sql_zhineng_3);
if(content_zhineng_3!=null)
{
	zhineng_count_3 = content_zhineng_3.get("count(oe_workfunction)").toString();
}

zhinengcount1 = Double.parseDouble(zhineng_count_1);
zhinengcount2 = Double.parseDouble(zhineng_count_2);
zhinengcount3 = Double.parseDouble(zhineng_count_3);
zhineng_count_all = zhinengcount1+zhinengcount2+zhinengcount3;
if(zhineng_count_all!=0)
{
	percent_zhineng_1 = zhinengcount1/zhineng_count_all;
	percent_zhineng_2 = zhinengcount2/zhineng_count_all;
	percent_zhineng_3 = zhinengcount3/zhineng_count_all;
}
//out.println(zhinengcount1);
//out.println(percent_zhineng_1);out.close();

String sql_yinxiang_1 = " select count(oe_totalimpress) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_totalimpress='1' ";
String sql_yinxiang_2 = " select count(oe_totalimpress) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_totalimpress='2' ";
String sql_yinxiang_3 = " select count(oe_totalimpress) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_totalimpress='3' ";
String sql_yinxiang_4 = " select count(oe_totalimpress) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_totalimpress='4' ";
String sql_yinxiang_5 = " select count(oe_totalimpress) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_totalimpress='5' ";

String yinxiang_count_1 = "";
String yinxiang_count_2 = "";
String yinxiang_count_3 = "";
String yinxiang_count_4 = "";
String yinxiang_count_5 = "";
double yinxiangcount1=0;
double yinxiangcount2=0;
double yinxiangcount3=0;
double yinxiangcount4=0;
double yinxiangcount5=0;
double yinxiang_count_all=0;
double percent_yinxiang_1=0;
double percent_yinxiang_2=0;
double percent_yinxiang_3=0;
double percent_yinxiang_4=0;
double percent_yinxiang_5=0;

Hashtable content_yinxiang_1 = dImpl.getDataInfo(sql_yinxiang_1);
if(content_yinxiang_1!=null)
{
	yinxiang_count_1 = content_yinxiang_1.get("count(oe_totalimpress)").toString();
}
Hashtable content_yinxiang_2 = dImpl.getDataInfo(sql_yinxiang_2);
if(content_yinxiang_2!=null)
{
	yinxiang_count_2 = content_yinxiang_2.get("count(oe_totalimpress)").toString();
}
Hashtable content_yinxiang_3 = dImpl.getDataInfo(sql_yinxiang_3);
if(content_yinxiang_3!=null)
{
	yinxiang_count_3 = content_yinxiang_3.get("count(oe_totalimpress)").toString();
}
Hashtable content_yinxiang_4 = dImpl.getDataInfo(sql_yinxiang_4);
if(content_yinxiang_4!=null)
{
	yinxiang_count_4 = content_yinxiang_4.get("count(oe_totalimpress)").toString();
}
Hashtable content_yinxiang_5 = dImpl.getDataInfo(sql_yinxiang_5);
if(content_yinxiang_5!=null)
{
	yinxiang_count_5 = content_yinxiang_5.get("count(oe_totalimpress)").toString();
}
yinxiangcount1 = Double.parseDouble(yinxiang_count_1);
yinxiangcount2 = Double.parseDouble(yinxiang_count_2);
yinxiangcount3 = Double.parseDouble(yinxiang_count_3);
yinxiangcount4 = Double.parseDouble(yinxiang_count_4);
yinxiangcount5 = Double.parseDouble(yinxiang_count_5);

yinxiang_count_all = yinxiangcount1+yinxiangcount2+yinxiangcount3+yinxiangcount4+yinxiangcount5;
if(yinxiang_count_all!=0)
{
percent_yinxiang_1 = yinxiangcount1/yinxiang_count_all;
percent_yinxiang_2 = yinxiangcount2/yinxiang_count_all;
percent_yinxiang_3 = yinxiangcount3/yinxiang_count_all;
percent_yinxiang_4 = yinxiangcount4/yinxiang_count_all;
percent_yinxiang_5 = yinxiangcount5/yinxiang_count_all;
}
String sql_zhenfeng_1 = " select count(oe_govstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_govstyle='1' ";
String sql_zhenfeng_2 = " select count(oe_govstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_govstyle='2' ";
String sql_zhenfeng_3 = " select count(oe_govstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_govstyle='3' ";
String sql_zhenfeng_4 = " select count(oe_govstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_govstyle='4' ";

String zhenfeng_count_1 = "";
String zhenfeng_count_2 = "";
String zhenfeng_count_3 = "";
String zhenfeng_count_4 = "";
double zhenfengcount1=0;
double zhenfengcount2=0;
double zhenfengcount3=0;
double zhenfengcount4=0;
double zhenfeng_count_all=0;
double percent_zhenfeng_1=0;
double percent_zhenfeng_2=0;
double percent_zhenfeng_3=0;
double percent_zhenfeng_4=0;

Hashtable content_zhenfeng_1 = dImpl.getDataInfo(sql_zhenfeng_1);
if(content_zhenfeng_1!=null)
{
	zhenfeng_count_1 = content_zhenfeng_1.get("count(oe_govstyle)").toString();
}
Hashtable content_zhenfeng_2 = dImpl.getDataInfo(sql_zhenfeng_2);
if(content_zhenfeng_2!=null)
{
	zhenfeng_count_2 = content_zhenfeng_2.get("count(oe_govstyle)").toString();
}
Hashtable content_zhenfeng_3 = dImpl.getDataInfo(sql_zhenfeng_3);
if(content_zhenfeng_3!=null)
{
	zhenfeng_count_3 = content_zhenfeng_3.get("count(oe_govstyle)").toString();
}
Hashtable content_zhenfeng_4 = dImpl.getDataInfo(sql_zhenfeng_4);
if(content_zhenfeng_4!=null)
{
	zhenfeng_count_4 = content_zhenfeng_4.get("count(oe_govstyle)").toString();
}
zhenfengcount1 = Double.parseDouble(zhenfeng_count_1);
zhenfengcount2 = Double.parseDouble(zhenfeng_count_2);
zhenfengcount3 = Double.parseDouble(zhenfeng_count_3);
zhenfengcount4 = Double.parseDouble(zhenfeng_count_4);

zhenfeng_count_all = zhenfengcount1+zhenfengcount2+zhenfengcount3+zhenfengcount4;
if(zhenfeng_count_all!=0)
{
percent_zhenfeng_1 = zhenfengcount1/zhenfeng_count_all;
percent_zhenfeng_2 = zhenfengcount2/zhenfeng_count_all;
percent_zhenfeng_3 = zhenfengcount3/zhenfeng_count_all;
percent_zhenfeng_4 = zhenfengcount4/zhenfeng_count_all;
}

String sql_zhifa_1 = " select count(oe_executebehavior) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_executebehavior='1' ";
String sql_zhifa_2 = " select count(oe_executebehavior) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_executebehavior='2' ";
String sql_zhifa_3 = " select count(oe_executebehavior) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_executebehavior='3' ";
String sql_zhifa_4 = " select count(oe_executebehavior) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_executebehavior='4' ";

String zhifa_count_1 = "";
String zhifa_count_2 = "";
String zhifa_count_3 = "";
String zhifa_count_4 = "";
double zhifacount1=0;
double zhifacount2=0;
double zhifacount3=0;
double zhifacount4=0;
double zhifa_count_all=0;
double percent_zhifa_1=0;
double percent_zhifa_2=0;
double percent_zhifa_3=0;
double percent_zhifa_4=0;

Hashtable content_zhifa_1 = dImpl.getDataInfo(sql_zhifa_1);
if(content_zhifa_1!=null)
{
	zhifa_count_1 = content_zhifa_1.get("count(oe_executebehavior)").toString();
}
Hashtable content_zhifa_2 = dImpl.getDataInfo(sql_zhifa_2);
if(content_zhifa_2!=null)
{
	zhifa_count_2 = content_zhifa_2.get("count(oe_executebehavior)").toString();
}
Hashtable content_zhifa_3 = dImpl.getDataInfo(sql_zhifa_3);
if(content_zhifa_3!=null)
{
	zhifa_count_3 = content_zhifa_3.get("count(oe_executebehavior)").toString();
}
Hashtable content_zhifa_4 = dImpl.getDataInfo(sql_zhifa_4);
if(content_zhifa_4!=null)
{
	zhifa_count_4 = content_zhifa_4.get("count(oe_executebehavior)").toString();
}
zhifacount1 = Double.parseDouble(zhifa_count_1);
zhifacount2 = Double.parseDouble(zhifa_count_2);
zhifacount3 = Double.parseDouble(zhifa_count_3);
zhifacount4 = Double.parseDouble(zhifa_count_4);

zhifa_count_all = zhifacount1+zhifacount2+zhifacount3+zhifacount4;
if(zhifa_count_all!=0)
{
percent_zhifa_1 = zhifacount1/zhifa_count_all;
percent_zhifa_2 = zhifacount2/zhifa_count_all;
percent_zhifa_3 = zhifacount3/zhifa_count_all;
percent_zhifa_4 = zhifacount4/zhifa_count_all;
}

String sql_jiandu_1 = " select count(oe_supervised) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_supervised='1' ";
String sql_jiandu_2 = " select count(oe_supervised) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_supervised='2' ";
String sql_jiandu_3 = " select count(oe_supervised) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_supervised='3' ";
String sql_jiandu_4 = " select count(oe_supervised) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_supervised='4' ";

String jiandu_count_1 = "";
String jiandu_count_2 = "";
String jiandu_count_3 = "";
String jiandu_count_4 = "";
double jianducount1=0;
double jianducount2=0;
double jianducount3=0;
double jianducount4=0;
double jiandu_count_all=0;
double percent_jiandu_1=0;
double percent_jiandu_2=0;
double percent_jiandu_3=0;
double percent_jiandu_4=0;

Hashtable content_jiandu_1 = dImpl.getDataInfo(sql_jiandu_1);
if(content_jiandu_1!=null)
{
	jiandu_count_1 = content_jiandu_1.get("count(oe_supervised)").toString();
}
Hashtable content_jiandu_2 = dImpl.getDataInfo(sql_jiandu_2);
if(content_jiandu_2!=null)
{
	jiandu_count_2 = content_jiandu_2.get("count(oe_supervised)").toString();
}
Hashtable content_jiandu_3 = dImpl.getDataInfo(sql_jiandu_3);
if(content_jiandu_3!=null)
{
	jiandu_count_3 = content_jiandu_3.get("count(oe_supervised)").toString();
}
Hashtable content_jiandu_4 = dImpl.getDataInfo(sql_jiandu_4);
if(content_jiandu_4!=null)
{
	jiandu_count_4 = content_jiandu_4.get("count(oe_supervised)").toString();
}
jianducount1 = Double.parseDouble(jiandu_count_1);
jianducount2 = Double.parseDouble(jiandu_count_2);
jianducount3 = Double.parseDouble(jiandu_count_3);
jianducount4 = Double.parseDouble(jiandu_count_4);

jiandu_count_all = jianducount1+jianducount2+jianducount3+jianducount4;
if(jiandu_count_all!=0)
{
percent_jiandu_1 = jianducount1/jiandu_count_all;
percent_jiandu_2 = jianducount2/jiandu_count_all;
percent_jiandu_3 = jianducount3/jiandu_count_all;
percent_jiandu_4 = jianducount4/jiandu_count_all;
}

String sql_xiaolv_1 = " select count(oe_efficiency) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_efficiency='1' ";
String sql_xiaolv_2 = " select count(oe_efficiency) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_efficiency='2' ";
String sql_xiaolv_3 = " select count(oe_efficiency) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_efficiency='3' ";
String sql_xiaolv_4 = " select count(oe_efficiency) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_efficiency='4' ";

String xiaolv_count_1 = "";
String xiaolv_count_2 = "";
String xiaolv_count_3 = "";
String xiaolv_count_4 = "";
double xiaolvcount1=0;
double xiaolvcount2=0;
double xiaolvcount3=0;
double xiaolvcount4=0;
double xiaolv_count_all=0;
double percent_xiaolv_1=0;
double percent_xiaolv_2=0;
double percent_xiaolv_3=0;
double percent_xiaolv_4=0;

Hashtable content_xiaolv_1 = dImpl.getDataInfo(sql_xiaolv_1);
if(content_xiaolv_1!=null)
{
	xiaolv_count_1 = content_xiaolv_1.get("count(oe_efficiency)").toString();
}
Hashtable content_xiaolv_2 = dImpl.getDataInfo(sql_xiaolv_2);
if(content_xiaolv_2!=null)
{
	xiaolv_count_2 = content_xiaolv_2.get("count(oe_efficiency)").toString();
}
Hashtable content_xiaolv_3 = dImpl.getDataInfo(sql_xiaolv_3);
if(content_xiaolv_3!=null)
{
	xiaolv_count_3 = content_xiaolv_3.get("count(oe_efficiency)").toString();
}
Hashtable content_xiaolv_4 = dImpl.getDataInfo(sql_xiaolv_4);
if(content_xiaolv_4!=null)
{
	xiaolv_count_4 = content_xiaolv_4.get("count(oe_efficiency)").toString();
}
xiaolvcount1 = Double.parseDouble(xiaolv_count_1);
xiaolvcount2 = Double.parseDouble(xiaolv_count_2);
xiaolvcount3 = Double.parseDouble(xiaolv_count_3);
xiaolvcount4 = Double.parseDouble(xiaolv_count_4);

xiaolv_count_all = xiaolvcount1+xiaolvcount2+xiaolvcount3+xiaolvcount4;
if(xiaolv_count_all!=0)
{
percent_xiaolv_1 = xiaolvcount1/xiaolv_count_all;
percent_xiaolv_2 = xiaolvcount2/xiaolv_count_all;
percent_xiaolv_3 = xiaolvcount3/xiaolv_count_all;
percent_xiaolv_4 = xiaolvcount4/xiaolv_count_all;
}

String sql_lianjie_1 = " select count(oe_probity) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_probity='1' ";
String sql_lianjie_2 = " select count(oe_probity) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_probity='2' ";
String sql_lianjie_3 = " select count(oe_probity) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_probity='3' ";
String sql_lianjie_4 = " select count(oe_probity) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_probity='4' ";

String lianjie_count_1 = "";
String lianjie_count_2 = "";
String lianjie_count_3 = "";
String lianjie_count_4 = "";
double lianjiecount1=0;
double lianjiecount2=0;
double lianjiecount3=0;
double lianjiecount4=0;
double lianjie_count_all=0;
double percent_lianjie_1=0;
double percent_lianjie_2=0;
double percent_lianjie_3=0;
double percent_lianjie_4=0;

Hashtable content_lianjie_1 = dImpl.getDataInfo(sql_lianjie_1);
if(content_lianjie_1!=null)
{
	lianjie_count_1 = content_lianjie_1.get("count(oe_probity)").toString();
}
Hashtable content_lianjie_2 = dImpl.getDataInfo(sql_lianjie_2);
if(content_lianjie_2!=null)
{
	lianjie_count_2 = content_lianjie_2.get("count(oe_probity)").toString();
}
Hashtable content_lianjie_3 = dImpl.getDataInfo(sql_lianjie_3);
if(content_lianjie_3!=null)
{
	lianjie_count_3 = content_lianjie_3.get("count(oe_probity)").toString();
}
Hashtable content_lianjie_4 = dImpl.getDataInfo(sql_lianjie_4);
if(content_lianjie_4!=null)
{
	lianjie_count_4 = content_lianjie_4.get("count(oe_probity)").toString();
}
lianjiecount1 = Double.parseDouble(lianjie_count_1);
lianjiecount2 = Double.parseDouble(lianjie_count_2);
lianjiecount3 = Double.parseDouble(lianjie_count_3);
lianjiecount4 = Double.parseDouble(lianjie_count_4);

lianjie_count_all = lianjiecount1+lianjiecount2+lianjiecount3+lianjiecount4;
if(lianjie_count_all!=0)
{
percent_lianjie_1 = lianjiecount1/lianjie_count_all;
percent_lianjie_2 = lianjiecount2/lianjie_count_all;
percent_lianjie_3 = lianjiecount3/lianjie_count_all;
percent_lianjie_4 = lianjiecount4/lianjie_count_all;
}

String sql_fuwu_1 = " select count(oe_serve) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_serve='1' ";
String sql_fuwu_2 = " select count(oe_serve) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_serve='2' ";
String sql_fuwu_3 = " select count(oe_serve) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_serve='3' ";
String sql_fuwu_4 = " select count(oe_serve) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_serve='4' ";

String fuwu_count_1 = "";
String fuwu_count_2 = "";
String fuwu_count_3 = "";
String fuwu_count_4 = "";
double fuwucount1=0;
double fuwucount2=0;
double fuwucount3=0;
double fuwucount4=0;
double fuwu_count_all=0;
double percent_fuwu_1=0;
double percent_fuwu_2=0;
double percent_fuwu_3=0;
double percent_fuwu_4=0;

Hashtable content_fuwu_1 = dImpl.getDataInfo(sql_fuwu_1);
if(content_fuwu_1!=null)
{
	fuwu_count_1 = content_fuwu_1.get("count(oe_serve)").toString();
}
Hashtable content_fuwu_2 = dImpl.getDataInfo(sql_fuwu_2);
if(content_fuwu_2!=null)
{
	fuwu_count_2 = content_fuwu_2.get("count(oe_serve)").toString();
}
Hashtable content_fuwu_3 = dImpl.getDataInfo(sql_fuwu_3);
if(content_fuwu_3!=null)
{
	fuwu_count_3 = content_fuwu_3.get("count(oe_serve)").toString();
}
Hashtable content_fuwu_4 = dImpl.getDataInfo(sql_fuwu_4);
if(content_fuwu_4!=null)
{
	fuwu_count_4 = content_fuwu_4.get("count(oe_serve)").toString();
}
fuwucount1 = Double.parseDouble(fuwu_count_1);
fuwucount2 = Double.parseDouble(fuwu_count_2);
fuwucount3 = Double.parseDouble(fuwu_count_3);
fuwucount4 = Double.parseDouble(fuwu_count_4);

fuwu_count_all = fuwucount1+fuwucount2+fuwucount3+fuwucount4;
if(fuwu_count_all!=0)
{
percent_fuwu_1 = fuwucount1/fuwu_count_all;
percent_fuwu_2 = fuwucount2/fuwu_count_all;
percent_fuwu_3 = fuwucount3/fuwu_count_all;
percent_fuwu_4 = fuwucount4/fuwu_count_all;
}

String sql_gongcheng_1 = " select count(oe_practice) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_practice='1' ";
String sql_gongcheng_2 = " select count(oe_practice) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_practice='2' ";
String sql_gongcheng_3 = " select count(oe_practice) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_practice='3' ";
String sql_gongcheng_4 = " select count(oe_practice) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_practice='4' ";

String gongcheng_count_1 = "";
String gongcheng_count_2 = "";
String gongcheng_count_3 = "";
String gongcheng_count_4 = "";
double gongchengcount1=0;
double gongchengcount2=0;
double gongchengcount3=0;
double gongchengcount4=0;
double gongcheng_count_all=0;
double percent_gongcheng_1=0;
double percent_gongcheng_2=0;
double percent_gongcheng_3=0;
double percent_gongcheng_4=0;

Hashtable content_gongcheng_1 = dImpl.getDataInfo(sql_gongcheng_1);
if(content_gongcheng_1!=null)
{
	gongcheng_count_1 = content_gongcheng_1.get("count(oe_practice)").toString();
}
Hashtable content_gongcheng_2 = dImpl.getDataInfo(sql_gongcheng_2);
if(content_gongcheng_2!=null)
{
	gongcheng_count_2 = content_gongcheng_2.get("count(oe_practice)").toString();
}
Hashtable content_gongcheng_3 = dImpl.getDataInfo(sql_gongcheng_3);
if(content_gongcheng_3!=null)
{
	gongcheng_count_3  = content_gongcheng_3.get("count(oe_practice)").toString();
}
Hashtable content_gongcheng_4 = dImpl.getDataInfo(sql_gongcheng_4);
if(content_gongcheng_4!=null)
{
	gongcheng_count_4  = content_gongcheng_4.get("count(oe_practice)").toString();
}
gongchengcount1 = Double.parseDouble(gongcheng_count_1);
gongchengcount2 = Double.parseDouble(gongcheng_count_2);
gongchengcount3 = Double.parseDouble(gongcheng_count_3);
gongchengcount4 = Double.parseDouble(gongcheng_count_4);

gongcheng_count_all = gongchengcount1+gongchengcount2+gongchengcount3+gongchengcount4;
if(gongcheng_count_all!=0)
{
percent_gongcheng_1 = gongchengcount1/gongcheng_count_all;
percent_gongcheng_2 = gongchengcount2/gongcheng_count_all;
percent_gongcheng_3 = gongchengcount3/gongcheng_count_all;
percent_gongcheng_4 = gongchengcount4/gongcheng_count_all;
}

String sql_zuofeng_1 = " select count(oe_workstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workstyle='1' ";
String sql_zuofeng_2 = " select count(oe_workstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workstyle='2' ";
String sql_zuofeng_3 = " select count(oe_workstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workstyle='3' ";
String sql_zuofeng_4 = " select count(oe_workstyle) from tb_onlineevaluate where gv_id='"+gv_id+"' and oe_workstyle='4' ";
String zuofeng_count_1 = "";
String zuofeng_count_2 = "";
String zuofeng_count_3 = "";
String zuofeng_count_4 = "";
double zuofengcount1=0;
double zuofengcount2=0;
double zuofengcount3=0;
double zuofengcount4=0;
double zuofeng_count_all=0;
double percent_zuofeng_1=0;
double percent_zuofeng_2=0;
double percent_zuofeng_3=0;
double percent_zuofeng_4=0;

Hashtable content_zuofeng_1 = dImpl.getDataInfo(sql_zuofeng_1);
if(content_zuofeng_1!=null)
{
	zuofeng_count_1 = content_zuofeng_1.get("count(oe_workstyle)").toString();
}
Hashtable content_zuofeng_2 = dImpl.getDataInfo(sql_zuofeng_2);
if(content_zuofeng_2!=null)
{
	zuofeng_count_2 = content_zuofeng_2.get("count(oe_workstyle)").toString();
}
Hashtable content_zuofeng_3 = dImpl.getDataInfo(sql_zuofeng_3);
if(content_zuofeng_1!=null)
{
	zuofeng_count_3  = content_zuofeng_3.get("count(oe_workstyle)").toString();
}
Hashtable content_zuofeng_4 = dImpl.getDataInfo(sql_zuofeng_4);
if(content_zuofeng_4!=null)
{
	zuofeng_count_4  = content_zuofeng_4.get("count(oe_workstyle)").toString();
}
zuofengcount1 = Double.parseDouble(zuofeng_count_1);
zuofengcount2 = Double.parseDouble(zuofeng_count_2);
zuofengcount3 = Double.parseDouble(zuofeng_count_3);
zuofengcount4 = Double.parseDouble(zuofeng_count_4);

zuofeng_count_all = zuofengcount1+zuofengcount2+zuofengcount3+zuofengcount4;
if(zuofeng_count_all!=0)
{
percent_zuofeng_1 = zuofengcount1/zuofeng_count_all;
percent_zuofeng_2 = zuofengcount2/zuofeng_count_all;
percent_zuofeng_3 = zuofengcount3/zuofeng_count_all;
percent_zuofeng_4 = zuofengcount4/zuofeng_count_all;
}

String sql_wenti = " select oe_govstyleproblem from tb_onlineevaluate where gv_id='"+gv_id+"' ";
String wenti_count="";
String [] wenti;
int i;
Vector vector_wenti = dImpl.splitPage(sql_wenti,1000,1);
if(vector_wenti!=null)
{
	for(i=0;i<vector_wenti.size();i++)
	{
		Hashtable content = (Hashtable)vector_wenti.get(i);
		wenti_count += content.get("oe_govstyleproblem").toString();
		wenti_count += ",";
	}
}
//out.println(wenti_count);
wenti = CTools.split(wenti_count,",");
double wenti_1 =0;
double wenti_2 =0;
double wenti_3 =0;
double wenti_4 =0;
double wenti_5 =0;
double wenti_6 =0;
double wenti_7 =0;
double wenti_all=0;
double percent_wenti_1=0;
double percent_wenti_2=0;
double percent_wenti_3=0;
double percent_wenti_4=0;
double percent_wenti_5=0;
double percent_wenti_6=0;
double percent_wenti_7=0;
for(int j=0;j<wenti.length;j++)
{	
	if(wenti[j].equals("1")) wenti_1++;
	if(wenti[j].equals("2")) wenti_2++;
	if(wenti[j].equals("3")) wenti_3++;
	if(wenti[j].equals("4")) wenti_4++;
	if(wenti[j].equals("5")) wenti_5++;
	if(wenti[j].equals("6")) wenti_6++;
	if(wenti[j].equals("7")) wenti_7++;
}
//out.println(wenti_2);
wenti_all = wenti_1+wenti_2+wenti_3+wenti_4+wenti_5+wenti_6+wenti_7;
if(wenti_all!=0)
{
percent_wenti_1=wenti_1/wenti_all;
percent_wenti_2=wenti_2/wenti_all;
percent_wenti_3=wenti_3/wenti_all;
percent_wenti_4=wenti_4/wenti_all;
percent_wenti_5=wenti_5/wenti_all;
percent_wenti_6=wenti_6/wenti_all;
percent_wenti_7=wenti_7/wenti_all;
}
%>
<TABLE cellSpacing="0" cellPadding="0" width=100% border="0" align="center">
<tr width="100%" align="center" class="title1">
<td align="center" colspan="3"><b>网上评议统计结果</b></td>
</tr>
<tr>
<td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
</tr>

										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">您对镇政府的工作职能</td>
										</tr> 
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										
										<tr class="line-even">
											<td align="left" width="30%">比较了解</td>
											<td align="left"><%=(new java.lang.Double(percent_zhineng_1*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhineng_1*20%>' height="5">&nbsp;&nbsp;<%=zhineng_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">有一定了解</td>
											<td align="left"><%=(new java.lang.Double(percent_zhineng_2*100)).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhineng_2*20%>' height="5">&nbsp;&nbsp;<%=zhineng_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">不了解</td>
											<td align="left"><%=new java.lang.Double(percent_zhineng_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhineng_3*20%>' height="5">&nbsp;&nbsp;<%=zhineng_count_3%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">您对本镇政风的总体印象</td>
										</tr> 
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">好</td>
											<td align="left"><%=new java.lang.Double(percent_yinxiang_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_yinxiang_1*20%>' height="5">&nbsp;&nbsp;<%=yinxiang_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较好</td>
											<td align="left"><%=new java.lang.Double(percent_yinxiang_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_yinxiang_2*20%>' height="5">&nbsp;&nbsp;<%=yinxiang_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_yinxiang_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_yinxiang_3*20%>' height="5">&nbsp;&nbsp;<%=yinxiang_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较差</td>
											<td align="left"><%=new java.lang.Double(percent_yinxiang_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_yinxiang_4*20%>' height="5">&nbsp;&nbsp;<%=yinxiang_count_4%>票</TD>
											</td>
										</tr><tr class="line-even">
											<td align="left" width="30%">差</td>
											<td align="left"><%=new java.lang.Double(percent_yinxiang_5*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_yinxiang_5*20%>' height="5">&nbsp;&nbsp;<%=yinxiang_count_5%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">同以往比较，现在本镇的政风情况</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">明显好转</td>
											<td align="left"><%=new java.lang.Double(percent_zhenfeng_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhenfeng_1*20%>' height="5">&nbsp;&nbsp;<%=zhenfeng_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">略有好转</td>
											<td align="left"><%=new java.lang.Double(percent_zhenfeng_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhenfeng_2*20%>' height="5">&nbsp;&nbsp;<%=zhenfeng_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">没有好转</td>
											<td align="left"><%=new java.lang.Double(percent_zhenfeng_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhenfeng_3*20%>' height="5">&nbsp;&nbsp;<%=zhenfeng_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">更差</td>
											<td align="left"><%=new java.lang.Double(percent_zhenfeng_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhenfeng_4*20%>' height="5">&nbsp;&nbsp;<%=zhenfeng_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇执法部门的执法行为</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">公正</td>
											<td align="left"><%=new java.lang.Double(percent_zhifa_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhifa_1*20%>' height="5">&nbsp;&nbsp;<%=zhifa_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较公正</td>
											<td align="left"><%=new java.lang.Double(percent_zhifa_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhifa_2*20%>' height="5">&nbsp;&nbsp;<%=zhifa_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_zhifa_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhifa_3*20%>' height="5">&nbsp;&nbsp;<%=zhifa_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">不公正</td>
											<td align="left"><%=new java.lang.Double(percent_zhifa_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zhifa_4*20%>' height="5">&nbsp;&nbsp;<%=zhifa_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇实施政务公开、接受社会监督</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">满意</td>
											<td align="left"><%=new java.lang.Double(percent_jiandu_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_jiandu_1*20%>' height="5">&nbsp;&nbsp;<%=jiandu_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较满意</td>
											<td align="left"><%=new java.lang.Double(percent_jiandu_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_jiandu_2*20%>' height="5">&nbsp;&nbsp;<%=jiandu_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_jiandu_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_jiandu_3*20%>' height="5">&nbsp;&nbsp;<%=jiandu_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">不满意</td>
											<td align="left"><%=new java.lang.Double(percent_jiandu_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_jiandu_4*20%>' height="5">&nbsp;&nbsp;<%=jiandu_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇的办事效率</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">高</td>
											<td align="left"><%=new java.lang.Double(percent_xiaolv_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_xiaolv_1*20%>' height="5">&nbsp;&nbsp;<%=xiaolv_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较高</td>
											<td align="left"><%=new java.lang.Double(percent_xiaolv_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_xiaolv_2*20%>' height="5">&nbsp;&nbsp;<%=xiaolv_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_xiaolv_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_xiaolv_3*20%>' height="5">&nbsp;&nbsp;<%=xiaolv_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">不高</td>
											<td align="left"><%=new java.lang.Double(percent_xiaolv_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_xiaolv_4*20%>' height="5">&nbsp;&nbsp;<%=xiaolv_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇工作人员的清正廉洁</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">好</td>
											<td align="left"><%=new java.lang.Double(percent_lianjie_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_lianjie_1*20%>' height="5">&nbsp;&nbsp;<%=lianjie_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较好</td>
											<td align="left"><%=new java.lang.Double(percent_lianjie_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_lianjie_2*20%>' height="5">&nbsp;&nbsp;<%=lianjie_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_lianjie_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_lianjie_3*20%>' height="5">&nbsp;&nbsp;<%=lianjie_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">差</td>
											<td align="left"><%=new java.lang.Double(percent_lianjie_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_lianjie_4*20%>' height="5">&nbsp;&nbsp;<%=lianjie_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇工作人员的服务意识</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">好</td>
											<td align="left"><%=new java.lang.Double(percent_fuwu_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_fuwu_1*20%>' height="5">&nbsp;&nbsp;<%=fuwu_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较好</td>
											<td align="left"><%=new java.lang.Double(percent_fuwu_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_fuwu_2*20%>' height="5">&nbsp;&nbsp;<%=fuwu_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_fuwu_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_fuwu_3*20%>' height="5">&nbsp;&nbsp;<%=fuwu_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">差</td>
											<td align="left"><%=new java.lang.Double(percent_fuwu_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_fuwu_4*20%>' height="5">&nbsp;&nbsp;<%=fuwu_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇的实事工程</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">好</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_1*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较好</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_2*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_3*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">差</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_4*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇干部的工作作风</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">满意</td>
											<td align="left"><%=new java.lang.Double(percent_zuofeng_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zuofeng_1*20%>' height="5">&nbsp;&nbsp;<%=zuofeng_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较满意</td>
											<td align="left"><%=new java.lang.Double(percent_zuofeng_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zuofeng_2*20%>' height="5">&nbsp;&nbsp;<%=zuofeng_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_zuofeng_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zuofeng_3*20%>' height="5">&nbsp;&nbsp;<%=zuofeng_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">不满意</td>
											<td align="left"><%=new java.lang.Double(percent_zuofeng_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_zuofeng_4*20%>' height="5">&nbsp;&nbsp;<%=zuofeng_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">本镇的实事工程</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">好</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_1*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_1%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">较好</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_2*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_2%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">一般</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_3*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_3%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">差</td>
											<td align="left"><%=new java.lang.Double(percent_gongcheng_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_gongcheng_4*20%>' height="5">&nbsp;&nbsp;<%=gongcheng_count_4%>票</TD>
											</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr width="100%" class="line-odd">
											<td align="left" colspan="3">当前镇政府必须重点抓的政风问题</td>
										</tr>
										<tr>
										 <td background="/website/images/mid10.gif" width="1" colspan="3"><img src="/website/images/mid10.gif" width="1" height="3"></td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">政务（事务）公开不到位，内容更新不及时</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_1*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_1*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_1).intValue()%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">执法不够严格，有随意性、不够公正</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_2*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_2*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_2).intValue()%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">办事推诿、拖拉，效率低，态度生硬</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_3*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_3*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_3).intValue()%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">利用职权"吃、拿、卡、要、报"，捞取好处</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_4*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_4*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_4).intValue()%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">违反规定收费，乱摊派、乱罚款</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_5*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_5*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_5).intValue()%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%">工作作风不实，干部下基层指导工作少，工作只布置不落实</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_6*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_6*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_6).intValue()%>票</TD>
											</td>
										</tr>
										<tr class="line-even">
											<td align="left" width="30%"> 好大喜功，民主意识差，工作要求脱离实际</td>
											<td align="left"><%=new java.lang.Double(percent_wenti_7*100).intValue()%>%</td>
											<td align="left">
											<img src="/system/images/bar.gif" width='<%=percent_wenti_7*20%>' height="5">&nbsp;&nbsp;<%=new java.lang.Double(wenti_7).intValue()%>票</TD>
											</td>
										</tr>




</table>

<%
dImpl.closeStmt();
dCn.closeCn();
%>
<%@include file="/system/app/skin/bottom.jsp"%>