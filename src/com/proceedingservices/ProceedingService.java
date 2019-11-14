package com.proceedingservices;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.TimerTask;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.CASUtil;
import com.util.CTools;

/**
 * 向.net推送办事事项表单接口（智能机器人办事事项查询）
 * http://31.6.130.53:8088/EasyReportForWS/ReportWS.asmx
 * @author Administrator 2009-11-23
 */
public class ProceedingService extends TimerTask {

	/**
	 * 构造函数
	 */
	public ProceedingService() {

	}

	/**
	 * 得到事项表单的XMLS
	 * 
	 * @return xmls
	 * @throws Exception
	 */
	public String getAllProceedingForm() throws Exception {
		com.proceedingservices.ReportWSSoap_BindingStub binding;
		ProceedingModel prm = new ProceedingModel();
		try {
			binding = (com.proceedingservices.ReportWSSoap_BindingStub) new com.proceedingservices.ReportWSLocator()
					.getReportWSSoap();
		} catch (javax.xml.rpc.ServiceException jre) {
			if (jre.getLinkedCause() != null)
				jre.getLinkedCause().printStackTrace();
			throw new junit.framework.AssertionFailedError(
					"JAX-RPC ServiceException caught: " + jre);
		}
		// Time out after a minute
		binding.setTimeout(60000);

		java.lang.String proceedingxmls = null;
		proceedingxmls = binding.getAllReportList();

		return proceedingxmls;

	}
	
	/**
	 * 得到XML根节点
	 * 调用接口入口
	 * @return
	 */
	public void getProceedingModels() {
		//String proxmls = "<?xml version=\"1.0\" encoding=\"gbk\"?><Root>	<FormInfo>		<FormName>		用1户2组3		</FormName>		<FormGuid>		10fb3a06-f261-44a0-a9a9-6bae6c181b3		</FormGuid>		<FormGroup>		System		</FormGroup>	</FormInfo>	<FormInfo>		<FormName>		34用户组23		</FormName>		<FormGuid>		10fb3a06-f261-44a0-a9a9-6bae6c181b82		</FormGuid>		<FormGroup>		System		</FormGroup>	</FormInfo></Root>";
		String proxmls = "";
		Element element = null;
		Element child = null;
		List ary = null;
		try {
			proxmls = this.getAllProceedingForm();
			proxmls = this.getproceedingxmls(proxmls);
			System.out.println("proxmls==="+proxmls);
			if (!"".equals(proxmls)) {
				element = this.initEle(proxmls);
				if (element != null) {
					ary =  element.getChildren();
					//本地删除.net已删除的表单
					this.deleteProceeding(ary);
					//新增或修改
					for (int i = 0; i < ary.size(); i++) {
						child = (Element) ary.get(i);
						this.dealElement(child);
					}
				}
			}
		} catch (Exception ex) {
			System.out.println(new Date() + "ProceedingService---getProceedingModels--"
					+ ex.getMessage());
			ex.printStackTrace();
		}
	}

	/**
	 * 操作数据库
	 * @param ele XML元素值
	 */
	private void dealElement(Element ele) {
		String pc_formname = "";
		String pc_formguid = "";
		String pc_formgroup = "";
		//String pc_formgroupcode = "";
		String sqlStr = "";
		String pc_id = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);

			pc_formname = ele.getChildTextTrim("FormName");
			pc_formguid = ele.getChildTextTrim("FormGuid");
			pc_formgroup = ele.getChildTextTrim("FormGroup");
			//pc_formgroupcode = ele.getChildTextTrim("FormGroupCode");
			
			sqlStr = "select pc_id from tb_proceeding_form where pc_formguid='"
					+ pc_formguid + "'";
			content = (Hashtable)dImpl.getDataInfo(sqlStr);
			if(content!=null){
				pc_id = CTools.dealNull(content.get("pc_id"));
				
				dImpl.edit("tb_proceeding_form", "pc_id", pc_id);
				dImpl.setValue("pc_formname",pc_formname,CDataImpl.STRING);
				dImpl.setValue("pc_formgroup",pc_formgroup,CDataImpl.STRING);
				dImpl.update();
				
			}else{
				dImpl.addNew("tb_proceeding_form", "pc_id");
				dImpl.setValue("pc_formname",pc_formname,CDataImpl.STRING);
				dImpl.setValue("pc_formguid",pc_formguid,CDataImpl.STRING);
				dImpl.setValue("pc_formgroup",pc_formgroup,CDataImpl.STRING);
				//dImpl.setValue("pc_formgroupcode",pc_formgroupcode,CDataImpl.STRING);
				dImpl.update();				
			}

		} catch (Exception ex) {
			System.out.println(new Date() + "ProceedingService---dealElement--"
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
	 * 删除.net表单已删除的本地表单
	 * @param lists
	 */
	private void deleteProceeding(List lists){
		String delSql = "";
		String sqlDel = "";
		String guids = "";
		Element ele = null;
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			for(int i=0;i<lists.size();i++){
				ele = (Element)lists.get(i);
				guids += "'"+ele.getChildTextTrim("FormGuid")+"'";
				if(i != (lists.size() -1))
					guids += ",";
			}
			//删除中间表tb_proceeding_center
			sqlDel = "delete from tb_proceeding_center where pc_id in(select pc_id from tb_proceeding_form where pc_formguid not in("+guids+"))";
			dImpl.executeUpdate(sqlDel);
			//删除表单表tb_proceeding_form
			delSql = "delete from tb_proceeding_form where pc_formguid not in("+guids+")";
			System.out.println(delSql);
			dImpl.executeUpdate(delSql);
			
		}catch (Exception ex) {
			System.out.println(new Date() + "ProceedingService---deleteProceeding--"
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
	 * 还原编码后的特殊字符
	 * @param xmls
	 * @return
	 */
	public String getproceedingxmls(String xmls){
		  xmls = xmls.replaceAll("&amp;","&");
		  xmls = xmls.replaceAll("&quot;","");
		  xmls = xmls.replaceAll("&lt;","<");
		  xmls = xmls.replaceAll("&gt;",">");
		  xmls = xmls.replaceAll("&nbsp;"," ");
		  return xmls;
	}

	/**
	 * 监听调用
	 */
	public void run() {
		// TODO Auto-generated method stub
		//this.getProceedingModels();
		
	}
	
	public static void main(String args[]){
		ProceedingService ps = new ProceedingService();
		ps.getProceedingModels();
		System.out.println("--over--");
		
	}
}
