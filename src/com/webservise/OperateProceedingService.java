package com.webservise;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import sun.misc.BASE64Decoder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.service.log.LogservicePd;
import com.util.CDate;
import com.util.CTools;
import com.util.ReadProperty;

/**
 * 提供对外的网上办事，办事事项接口（接收办事事项）
 * @author Administrator
 *
 */
public class OperateProceedingService {
	ReadProperty rp = new ReadProperty();
	SimpleDateFormat logdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * 操作办事事项
	 * @param xmls
	 * @return 1 success 0 failed
	 */
	public String OperateManager(String proxmls){
		Element element = null;
		try {
			//proxmls = this.getFromBASE64(proxmls);
			System.out.println("proxmls===="+proxmls);
			proxmls = this.getproceedingxmls(proxmls);
			
			if (!"".equals(proxmls)) {
				element = this.initEle(proxmls);
				if (element != null) {
					return this.dealElement(element);
				}
			}
		} catch (Exception ex) {
			System.out.println(new Date() + "ProceedingService---getProceedingModels--"
					+ ex.getMessage());
			ex.printStackTrace();
			return "<xml><result>0</result></xml>";
		}
		return "<xml><result>1</result></xml>";
	}
	
	/**
	 * 操作数据库
	 * @param ele XML元素值
	 */
	private String dealElement(Element ele) {
		String operater = "";
		String pr_id_old = "";
		String cw_id = "";
		String cw_ids [] = null;
		String sw_id = "";
		String pr_id = "";
		String pr_name = "";
		String uk_id = "";
		String pr_sxtype = "";
		String pr_prtype = "";
		String pr_type = "";//xzsp、pudong、pudongold
		String pr_url = "";
		String dt_code = "";
		String dt_name = "";
		String dt_id = "";
		String sqlStr = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable contentPr = null;
		Hashtable contentDept = null;
		Hashtable deptPr = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			operater = ele.getChildTextTrim("operater");
			pr_id_old = ele.getChildTextTrim("PR_ID");
			cw_id = ele.getChildTextTrim("CW_ID");//关联主题
			//事项主题 个人办事、企业办事、特别关爱
//			个人办事	
//			生育收养 户籍身份 婚姻家庭 教育培训 文化娱乐   医疗卫生 租房住房 劳动就业 社会保障 
//			纳税服务   兵役服务 消费维权 职业资格 证件办理 交通旅游   出境入境 司法公证 产权专利 
//			民族宗教 公用事业   离休退休 殡葬服务 会计服务 其他
//
//			企业办事	
//			设立变更 行业准入 质量监督 纳税缴费 教育卫生 交通运输 规划地名 劳动保障 土地房产 
//			公共安全 食品药品 城市建设 环保绿化 资质认证 人才资源 司法公证 文物保护 水利水务 
//			对外交流 新闻广电 农林牧渔 立项申报 年审年检 破产注销 知识产权 档案气象 科学技术 
//			宗教侨务 其他 
//
//			特别关爱
//			妇女  儿童  老人  残疾人  特困人员  优抚对象 流动人口  港澳台同胞  海外侨胞  
//			留学归国  外国人
			
			//个人办事
			if(cw_id.indexOf("生育收养")>=0){
				cw_id = cw_id.replaceAll("生育收养", "o11840");
			}
			if(cw_id.indexOf("户籍身份")>=0){
				cw_id = cw_id.replaceAll("户籍身份", "o11841");
			}
			if(cw_id.indexOf("婚姻家庭")>=0){
				cw_id = cw_id.replaceAll("婚姻家庭", "o11842");
			}
			if(cw_id.indexOf("教育培训")>=0){
				cw_id = cw_id.replaceAll("教育培训", "o11843");
			}
			if(cw_id.indexOf("文化娱乐")>=0){
				cw_id = cw_id.replaceAll("文化娱乐", "o11844");
			}
			if(cw_id.indexOf("医疗卫生")>=0){
				cw_id = cw_id.replaceAll("医疗卫生", "o11845");
			}
			if(cw_id.indexOf("租房住房")>=0){
				cw_id = cw_id.replaceAll("租房住房", "o11846");
			}
			if(cw_id.indexOf("劳动就业")>=0){
				cw_id = cw_id.replaceAll("劳动就业", "o11847");
			}
			if(cw_id.indexOf("社会保障")>=0){
				cw_id = cw_id.replaceAll("社会保障", "o11848");
			}
			if(cw_id.indexOf("纳税服务")>=0){
				cw_id = cw_id.replaceAll("纳税服务", "o11849");
			}
			if(cw_id.indexOf("兵役服务")>=0){
				cw_id = cw_id.replaceAll("兵役服务", "o11850");
			}
			if(cw_id.indexOf("消费维权")>=0){
				cw_id = cw_id.replaceAll("消费维权", "o11851");
			}
			if(cw_id.indexOf("职业资格")>=0){
				cw_id = cw_id.replaceAll("职业资格", "o11852");
			}
			if(cw_id.indexOf("证件办理")>=0){
				cw_id = cw_id.replaceAll("证件办理", "o11853");
			}
			if(cw_id.indexOf("交通旅游")>=0){
				cw_id = cw_id.replaceAll("交通旅游", "o11854");
			}
			if(cw_id.indexOf("出境入境")>=0){
				cw_id = cw_id.replaceAll("出境入境", "o11855");
			}
			if(cw_id.indexOf("司法公证")>=0){
				cw_id = cw_id.replaceAll("司法公证", "o11856");
			}
			if(cw_id.indexOf("产权专利")>=0){
				cw_id = cw_id.replaceAll("产权专利", "o11857");
			}
			if(cw_id.indexOf("民族宗教")>=0){
				cw_id = cw_id.replaceAll("民族宗教", "o11858");
			}
			if(cw_id.indexOf("公用事业")>=0){
				cw_id = cw_id.replaceAll("公用事业", "o11859");
			}
			if(cw_id.indexOf("离休退休")>=0){
				cw_id = cw_id.replaceAll("离休退休", "o11860");
			}
			if(cw_id.indexOf("殡葬服务")>=0){
				cw_id = cw_id.replaceAll("殡葬服务", "o11861");
			}
			if(cw_id.indexOf("会计服务")>=0){
				cw_id = cw_id.replaceAll("会计服务", "o11862");
			}
			if(cw_id.indexOf("其它（个人）")>=0){
				cw_id = cw_id.replaceAll("其它（个人）", "o11863");
			}
			//企业办事
			if(cw_id.indexOf("设立变更")>=0){
				cw_id = cw_id.replaceAll("设立变更", "o11864");
			}
			if(cw_id.indexOf("行业准入")>=0){
				cw_id = cw_id.replaceAll("行业准入", "o11865");
			}
			if(cw_id.indexOf("质量监督")>=0){
				cw_id = cw_id.replaceAll("质量监督", "o11866");
			}
			if(cw_id.indexOf("纳税缴费")>=0){
				cw_id = cw_id.replaceAll("纳税缴费", "o11867");
			}
			if(cw_id.indexOf("教育卫生")>=0){
				cw_id = cw_id.replaceAll("教育卫生", "o11868");
			}
			if(cw_id.indexOf("交通运输")>=0){
				cw_id = cw_id.replaceAll("交通运输", "o11869");
			}
			if(cw_id.indexOf("规划地名")>=0){
				cw_id = cw_id.replaceAll("规划地名", "o11870");
			}
			if(cw_id.indexOf("劳动保障")>=0){
				cw_id = cw_id.replaceAll("劳动保障", "o11871");
			}
			if(cw_id.indexOf("土地房产")>=0){
				cw_id = cw_id.replaceAll("土地房产", "o11872");
			}
			if(cw_id.indexOf("公共安全")>=0){
				cw_id = cw_id.replaceAll("公共安全", "o11873");
			}
			if(cw_id.indexOf("食品药品")>=0){
				cw_id = cw_id.replaceAll("食品药品", "o11874");
			}
			if(cw_id.indexOf("城市建设")>=0){
				cw_id = cw_id.replaceAll("城市建设", "o11875");
			}
			if(cw_id.indexOf("环保绿化")>=0){
				cw_id = cw_id.replaceAll("环保绿化", "o11876");
			}
			if(cw_id.indexOf("资质认证")>=0){
				cw_id = cw_id.replaceAll("资质认证", "o11877");
			}
			if(cw_id.indexOf("人才资源")>=0){
				cw_id = cw_id.replaceAll("人才资源", "o11878");
			}
			if(cw_id.indexOf("司法公证")>=0){
				cw_id = cw_id.replaceAll("司法公证", "o11879");
			}
			if(cw_id.indexOf("文物保护")>=0){
				cw_id = cw_id.replaceAll("文物保护", "o11880");
			}
			if(cw_id.indexOf("水利水务")>=0){
				cw_id = cw_id.replaceAll("水利水务", "o11881");
			}
			if(cw_id.indexOf("对外交流")>=0){
				cw_id = cw_id.replaceAll("对外交流", "o11882");
			}
			if(cw_id.indexOf("新闻广电")>=0){
				cw_id = cw_id.replaceAll("新闻广电", "o11883");
			}
			if(cw_id.indexOf("农林牧渔")>=0){
				cw_id = cw_id.replaceAll("农林牧渔", "o11884");
			}
			if(cw_id.indexOf("立项申报")>=0){
				cw_id = cw_id.replaceAll("立项申报", "o11885");
			}
			if(cw_id.indexOf("年审年检")>=0){
				cw_id = cw_id.replaceAll("年审年检", "o11886");
			}
			if(cw_id.indexOf("破产注销")>=0){
				cw_id = cw_id.replaceAll("破产注销", "o11887");
			}
			if(cw_id.indexOf("知识产权")>=0){
				cw_id = cw_id.replaceAll("知识产权", "o11888");
			}
			if(cw_id.indexOf("档案气象")>=0){
				cw_id = cw_id.replaceAll("档案气象", "o11889");
			}
			if(cw_id.indexOf("科学技术")>=0){
				cw_id = cw_id.replaceAll("科学技术", "o11890");
			}
			if(cw_id.indexOf("宗教侨务")>=0){
				cw_id = cw_id.replaceAll("宗教侨务", "o11891");
			}
			if(cw_id.indexOf("其它（企业）")>=0){			//
				cw_id = cw_id.replaceAll("其它（企业）", "o11892");
			}
			//特别关爱
			if(cw_id.indexOf("妇女")>=0){
				cw_id = cw_id.replaceAll("妇女", "o11893");
			}
			if(cw_id.indexOf("儿童")>=0){
				cw_id = cw_id.replaceAll("儿童", "o11894");
			}
			if(cw_id.indexOf("老人")>=0){
				cw_id = cw_id.replaceAll("老人", "o11895");
			}
			if(cw_id.indexOf("残疾人")>=0){
				cw_id = cw_id.replaceAll("残疾人", "o11896");
			}
			if(cw_id.indexOf("特困人员")>=0){
				cw_id = cw_id.replaceAll("特困人员", "o11897");
			}
			if(cw_id.indexOf("优抚对象")>=0){
				cw_id = cw_id.replaceAll("优抚对象", "o11898");
			}
			if(cw_id.indexOf("流动人口")>=0){
				cw_id = cw_id.replaceAll("流动人口", "o11899");
			}
			if(cw_id.indexOf("港澳台同胞")>=0){
				cw_id = cw_id.replaceAll("港澳台同胞", "o11900");
			}
			if(cw_id.indexOf("海外侨胞")>=0){
				cw_id = cw_id.replaceAll("海外侨胞", "o11901");
			}
			if(cw_id.indexOf("留学归国")>=0){
				cw_id = cw_id.replaceAll("留学归国", "o11902");
			}
			if(cw_id.indexOf("外国人")>=0){
				cw_id = cw_id.replaceAll("外国人", "o11903");
			}
			
			
			cw_ids = cw_id.split(",");
			
			
			sw_id = ele.getChildTextTrim("SW_ID");//分类事项类别
			pr_name = ele.getChildTextTrim("PR_NAME");//事项名称
			dt_code = ele.getChildTextTrim("DT_CODE");//部门code
			pr_sxtype = ele.getChildTextTrim("PR_SXTYPE");//
			pr_prtype = ele.getChildTextTrim("PR_PRTYPE");//事项分类
			pr_url = ele.getChildTextTrim("PR_URL");//在线办理链接
			
			//事项类型代码		
			if("SP".equals(pr_prtype)){
				pr_prtype = "行政审批事项";
			}else if("ZS".equals(pr_prtype)){
				pr_prtype = "行政征收事项";
			}else if("QR".equals(pr_prtype)){
				pr_prtype = "行政确认事项";
			}else if("FW".equals(pr_prtype)){
				pr_prtype = "便民服务事项";
			}else if("DL".equals(pr_prtype)){
				pr_prtype = "代理类事项";
			}else if("QT".equals(pr_prtype)){
				pr_prtype = "其他";
			}else{
				pr_prtype = "其他";
			}
			
			//获取部门名称和ID
			sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_deskoperid = '"+dt_code+"' ";
			deptPr = (Hashtable)dImpl.getDataInfo(sqlStr);
			if(deptPr!=null){
				dt_id = CTools.dealNull(deptPr.get("dt_id"));
				dt_name = CTools.dealNull(deptPr.get("dt_name"));
			}

			//查找已经录过的数据ID
			uk_id = ele.getChildTextTrim("UK_ID");
			sqlStr = "select p.pr_id,p.pr_type from tb_proceeding_new p,tb_deptinfo d where (p.pr_id_old='"+pr_id_old+"' and p.pr_name like '%"+pr_name+"%') and p.pr_id_old is not null and p.pr_type in('xzsp','pudong')  and p.dt_id = d.dt_id and d.dt_deskoperid = '"+dt_code+"'";
			System.out.println("sqlStr=================="+sqlStr);
			contentPr = (Hashtable)dImpl.getDataInfo(sqlStr);
			if(contentPr!=null){
				pr_id = CTools.dealNull(contentPr.get("pr_id"));
				pr_type = CTools.dealNull(contentPr.get("pr_type"));
			}else{
				if(!"delete".equals(operater)){
					operater = "add";
				}
			}

			dCn.beginTrans();
			String projectid = "";
			String pr_content = "";
			if("add".equals(operater)){
				projectid = dImpl.addNew("tb_proceeding_new","pr_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
				dImpl.setValue("pr_name",pr_name,CDataImpl.STRING);
				dImpl.setValue("sw_id",sw_id,CDataImpl.STRING);
				dImpl.setValue("dt_name",dt_name,CDataImpl.STRING);
				dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
				dImpl.setValue("pr_id_old",pr_id_old,CDataImpl.STRING);
				dImpl.setValue("uk_id",uk_id,CDataImpl.STRING);
				dImpl.setValue("pr_url",pr_url,CDataImpl.STRING);
				dImpl.setValue("pr_sxtype",pr_prtype,CDataImpl.STRING);
				dImpl.setValue("pr_type","xzsp",CDataImpl.STRING);
				dImpl.setValue("pr_edittime",CDate.getThisday(),CDataImpl.DATE);
				dImpl.update();
				
				for(int i=0;i<cw_ids.length;i++){
					dImpl.addNew("tb_commonproceed_new","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
					dImpl.setValue("pr_id",projectid,CDataImpl.STRING);
					dImpl.setValue("cw_id",cw_ids[i],CDataImpl.STRING);
					dImpl.update();
				}
				pr_id = projectid;
				pr_content = "“"+pr_name+"”　新增成功";
				
			}else if("update".equals(operater)){
				dImpl.edit("tb_proceeding_new", "pr_id", pr_id); 
				dImpl.setValue("sw_id",sw_id,CDataImpl.STRING);
				dImpl.setValue("pr_name",pr_name,CDataImpl.STRING);
				dImpl.setValue("dt_name",dt_name,CDataImpl.STRING);
				dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
				dImpl.setValue("uk_id",uk_id,CDataImpl.STRING);
				dImpl.setValue("pr_url",pr_url,CDataImpl.STRING);
				dImpl.setValue("pr_sxtype",pr_prtype,CDataImpl.STRING);
				//dImpl.setValue("pr_type","".equals(pr_type)?"xzsp":pr_type,CDataImpl.STRING);
				dImpl.setValue("pr_edittime",CDate.getThisday(),CDataImpl.DATE);
				dImpl.update();
				
				dImpl.delete("tb_commonproceed_new", "pr_id", pr_id);
				
				for(int i=0;i<cw_ids.length;i++){
					dImpl.addNew("tb_commonproceed_new","cp_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
					dImpl.setValue("pr_id",pr_id,CDataImpl.STRING);
					dImpl.setValue("cw_id",cw_ids[i],CDataImpl.STRING);
					dImpl.update();
				}
				
				pr_content = "“"+pr_name+"”　修改成功";
				
			}else if("delete".equals(operater)){
				dImpl.delete("tb_proceeding_new", "pr_id", pr_id);
				dImpl.delete("tb_commonproceed_new", "pr_id", pr_id);
				
				pr_content = "“"+pr_name+"”　删除成功";
			}
			/**
			 * 日志记录
			 */
			writeLog(pr_id,"行政审批",pr_content,"成功");
			
			
			
			dCn.commitTrans();
			

		} catch (Exception ex) {
			System.out.println(new Date() + "ProceedingService---dealElement--"
					+ ex.getMessage());
			ex.printStackTrace();
			return "<xml><result>0</result></xml>";//接口调用失败返回0
		} finally {
			if (dImpl != null) {
				dImpl.closeStmt();
			}
			if (dCn != null) {
				dCn.closeCn();
			}
		}
		return "<xml><result>1</result></xml>";//接口调用成功返回1
	}
	
	/**
	 * 记录日志
	 * @param cw_id 信件ID
	 * @param cw_content 信件内容
	 * @param log_levn 信访反馈
	 * @param log_success 信件日志成功与否的动作说明
	 */
	public void writeLog(String pr_id,String log_levn,String pr_content,String log_success){
		String log_descript = "";
		LogservicePd logservicepd = new LogservicePd();
		log_descript = "行政审批事项库在"+logdf.format(new java.util.Date())+" "+pr_id+"-"+pr_content;
		logservicepd.writeLog(log_levn,log_descript,log_success,"pdxzsp");
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
	 * 调用机器人办事事项接口，推送办事事项信息
	 * @param OType 操作方式
	 * @param projectId 事项ID
	 */
	public void RobotProceeding(String OType,String projectId){
		
		NewProceedingService nps = new NewProceedingService();
		nps.proceeding(OType,projectId);
		//
	}
	
	/**
	 * 还原编码后的特殊字符
	 * @param xmls
	 * @return
	 */
	private String getproceedingxmls(String xmls){
		  xmls = xmls.replaceAll("&amp;","&");
		  xmls = xmls.replaceAll("&quot;","");
		  xmls = xmls.replaceAll("&lt;","<");
		  xmls = xmls.replaceAll("&gt;",">");
		  xmls = xmls.replaceAll("&nbsp;"," ");
		  return xmls;
	}
	/**
	 * 将 String 进行 BASE64 编码 
	 * @param s 被传入的进行编码的字符串
	 * @return 返回编码后的字符串
	 */
	private static String getBASE64(String s) { 
		if (s == null) return null; 
		return (new sun.misc.BASE64Encoder()).encode( s.getBytes() ); 
	}
	/**
	 * 将 BASE64 编码的字符串 s 进行解码 
	 * @param s 需要解码的字符串
	 * @return 返回解码后的字符串
	 */
	private static String getFromBASE64(String s) { 
		if (s == null) return null; 
		BASE64Decoder decoder = new BASE64Decoder(); 
		try { 
			byte[] b = decoder.decodeBuffer(s); 
			return new String(b); 
		} catch (Exception e) { 
			return null; 
		} 
	}
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String args[]){
		String proxmls = "<?xml version='1.0' encoding='utf-8'?> <root> <operater>update</operater> <PR_ID>4580</PR_ID> <CW_ID>证件办理</CW_ID> <SW_ID>o28</SW_ID> <PR_NAME>会计从业资格审批许可事项</PR_NAME> <DT_CODE>pd10030</DT_CODE> <PR_MONEY></PR_MONEY> <PR_TIMELIMIT></PR_TIMELIMIT> <PR_ISACCEPT></PR_ISACCEPT> <PR_URL><![CDATA[http://kuaiji.pudong.gov.cn ]]></PR_URL> <PR_EDITTIME></PR_EDITTIME> <UK_ID> </UK_ID> <PR_TELEPHONE></PR_TELEPHONE> <PR_TSTYPE></PR_TSTYPE> <PR_SXTYPE></PR_SXTYPE> <PR_PRTYPE>SP</PR_PRTYPE> <PR_ADDRESS></PR_ADDRESS> <PR_TSTEL></PR_TSTEL> <PR_TSEMAIL></PR_TSEMAIL> <PR_BY></PR_BY> <PR_AREA></PR_AREA> <PR_STUFF></PR_STUFF> <PR_BLCX></PR_BLCX> <PR_QT></PR_QT> <PR_BC></PR_BC><pr_type></pr_type> <attach> <title></title> <attachURL></attachURL> </attach> </root>";
		OperateProceedingService ops = new OperateProceedingService();
		System.out.println(ops.OperateManager(proxmls));
		//System.out.println(ops.OperateManager(ops.getBASE64(proxmls)));
		
	}
}
