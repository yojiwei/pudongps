package com.webservise;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import sun.misc.BASE64Decoder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;
import com.util.ReadProperty;
/**
 * 对外提供委办局报送行政处罚信息的接口
 * @author Administrator
 *
 */ 
public class XzcfInfoService {
	ReadProperty rp = new ReadProperty();
	WebserviceReadProperty pro = new WebserviceReadProperty();
	SimpleDateFormat logdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public XzcfInfoService(){}
	/**
	 * 获取XZCF信息
	 * @param xmls
	 * @return 1 success 0 failed
	 */
	public String OperateXzcf(String proxmls){
		Element element = null;
		try {
			proxmls = this.getXzcfxmls(proxmls);
			System.out.println("proxmls===="+proxmls);
			if (!"".equals(proxmls)) {
				element = this.initEle(proxmls);
				if (element != null) {
					return this.dealElement(element);
				}
			}
		} catch (Exception ex) {
			System.out.println(new Date() + "XzcfService---getXzcfModels--"
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
		String deptcode = "";
		String filenum = "";
		String cfid = "";
		String wfqy = "";
		String wfqycode = "";
		String cfname = "";
		String wfss = "";
		String cfzl_by = "";
		String lxfs_qx = "";
		String cfdate = "";
		String memo = "";
		String subjectcode = "";
		String dtcf_id = "";
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
			operater = ele.getChildTextTrim("OPERATER");
			deptcode = ele.getChildTextTrim("DEPTCODE");
			filenum = ele.getChildTextTrim("FILENUM");//处罚书文号
			wfqy = ele.getChildTextTrim("WFQY");//违法企业名称和自然人名称
			wfqycode = ele.getChildTextTrim("WFQYCODE");//违法企业组织机构代码
			cfname = ele.getChildTextTrim("CFNAME");//法定代表人名称
			wfss = ele.getChildTextTrim("WFSS");//违法事实
			cfzl_by = ele.getChildTextTrim("CFZL_BY");//处罚种类和依据
			lxfs_qx = ele.getChildTextTrim("LXFS_QX");//履行方式和期限
			cfdate = ele.getChildTextTrim("CFDATE");//处罚日期
			memo = ele.getChildTextTrim("MEMO");//备注
			subjectcode = pro.getPropertyValue("XZCF_"+deptcode);
			
			//System.out.println(operater+"========"+subjectcode);
			
			//获取部门名称和ID
			sqlStr = "select dt_id,dt_name from tb_deptinfo where dt_code = '"+deptcode+"' ";
			deptPr = (Hashtable)dImpl.getDataInfo(sqlStr);
			if(deptPr!=null){
				dt_id = CTools.dealNull(deptPr.get("dt_id"));
				dt_name = CTools.dealNull(deptPr.get("dt_name"));
			}

			//查找已经录过的数据ID
			dtcf_id = deptcode+"_"+ele.getChildTextTrim("MESSAGEID");
			if(!"".equals(dtcf_id)){
				sqlStr = "select cf_id from tb_xzcf where dtcf_id = '"+dtcf_id+"'";
				System.out.println(sqlStr);
				contentPr = (Hashtable)dImpl.getDataInfo(sqlStr);
				if(contentPr!=null){
					cfid = CTools.dealNull(contentPr.get("cf_id"));
					if("add".equals(operater)){
						operater = "edit";
					}
				}
			}

			dCn.beginTrans();
			String projectid = "";
			if("add".equals(operater)){
				dImpl.setTableName("tb_xzcf");
				dImpl.setPrimaryFieldName("cf_id");
				projectid = Long.toString(dImpl.addNew());
				dImpl.setValue("cf_number",filenum,CDataImpl.STRING);
				dImpl.setValue("cf_qyname",wfqy,CDataImpl.STRING);
				dImpl.setValue("cf_qycode",wfqycode,CDataImpl.STRING);
				dImpl.setValue("cf_name",cfname,CDataImpl.STRING);
				dImpl.setValue("cf_wfss",wfss,CDataImpl.STRING);
				dImpl.setValue("cf_type_by",cfzl_by,CDataImpl.STRING);
				dImpl.setValue("cf_lxfs_date",lxfs_qx,CDataImpl.STRING);
				dImpl.setValue("cf_deptname",dt_name,CDataImpl.STRING);
				dImpl.setValue("cf_date",cfdate,CDataImpl.DATE);
				dImpl.setValue("cf_memo",memo,CDataImpl.STRING);
				dImpl.setValue("cf_subjectcode",subjectcode,CDataImpl.STRING);
				dImpl.setValue("dt_code",deptcode,CDataImpl.STRING);
				dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
				dImpl.setValue("issend","0",CDataImpl.STRING);
				dImpl.setValue("operater",operater,CDataImpl.STRING);
				dImpl.setValue("dtcf_id",dtcf_id,CDataImpl.STRING);
				dImpl.update();
				
				
			}else if("edit".equals(operater)){
				dImpl.edit("tb_xzcf", "cf_id", cfid); 
				dImpl.setValue("cf_number",filenum,CDataImpl.STRING);
				dImpl.setValue("cf_qyname",wfqy,CDataImpl.STRING);
				dImpl.setValue("cf_qycode",wfqycode,CDataImpl.STRING);
				dImpl.setValue("cf_name",cfname,CDataImpl.STRING);
				dImpl.setValue("cf_wfss",wfss,CDataImpl.STRING);
				dImpl.setValue("cf_type_by",cfzl_by,CDataImpl.STRING);
				dImpl.setValue("cf_lxfs_date",lxfs_qx,CDataImpl.STRING);
				dImpl.setValue("cf_deptname",dt_name,CDataImpl.STRING);
				dImpl.setValue("cf_date",cfdate,CDataImpl.DATE);
				dImpl.setValue("cf_memo",memo,CDataImpl.STRING);
				dImpl.setValue("cf_subjectcode",subjectcode,CDataImpl.STRING);
				dImpl.setValue("dt_code",deptcode,CDataImpl.STRING);
				dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
				dImpl.setValue("issend","0",CDataImpl.STRING);
				dImpl.setValue("operater",operater,CDataImpl.STRING);
				dImpl.setValue("dtcf_id",dtcf_id,CDataImpl.STRING);
				dImpl.update();
				
			}else if("delete".equals(operater)){
				dImpl.edit("tb_xzcf", "cf_id", cfid); 
				dImpl.setValue("issend","0",CDataImpl.STRING);
				dImpl.setValue("operater",operater,CDataImpl.STRING);
				dImpl.update();
			}

			
			dCn.commitTrans();
			

		} catch (Exception ex) {
			System.out.println(new Date() + "XzcfService---dealElement--"
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
	private String getXzcfxmls(String xmls){
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
		String proxmls = "<?xml version='1.0' encoding='utf-8'?> <DEP_DataExchangeData> <OPERATER>add</OPERATER> <MESSAGEID>3146049</MESSAGEID> <DEPTCODE>XB1</DEPTCODE> <FILENUM>2200140022</FILENUM> <WFQY>孙健（混凝土石块粉碎场）</WFQY> <WFQYCODE></WFQYCODE> <CFNAME>孙健</CFNAME> <WFSS>建设项目需要配套建设的环境保护设施未建成，主体工程正式投入生产或者使用</WFSS> <CFZL_BY>《建设项目环境保护管理条例》第二十八条</CFZL_BY> <LXFS_QX>责令停止废旧混凝土石块粉碎加工;罚款人民币肆万伍仟元整</LXFS_QX> <CFDATE>2014-01-29</CFDATE> <MEMO></MEMO> </DEP_DataExchangeData>";
		XzcfInfoService ops = new XzcfInfoService();
		System.out.println(ops.OperateXzcf(proxmls));
		
	}
}
