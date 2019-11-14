<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@include file="/system/common/parameter.jsp"%>
<link href="applyopen.css" type="text/css" rel="stylesheet">
<script language="javascript" src="applyopen.js"></script>
<%
String strTitle="申请信息表";
String OPType = ""; //操作方式 Add是添加 Edit是修改
String infoid = ""; //信息id
String keyword = ""; //关键字
String sqlStr = "";
//
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);
//
String infotitle = ""; //申请信息标题
String indexnum = ""; //所需信息索取号
String proposer =""; //申请人类别：公民、企业
String pname=""; //公民姓名
String punit = ""; //工作单位
String pcard = ""; //证件名称
String pcardnum = ""; //证件号码
String paddress=""; //通信地址
String pzipcode = ""; //邮政编码
String ptele = ""; //联系电话
String ptele1 = ""; //联系电话1
String ptele2 = ""; //联系电话2
String pemail = ""; //电子邮件
String ename = "";//申请企业名称
String ecode = "";//组织结构代码
String ebunissinfo = ""; //营业执照信息
String edeputy =""; //法人代表
String elinkman=""; //联系人
String etele = ""; //联系电话
String etele1 = ""; //联系电话1
String etele2 = ""; //联系电话2
String eemail = ""; //电子邮件
String applytime = ""; //申请时间
String commentinfo=""; //所需信息内容描述
String purpose = ""; //所需信息用途
String ischarge = ""; //是否减免费用
String chargeAbout = ""; //是否减免费用
String offermodeC[] = new String[3]; //所需信息提供方式
String offermode = ""; //所需信息提供方式
String gainmodeC[] = new String[5]; //获取信息方式
String gainmode = ""; //获取信息方式
String othermode = ""; //是否接受其他信息提供方式 0不接受、1接受
String feedback = ""; //反馈意见
String status = "0"; //状态：0待处理、1处理中、2已结束通过、3处理结束不通过
String finishtime = ""; //结束时间
String ispublish = ""; //是否公开：0公开、1不公开
String dt_id = "";//部门id
String dname = "";//部门名称

Hashtable holidy_con = null; //节假日设置
String isholiday = ""; //1是节假日，0工作日，null表示原始状态（如周一至周五是工作日，周六、周日为节假日）

OPType = CTools.dealString(request.getParameter("OPType")).trim();
infoid = CTools.dealString(request.getParameter("ct_id")).trim();
keyword = CTools.dealString(request.getParameter("keyword")).trim();


if(OPType.equals(""))
{
	OPType = "add";
}

DateFormat df = DateFormat.getDateTimeInstance(DateFormat.DEFAULT,DateFormat.DEFAULT,Locale.CHINA);
applytime = df.format(new java.util.Date());

Calendar cal = Calendar.getInstance();
for (int i=0;i<15;i++) {
	cal.add(Calendar.DAY_OF_MONTH,1);
	sqlStr = "select hd_flag from tb_holiday where hd_date = to_date('"+ df.format(cal.getTime()).substring(0,df.format(cal.getTime()).indexOf(" ")) +"','yyyy-mm-dd hh:mi:ss')";
	holidy_con = dImpl.getDataInfo(sqlStr);
	if (holidy_con != null)
	{
		isholiday = holidy_con.get("hd_flag").toString();
	}
	if ((cal.get(Calendar.DAY_OF_WEEK)-1) == 6 || (cal.get(Calendar.DAY_OF_WEEK)-1) == 0) //星期六或星期日
	{
		if (!"0".equals(isholiday)) { //未设置当天为工作日
			i--; //当天为节假日，日期增加一天
		}
	}
else //星期一至星期五
	{
		if ("1".equals(isholiday)) { //设置为节假日
			i--; //当天为节假日，日期增加一天
		}
	}
	isholiday = ""; //节假日状态还原
}

