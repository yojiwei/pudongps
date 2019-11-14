<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
NumberFormat formatter = NumberFormat.getNumberInstance();
formatter.setMinimumFractionDigits(2);
formatter.setMaximumFractionDigits(2);
java.util.Date date = new java.util.Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
String czl = "0";  //参政类
String jbl = "0";  //举报类
String ssl = "0";  //申诉类
String qjl = "0";  //求决类
String qtl = "0";  //其他类
int qz_yxxj = 0;        // 区长总共有效信件数
int qz_cnyxxj = 0;      // 中文版区长有效信件
int qz_enyxxj = 0;      // 英文版区长有效信件
int qz_hfxj = 0;        // 区长回复信件数
int jd_yxxj = 0;        // 街道有效信件数
int jd_hfxj = 0;        // 街道回复信件数
int zx_yxxj = 0;        // 网上咨询有效信件数
int zx_hfxj = 0;        // 网上咨询回复信件数
int ts_yxxj = 0;        // 投诉类有效信件数
int ts_hfxj = 0;        // 投诉类回复信件数
int xf_yxxj = 0;        // 信访有效信件数
int xf_hfxj = 0;        // 信访回复信件数
StringBuffer caseContent = new StringBuffer(); //典型案例
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String beginTime = "";
String endTime = "";
beginTime = CTools.dealString(request.getParameter("beginTime")).trim();
endTime = CTools.dealString(request.getParameter("endTime")).trim();
//区长信箱
String sqlStr="SELECT count(c.cw_id) num,c.dd_id FROM tb_connwork c,tb_connproc p WHERE (p.cp_id='o1' or p.cp_upid='o1') and c.cp_id=p.cp_id and c.cw_status <>9 ";

String hf_sqlStr="SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_id='o1'or p.cp_upid='o1') and c.cp_id=p.cp_id and c.cw_status=1";
//街道镇信箱
String jd_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_upid = 'o10000' or p.cp_id= 'o11835') and c.cp_id=p.cp_id and c.cw_status<>9";//加上川沙新镇

String jdhf_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_upid='o10000'  or p.cp_id= 'o11835') and c.cp_id=p.cp_id and c.cw_status=1";
//咨询信箱有效信件
String zx_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_upid='o7') and c.cp_id=p.cp_id and c.cw_status<>9";
//咨询信箱待处理信件
String zxhf_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_upid='o7') and c.cp_id=p.cp_id and c.cw_status=1";
//信访信箱有效信件
String xf_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_id='o5'or p.cp_upid='o5') and c.cp_id=p.cp_id and c.cw_status<>9";
//信访信箱待处理信件
String xfhf_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_id='o5'or p.cp_upid='o5') and c.cp_id=p.cp_id and c.cw_status=1";
//投诉信箱有效信件
String ts_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_id='o4'or p.cp_upid='o4' or p.cp_id='o8' or  p.cp_id='o9') and c.cp_id=p.cp_id and c.cw_status<>9";
//投诉信箱待处理信件
String tshf_sqlStr = "SELECT count(c.cw_id) num FROM tb_connwork c,tb_connproc p WHERE (p.cp_id='o4'or p.cp_upid='o4' or p.cp_id='o8' or  p.cp_id='o9') and c.cp_id=p.cp_id and c.cw_status=1";

//典型案例
String case_sqlStr = "select c.cs_title,c.cs_content,c.cp_id,d.dt_name from tb_conncase c,tb_deptinfo d  where  c.dt_id = d.dt_id and c.cp_id='o1'";
String case_sqlStr_jd = "select c.cs_title,c.cs_content,c.cp_id,d.dt_name from tb_conncase c,tb_deptinfo d  where c.dt_id = d.dt_id and c.cp_id='o10000'";
String case_sqlStr_zx = "select c.cs_title,c.cs_content,c.cp_id,d.dt_name from tb_conncase c,tb_deptinfo d  where c.dt_id = d.dt_id and c.cp_id='o7'";
String case_sqlStr_ts = "select c.cs_title,c.cs_content,c.cp_id,d.dt_name from tb_conncase c,tb_deptinfo d  where c.dt_id = d.dt_id and (c.cp_id='o4' or c.cp_id='o8' or c.cp_id='o9')";
String case_sqlStr_xf = "select c.cs_title,c.cs_content,c.cp_id,d.dt_name from tb_conncase c,tb_deptinfo d  where c.dt_id = d.dt_id and c.cp_id='o5'";

