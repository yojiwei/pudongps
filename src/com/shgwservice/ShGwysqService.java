package com.shgwservice;
import javax.xml.rpc.ParameterMode;
import java.io.File;
import java.io.FileInputStream;
import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;

/**
 * 调用上海市依申请公开接口，自动推送浦东公文备案依申请公开数据
 * @author Administrator
 * 操作方法名称：importInfo
 * http://10.81.96.38:8080/services/ApplyOpenService 新地址
 * 
 */
public class ShGwysqService extends TimerTask{
	/**
	 * 执行监听的方法
	 */
	public void run(){
		toShGwysq();
	}
	/**
	 * 自动推送到上海市依申请公开
	 * @param xmls
	 * @return
	 */
	public void toShGwysq(){
		String reback = "";
		String ids = "";
		String infoids [] = null;
		try {
			 Service service = new Service();
			    Call call = ( Call ) service.createCall();

			    //设置访问点
			    call.setTargetEndpointAddress( "http://10.81.96.38:8080/services/ApplyOpenService" );

			    //设置操作名
			    call.setOperationName( "importInfo" );

			    //设置入口参数
			    call.addParameter( "infoXml", XMLType.XSD_STRING, ParameterMode.IN );
			    call.setReturnType( XMLType.XSD_STRING );
			    
			    //获取待推送列表或待推送的特定依申请公开IDS，每次自动获取100条
			    ids = getDtsYsqIds();			    
			    infoids = ids.split(",");
			    for(int i=0;i<infoids.length;i++){
				    //调用服务,开始同步
				    reback = (String)call.invoke( new Object[] {getNewYsqgkXmls(infoids[i])});
				    //根据反馈信息修改数据库字段
				    UpdateInfoOpenIsgosh(reback,infoids[i]);
			    }
			    
			    
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println("ysqgk-reback==============="+reback);
	}
	
	/**
	 * 手动推送到上海市依申请公开
	 * @param id
	 * @return
	 */
	public String sdToShGwysq(String ids){
		String reback = "";
		String infoids [] = null;
		try {
			 Service service = new Service();
			    Call call = ( Call ) service.createCall();

			    //设置访问点
			    call.setTargetEndpointAddress( "http://10.81.96.38:8080/services/ApplyOpenService" );

			    //设置操作名
			    call.setOperationName( "importInfo" );

			    //设置入口参数
			    call.addParameter( "infoXml", XMLType.XSD_STRING, ParameterMode.IN );
			    call.setReturnType( XMLType.XSD_STRING );
			    //手动获取需要推送到上海市依申请公开的申请ID    
			    infoids = ids.split(",");
			    for(int i=0;i<infoids.length;i++){
				    //调用服务,开始同步
				    reback = (String)call.invoke( new Object[] {getNewYsqgkXmls(infoids[i])});
				    //根据反馈信息修改数据库字段
				    UpdateInfoOpenIsgosh(reback,infoids[i]);
			    }
			    
		} catch (Exception e) {
			// TODO: handle exception
		}

		System.out.println("sd-reback==============="+reback);
		return reback;
	}
	
	/**
	 * 获取待推送到上海市依申请公开的所有申请
	 * 每次推送100条
	 */
	public String getDtsYsqIds(){
		String ids = "";
		String ysqgksql = "";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		//
		try { 
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			
			ysqgksql = "select i.id from infoopen i,infoopen_word d,tb_deptinfo t " +
						"where i.id = d.ip_id and i.did = t.dt_id and i.step = 5 and i.ISGOSH is null and i.applytime > to_date('2017-01-01','yyyy-MM-dd') order by i.id desc  ";
			vPage = dImpl.splitPage(ysqgksql, 100,1);//最多取100条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i); 
					ids += CTools.dealNull(table.get("id"))+",";
				}
			}
			
			
		}catch (Exception e) {
			// TODO: handle exception
						e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			cDn.closeCn();
		}
		
