package com.shgwservice;

import java.io.File;
import java.io.FileInputStream;
import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import javax.xml.rpc.ParameterMode;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;

/**
 * 调用上海市公文备案系统信息发布接口，推送浦东的信息公开数据 
 * http://10.81.96.38:8080/services/DocBakService 新地址
 * 
 * 操作方法名称：importInfo
 * 
 * @author Administrator
 * 
 */
public class ShGwbaService extends TimerTask{

	/**
	 * 执行监听的方法
	 */
	public void run(){
		toShGwbaAuto();
	}
	
	/**
	 * 获取待发送的浦东公文备案信息公开列表
	 * @return
	 */
	public void toShGwbaAuto(){
		String xxgkxmls = "";
		String xxgksql = "";
		String reback = "";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		//
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			
			
			xxgksql = "select c.ct_id as ct_id,c.ct_title as ct_title,c.in_filenum as in_filenum,d.dt_shortname as dt_name,decode(c.in_dzhhxx,0,'N',1,'Y','N') as " +
						"in_dzhhxx, c.ct_create_time as ct_create_time," +
						"decode(c.in_gongkaitype,0,'主动公开',1,'依申请公开','2','不予公开','3','非政府信息') as  in_gongkaitype,decode(c.in_govopencarriertype,'','其他',c.in_govopencarriertype) as in_govopencarriertype, " +
						"decode(c.in_colseid,1,'商业秘密','2','个人隐私','3','内部管理信息','5','其他') as in_colseid,cd.ct_content as ct_content,c.ct_memo as ct_memo," +
						"decode(c.in_gongwentype,0,'命令（令）',1,'决定','2','公告','3','通告','4','通知','5','通报','6','议案','7','报告','8','请示','9','批复','10','意见','11','函','12','会议纪要') as in_gongwentype, " +
						"decode(c.in_subjectid,0,'机构职能',1,'政策法规','2','规划计划','3','业务类','9','其它') as in_subjectid, decode(c.in_draft,0,'N',1,'Y','N') as in_draft,decode(c.in_isgw,0,'N',1,'Y') as in_isgw," +
						"decode(c.in_specsfile,0,'N',1,'Y','N') as in_specsfile,decode(c.in_zutici1,'','12125',c.in_zutici1) as in_zutici1,decode(c.in_zutici2,'','12253',c.in_zutici2) as in_zutici2,decode(c.in_zupeitype,'','其它',c.in_zupeitype) as in_zupeitype,d.dt_zzjgdm,d.dt_shortname " +
						"from tb_content c,tb_deptinfo d,tb_contentdetail cd  where c.isgosh = '0' and c.dt_id = d.dt_id and c.ct_id = cd.ct_id order by c.ct_id desc";
			
			//System.out.println(xxgksql);
			
			StringBuffer strB= new StringBuffer();
			vPage = dImpl.splitPage(xxgksql, 10,1);//最多取100条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					
					strB.append("<?xml version=\"1.0\" encoding=\"GBK\"?>");
					strB.append("<root>");
					strB.append("<userAccount><![CDATA[gongyw]]></userAccount>");
					strB.append("<docBakInfo>");
					strB.append("<syId><![CDATA[]]></syId>");//索引号，格式（共21位）：SY + 成文单位的9位组织机构代码 + 1位来源标识（政务外网：0；涉密内网：1） + 4位年份 + 5位流水号；索引号如为空，则由系统自动生成
					strB.append("<docTitle><![CDATA["+CTools.dealNull(table.get("ct_title"))+"]]></docTitle>");//标题，长度不超过200字
					strB.append("<authNo><![CDATA["+getIn_filenum(CTools.dealNull(table.get("in_filenum")))+"]]></authNo>");//文号，格式：***〔****〕***号，长度不超过50字
					strB.append("<authUnit><![CDATA["+CTools.dealNull(table.get("dt_shortname"))+"]]></authUnit>");//发文机关，长度不超过100字
					strB.append("<partyFlag><![CDATA["+CTools.dealNull(table.get("in_dzhhxx"))+"]]></partyFlag>");//党政混合信息标识：Y（是）或N（否）
					strB.append("<unitedocFlag><![CDATA[N]]></unitedocFlag>");//是否是联合发文：Y（是）或N（否）
					strB.append("<authDate><![CDATA["+CTools.dealNull(table.get("ct_create_time"))+"]]></authDate>");//生成日期，格式：YYYY-MM-DD
					strB.append("<openType><![CDATA["+CTools.dealNull(table.get("in_gongkaitype"))+"]]></openType>");//公开类别，选项：主动公开、依申请公开、不予公开、非政府信息
					strB.append("<openCarrier><![CDATA["+CTools.dealNull(table.get("in_govopencarriertype")) +"]]></openCarrier>");//主动公开载体，可为空，选项：网站、公报、短信、邮件、电子终端、其他
					strB.append("<openUrl><![CDATA[]]></openUrl>");//网址，长度不超过500字
					strB.append("<notopenReason><![CDATA["+CTools.dealNull(table.get("in_colseid"))+"]]></notopenReason>");//免予公开理由,可为空，选项：国家秘密、商业秘密、个人隐私、过程中信息、内部管理信息、危及三安全一稳定、其他
					strB.append("<docSecret><![CDATA[非密]]></docSecret>");//密级，选项：非密、秘密、机密、绝密
					strB.append("<content><![CDATA["+CTools.dealNull(table.get("ct_content")).replaceAll("\"/attach/infoattach/", "\"http://www.pudong.gov.cn/UpLoadPath/PublishInfo/")+"]]></content>");//正文 内容
					strB.append("<briefContent><![CDATA["+CTools.dealNull(table.get("ct_memo"))+"]]></briefContent>");//内容概述，长度不超过1500字
					strB.append("<missiveFlag><![CDATA["+CTools.dealNull(table.get("in_isgw"))+"]]></missiveFlag>");//是否是公文类政府信息（公文类标识）：Y（是）或N（否）
					//主题词
					strB.append("<themeOne><![CDATA["+getZctValue(dImpl,CTools.dealNull(table.get("in_zutici1")))+"]]></themeOne>");//主题词一级类目，选项见《主题词清单
					strB.append("<themeTwo><![CDATA["+getZctValue(dImpl,CTools.dealNull(table.get("in_zutici2")))+"]]></themeTwo>");//主题词二级类目，选项见《主题词清单
					//
					strB.append("<docType><![CDATA["+CTools.dealNull(table.get("in_gongwentype"))+"]]></docType>");//体裁分类，选项：命令（令）、决定、公告、通告、通知、通报、议案、报告、请示、批复、意见、函、会议纪要
					strB.append("<groupType><![CDATA["+CTools.dealNull(table.get("in_zupeitype"))+"]]></groupType>");//组配分类，选项：机构职能、政策法规、规划计划、行政事务、人事人才、财务审计、国资管理、统计信息、便民信息、其它
					strB.append("<decisionFlag><![CDATA["+CTools.dealNull(table.get("in_draft"))+"]]></decisionFlag>");//是否为重大决定的草案：Y（是）或N（否）
					strB.append("<standardFlag><![CDATA["+CTools.dealNull(table.get("in_specsfile"))+"]]></standardFlag>");//是否为规范性文件：Y（是）或N（否）
					strB.append("<invalidDate><![CDATA[]]></invalidDate>");//失效日期，格式：YYYY-MM-DD
					strB.append("<note><![CDATA["+CTools.dealNull(table.get("ct_memo"))+"]]></note>");//备注，长度不超过500字
					strB.append("</docBakInfo>");
					strB.append("</root>");
					xxgkxmls = strB.toString();
					
					
					
					//执行自动推送上海市公文备案接口
					reback = toShGwbaAutoService(xxgkxmls);
					//修改数据isgosh
					updateContent(CTools.dealNull(table.get("ct_id")),reback,dImpl);
					
					strB= new StringBuffer();
					System.out.println("reback======="+reback);
					
				}
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(cDn!=null)
				cDn.closeCn();
		}
	}
	/**
	 * 手动推送浦东信息公开数据至上海市
	 * @param xml
	 * @return
	 */
	public String toShGwba(String ct_ids){
		String xxgkxmls = "";
		String reback = "";
		String xxgksql = "";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		//
		try {
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			if(!"".equals(ct_ids)){
				xxgksql = "select c.ct_id as ct_id,c.ct_title as ct_title,c.in_filenum as in_filenum,d.dt_shortname as dt_name,decode(c.in_dzhhxx,0,'N',1,'Y','N') as " +
					"in_dzhhxx, c.ct_create_time as ct_create_time," +
					"decode(c.in_gongkaitype,0,'主动公开',1,'依申请公开','2','不予公开','3','非政府信息') as  in_gongkaitype,decode(c.in_govopencarriertype,'','其他',c.in_govopencarriertype) as in_govopencarriertype, " +
					"decode(c.in_colseid,1,'商业秘密','2','个人隐私','3','内部管理信息','5','其他') as in_colseid,cd.ct_content as ct_content,c.ct_memo as ct_memo," +
					"decode(c.in_gongwentype,0,'命令（令）',1,'决定','2','公告','3','通告','4','通知','5','通报','6','议案','7','报告','8','请示','9','批复','10','意见','11','函','12','会议纪要') as in_gongwentype, " +
					"decode(c.in_subjectid,0,'机构职能',1,'政策法规','2','规划计划','3','业务类','9','其它') as in_subjectid, decode(c.in_draft,0,'N',1,'Y','N') as in_draft,decode(c.in_isgw,0,'N',1,'Y') as in_isgw," +
					"decode(c.in_specsfile,0,'N',1,'Y','N') as in_specsfile,decode(c.in_zutici1,'','12125',c.in_zutici1) as in_zutici1,decode(c.in_zutici2,'','12253',c.in_zutici2) as in_zutici2,decode(c.in_zupeitype,'','其它',c.in_zupeitype) as in_zupeitype,d.dt_zzjgdm,d.dt_shortname " +
					"from tb_content c,tb_deptinfo d,tb_contentdetail cd  where c.ct_id in ("+ct_ids+") and c.dt_id = d.dt_id and c.ct_id = cd.ct_id order by c.ct_id desc";
			}
			//System.out.println(xxgksql);
			
			StringBuffer strB= new StringBuffer();
			
			
			vPage = dImpl.splitPage(xxgksql, 100,1);//最多取100条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					strB.append("<?xml version=\"1.0\" encoding=\"GBK\"?>");
					strB.append("<root>");
					strB.append("<userAccount><![CDATA[gongyw]]></userAccount>");
					strB.append("<docBakInfo>");
					strB.append("<syId><![CDATA[]]></syId>");//索引号，格式（共21位）：SY + 成文单位的9位组织机构代码 + 1位来源标识（政务外网：0；涉密内网：1） + 4位年份 + 5位流水号；索引号如为空，则由系统自动生成
					strB.append("<docTitle><![CDATA["+CTools.dealNull(table.get("ct_title"))+"]]></docTitle>");//标题，长度不超过200字
					strB.append("<authNo><![CDATA["+getIn_filenum(CTools.dealNull(table.get("in_filenum")))+"]]></authNo>");//文号，格式：***〔****〕***号，长度不超过50字
					strB.append("<authUnit><![CDATA["+CTools.dealNull(table.get("dt_shortname"))+"]]></authUnit>");//发文机关，长度不超过100字
					strB.append("<partyFlag><![CDATA["+CTools.dealNull(table.get("in_dzhhxx"))+"]]></partyFlag>");//党政混合信息标识：Y（是）或N（否）
					strB.append("<unitedocFlag><![CDATA[N]]></unitedocFlag>");//是否是联合发文：Y（是）或N（否）
					strB.append("<authDate><![CDATA["+CTools.dealNull(table.get("ct_create_time"))+"]]></authDate>");//生成日期，格式：YYYY-MM-DD
					strB.append("<openType><![CDATA["+CTools.dealNull(table.get("in_gongkaitype"))+"]]></openType>");//公开类别，选项：主动公开、依申请公开、不予公开、非政府信息
					strB.append("<openCarrier><![CDATA["+CTools.dealNull(table.get("in_govopencarriertype")) +"]]></openCarrier>");//主动公开载体，可为空，选项：网站、公报、短信、邮件、电子终端、其他
					strB.append("<openUrl><![CDATA[]]></openUrl>");//网址，长度不超过500字
					strB.append("<notopenReason><![CDATA["+CTools.dealNull(table.get("in_colseid"))+"]]></notopenReason>");//免予公开理由,可为空，选项：国家秘密、商业秘密、个人隐私、过程中信息、内部管理信息、危及三安全一稳定、其他
					strB.append("<docSecret><![CDATA[非密]]></docSecret>");//密级，选项：非密、秘密、机密、绝密
					strB.append("<content><![CDATA["+CTools.dealNull(table.get("ct_content")).replaceAll("\"/attach/infoattach/", "\"http://www.pudong.gov.cn/UpLoadPath/PublishInfo/")+"]]></content>");//正文 内容
					strB.append("<briefContent><![CDATA["+CTools.dealNull(table.get("ct_memo"))+"]]></briefContent>");//内容概述，长度不超过1500字
					strB.append("<missiveFlag><![CDATA["+CTools.dealNull(table.get("in_isgw"))+"]]></missiveFlag>");//是否是公文类政府信息（公文类标识）：Y（是）或N（否）
					//主题词
					strB.append("<themeOne><![CDATA["+getZctValue(dImpl,CTools.dealNull(table.get("in_zutici1")))+"]]></themeOne>");//主题词一级类目，选项见《主题词清单
					strB.append("<themeTwo><![CDATA["+getZctValue(dImpl,CTools.dealNull(table.get("in_zutici2")))+"]]></themeTwo>");//主题词二级类目，选项见《主题词清单
					//
					strB.append("<docType><![CDATA["+CTools.dealNull(table.get("in_gongwentype"))+"]]></docType>");//体裁分类，选项：命令（令）、决定、公告、通告、通知、通报、议案、报告、请示、批复、意见、函、会议纪要
					strB.append("<groupType><![CDATA["+CTools.dealNull(table.get("in_zupeitype"))+"]]></groupType>");//组配分类，选项：机构职能、政策法规、规划计划、行政事务、人事人才、财务审计、国资管理、统计信息、便民信息、其它
					strB.append("<decisionFlag><![CDATA["+CTools.dealNull(table.get("in_draft"))+"]]></decisionFlag>");//是否为重大决定的草案：Y（是）或N（否）
					strB.append("<standardFlag><![CDATA["+CTools.dealNull(table.get("in_specsfile"))+"]]></standardFlag>");//是否为规范性文件：Y（是）或N（否）
					strB.append("<invalidDate><![CDATA[]]></invalidDate>");//失效日期，格式：YYYY-MM-DD
					strB.append("<note><![CDATA["+CTools.dealNull(table.get("ct_memo"))+"]]></note>");//备注，长度不超过500字
					strB.append("</docBakInfo>");
					strB.append("</root>");
					xxgkxmls = strB.toString();
					
					//执行自动推送上海市公文备案接口
					reback = toShGwbaAutoService(xxgkxmls);
					//修改数据isgosh
					updateContent(CTools.dealNull(table.get("ct_id")),reback,dImpl);
					
					strB= new StringBuffer();
					
					
				}
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(cDn!=null)
				cDn.closeCn();
			
		}
		System.out.println("gwba-reback==============="+reback);
		return reback;
	}
	
	
	
	/**
	 * 自动定时推送到上海市公文备案系统
	 * @param xmls
	 * @return
	 */
	public String toShGwbaAutoService(String xmls) {
		String reback = "";
		Service service = null;
		Call call = null;
		try {
			service = new Service();
			call = (Call) service.createCall();

			// 设置访问点
			call.setTargetEndpointAddress("http://10.81.96.38:8080/services/DocBakService");

			// 设置操作方法名
			call.setOperationName("importInfo");

			// 设置入口参数
			call.addParameter("infoXml", XMLType.XSD_STRING, ParameterMode.IN);
			call.setReturnType(XMLType.XSD_STRING);
			
			// 调用服务
			reback = (String) call.invoke(new Object[] {xmls});
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			service = null;
			call = null;
		}
		return reback;
	}
	
	/**
	 * 修改信息isgosh
	 * @param ct_id
	 * @param reback
	 */
	public void updateContent(String ct_id,String reback,CDataImpl dImpl){
		try {
			dImpl.executeUpdate("update tb_content set isgosh='"+reback+"' where ct_id='" + ct_id + "'");
			dImpl.update();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	/**
	 * 获取主题词值
	 * @param dv_id
	 * @return
	 */
	public String getZctValue(CDataImpl dImpl,String dv_id){
		Hashtable ztcContent = null;
		String ztcSql = "";
		String dv_value = "";
		try {
			ztcSql = "select dv_value from tb_datavalue where dv_id = "+dv_id;
			ztcContent=dImpl.getDataInfo(ztcSql);
			if(ztcContent!=null){
				dv_value = CTools.dealNumber(ztcContent.get("dv_value"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return dv_value;
	}
	/**
	 * 文号格式修改
	 * @param in_filenum
	 * @return
	 */
	public String getIn_filenum(String in_filenum){
		if(!"".equals(in_filenum)){
		in_filenum = in_filenum.replace('[','〔');
		in_filenum = in_filenum.replace(']','〕');
		
		in_filenum = in_filenum.replace('(','〔');
		in_filenum = in_filenum.replace(')','〕');
		
		in_filenum = in_filenum.replace('（','〔');
		in_filenum = in_filenum.replace('）','〕');
		
		in_filenum = in_filenum.replace('﹝','〔');
		in_filenum = in_filenum.replace('﹞','〕');
		
		in_filenum = in_filenum.replace('【','〔');
		in_filenum = in_filenum.replace('】','〕');
		
		}
		
		return in_filenum;
		
	}
	/**
	 * 
	 * @param args
	 */
	public static void main(String args[]){
		ShGwbaService sgs = new ShGwbaService();
		//批量
		//sgs.toShGwbaAuto();
		//单个
		sgs.toShGwba("328978");
		//System.out.println("返回值============="+sgs.toShGwbaAuto(ct_id));
		
		
	}
}