if(!"".equals(infoid))
{
  sqlStr = "select ct_title,in_catchnum from tb_content where ct_id = "+ infoid;
  Hashtable ctCon = dImpl.getDataInfo(sqlStr);
  if (ctCon != null)
  {
    infotitle = ctCon.get("ct_title").toString();
    indexnum = ctCon.get("in_catchnum").toString();
  }
}

if(!"".equals(keyword))
{
  infotitle = keyword;
}
	//获得使用用户的部门编号
	CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
	if (mySelf!=null){
		dt_id = Long.toString(mySelf.getDtId());
		if (!"".equals(dt_id))
		{
			//查询出使用用户的部门名称
		  String dtSql = "select dt_name from tb_deptinfo where dt_id = " + dt_id;
		  Hashtable dtCon = dImpl.getDataInfo(dtSql);
		  if (dtCon != null)
		  {
		    dname = dtCon.get("dt_name").toString();
		  }
		}
	}
%>
<%@include file="/system/app/skin/skin4/template/info_top.jsp"%>
<!--    模块名称开始    -->

<!--    模块名称结束    -->
<%@include file="/system/app/skin/skin4/template/info_funtion.jsp"%>
<!--    功能按钮开始    -->

<!--    功能按钮结束    -->
<%@include file="/system/app/skin/skin4/template/info_main.jsp"%>
<!--    表单提交开始    -->
<table class="main-table" height=0 width="100%">
<iframe id="usercheck" name="usercheck" src="#" width="0" height="0"></iframe>
<form name="formData" method="post" action="applyResult.jsp">
	<!--用户操作类型 -->
	<input type="hidden" name="OPType" value="<%=OPType%>">
	<input type="hidden" name="applyflag" value="">
	<input type="hidden" name="finishnow" value="0">
	<input type="hidden" name="infoid" value="<%=infoid%>">
	<input type="hidden" name="limittime" value="<%=df.format(cal.getTime()).substring(0,df.format(cal.getTime()).indexOf(" "))%>">
  <tr>
    <td colspan="6" align="center" class="title1">信息公开申请表</td>
  </tr>
  <tr class="line-odd">
    <td align="center" width="12%">受理方式</td>
    <td align="left"><select name="signmode" onchange="allowPnt(this)">
    	<option value="1">现场登记</option>
    	<option value="2">E-mail申请</option>
    	<option value="3">信函申请</option>
    	<option value="4">电报申请</option>
    	<option value="5">传真申请</option>
    	<option value="6">其它</option>
    </select></td>
  </tr>
<%if (OPType.equals("add")) {%>
  <tr class="line-even">
    <td colspan="6" align="left">· 非企业用户申请请您先输入用户的<font color="#FF0000">身份证号码</font>，并点击“个人用户验证”；<br>· 企业用户申请请您先输入申请企业营业执照上的<font color="#FF0000">企业名称</font>并点击“企业用户验证”；<br>· 若用户注册信息存在，系统会自动读取用户注册信息，您也可以直接填写表格！</td>
  </tr>
<%}%>
  <tr class="line-odd">
    <td align="center" width="12%">验证关键字</td>
    <td align="left"><input name="pcardnumCheck" type="text" size="24" onFocus="javascript:this.select();" maxlength="20"> <input type="button" class="bttn" name="usubmit" value="个人用户验证" onclick="checkUser(0)"> <input type="button" class="bttn" name="usubmit" value="企业用户验证" onclick="checkUser(1)"></td>
  </tr>
  <tr class="line-even">
    <td align="center" width="12%">申请人类别</td>
    <td align="left">
    	<input type="radio" name="proposer" id="proposer1" value="0" onclick="javascript:showpe('0');" checked> 公民　　
      <input type="radio" name="proposer" id="proposer2" value="1" onclick="javascript:showpe('1');"> 法人/其他组织</td>
  </tr>
</table> 