if (!beginTime.equals("")){
	sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	hf_sqlStr +=" and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	jd_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	jdhf_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";	
	zx_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	zxhf_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";	
	xf_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	xfhf_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";	
	ts_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	tshf_sqlStr += " and c.cw_applytime > to_date('" + beginTime + " 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
	case_sqlStr  += " and cs_date>= to_date('" + beginTime + "','yyyy-mm-dd') ";
	case_sqlStr_jd  += " and cs_date>= to_date('" + beginTime + "','yyyy-mm-dd') ";
	case_sqlStr_zx  += " and cs_date>= to_date('" + beginTime + "','yyyy-mm-dd') ";
	case_sqlStr_ts  += " and cs_date>= to_date('" + beginTime + "','yyyy-mm-dd') ";
	case_sqlStr_xf  += " and cs_date>= to_date('" + beginTime + "','yyyy-mm-dd') ";
 }
if (!endTime.equals("")){
	sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	hf_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	jd_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	jdhf_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";	
	zx_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	zxhf_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";	
	xf_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	xfhf_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";	
	ts_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
	tshf_sqlStr += " and c.cw_applytime < to_date('" + endTime + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";	
	case_sqlStr  += " and cs_date<= to_date('" + endTime + "','yyyy-mm-dd') ";
	case_sqlStr_jd  += " and cs_date<= to_date('" + endTime + "','yyyy-mm-dd') ";
	case_sqlStr_zx  += " and cs_date<= to_date('" + endTime + "','yyyy-mm-dd') ";
	case_sqlStr_ts  += " and cs_date<= to_date('" + endTime + "','yyyy-mm-dd') ";
	case_sqlStr_xf  += " and cs_date<= to_date('" + endTime + "','yyyy-mm-dd') ";
}
sqlStr +="	group by c.dd_id"; 

Vector vectorPage = dImpl.splitPage(sqlStr,request,20);
if(vectorPage!=null){
     for(int j=0;j<vectorPage.size();j++){
       Hashtable content = (Hashtable)vectorPage.get(j);
       String dd_id = CTools.dealNull(content.get("dd_id"));
			 String num =  CTools.dealNull(content.get("num"));
			 qz_yxxj = qz_yxxj + Integer.parseInt(num);
			 if(!"".equals(dd_id)){
			 	qz_cnyxxj = qz_cnyxxj + Integer.parseInt(num);
			 }else{
			 	qz_enyxxj = qz_enyxxj + Integer.parseInt(num);
			 }
			 if(dd_id.equals("10")){
		        czl = num;
			 }
			 else if(dd_id.equals("20")){
		       ssl = num;
			 }
			 else if(dd_id.equals("30")){
		       qjl = num;
			 }
			 else if(dd_id.equals("40")){
		       jbl = num;
			 }
			 else if(dd_id.equals("99")){
		       qtl = num;
			 }
		   }
}
//区长信箱有效信件、回复率
Hashtable hf_content = dImpl.getDataInfo(hf_sqlStr);
if(hf_content!=null)
qz_hfxj =  qz_yxxj - Integer.parseInt(hf_content.get("num").toString());
double qzhf_rate = 100;
if(qz_yxxj>0)
qzhf_rate = (Double.parseDouble(qz_hfxj+"")/Double.parseDouble(qz_yxxj+""))*100;