		return ids;
	}
	
	/**
	 * 获取待发送的浦东依申请公开XMLS
	 * 推送已完成状态的step=5
	 * @return
	 */
	public String getNewYsqgkXmls(String infoid){
		String ysqgkxmls = "";
		String ysqgksql = "";
		String purpose = "";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		String status_name = "";
		String wordcontent = "";
		String commentinfo = "";
		String flownum = "";
		String pcardnum = "";
		//
		try { 
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			//手动推送特定ID
			if(!"".equals(infoid)){
				
				
				if(isInfoword(infoid)){			
				ysqgksql = "select decode(i.proposer,0,'公民',1,'法人') as proposer,i.pname as pname,i.paddress as paddress,i.pcard as pcard,i.pcardnum as pcardnum,i.ename as ename," +
						"i.edeputy as edeputy,i.elinkman as elinkman,i.ptele as ptele,i.pzipcode as pzipcode,i.pemail as pemail,i.applytime as applytime,i.commentinfo||'　'||i.indexnum||'　'||i.memo as commentinfo," +
						"decode(i.gainmode,'0','邮寄','1','递送','2','电子邮件','3','传真','4','当面领取','5','现场查阅') as gainmode,i.purpose as purpose," +
						"decode(i.free,'1','属于城乡居民最低生活保障对象','2','确有其他经济困难的','3','属于农村五保供养对象','4','属于领取国家抚恤补助的优抚对象')as free," +
						"decode(i.signmode,0,'门户网站',1,'当面',2,'电子邮件',3,'信函',5,'传真',6,'其他') as signmode,decode(t.dt_shortname,'上海市浦东新区人民政府办公室','上海市浦东新区人民政府','征管中心','上海市浦东新区人民政府',t.dt_shortname,t.dt_shortname) as dname," +
						"decode(i.isbmtgxx,0,'N',1,'Y') as isbmtgxx,decode(i.offermode,'0','纸质文本','3','光盘','2','磁盘','1','光盘') as offermode," +
						"i.status_name as status_name,d.wordcontent as wordcontent,d.inserttime as inserttime,i.flownum as flownum from infoopen i,infoopen_word d,tb_deptinfo t " +
						"where i.id = d.ip_id and i.did = t.dt_id and i.step = 5 and d.iw_id in(select max(t.iw_id) from infoopen i,infoopen_word t  " +
						"where i.id = t.ip_id and t.ip_id in("+infoid+") group by i.infotitle ) and i.ISGOSH is null and i.id in ("+infoid+") order by i.id desc  ";
				}else{
				ysqgksql = "select decode(i.proposer,0,'公民',1,'法人') as proposer,i.pname as pname,i.paddress as paddress,i.pcard as pcard,i.pcardnum as pcardnum,i.ename as ename,i.edeputy as edeputy,i.elinkman as elinkman,i.ptele as ptele,i.pzipcode as pzipcode,i.pemail as pemail,i.applytime as applytime,i.commentinfo||'　'||i.indexnum||'　'||i.memo as commentinfo,decode(i.gainmode,'0','邮寄','1','递送','2','电子邮件','3','传真','4','当面领取','5','现场查阅') as gainmode,i.purpose as purpose,decode(i.free,'1','属于城乡居民最低生活保障对象','2','确有其他经济困难的','3','属于农村五保供养对象','4','属于领取国家抚恤补助的优抚对象')as free,decode(i.signmode,0,'门户网站',1,'当面',2,'电子邮件',3,'信函',5,'传真',6,'其他') as signmode,decode(t.dt_shortname,'上海市浦东新区人民政府办公室','上海市浦东新区人民政府','征管中心','上海市浦东新区人民政府',t.dt_shortname,t.dt_shortname) as dname,decode(i.isbmtgxx,0,'N',1,'Y') as isbmtgxx,decode(i.offermode,'0','纸质文本','3','光盘','2','磁盘','1','光盘') as offermode,i.status_name as status_name,'无内容' as wordcontent,'2018-01-01' as inserttime,i.flownum as flownum from infoopen i  join tb_deptinfo t  on i.did = t.dt_id where  i.step = 5  and i.ISGOSH is null and i.id in ("+infoid+") order by i.id desc";
				}
				
			}
			
			//System.out.println("ysqgksql=============="+ysqgksql);
			
			StringBuffer strB= new StringBuffer();
			strB.append("<?xml version=\"1.0\" encoding=\"GBK\"?>");
			strB.append("<root>");
			strB.append("<userAccount><![CDATA[pdxqzf]]></userAccount>");
			
			vPage = dImpl.splitPage(ysqgksql, 100,1);//最多取100条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i); 
			
					//处理结果名称对应上海市公文备案处理结果名称----代码段
					status_name = CTools.dealNull(table.get("status_name"));
					status_name = status_name.replaceAll("\\d+","");
					if("不符合申请要求（申请内容不明确）".equals(status_name)){
						status_name = "非申请（申请内容不明确）";
					}else if("不符合申请要求（其他）".equals(status_name)){
						status_name = "非申请（其他）";
					}else if("不符合申请要求（咨询）".equals(status_name)){
						status_name = "咨询";
					}else if("不属于本机关公开职责权限范围".equals(status_name)){
						status_name = "非本机关公开职权范围";
					}else if("非《条例》、《规定》所指政府信息".equals(status_name)){
						status_name = "非规定所指政府信息";
					}else if("内部管理信息及过程性信息".equals(status_name)){
						status_name = "内部管理、过程性信息不予公开";
					}else if("政府信息不存在".equals(status_name)){
						status_name = "信息不存在";
					}else if("商业秘密个人隐私予以公开".equals(status_name)){
						status_name = "涉及商业秘密、个人隐私公开";
					}else if("危及“三安全一稳定”".equals(status_name)){
						status_name = "三安全一稳定不予公开";
					}else if("已移交国家档案馆的信息".equals(status_name)){
						status_name = "档案";
					}else if("其他法律法规另有规定".equals(status_name)){
						status_name = "其他法律法规另有规定（其他）";
					}else if("未补充“三需要”证明材料，不予提供".equals(status_name)){
						status_name = "未补充证明三需要不予公开";
					}else if("与“三需要”无关，不予提供".equals(status_name)){
						status_name = "不足以证明三需要不予公开";
					}else if("历史信息".equals(status_name)){
						status_name = "档案";
					}else if("党政混合信息（公开）".equals(status_name)){
						status_name = "党政混合信息公开";
					}else if("党政混合信息（不予公开）".equals(status_name)){
						status_name = "党政混合信息不予公开";
					}else if("信访信息函告".equals(status_name)){
						status_name = "获取信访信息";
					}else if("行政复议信息函告".equals(status_name)){
						status_name = "获取行政复议信息";
					}else if("涉诉信息函告".equals(status_name)){
						status_name = "获取涉诉信息";
					}else if("信访活动函告".equals(status_name)){
						status_name = "进行信访、投诉举报等活动";
					}else if("查阅案卷函告".equals(status_name)){
						status_name = "查阅案卷材料";
					}else if("特定领域信息函告".equals(status_name)){
						status_name = "特定行政管理领域业务查询";
					}else if("咨询函告".equals(status_name)){
						status_name = "咨询";
					}else if("申请人放弃申请".equals(status_name)){
						status_name = "申请人主动撤销";
					}else if("多次重复申请不作处理".equals(status_name)){
						status_name = "重复申请不予答复处理";
					}else if("无效申请".equals(status_name)){
						status_name = "申请人主动撤销";
					}else if("申请人主动放弃申请".equals(status_name)){
						status_name = "申请人主动撤销";
					}
					//处理结果名称对应上海市公文备案处理结果名称----代码段
					//System.out.println("flownum-----"+flownum);
					flownum = CTools.dealNull(table.get("flownum"));
					//市里面的申请
					if(flownum.indexOf("SQ")>-1)
					{
						strB.append("<applyOpenInfo>");
						strB.append("<applyNo><![CDATA["+CTools.dealNull(table.get("flownum"))+"]]></applyNo>");//申请号，格式（共23位）：SQ + 成文单位的9位组织机构代码 + 1位来源标识（政务外网：0；涉密内网：1） + 8位受理日期 + 3位流水号；申请号如为空，则由系统自动生成
						strB.append("<dealUnitName><![CDATA["+CTools.dealNull(table.get("dname"))+"]]></dealUnitName>");//受理单位名称
						strB.append("<dealType><![CDATA["+status_name+"]]></dealType>");//受理结果类型：选项："主动公开","依申请公开","涉及商业秘密、个人隐私公开","部分公开","国家秘密不予公开","商业秘密不予公开","个人隐私不予公开","三安全一稳定不予公开","内部管理、过程性信息不予公开","不足以证明三需要不予公开","未补充证明三需要不予公开","其他不予公开","非本机关公开职权范围","信息不存在","非规定所指政府信息","信访事项","复议事项","房地产登记事项","其他法律法规另有规定（其他）","非申请（咨询）","非申请（申请内容不明确）","非申请（其他）","档案","重复申请","党政混合信息公开","党政混合信息不予公开","其他","未补正，视为自动放弃","申请人主动撤销","重复申请不予答复处理"
						wordcontent = CTools.dealNull(table.get("wordcontent"));
						if(wordcontent.length()>1200){
							wordcontent = wordcontent.substring(0,1190)+"... ...";
						}
						strB.append("<noticeContent><![CDATA["+wordcontent+"]]></noticeContent>");//告知书正文，长度不超过2000字  还是1200啊
						strB.append("<replyDate><![CDATA["+CTools.dealNull(table.get("inserttime"))+"]]></replyDate>");//答复日期，格式：YYYY-MM-DD
						strB.append("<isProvide><![CDATA["+CTools.dealNull(table.get("isbmtgxx"))+"]]></isProvide>");//是否便民提供相关信息：Y（是）或N（否）
						strB.append("<status><![CDATA[已办结]]></status>");//当前状态：选项："已办结","已合并"，必填项
						strB.append("</applyOpenInfo>");
					//区里面的申请
					}else{
					
					strB.append("<applyOpenInfo>");
					strB.append("<applyNo><![CDATA[]]></applyNo>");//申请号，格式（共23位）：SQ + 成文单位的9位组织机构代码 + 1位来源标识（政务外网：0；涉密内网：1） + 8位受理日期 + 3位流水号；申请号如为空，则由系统自动生成
					strB.append("<applyType><![CDATA["+CTools.dealNull(table.get("proposer"))+"]]></applyType>");//申请人类型：公民、法人
					//公民
					strB.append("<applyName><![CDATA["+CTools.dealNull(table.get("pname"))+"]]></applyName>");//申请人（公民）姓名，长度不超过50字
					strB.append("<applyUnit><![CDATA["+CTools.dealNull(table.get("paddress"))+"]]></applyUnit>");//申请人（公民）工作单位，长度不超过100字
					strB.append("<applyCertificateType><![CDATA["+CTools.dealNull(table.get("pcard"))+"]]></applyCertificateType>");//申请人（公民）证件类型，长度不超过50字
					////申请人（公民）证件号码，长度不超过18字
					pcardnum = CTools.dealNull(table.get("pcardnum"));
					if(pcardnum.length()>18){
						pcardnum = pcardnum.substring(0,17);
					}
					strB.append("<applyCertificateNo><![CDATA["+pcardnum+"]]></applyCertificateNo>");
					//法人
					strB.append("<applyLegal><![CDATA["+CTools.dealNull(table.get("ename"))+"]]></applyLegal>");//申请人（法人）名称，长度不超过50字
					strB.append("<applyLegalCode><![CDATA[]]></applyLegalCode>");//申请人（法人）组织机构代码，长度不超过10字
					strB.append("<applyLegalRep><![CDATA["+CTools.dealNull(table.get("edeputy"))+"]]></applyLegalRep>");//申请人（法人）法人代表，长度不超过50字
					strB.append("<applyContactName><![CDATA["+CTools.dealNull(table.get("elinkman"))+"]]></applyContactName>");//申请人（法人）联系人姓名，长度不超过50字
					strB.append("<applyPhone><![CDATA["+CTools.dealNull(table.get("ptele"))+"]]></applyPhone>");//申请人联系电话，长度不超过50字
					strB.append("<applyAddress><![CDATA["+CTools.dealNull(table.get("paddress"))+"]]></applyAddress>");//申请人联系地址，长度不超过100字
					strB.append("<applyZipcode><![CDATA["+CTools.dealNull(table.get("pzipcode"))+"]]></applyZipcode>");//申请人邮政编码，长度不超过6字
					strB.append("<applyEmail><![CDATA["+CTools.dealNull(table.get("pemail"))+"]]></applyEmail>");//申请人电子邮箱，长度不超过100字
					strB.append("<applyDate><![CDATA["+CTools.dealNull(table.get("applytime"))+"]]></applyDate>");//申请日期，格式：YYYY-MM-DD
					//所需信息的内容描述，必填，长度不超过1000字
					commentinfo = CTools.dealNull(table.get("commentinfo"));
					if(commentinfo.length()>1000){
						commentinfo = commentinfo.substring(0,990)+"... ...";
					}
					strB.append("<infoDesc><![CDATA["+commentinfo+"]]></infoDesc>");
					strB.append("<getType><![CDATA["+CTools.dealNull(table.get("gainmode"))+"]]></getType>");//获取信息的方式，选项：邮寄、传真、递送、当面领取、现场查阅、电子邮件
					strB.append("<getMedia><![CDATA["+CTools.dealNull(table.get("offermode"))+"]]></getMedia>");//信息的载体形式，选项：纸质文本、光盘、磁盘
					//所需信息的用途，选项：自身生产的需要、自身生活的需要、自身科研的需要、查验自身信息 （可多选，以英文逗号分隔）
					purpose = CTools.dealNull(table.get("purpose"));
					if(purpose.length()>0){
						String s = purpose.substring(purpose.length()-1, purpose.length()) ;
				    	if(",".equals(s)){
							purpose = purpose.substring(0,purpose.length()-1);
						}else{
							purpose = purpose.substring(0,purpose.length());
						}
					}
					strB.append("<applyUseType><![CDATA["+purpose+"]]></applyUseType>");
					strB.append("<applyUseTypeDesc><![CDATA[]]></applyUseTypeDesc>");//所需信息的用途描述，长度不超过1000字
					strB.append("<freeReason><![CDATA["+CTools.dealNull(table.get("free"))+"]]></freeReason>");//需要减免费用理由，选项：属于农村五保供养对象、属于城乡居民最低生活保障对象、属于领取国家抚恤补助的优抚对象、确有其他经济困难的 （可多选，以英文逗号分隔）
					strB.append("<applyWay><![CDATA["+CTools.dealNull(table.get("signmode"))+"]]></applyWay>");//申请方式，选项：信函、门户网站、电子邮件、传真、当面、其他
					//答复
					
					strB.append("<dealUnitName><![CDATA["+CTools.dealNull(table.get("dname"))+"]]></dealUnitName>");//受理单位名称
					strB.append("<dealType><![CDATA["+status_name+"]]></dealType>");//受理结果类型：选项："主动公开","依申请公开","涉及商业秘密、个人隐私公开","部分公开","国家秘密不予公开","商业秘密不予公开","个人隐私不予公开","三安全一稳定不予公开","内部管理、过程性信息不予公开","不足以证明三需要不予公开","未补充证明三需要不予公开","其他不予公开","非本机关公开职权范围","信息不存在","非规定所指政府信息","信访事项","复议事项","房地产登记事项","其他法律法规另有规定（其他）","非申请（咨询）","非申请（申请内容不明确）","非申请（其他）","档案","重复申请","党政混合信息公开","党政混合信息不予公开","其他","未补正，视为自动放弃","申请人主动撤销","重复申请不予答复处理"
					wordcontent = CTools.dealNull(table.get("wordcontent"));
					if(wordcontent.length()>1200){
						wordcontent = wordcontent.substring(0,1190)+"... ...";
					}
					strB.append("<noticeContent><![CDATA["+wordcontent+"]]></noticeContent>");//告知书正文，长度不超过2000字  还是1200啊
					strB.append("<replyDate><![CDATA["+CTools.dealNull(table.get("inserttime"))+"]]></replyDate>");//答复日期，格式：YYYY-MM-DD
					strB.append("<isProvide><![CDATA["+CTools.dealNull(table.get("isbmtgxx"))+"]]></isProvide>");//是否便民提供相关信息：Y（是）或N（否）
					
					strB.append("</applyOpenInfo>");
					}
					
				}
			}
			strB.append("</root>");
			ysqgkxmls = strB.toString();
			System.out.println("ysqgkxmls==========="+ysqgkxmls);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			cDn.closeCn();
		}
		return ysqgkxmls;
	}
	
	/**
	 * 修改infoopen表中isgosh字段值
	 * 将返回值插入到申请表中
	 */
	public void UpdateInfoOpenIsgosh(String reback,String infoid)
	{
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		//
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			
			dImpl.edit("infoopen", "id", infoid);
			dImpl.setValue("isgosh",reback, CDataImpl.STRING);
			dImpl.update();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			cDn.closeCn();
		}
	}
	/**
	 * 是否有处理答复意见
	 * @param infoid
	 * @return
	 */
	private boolean isInfoword(String infoid) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable table = null;
		boolean isinfoword = false;
		String sql = "select iw_id from infoopen_word where ip_id = '"
				+ infoid + "'";
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
			if (table != null)
				isinfoword = true;
		} catch (Exception e) {
			System.err.println("ParseBeianXml:hasIndexnum " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return isinfoword;
	}
	/**
	 * 
	 * @param args
	 */
	public static void main(String args[]){
		ShGwysqService sgs = new ShGwysqService();
		//批量
		//sgs.toShGwysq();
		//单个
		//sgs.sdToShGwysq("36063,36062,36053,36053,36037,36016,36015,36014,36013,35999,35998,35997,35984,35978,35967,35953,35952,35948,35948,35945,35923,35907,35907,35896,35857,35818,35818,35814,35803,35802,35798,35789,35783,35783,35783,35783,35740,35739,35734,35734,35734,35732,35732,35732,35700,35700,35696,35689,35689,35689,35679,35679,35679,35678,35678,35678,35677,35677,35677,35674,35673,35672,35665,35660,35659,35656,35651,35644,35641,35641,35641,35640,35639,35637,35636,35635,35629,35626,35626,35625,35625,35624,35624,35623,35623,35622,35622,35622,35621,35621,35621,35617,35617,35617,35606,35605,35604,35602,35602,35602,35601,35601,35601,35598,35598,35598,35594,35588,35588,35588,35578,35576,35576,35576,35562,35562,35548,35547,35539,35517,35517,35517,35517,35498,35498,35498,35485,35485,35485,35485,35397,35397,35397,35397,35396,35396,35396,35396,33583,33583,33278,33278,33278,33276,33276,33276,33272,33272,32863,32863,32863,32863");
		//System.out.println("返回值============="+sgs.toShGwbaAuto(ct_id));
		
		
	}
	
}