<table class="main-table"  style="display:" id='pinfo' height=0 width="100%">
  <tr>
    <td colspan="6" align="center" class="title1">申请人信息</td>
  </tr>
  <tr class="line-odd">
    <td rowspan="5" align="center">公民</td>
    <td width="16%" align="center">申请人姓名</td>
    <td width="20%" align="left"><input name="pname" type="text" size="14" maxlength="10"/> <font color="#FF0000">*</font></td>
    <td width="16%" align="center">工作单位</td>
    <td colspan="2" align="left"><input name="punit" type="text" size="24" maxlength="50"/></td>
  </tr>
  <tr class="line-even">
    <td align="center">证件名称</td>
    <td align="left"><input name="pcard" type="text" size="14" value="身份证" maxlength="8"> <font color="#FF0000">*</font></td>
    <td align="center">证件号码</td>
    <td colspan="2" align="left"><input name="pcardnum" type="text" size="24" maxlength="22"/> <font color="#FF0000">*</font></td>
  </tr>
  <tr class="line-odd">
    <td align="center">通信地址</td>
    <td colspan="2" align="left"><input name="paddress" type="text" size="24" /> <font color="#FF0000">*</font></td>
    <td width="16%" align="center">邮政编码</td>
    <td width="20%" align="left"><input name="pzipcode" type="text" size="14" maxlength="6"/> <font color="#FF0000">*</font></td>
  </tr>
  <tr class="line-even">
    <td align="center">联系电话</td>
    <td colspan="2" align="left"><input name="ptele1" type="text" size="24" maxlength="22"/> <font color="#FF0000">*</font></td>
    <td colspan="2" align="left"><input name="ptele2" type="text" size="24" maxlength="22"/></td>
    <input type="hidden" name="ptele" size="24" value="">
  </tr>
  <tr class="line-odd">
    <td align="center">电子邮箱</td>
    <td colspan="4" align="left"><input name="pemail" type="text" size="50" maxlength="30"/></td>
  </tr>
</table> 
  
<table class="main-table" id='einfo' height=0 width="100%" style="display:none">
  <tr>
    <td colspan="5" align="center" class="title1">申请人信息</td>
  </tr>
  <tr class="line-odd">
    <td rowspan="5" align="center">法人/<br />
    其他组织</td>
    <td align="center" width="16%">企业名称</td>
    <td align="left" width="20%"><input name="ename" type="text" size="14" maxlength="16"/> <font color="#FF0000">*</font></td>
    <td align="center" width="16%">组织机构代码</td>
    <td align="left" width="36%"><input name="ecode" type="text" size="24" maxlength="20"/> <font color="#FF0000">*</font></td>
  </tr>
  <tr class="line-even">
    <td align="center">营业执照信息</td>
    <td colspan="3" align="left"><input name="ebunissinfo" type="text" size="50" maxlength="50"/> <font color="#FF0000">*</font></td>
    </tr>
  <tr class="line-odd">
    <td align="center">法人代表</td>
    <td align="left"><input name="edeputy" type="text" size="14" maxlength="10"/> <font color="#FF0000">*</font></td>
    <td align="center">联系人姓名</td>
    <td align="left"><input name="elinkman" type="text" size="24" maxlength="10"/> <font color="#FF0000">*</font></td>
    </tr>
  <tr class="line-even">
    <td align="center">联系人电话</td>
    <td colspan="2" align="left"><input name="etele1" type="text" size="24" maxlength="22"/> <font color="#FF0000">*</font></td>
    <td align="left"><input name="etele2" type="text" size="24" maxlength="22"/></td>
    <input type="hidden" name="etele" size="24" value="">
  </tr>
  <tr class="line-odd">
    <td align="center">联系人电子邮箱</td>
    <td colspan="3" align="left"><input name="eemail" type="text" size="50" maxlength="30"/></td>
  </tr> 
</table> 

