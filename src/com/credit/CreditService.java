package com.credit;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;

/**
 * 浦东诚信网站企业信息查询数据接口
 * @author Administrator
 * 2009-11-25
 * update 20100120
 */
public class CreditService {
	
	public CreditService(){}
	/**
	 * 得到诚信企业信息xmls
	 * @param creditxmls 
	 */
	public void getxmls(String creditxmls){
		Element ele = null;
		Element child = null;
		List lists = null;
		System.out.println(CDate.getNowTime()+" creditxmls = "+creditxmls);
		if(!"".equals(creditxmls)){
			if(creditxmls.indexOf("gbk")>0){
				creditxmls = creditxmls.replaceAll("gbk", "utf-8");
			}
			ele = this.initEle(creditxmls);
			if(ele!=null){
				lists = ele.getChildren();
				for(int i=0;i<lists.size();i++){
					child = (Element)lists.get(i);
					this.operateCredit(child);
				}
			}
		}
	}
	/**
	 * 选择操作的具体表
	 * @param child
	 */
	private void operateCredit(Element child){
		String tablename = "";
		String operate = "";
		String id = "";
		try{
			tablename = child.getChildTextTrim("tablename");
			operate = child.getChildTextTrim("operate");
			id = child.getChildTextTrim("id");
			System.out.println("tablename = "+tablename+" operate = "+operate +" id="+id);
			if("ba_info".equals(tablename)){
				this.operateBaInfo(operate, child);
			}else if("dc_co_type".equals(tablename)){
				this.operateCoType(operate, child);
			}else if("dc_jgtype".equals(tablename)){
				this.operateJgType(operate, child);
			}else{
				this.operateMoneyType(operate, child);
			}
		}catch(Exception ex){
			System.out.println(new Date() + "CreditService---operateCredit--"
					+ ex.getMessage());
			ex.printStackTrace();
		}
	}
	/**
	 * 操作企业信息主表 ba_info(tb_ba_info)(92098条)
	 * @param operate
	 * @param child
	 */
	private void operateBaInfo(String operate,Element child){
		String id = "";//ID
		String coname = "";//企业名称
		String reg_code = "";//工商注册号
		String reg_addr = "";//工商注册地址
		String reg_person = "";//法人代表
		String work_addr = "";//经营地址
		String work_tel = "";//经营地电话
		String work_post = "";//经营地邮编
		String capital = "";//注册资金</capital>
		String money_type = "";//注册资金货币类型
		String range = "";//经营范围
		String reg_date = "";//注册日期
		String vali_date = "";//经营期限
		String co_type = "";//企业类型
		String co_statues = "";//企业状态
		String tax_code = "";//纳税人识别号
		String tax_name = "";//纳税人姓名
		String tax_statues = "";//纳税人状态
		String jgcode = "";//组织机构代码
		String jg_type = "";//机构注册类型
		String jg_date = "";//颁证日期
		String updatetime = "";//最后更新日期
		String updater = "";//最后更新人
		String xl = "";//行业分类
		String sbtime = "";//上报时间
		
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable contentadd = null;
		Hashtable contentupd = null;
		Hashtable contentdel = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			id = child.getChildTextTrim("id");
			coname = child.getChildTextTrim("coname");
			reg_code = child.getChildTextTrim("reg_code");
			reg_addr = child.getChildTextTrim("reg_addr");
			reg_person = child.getChildTextTrim("reg_person");
			work_addr = child.getChildTextTrim("work_addr");
			work_tel = child.getChildTextTrim("work_tel");
			work_post = child.getChildTextTrim("work_post");
			capital = child.getChildTextTrim("capital");
			money_type = child.getChildTextTrim("money_type");
			range = child.getChildTextTrim("range");
			reg_date = child.getChildTextTrim("reg_date");
			vali_date = child.getChildTextTrim("vali_date");
			co_type = child.getChildTextTrim("co_type");
			co_statues = child.getChildTextTrim("co_statues");
			tax_code = child.getChildTextTrim("tax_code");
			tax_name = child.getChildTextTrim("tax_name");
			tax_statues = child.getChildTextTrim("tax_statues");
			jgcode = child.getChildTextTrim("jgcode");
			jg_type = child.getChildTextTrim("jg_type");
			jg_date = child.getChildTextTrim("jg_date");
			updatetime = child.getChildTextTrim("updatetime");
			updater = child.getChildTextTrim("updater");
			xl = child.getChildTextTrim("xl");
			sbtime = child.getChildTextTrim("sbtime");
			
			if("add".equals(operate)){
				//查看是否存在
				String isSql = "select id from tb_ba_info where id = "+id+"";
				contentadd = (Hashtable)dImpl.getDataInfo(isSql);
				if(contentadd!=null){
					System.out.println("您新增的企业信息已经存在");
				}else{				
					dImpl.addNewValue("tb_ba_info", "id", Integer.parseInt(id));
					dImpl.setValue("coname",coname,CDataImpl.STRING);
					dImpl.setValue("reg_code",reg_code,CDataImpl.STRING);
					dImpl.setValue("reg_addr",reg_addr,CDataImpl.STRING);
					dImpl.setValue("reg_person",reg_person,CDataImpl.STRING);
					dImpl.setValue("work_addr",work_addr,CDataImpl.STRING);
					dImpl.setValue("work_tel",work_tel,CDataImpl.STRING);
					dImpl.setValue("work_post",work_post,CDataImpl.STRING);
					dImpl.setValue("capital",capital,CDataImpl.STRING);
					dImpl.setValue("money_type",money_type,CDataImpl.STRING);
					dImpl.setValue("range",range,CDataImpl.STRING);
					dImpl.setValue("reg_date",reg_date,CDataImpl.DATE);
					dImpl.setValue("vali_date",vali_date,CDataImpl.DATE);
					dImpl.setValue("co_type",co_type,CDataImpl.STRING);
					dImpl.setValue("co_statues",co_statues,CDataImpl.STRING);
					dImpl.setValue("tax_code",tax_code,CDataImpl.STRING);
					dImpl.setValue("tax_name",tax_name,CDataImpl.STRING);
					dImpl.setValue("tax_statues",tax_statues,CDataImpl.STRING);
					dImpl.setValue("jgcode",jgcode,CDataImpl.STRING);
					dImpl.setValue("jg_type",jg_type,CDataImpl.STRING);
					dImpl.setValue("jg_date",jg_date,CDataImpl.DATE);
					dImpl.setValue("updatetime",updatetime,CDataImpl.DATE);
					dImpl.setValue("updater",updater,CDataImpl.STRING);
					dImpl.setValue("xl",xl,CDataImpl.STRING);
					dImpl.setValue("sbtime",sbtime,CDataImpl.DATE);
					dImpl.update();
				}
			}else if("update".equals(operate)){
				String isSql = "select id from tb_ba_info where id = "+id+"";
				contentupd = (Hashtable)dImpl.getDataInfo(isSql);
				if(contentupd==null){
					System.out.println("您需要删除的企业信息不存在!");
				}else{
					dImpl.edit("tb_ba_info", "id", Integer.parseInt(id));
					dImpl.setValue("coname",coname,CDataImpl.STRING);
					dImpl.setValue("reg_code",reg_code,CDataImpl.STRING);
					dImpl.setValue("reg_addr",reg_addr,CDataImpl.STRING);
					dImpl.setValue("reg_person",reg_person,CDataImpl.STRING);
					dImpl.setValue("work_addr",work_addr,CDataImpl.STRING);
					dImpl.setValue("work_tel",work_tel,CDataImpl.STRING);
					dImpl.setValue("work_post",work_post,CDataImpl.STRING);
					dImpl.setValue("capital",capital,CDataImpl.STRING);
					dImpl.setValue("money_type",money_type,CDataImpl.STRING);
					dImpl.setValue("range",range,CDataImpl.STRING);
					dImpl.setValue("reg_date",reg_date,CDataImpl.DATE);
					dImpl.setValue("vali_date",vali_date,CDataImpl.DATE);
					dImpl.setValue("co_type",co_type,CDataImpl.STRING);
					dImpl.setValue("co_statues",co_statues,CDataImpl.STRING);
					dImpl.setValue("tax_code",tax_code,CDataImpl.STRING);
					dImpl.setValue("tax_name",tax_name,CDataImpl.STRING);
					dImpl.setValue("tax_statues",tax_statues,CDataImpl.STRING);
					dImpl.setValue("jgcode",jgcode,CDataImpl.STRING);
					dImpl.setValue("jg_type",jg_type,CDataImpl.STRING);
					dImpl.setValue("jg_date",jg_date,CDataImpl.DATE);
					dImpl.setValue("updatetime",updatetime,CDataImpl.DATE);
					dImpl.setValue("updater",updater,CDataImpl.STRING);
					dImpl.setValue("xl",xl,CDataImpl.STRING);
					dImpl.setValue("sbtime",sbtime,CDataImpl.DATE);
					dImpl.update();
				}
			}else if("delete".equals(operate)){
				String isSql = "select id from tb_ba_info where id = "+id+"";
				contentdel = (Hashtable)dImpl.getDataInfo(isSql);
				if(contentdel!=null){
					dImpl.delete("tb_ba_info", "id", Integer.parseInt(id));
					dImpl.update();
				}else{
					System.out.println("您需要删除的企业信息不存在!");
				}
			}	
			
		}catch (Exception ex) {
			System.out.println(new Date() + "CreditService---operateBaInfo--"
					+ ex.getMessage());
			ex.printStackTrace();
		} finally {
			if (dImpl != null) {
				dImpl.closeStmt();
			}
			if (dCn != null) {
				dCn.closeCn();
			}
		}
	}
	/**
	 * 操作企业经济性质表dc_co_type(tb_dc_co_type)
	 * @param operate
	 * @param child
	 */
	private void operateCoType(String operate,Element child){
		String innerid = "";
		String name = "";
		String orgid = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			innerid = child.getChildTextTrim("innerid");
			name = child.getChildTextTrim("name");
			orgid = child.getChildTextTrim("orgid");
			
			if("add".equals(operate)){
				//查看是否存在
				String isSql = "select innerid from tb_dc_co_type where innerid = "+innerid+"";
				content = (Hashtable)dImpl.getDataInfo(isSql);
				if(content!=null){
					System.out.println("您新增的企业经济性质已经存在");
				}else{	
					dImpl.addNewValue("tb_dc_co_type", "innerid", Integer.parseInt(innerid));
					dImpl.setValue("name",name,CDataImpl.STRING);
					dImpl.setValue("orgid",orgid,CDataImpl.INT);
					dImpl.update();
				}
			}else if("update".equals(operate)){
				dImpl.edit("tb_dc_co_type", "innerid", innerid);
				dImpl.setValue("name",name,CDataImpl.STRING);
				dImpl.setValue("orgid",orgid,CDataImpl.INT);
				dImpl.update();
			}else if("delete".equals(operate)){
				dImpl.delete("tb_dc_co_type", "innerid", innerid);
				dImpl.update();
			}			
			
		}catch (Exception ex) {
			System.out.println(new Date() + "CreditService---operateCoType--"
					+ ex.getMessage());
			ex.printStackTrace();
		} finally {
			if (dImpl != null) {
				dImpl.closeStmt();
			}
			if (dCn != null) {
				dCn.closeCn();
			}
		}
	}
	/**
	 * 操作企业机构类型表dc_jgtype(tb_dc_jg_type)
	 * @param operate
	 * @param child
	 */
	private void operateJgType(String operate,Element child){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		String innerid = "";
		String name = "";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			innerid = child.getChildTextTrim("innerid");
			name = child.getChildTextTrim("name");
			
			if("add".equals(operate)){
				//查看是否存在
				String isSql = "select innerid from tb_dc_jg_type where innerid = '"+innerid+"'";
				content = (Hashtable)dImpl.getDataInfo(isSql);
				if(content!=null){
					System.out.println("您新增的企业机构类型已经存在");
				}else{	
					dImpl.addNew("tb_dc_jg_type", "innerid");
					dImpl.setValue("innerid", innerid, CDataImpl.STRING);
					dImpl.setValue("name",name,CDataImpl.STRING);
					dImpl.update();
				}
			}else if("update".equals(operate)){
				dImpl.edit("tb_dc_jg_type", "innerid", innerid);
				dImpl.setValue("name",name,CDataImpl.STRING);
				dImpl.update();
			}else if("delete".equals(operate)){
				dImpl.delete("tb_dc_jg_type", "innerid", innerid);
				dImpl.update();
			}	
			
		}catch (Exception ex) {
			System.out.println(new Date() + "CreditService---operateJgType--"
					+ ex.getMessage());
			ex.printStackTrace();
		} finally {
			if (dImpl != null) {
				dImpl.closeStmt();
			}
			if (dCn != null) {
				dCn.closeCn();
			}
		}
	}
	/**
	 * 操作企业货币类型表money_type(tb_money_type)
	 * @param operate
	 * @param child
	 */
	private void operateMoneyType(String operate,Element child){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String innerid = "";
		String name = "";
		String xl = "";
		Hashtable content = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			innerid = child.getChildTextTrim("innerid");
			name = child.getChildTextTrim("name");
			xl = child.getChildTextTrim("xl");
			
			if("add".equals(operate)){
				//查看是否存在
				String isSql = "select innerid from tb_money_type where innerid = '"+innerid+"'";
				content = (Hashtable)dImpl.getDataInfo(isSql);
				if(content!=null){
					System.out.println("您新增的企业货币类型已经存在");
				}else{	
					dImpl.addNewValue("tb_money_type", "innerid", Integer.parseInt(innerid));//
					dImpl.setValue("name",name,CDataImpl.STRING);
					dImpl.setValue("xl",xl,CDataImpl.STRING);
					dImpl.update();
				}
			}else if("update".equals(operate)){
				dImpl.edit("tb_money_type", "innerid", innerid);
				dImpl.setValue("name",name,CDataImpl.STRING);
				dImpl.setValue("xl",xl,CDataImpl.STRING);
				dImpl.update();
			}else if("delete".equals(operate)){
				dImpl.delete("tb_money_type", "innerid", innerid);
				dImpl.update();
			}
			
		}catch (Exception ex) {
			System.out.println(new Date() + "CreditService---operateMoneyType--"
					+ ex.getMessage());
			ex.printStackTrace();
		} finally {
			if (dImpl != null) {
				dImpl.closeStmt();
			}
			if (dCn != null) {
				dCn.closeCn();
			}
		}
	}
	
	/**
	 * Description：初始化变量
	 * 
	 * @param fileStr
	 *            一段xml的字符串
	 */
	private Element initEle(String fileStr) {
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try {
			sb = new SAXBuilder();
			InputStream inputStream = new ByteArrayInputStream(fileStr
					.getBytes("utf-8"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		} catch (Exception ex) {
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}
	
	/**
	 * main
	 */
	public static void main(String args[]){
		CreditService cred = new CreditService();
		//String credxmls = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Root><bainfo><tablename>ba_info</tablename><operate>add</operate><id>123456123</id><coname>上海同盛银行总行</coname><reg_code>A-123456789-B</reg_code><reg_addr>上海金勇</reg_addr><reg_person>法人代表</reg_person><work_addr>经营地址</work_addr><work_tel>123456</work_tel><work_post>520123</work_post><capital>900</capital><money_type>840</money_type><range>经营范围</range><reg_date>2009-11-26</reg_date><vali_date>209-12-22</vali_date><co_type>520</co_type><co_statues>1</co_statues><tax_code>ABC</tax_code><tax_name>纳税人姓名</tax_name><tax_statues>1</tax_statues><jgcode>zuzhiCODE</jgcode><jg_type>1</jg_type><jg_date>2009-11-25</jg_date><updatetime>2009-11-27</updatetime><updater>最后更新人</updater><xl>12</xl><sbtime>2009-12-12</sbtime></bainfo><bainfo><tablename>dc_jgtype</tablename><operate>update</operate><innerid>DJ</innerid><name>金勇</name></bainfo></Root>";
		String credxmls = "<?xml version=\"1.0\" standalone=\"yes\"?><NewDataSet><ba_info><tablename>ba_info</tablename><operate>add</operate><id>358975</id><coname>上海雷允上博山药店</coname><reg_code>310115001073914</reg_code><reg_addr>上海市浦东新区博山东路４８０号</reg_addr><reg_person>顾汇丽</reg_person><work_addr>上海市博山东路４８０号</work_addr><work_tel>50341848</work_tel><work_post>200136</work_post><capital>0</capital><money_type>156</money_type><range>中成药、化学药制剂、抗生素、生化药品、生物制品（至２０１３年５月２７日）、日用百货、化妆品、一类医疗器械的零售（涉及许可经营的凭许可证经营）。</range><reg_date>2010-1-21 13:52:35</reg_date><vali_date>2010-1-21 13:52:35</vali_date>    <co_type>171</co_type><jgcode>676247791</jgcode><jg_type>G</jg_type><sbtime>2010-1-21 13:52:35</sbtime></ba_info><ba_info><tablename>ba_info</tablename><operate>add</operate><id>358976</id><coname>辽源市人民政府驻上海联络处</coname><reg_code>002352157</reg_code><reg_addr>上海市浦东新区丁香路９９９弄２号７０２室</reg_addr><reg_person>金成国</reg_person><work_addr>上海市杨浦区国定路３３５号１号楼５０１０室</work_addr>    <work_tel>55520261</work_tel>    <work_post>200433</work_post>    <capital>0</capital>    <money_type>156</money_type>    <range>合作交流</range>    <reg_date>2010-1-21 13:52:35</reg_date>    <vali_date>2010-1-21 13:52:35</vali_date>    <co_type>000</co_type>    <jgcode>002352157</jgcode>    <jg_type>0</jg_type>    <sbtime>2010-1-21 13:52:35</sbtime>  </ba_info>  <ba_info>    <tablename>ba_info</tablename>    <operate>add</operate>    <id>358974</id>    <coname>上海城邦房地产经纪事务所</coname>    <reg_code>310115001099125</reg_code>    <reg_addr>上海市浦东新区紫薇路１９２号底楼</reg_addr>    <reg_person>候福林</reg_person>    <work_addr>上海市浦东新区紫薇路１９２号底楼</work_addr>    <work_tel>58956208</work_tel>    <work_post>201210</work_post>    <capital>0</capital>    <money_type>156</money_type>    <range>房地产经纪。【企业经营涉及行政许可的，凭许可证件经营】</range>    <reg_date>2010-1-21 13:52:35</reg_date>    <vali_date>2010-1-21 13:52:35</vali_date>    <co_type>171</co_type>    <jgcode>682232318</jgcode>    <jg_type>G</jg_type>    <sbtime>2010-1-21 13:52:35</sbtime>  </ba_info></NewDataSet>";
		//String credxmls = "<?xml version=\"1.0\" encoding=\"gbk\"?><Root><bainfo><tablename>dc_jgtype</tablename><operate>update</operate><innerid>DJ</innerid><name>懒人</name></bainfo></Root>";
		//String credxmls = "<?xml version=\"1.0\" encoding=\"gbk\"?><Root><bainfo><tablename>dc_co_type</tablename><operate>update</operate><innerid>456</innerid><name>公私+分明</name><orgid>0</orgid></bainfo><bainfo><tablename>money_type</tablename><operate>add</operate><innerid>960</innerid><name>新加坡坡元</name><xl>1</xl></bainfo></Root>";
		cred.getxmls(credxmls);
		System.out.println("----over----!");
	}
}
