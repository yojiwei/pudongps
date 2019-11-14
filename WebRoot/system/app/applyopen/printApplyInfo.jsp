<%@page contentType="text/html; charset=GBK"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>信息公开申请表</title>
<link href="print.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
function fmprint()
{
	prid.style.display="none";
	window.print();
	window.close();
}

var args = dialogArguments; //接收参数
function initPage()
{
	var pname1       = args["pname"];
	var punit1       = args["punit"];
	var pcard1       = args["pcard"];
	var pcardnum1    = args["pcardnum"];
	var paddress1    = args["paddress"];
	var pzipcode1    = args["pzipcode"];
	var ptele1       = args["ptele"];
	var ename1       = args["ename"];
	var ecode1       = args["ecode"];
	var ebunissinfo1 = args["ebunissinfo"];
	var edeputy1     = args["edeputy"];
	var elinkman1    = args["elinkman"];
	var etele1       = args["etele"];
	var eemail1      = args["eemail"];
	var infotitle1   = args["infotitle"];
	var commentinfo1 = args["commentinfo"];
	var indexnum1    = args["indexnum"];
	var purpose1     = args["purpose"];
	var ischarge1    = args["ischarge"];
	var offermode1   = args["offermode"];
	var gainmode1    = args["gainmode"];
	var applyflag1   = args["applyflag"];
	var did1         = args["did"];
	var len = document.all.length;
	var obj; 
	for (var i = 0;i < len;i++)
	{
		obj = document.all[i];
		if (obj.id!=""&&obj.id!="prid"&&obj.id!="pin"&&obj.id!="ein")
		{
			if (typeof(eval(obj.id+"1"))!="undefined")
			{
				if (eval(obj.id + "1") == "")
				{
					eval("obj.innerText = '　'");
				}
				else
				{
				eval("obj.innerText = " + obj.id + "1");
				}
			}
		}
	}
}

</script>

<script language="javascript" for=window event=onload>
initPage();
</script>

<body>
<table width="630" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="26" align="center" valign="top" class="f18">上海市浦东新区政府信息公开申请表</td>
  </tr>
  <tr>
    <td>
    <table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#000000">
      <tr bgcolor="#FFFFFF" id="pin">
        <td width="6%" rowspan="5" align="center" valign="middle">公民</td>
        <td width="21%" height="24" align="center" valign="middle">姓　名</td>
        <td width="17%" align="center" valign="middle" id="pname" class="f14"></td>
        <td width="17%" align="center" valign="middle">工作单位</td>
        <td colspan="2" align="center" valign="middle" id="punit" class="f14"></td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">证件名称</td>
        <td align="center" valign="middle">&nbsp;</td>
        <td align="center" valign="middle">证件号码</td>
        <td colspan="2" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">通信地址</td>
        <td colspan="2" align="center" valign="middle">&nbsp;</td>
        <td width="17%" align="center" valign="middle">邮政编码</td>
        <td width="17%" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">联系电话</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">电子邮箱</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
      </tr>
      <tr bgcolor="#FFFFFF" id="ein">
        <td rowspan="5" align="center" valign="middle">法人或其他组织</td>
        <td height="24" align="center" valign="middle">名　称</td>
        <td colspan="2" align="center" valign="middle">&nbsp;</td>
        <td align="center" valign="middle">组织机构代码</td>
        <td align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">营业执照信息</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">法人代表</td>
        <td colspan="2" align="center" valign="middle">&nbsp;</td>
        <td align="center" valign="middle">联系人姓名</td>
        <td align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">联系人电话</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" align="center" valign="middle">联系人电子邮箱</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td rowspan="6" align="center" valign="middle"><strong>所需信息情况</strong></td>
        <td height="80" align="center" valign="middle">所需信息的内容描述</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" colspan="5" align="center" valign="middle"><strong>选　填　部　分</strong></td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="30" align="center" valign="middle">所需信息的所取号</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="30" align="center" valign="middle">所需信息的用途</td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td align="left" valign="top">是否申请减免费用：<br />
          <input type="checkbox" name="checkbox" value="checkbox" />          申请。<br />
          请提供相关证明<br />
          <input type="checkbox" name="checkbox2" value="checkbox" />          不申请。</td>
        <td colspan="2" align="left" valign="top">所需信息的指定提供方式（可多选）<br />
          <input type="checkbox" name="checkbox5" value="checkbox" />
          纸面<br />
          <input type="checkbox" name="checkbox6" value="checkbox" />
          电子邮件<br />
          <input type="checkbox" name="checkbox7" value="checkbox" />
          磁盘</td>
        <td colspan="2" align="left" valign="top">获取信息的方式（可多选）<br />
          <input type="checkbox" name="checkbox8" value="checkbox" />
          自行领取/当场阅读、抄录<br />
          <input type="checkbox" name="checkbox9" value="checkbox" />
          邮寄<br />
          <input type="checkbox" name="checkbox10" value="checkbox" />
          快递<br />
          <input type="checkbox" name="checkbox11" value="checkbox" />
          电子邮件<br />
          <input type="checkbox" name="checkbox12" value="checkbox" />          传真</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" colspan="5" align="left" valign="middle">若本机关无法按照指定方式提供所需信息，将以现有的方式提供。</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td align="center" valign="middle"><strong>申请代办</strong></td>
        <td height="60" colspan="5" align="left" valign="middle">申请人可以选择委托本信息公开服务窗口代办非本单位政府信息公开申请事项，信息公开申请是否受理由该信息公开责任单位决定：<br />
          <input type="checkbox" name="checkbox3" value="checkbox" />
          委托本服务窗口代办     
          <input type="checkbox" name="checkbox4" value="checkbox" />
          由申请人直接向信息公开责任单位提出申请</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="100" align="center" valign="middle"><strong>承诺</strong></td>
        <td colspan="5" align="left" valign="middle">本人对本次政府信息公开申请作出如下承诺：<br />
          一、填报的申请材料实质内容属实；<br />
          二、不利用获取的政府信息从事违法活动；<br />
          三、对违反上述承诺的行为自愿承担相应的法律责任；<br />
          四、以上陈述是本人真实意思表示。</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="80" colspan="2" align="center" valign="middle"><strong>备注</strong></td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="80" colspan="2" align="center" valign="middle"><strong>申请人签字、盖章</strong></td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
      <tr bgcolor="#FFFFFF">
        <td height="24" colspan="2" align="center" valign="middle"><strong>申请时间</strong></td>
        <td colspan="4" align="center" valign="middle">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
  <tr id="prid" style="display:">
   <td align=center height = "30">  
      <INPUT TYPE="BUTTON" VALUE="打印" onclick="fmprint()">&nbsp;
      <INPUT TYPE="BUTTON" VALUE="关闭" onclick="window.close()">
   </td>
  </tr>
</table>
</body>