<table class="main-table" height=0 width="100%">
  <tr>
    <td colspan="5" align="center" class="title1">所需信息情况</td>
  </tr>
  <tr class="line-even">
    <td width="10%" align="center">信息名称</td>
    <td colspan="4" align="left"><input name="infotitle" type="text" size="50" maxlength="100" value="<%=infotitle%>" <%if (!"".equals(infoid)) out.println("readonly");%>> <font color="#FF0000">*</font></td>
  </tr>
  <tr class="line-odd">
    <td align="center">所需信息内容描述</td>
    <td colspan="4" align="left"><textarea name="commentinfo" cols="50" rows="5" ></textarea> <font color="#FF0000">*</font></td>
  </tr>
  <tr class="line-even">
    <td align="center">所需信息的索取号</td>
    <td colspan="4" align="left"><input name="indexnum" type="text" size="50" value="<%=indexnum%>" readonly></td>
  </tr>
  <tr class="line-odd">
    <td align="center">所需信息的用途</td>
    <td colspan="4" align="left"><input name="purpose" type="text" size="50" maxlength="200"/> <font color="#FF0000">*</font></td>
  </tr>
  <tr class="line-even">
    <td align="center">备注</td>
    <td colspan="4" align="left"><textarea name="memo" cols="50" rows="5"></textarea></td>
  </tr>
  <tr class="line-odd">
    <td align="center">是否申请减免费用</td>
    <td align="left" colspan="4"><input type="radio" name="ischarge" value="0" checked>
      不　　
      <input type="radio" name="ischarge" value="1" />
      是（申请减免费用请提供相关证明）
    </td>
    <input type="hidden" name="ischarge" value="">
     </tr>
  <tr class="line-even">
    <td align="center">所需信息指定提供方式</td>
    <input type="hidden" name="offermode" value="">
    <td colspan="4" align="left"><input type="checkbox" name="offermodeC" value="0" />
      纸面　　
        <input type="checkbox" name="offermodeC" value="1" />
电子邮件　　
<input type="checkbox" name="offermodeC" value="2" />
磁盘　　</td>
  </tr>
  <tr class="line-odd">
    <td align="center">获取信息的方式</td>
    <input type="hidden" name="gainmode" value="">
    <td colspan="4" align="left"><input type="checkbox" name="gainmodeC" value="0" />
      邮寄　　
      <input type="checkbox" name="gainmodeC" value="1" />
      快递　　
      <input type="checkbox" name="gainmodeC" value="2" />
电子邮件　　
      <input type="checkbox" name="gainmodeC" value="3" />
      传真　　
      <input type="checkbox" name="gainmodeC" value="4" />
      自行领取/当场阅读抄录　　</td>
  </tr>
  <tr class="line-even">
    <td align="center">选择受理答复情况</td>
    <td width="16%" align="left">
    	<input type="radio" name="sign" value="0" onclick="javascript:applytask(this.value,this)"> 当场答复　　
    	<input type="radio" name="sign" value="1" onclick="javascript:applytask(this.value,this)"> 书面答复</td>
    <td align="center" width="8%">答复日期</td>
    <td colspan="2" align="left" width="20%"><input type="text" name="aanswertime" readonly="true" value=""></td>
  </tr>
  <tr class="line-odd">
    <td align="center">申请代办</td>
    <td colspan="4" align="left">
    	<input type="radio" name="sign" value="2" onclick="javascript:applytask(this.value,this)"> 委托本服务窗口代办　　
    	<input type="radio" name="sign" value="3" onclick="javascript:applytask(this.value,this)"> 由申请人直接向信息公开责任单位提出申请</td>
  </tr>
  <tr class="line-even" id="pass" style="display:none">
    <td colspan="5" align="center">
    	<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom">
						<table cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td id="chone" align="center" class="title_down" style="cursor:hand" onclick="javascript:wt('chooseDept.jsp','deptlist','chone');">直接选择委办局</td>
							</tr>
						</table>
					</td>
					<td class="title_mi" width="2"></td>
					<td valign="bottom">
						<table cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td id="chtwo" class="title_down" align="center" style="cursor:hand" onclick="javascript:wt('selectDept.jsp','deptlist','chtwo');">根据机构职能指派</td>
							</tr>
						</table>
					</td>
					<td class="title_mi" width="60%"></td>
				</tr>
			</table>
    </td>
  </tr>
  <tr class="line-odd">
  	<td align="center" colspan="5">
  		<table width="90%" border="0" cellspacing="0" cellpadding="0">
  			<tr>
  				<td id="deptlist" align="left"></td>
  			</tr>
  		</table>
  	</td>
  </tr>
  <tr class="outset-table" align="center">
    <td colspan="5">
			<input id="ispnt" type="button" class="bttn" name="fprint" value="打印受理单" onclick="fnprint();">&nbsp;
    	<input type="button" class="bttn" name="fsubmit" value="受 理" onclick="submitform();">&nbsp;
			<input type="button" class="bttn" name="freset" value="清 空" onclick="fnreset();">&nbsp;
			<input type="button" class="bttn" name="back" value="返回查询页面" onclick="javascript:window.location.href='infoSearch.jsp';">
    </td>
  </tr>