//街道有效信件、回复率
Hashtable yx_content = dImpl.getDataInfo(jd_sqlStr);
if(yx_content!=null)
jd_yxxj =  Integer.parseInt(yx_content.get("num").toString());
hf_content = dImpl.getDataInfo(jdhf_sqlStr);
if(hf_content!=null)
jd_hfxj = jd_yxxj - Integer.parseInt(hf_content.get("num").toString());
double jdhf_rate = 100;
if(jd_yxxj>0)
jdhf_rate = (Double.parseDouble(jd_hfxj+"")/Double.parseDouble(jd_yxxj+""))*100;
//网上咨询有效信件、回复率
yx_content = dImpl.getDataInfo(zx_sqlStr);
if(yx_content!=null)
zx_yxxj =  Integer.parseInt(yx_content.get("num").toString());
hf_content = dImpl.getDataInfo(zxhf_sqlStr);
if(hf_content!=null)
zx_hfxj = zx_yxxj - Integer.parseInt(hf_content.get("num").toString());
double zxhf_rate = 100;
if(zx_yxxj>0)
zxhf_rate = (Double.parseDouble(zx_hfxj+"")/Double.parseDouble(zx_yxxj+""))*100;
//投诉类有效信件、回复率
yx_content = dImpl.getDataInfo(ts_sqlStr);
if(yx_content!=null)
ts_yxxj =  Integer.parseInt(yx_content.get("num").toString());
hf_content = dImpl.getDataInfo(tshf_sqlStr);
if(hf_content!=null)
ts_hfxj =  ts_yxxj - Integer.parseInt(hf_content.get("num").toString());
double tshf_rate = 100;
if(ts_yxxj>0)
tshf_rate = (Double.parseDouble(ts_hfxj+"")/Double.parseDouble(ts_yxxj+""))*100;
//信访有效信件、回复率
yx_content = dImpl.getDataInfo(xf_sqlStr);
if(yx_content!=null)
xf_yxxj =  Integer.parseInt(yx_content.get("num").toString());//信访有效总信件
hf_content = dImpl.getDataInfo(xfhf_sqlStr);
if(hf_content!=null)
xf_hfxj = xf_yxxj - Integer.parseInt(hf_content.get("num").toString());//信访处理过信件
double xfhf_rate = 100;
if(xf_yxxj>0)
xfhf_rate = (Double.parseDouble(xf_hfxj+"")/Double.parseDouble(xf_yxxj+""))*100;//信访信箱回复率