</form>
</table>
<!--    表单提交结束    -->
<%@include file="/system/app/skin/skin4/template/info_bottom.jsp"%> 
<script LANGUAGE="javascript">
function showpe(pe)
{
	var ein = document.all.einfo;
	var pin = document.all.pinfo;
	if (pe == 0) {
			ein.style.display = "none";
			pin.style.display = "";
	}
	else {
			pin.style.display = "none";
			ein.style.display = "";
	}
}
	
function fnreset()
{
	if (confirm("确认清空已填写信息？"))
	var form = document.formData
	form.reset();
}

function checkEmail(email)
{
	var filter=/^.+@.+\..{2,3}$/;
	if(email!="")
	{
		if (filter.test(email)) 
			{
				return true;
			}
		else
			{
				return false;
			}
	}
	return true;
}

function fnprint()
{
	if (checkthisform ()) {
    var w = screen.availWidth;
    var h = screen.availHeight;
	  var form = document.formData;
    var args = new Object;
    args["proposer"] = form.proposer.value;
    args["pname"] = form.pname.value;
    args["punit"] = form.punit.value;
    args["pcard"] = form.pcard.value;
    args["pcardnum"] = form.pcardnum.value;
    args["paddress"] = form.paddress.value;
    args["pzipcode"] = form.pzipcode.value;
    args["ptele"] = form.ptele.value;
    args["pemail"] = form.pemail.value;
    args["ename"] = form.ename.value;
    args["ecode"] = form.ecode.value;
    args["ebunissinfo"] = form.ebunissinfo.value;
    args["edeputy"] = form.edeputy.value;
    args["elinkman"] = form.elinkman.value;
    args["etele"] = form.etele.value;
    args["eemail"] = form.eemail.value;
    args["infotitle"] = form.infotitle.value;
    args["commentinfo"] = form.commentinfo.value;
    args["indexnum"] = form.indexnum.value;
    args["purpose"] = form.purpose.value;
    args["memo"] = form.memo.value;
    args["ischarge"] = form.ischarge.value;
    args["offermode"] = form.offermode.value;
    args["gainmode"] = form.gainmode.value;
    if (document.all.sign[2].checked) {
    args["do"] = "1";
    }
    else if (document.all.sign[3].checked) {
    args["do"] = "2";
    }
    else {
    args["do"] = "0";
    }
    var URL
    if (form.proposer[0].checked) {
    	url = "printApplyInfop.jsp";
    }
    else {
    	url = "printApplyInfoe.jsp";
    }
    window.showModalDialog(url,args,'dialogTop=0px;dialogLeft=0px;dialogWidth='+w+'px;dialogHeight='+h+'px;help=no;status=no;scroll=yes;resizable=yes;');
  }
}


function applytask(o,t){
	var obj = new Array("0","1","2","3");
	try{
		t.checked = true;
		if(o==2){
			document.all.aanswertime.value="";
			document.all.pass.style.display = "";
			wt('chooseDept.jsp','deptlist','chone');
		}else if(o==1){
			document.all.pass.style.display = "none";
			document.all.deptlist.innerHTML = "";
			document.all.aanswertime.value="<%=df.format(cal.getTime()).substring(0,df.format(cal.getTime()).indexOf(" "))%>";
		}else{
			document.all.aanswertime.value="";
			document.all.pass.style.display = "none";
			document.all.deptlist.innerHTML = "";
		}
		
		for(i=0; i<obj.length; i++){
			if(obj[i]==o){
				eval("document.all.s"+obj[i]+".style.display = '';");
			}else{
				eval("document.all.s"+obj[i]+".style.display = 'none';");
			}	
		}
	}catch(e){
		//nothing
	}
}
	
function checkthisform()
{
	
	var form = document.formData;
	var obj = document.all.sign;
	var dept = document.all.did;

	
	if (form.proposer[0].checked)
  {
  	form.proposer.value = "0";
  	
  	if (form.pname.value =="")
    {
       alert("请填写申请人姓名!");
       form.pname.focus();
       return false;
    }
    if (form.pcard.value =="")
    {
       alert("请填写证件名称!");
       form.pcard.focus();
       return false;
    }
	var rex_personid = /^(\d{15}|\w{18})$/;
    if (!rex_personid.test(form.pcardnum.value))
    {
       alert("请正确填写证件号码!");
       form.pcardnum.focus();
       return false;
    }
    if (form.paddress.value =="")
    {
       alert("请填写通信地址!");
       form.paddress.focus();
       return false;
    }
	var rex_zip = /^\d{6}$/;
    if (!rex_zip.test(form.pzipcode.value))
    {
       alert("请正确填写邮政编码!");
       form.pzipcode.focus();
       return false;
    }
    if (form.ptele1.value=="")
    {
      alert("请填写联系人电话!");
      form.ptele1.focus();
      return false;
    }
  else {
  	  form.ptele.value = form.ptele1.value;
  	}
    if (form.ptele2.value !="")
    {
  		form.ptele.value += ",";
  		form.ptele.value += form.ptele2.value;
    }
    if ((form.offermodeC[1].checked || form.gainmodeC[2].checked) && form.pemail.value == "") {
      alert("您选择了通过电子邮件提供及获取信息，请填写电子邮件地址!");
      form.pemail.focus();
      return false;
    }
    if (form.pemail.value != "")
    {
    	if(checkEmail(form.pemail.value)==false)
			{
				alert("填入的不是正确email");
				form.pemail.focus();
				return false;
			}
    }
  }
  else if (form.proposer[1].checked)
  {
  	form.proposer.value = "1";
  	
    if (form.ename.value =="")
    {
       alert("请填写企业名称!");
       form.ename.focus();
       return false;
    }
    if (form.ecode.value =="")
    {
       alert("请填写组织机构代码!");
       form.ecode.focus();
       return false;
    }
    if (form.ebunissinfo.value =="")
    {
       alert("请填写营业执照信息!");
       form.ebunissinfo.focus();
       return false;
    }
    if (form.edeputy.value =="")
    {
       alert("请填写法人代表!");
       form.edeputy.focus();
       return false;
    }
    if (form.elinkman.value =="")
    {
       alert("请填写联系人姓名!");
       form.elinkman.focus();
       return false;
    }
    if (form.elinkman.value =="")
    {
       alert("请填写联系人姓名!");
       form.elinkman.focus();
       return false;
    }
    if (form.etele1.value=="")
    {
      alert("请填写联系人电话!");
      form.etele1.focus();
      return false;
    }
  else {
  		form.etele.value = form.etele1.value;
  	}
    if (form.etele2.value !="")
    {
  		form.etele.value += ",";
  		form.etele.value += form.etele2.value;
    }
    
    if ((form.offermodeC[1].checked || form.gainmodeC[2].checked) && form.eemail.value == "") {
      alert("您选择了通过电子邮件提供及获取信息，请填写电子邮件地址!");
      form.eemail.focus();
      return false;
    }
    if (form.eemail.value != "")
    {
    	if(checkEmail(form.eemail.value)==false)
			{
				alert("填入的不是正确email");
				form.eemail.focus();
				return false;
			}
    }
  }
  else
  {
  	alert("请选择用户类别!");
    form.proposer.focus();
    return false;
  }
  
  if (form.infotitle.value =="")
  {
     alert("请填写信息名称或通过信息公开目录搜索获得!");
     form.infotitle.focus();
     return false;
  }
  if (form.commentinfo.value =="")
  {
     alert("请填写所需信息内容描述!");
     form.commentinfo.focus();
     return false;
  }
  if (form.purpose.value =="")
  {
     alert("请填写所需信息的用途!");
     form.purpose.focus();
     return false;
  }
  if (form.ischarge[1].checked)
  {
  	form.ischarge.value = "1";
  }
  else 
	{
		form.ischarge.value = "0";
	}
	var offermode = "";
	for (var i = 0;i < 3;i++) {
		if (form.offermodeC[i].checked) {
			offermode += form.offermodeC[i].value;
			offermode += ",";
		}
	}
	form.offermode.value = offermode;
	var gainmode = "";
	for (var i = 0;i < 5;i++) {
		if (form.gainmodeC[i].checked) {
			gainmode += form.gainmodeC[i].value;
			gainmode += ",";
		}
	}
	form.gainmode.value = gainmode;

	var status = false;
	if(dept==undefined){
		status = false;
	}else{
		if(dept.length==undefined){
			if(dept.checked) status = true;
			else status = false;
		}else{
			for(i=0; i<dept.length; i++){
				if(dept[i].checked){
					status = true;
					break;
				}
			}
		}
	}
	if(obj[0].checked){
			document.all.applyflag.value = "1";
			document.all.finishnow.value = "1";
	}
	else if(obj[1].checked){
    if (form.aanswertime.value =="")
    {
       return false;
    }
			document.all.applyflag.value = "1";
	}
	//update by dongliang 2008.12.30
	else if(obj[2].checked){
		if(!status){
			alert("请选择委托代办部门!");
				return false;
			
		}
			document.all.applyflag.value = "2";
	}
	else if(obj[3].checked){
			document.all.applyflag.value = "0";
			document.all.finishnow.value = "1";
	}
	else
	{
		alert("请选择“受理答复情况”或“申请代办”!");
    return false;
	}
	if (form.proposer[0].checked)
	{
		form.ename.value ="";
		form.ecode.value ="";
		form.ebunissinfo.value ="";
		form.edeputy.value ="";
		form.elinkman.value ="";
		form.etele.value ="";
		form.eemail.value ="";
	}
	if (form.proposer[1].checked)
	{
		form.pname.value ="";
		form.punit.value ="";
		form.pcard.value ="";
		form.pcardnum.value ="";
		form.paddress.value ="";
		form.pzipcode.value ="";
		form.ptele.value ="";
		form.pemail.value ="";
	}
	if(form.commentinfo.value.length>500)
	{
		alert("所需信息内容描述不能超过500字符！");
		form.commentinfo.focus();
		return false;
	}
	if(form.memo.value.length>500)
	{
		alert("备注不能超过500字符！");
		form.memo.focus();
		return false;
	}
  return true;
}

function submitform ()
{
	if (checkthisform ()) {
	  var form = document.formData;
	  form.submit();
  }
}

function checkUser(prId)
{
	var form = document.formData
	if (form.pcardnumCheck.value =="")
  {
    alert("请填写验证关键字!");
    form.pcardnumCheck.focus();
    return false;
  }
  else 
  {
  	if (prId == 0) { 
	    usercheck.location.href='checkUser.jsp?pcardnum='+document.all.pcardnumCheck.value;
	  }
	  else {
	  	usercheck.location.href='checkUser.jsp?ename='+document.all.pcardnumCheck.value;
	  }
	}
}

function allowPnt(obj) {
  if(obj.selectedIndex == 0) { document.formData.ispnt.style.display=""; }
  else {document.formData.ispnt.style.display="none"; }
  return true;
  }
  function checkLength(obj)
  {
		if(obj.value.length>10)
		{
			obj.value = "";
			obj.focus();
		}
  }
</script>
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
                                     