//典型案例
vectorPage = dImpl.splitPage(case_sqlStr,request,1000);
if(vectorPage!=null){
caseContent.append("区长信箱");
 caseContent.append("<br>");
  for(int j=0;j<vectorPage.size();j++){
   Hashtable content = (Hashtable)vectorPage.get(j);		
   int num = j+1; 
	 caseContent.append("&nbsp;&nbsp;&nbsp;&nbsp;"+num+":");    
   caseContent.append("单位："+content.get("dt_name")+"&nbsp;&nbsp;&nbsp;&nbsp;");   
   caseContent.append("主题："+content.get("cs_title")+"&nbsp;&nbsp;&nbsp;&nbsp;");       
	 caseContent.append("内容："+content.get("cs_content").toString());
	 caseContent.append("<br>");		 
   }
}
vectorPage = dImpl.splitPage(case_sqlStr_jd,request,1000);
if(vectorPage!=null){
  caseContent.append("街道信箱");
  caseContent.append("<br>");
  for(int j=0;j<vectorPage.size();j++){
   Hashtable content = (Hashtable)vectorPage.get(j);   
  int num = j+1; 
	 caseContent.append("&nbsp;&nbsp;&nbsp;&nbsp;"+num+":");    
   caseContent.append("单位："+content.get("dt_name")+"&nbsp;&nbsp;&nbsp;&nbsp;");   
   caseContent.append("主题："+content.get("cs_title")+"&nbsp;&nbsp;&nbsp;&nbsp;");        
	 caseContent.append("内容："+content.get("cs_content").toString());
	 caseContent.append("<br>");
   }
}
vectorPage = dImpl.splitPage(case_sqlStr_zx,request,1000);
if(vectorPage!=null){
  caseContent.append("网上咨询");
  caseContent.append("<br>");
  for(int j=0;j<vectorPage.size();j++){
   Hashtable content = (Hashtable)vectorPage.get(j);   
   int num = j+1; 
	 caseContent.append("&nbsp;&nbsp;&nbsp;&nbsp;"+num+":");    
   caseContent.append("单位："+content.get("dt_name")+"&nbsp;&nbsp;&nbsp;&nbsp;");   
   caseContent.append("主题："+content.get("cs_title")+"&nbsp;&nbsp;&nbsp;&nbsp;");       
	 caseContent.append("内容："+content.get("cs_content").toString());
	 caseContent.append("<br>");
   }
}
vectorPage = dImpl.splitPage(case_sqlStr_ts,request,1000);
if(vectorPage!=null){
  caseContent.append("投诉类信箱");
  caseContent.append("<br>");
  for(int j=0;j<vectorPage.size();j++){
   Hashtable content = (Hashtable)vectorPage.get(j);   
  int num = j+1; 
	 caseContent.append("&nbsp;&nbsp;&nbsp;&nbsp;"+num+":");    
   caseContent.append("单位："+content.get("dt_name")+"&nbsp;&nbsp;&nbsp;&nbsp;");   
   caseContent.append("主题："+content.get("cs_title")+"&nbsp;&nbsp;&nbsp;&nbsp;");   
	 caseContent.append("内容："+content.get("cs_content").toString());
	 caseContent.append("<br>");
   }
}
vectorPage = dImpl.splitPage(case_sqlStr_xf,request,1000);
if(vectorPage!=null){
  caseContent.append("信访信箱");
  caseContent.append("<br>");
  for(int j=0;j<vectorPage.size();j++){
   Hashtable content = (Hashtable)vectorPage.get(j);   
   int num = j+1; 
	 caseContent.append("&nbsp;&nbsp;&nbsp;&nbsp;"+num+":");    
   caseContent.append("单位："+content.get("dt_name")+"&nbsp;&nbsp;&nbsp;&nbsp;");   
   caseContent.append("主题："+content.get("cs_title")+"&nbsp;&nbsp;&nbsp;&nbsp;");     
	 caseContent.append("内容："+content.get("cs_content").toString());
	 caseContent.append("<br>");
   }
}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->
上海浦东信箱运行和反馈情况表
<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" width="100%">
	<form name="formData" method="post" >
			<tr class="line-odd">
				<td  colspan="10">&nbsp;</td>		
				<td  colspan="10" width="100">&nbsp;</td>			
			</tr>
			<tr class="line-odd">
				<td align="right">标题</td>
				<td align="left" colspan="9"><input class="text-line" name="n1" value="上海浦东信箱运行和反馈情况表（<%=("".equals(beginTime)&&"".equals(endTime))?sdf.format(date).toString():beginTime+"至"+endTime%>）"  size="65" maxlength="100"></td>
				<td  colspan="10" width="100">&nbsp;</td>		
			</tr>
			<tr class="line-even">
				<td align="right">填报单位名称</td>
				<td align="left"  colspan="3"><input class="text-line" name="n2" value="" size="20" maxlength="50"></td>			
				<td align="right">填报部门名称</td>
				<td align="left"  colspan="5"><input class="text-line" name="n3" value="" size="20" maxlength="50"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
				<td align="right">联系人</td>
				<td align="left"  colspan="3"><input class="text-line" name="n4" value="" size="20" maxlength="50"></td>			
				<td align="right">联系电话</td>
				<td align="left"  colspan="5"><input class="text-line" name="n5" value="" size="20" maxlength="50"></td>
			    <td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-even">
				<td align="right">领导信箱名称</td>
				<td align="left" colspan="9"><input class="text-line" name="n6" value="区长信箱"  size="65" maxlength="100"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
				<td align="right">有效总信件数</td>
				<td align="left"  colspan="3"><input class="text-line" name="n7" value="<%=qz_yxxj%>" size="20" maxlength="50"></td>			
				<td align="right">回复率</td>
				<td align="left"  colspan="5"><input class="text-line" name="n8" value="<%=formatter.format(qzhf_rate)%>%" size="20" maxlength="50"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
				<td align="right">中文有效信件数</td>
				<td align="left"  colspan="9"><input class="text-line" name="n7" value="<%=qz_cnyxxj%>" size="20" maxlength="50"></td>			<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
            <tr class="line-even">
				<td align="right">参政类</td>
				<td align="left" ><input class="text-line" name="n9" value="<%=czl%>" size="5" maxlength="10"></td>		
				<td align="right">申诉类</td>
				<td align="left" ><input class="text-line" name="n10" value="<%=ssl%>" size="5" maxlength="10"></td>	
				<td align="right">求决类</td>
				<td align="left" ><input class="text-line" name="n11" value="<%=qjl%>" size="5" maxlength="10"></td>	
				<td align="right">举报类</td>
				<td align="left" ><input class="text-line" name="n12" value="<%=jbl%>" size="5" maxlength="10"></td>	
				<td align="right">其他</td>
				<td align="left" ><input class="text-line" name="n13" value="<%=qtl%>" size="5" maxlength="10"></td>	
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
				<td align="right">英文有效信件数</td>
				<td align="left"  colspan="9"><input class="text-line" name="n7" value="<%=qz_enyxxj%>" size="20" maxlength="50"></td>			<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
				<td align="left" colspan="10">________________________________________________________________________________________________________</td>	
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
      <tr class="line-even">
				<td align="right">街道乡镇信箱数</td>
				<td align="left" colspan="2" ><input class="text-line" name="n9" value="38" size="5" maxlength="10"></td>		
				<td align="right" >有效信件数</td>
				<td align="left" colspan="2"><input class="text-line" name="n10" value="<%=jd_yxxj%>" size="5" maxlength="10"></td>	
				<td align="right">回复率</td>
				<td align="left" colspan="3"><input class="text-line" name="n11" value="<%=formatter.format(jdhf_rate)%>%" size="5" maxlength="10"></td>					
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
      <tr class="line-odd">
				<td align="left" colspan="10">________________________________________________________________________________________________________</td>	
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
      <tr class="line-even">
        <td align="right" >&nbsp;</td>	
				<td align="center" colspan="3" >其他互动信箱名称</td>			
				<td align="center" colspan="3" >有效信件数</td>				
				<td align="center" colspan="3" >回复率</td>							
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
      <tr class="line-odd">
        <td align="center" >1</td>	
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="网上咨询" size="15" maxlength="10"></td>			
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="<%=zx_yxxj%>" size="15" maxlength="10"></td>				
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="<%=formatter.format(zxhf_rate)%>%" size="15" maxlength="10"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-even">
        <td align="center" >2</td>	
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="投诉类信箱" size="15" maxlength="10"></td>			
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="<%=ts_yxxj%>" size="15" maxlength="10"></td>				
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="<%=formatter.format(tshf_rate)%>%" size="15" maxlength="10"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
                <td align="center" >3</td>	
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="信访信箱" size="15" maxlength="10"></td>			
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="<%=xf_yxxj%>" size="15" maxlength="10"></td>				
				<td align="center" colspan="3" ><input class="text-line" name="n10" value="<%=formatter.format(xfhf_rate)%>%" size="15" maxlength="10"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-even">
                <td align="right" >备注</td>	
				<td align="left" colspan="9" ><input class="text-line" name="n10" value="投诉类信箱信件包含纪委监察委信箱、检察院信箱、法院信箱" size="65" maxlength="10"></td>
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
                <td align="right" >典型案例</td>	
				<td align="left" colspan="9" ><textarea id="content" name="CT_content" style="display:none;WIDTH: 100%; HEIGHT: 400px"><%=caseContent.toString()%>&nbsp;</textarea>
		         <IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=CT_content&style=standard" frameborder="0" scrolling="no" width="100%" height="400"></IFRAME></td>	
			<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
			<tr class="line-odd">
				<td  colspan="10">&nbsp;</td>		
				<td  colspan="10" width="100">&nbsp;</td>	
			</tr>
	</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<%
}
catch(Exception e){
	System.out.print(e.toString());
}
finally{
	dImpl.closeStmt();
	dCn.closeCn(); 
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
                                     
