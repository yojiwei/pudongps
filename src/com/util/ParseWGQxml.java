package com.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.rmi.RemoteException;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

public class ParseWGQxml {

	private static String ct_title = "";

	private static String ct_content = "";

	private static String ct_create_time = "";

	private static String ct_source = "";

	private static String sj_id = "";

	private static String dt_id = "";

	private static String[] ct_base;

	private static String[] ct_type;

	//	webservice要使用的用户名
	public static String username = "";

	//	webservice要使用的密码
	public static String password = "";
	
	//	调用webservice的urlName
	private static String urlName = "";
	
	private ReadProperty pro ;
	
	public ParseWGQxml(String urlname){
		ParseWGQxml.urlName = urlname;
		pro = new ReadProperty();
		username = pro.getPropertyValue(urlName + "_username");
		password = pro.getPropertyValue(urlName + "_password");
		
	}
	/**
	 * 环保局调用公文备案信息发布接口
	 * @param fileStr 环保局的XMLS
	 * @param eleValue 环保局的CT_ID
	 */
	public void webService(String fileStr,String eleValue) {
		Element ele = initEle(fileStr);
		if (getContent(ele))
			sendToWebservice(username,password,eleValue);
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
					.getBytes("gb2312"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		} catch (Exception ex) {
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}

	/**
	 * 将传入的字符串转化插入相应的数据表
	 * 
	 * @param element
	 *            跟目录元素
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean getContent(Element element) {
		Element content = null;
		String ctName = "";
		List list = element.getChildren();
		boolean flag = true;
		try {
			for (int cnt = 0; cnt < list.size(); cnt++) {
				content = (Element) list.get(cnt);
				ctName = content.getName().toString();

				if ("TB_CONTENT".equals(ctName))
					flag = getContentInfo(content);
			}
		} catch (Exception e) {
			System.out.println(CDate.getNowTime() + "-->" + e.getMessage());
			flag = false;
		}
		return flag;
	}

	/**
	 * 
	 * @param content
	 *            包含内容主体的 HashMap
	 * @return boolean 提取成功返回 true ,失败返回 false
	 */
	private boolean getContentInfo(Element content) {
		List subList = null;
		Element subEle = null;
		subList = content.getChildren();
		String innerName = "";
		String innerValue = "";
		boolean flag = true;
		try {
			for (int len = 0; len < subList.size(); len++) {
				subEle = (Element) subList.get(len);
				innerName = subEle.getName();

				innerValue = subEle.getText();
				if ("CT_TITLE".equals(innerName))
					ct_title = innerValue;
				else if ("CT_CONTENT".equals(innerName))
					ct_content = innerValue;
				else if ("CT_CREATE_TIME".equals(innerName))
					ct_create_time = innerValue;
				else if ("CT_SOURCE".equals(innerName))
					ct_source = innerValue;
				else if ("SJ_ID".equals(innerName))
					sj_id = innerValue;
				else if ("DT_ID".equals(innerName))
					dt_id = innerValue;
				else if ("ATTACH".equals(innerName)) {
					getAttachInfo(subEle);

				}
			}
		} catch (Exception e) {
			System.out.println(CDate.getNowTime() + "-->" + e.getMessage());
			flag = false;
		}
		return flag;
	}

	/**
	 * 将附件信息存放在List中返回
	 * 
	 * @param attach
	 *            包含附件信息的元素
	 */
	private void getAttachInfo(Element attach) {
		List subList = null;
		Element subEle = null;
		Element innerEle = null;
		List innerList = null;
		subList = attach.getChildren();
		String innerName = "";
		String innerValue = "";
		for (int len = 0; len < subList.size(); len++) {
			ct_base = new String[subList.size()];
			ct_type = new String[subList.size()];
			subEle = (Element) subList.get(len);
			innerList = subEle.getChildren();

			for (int cnt = 0; cnt < innerList.size(); cnt++) {
				innerEle = (Element) innerList.get(cnt);
				innerName = innerEle.getName();
				innerValue = innerEle.getTextTrim();
				if (!"".equals(innerName)) {
					if ("CT_BASE".equals(innerName))
						ct_base[len] = innerValue;
					else if ("CT_TYPE".equals(innerName))
						ct_type[len] = innerValue;
				}
			}
		}
	}

	private void sendToWebservice(String username,String password,String eleValue) {
		StringBuffer wgqxml;
		pro = new ReadProperty();
		String[] listSjid = sj_id.split(",");
		String sjCode = "";
		String syscode = "";
		syscode = pro.getPropertyValue(urlName + "_syscode");
		if(eleValue.indexOf(".") != -1)
			eleValue = eleValue.substring(0,eleValue.indexOf("."));
		
		if (listSjid.length > 0) {
			for (int count = 0; count < listSjid.length; count++) {
				sjCode = !"".equals(pro.getPropertyValue(urlName + "_" + listSjid[count]))
							? pro.getPropertyValue(urlName + "_" + listSjid[count]) : listSjid[count];
				wgqxml = new StringBuffer();
				wgqxml.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
				wgqxml.append("<DEP_DataExchangeData>");
				wgqxml.append("<OperationType>信息报送</OperationType>");
				wgqxml.append("<MessageTitle>" + ct_title + "</MessageTitle>");
				wgqxml.append("<MessageID></MessageID>");
				wgqxml.append("<MessageBody>");
				wgqxml.append("<ROOT>");
				wgqxml.append("<DATASEND>");
				wgqxml.append("<OPERATER>add</OPERATER>");
				wgqxml.append("<ID>"+listSjid[count]+"_"+eleValue+"</ID>");
				wgqxml.append("<SYSCODE>"+syscode+"</SYSCODE>");
				wgqxml.append("<FORMID>OA_28805</FORMID>");
				wgqxml.append("<SPECIAL>1</SPECIAL>");

				wgqxml.append("<LINK></LINK>");
				wgqxml.append("<TITLE>" + ct_title + "</TITLE>");
				wgqxml.append("<SUBJECTID>" + listSjid[count] + "</SUBJECTID>");
				wgqxml.append("<CONTENT><![CDATA[" + ct_content
						+ "]]></CONTENT>");

				wgqxml.append("<STARTTIME>" + ct_create_time + "</STARTTIME>");
				wgqxml.append("<ENDTIME>2050-12-31</ENDTIME>");
				wgqxml.append("<SENDUNIT>外高桥功能区</SENDUNIT>");
				wgqxml.append("<FILECODE></FILECODE>");
				wgqxml.append("<INDEX></INDEX>");
				wgqxml.append("<PUBLISH></PUBLISH>");
				wgqxml.append("<CARRIER></CARRIER>");
				wgqxml.append("<ANNAL></ANNAL>");
				wgqxml.append("<SUBJECTCODE>" + sjCode
						+ "</SUBJECTCODE>");
				wgqxml.append("<SOURCE>" + ct_source + "</SOURCE>");
				wgqxml.append("<DESCRIBE></DESCRIBE>");
				wgqxml.append("<KEY></KEY>");
				wgqxml.append("<IMPORTANTFLAG>0</IMPORTANTFLAG>");

				wgqxml.append("<FILEPUBATTACH>");
				if (ct_base != null && ct_base.length >= 1) {
					for (int cnt = 0; cnt < ct_base.length; cnt++) {
						if(!"".equals(ct_base[cnt])){
							wgqxml.append("<PUBATTACH>");
							wgqxml.append("<FILENAME>外高桥附件</FILENAME>");
							wgqxml
									.append("<FILETYPE>APPLICATION/MSWORD</FILETYPE>");
							wgqxml.append("<FILELENGTH>" + ct_base[cnt].length()
									+ "</FILELENGTH>");
							wgqxml.append("<FILECONTENT>" + ct_base[cnt]
									+ "</FILECONTENT>");
							wgqxml.append("<FILEEXTENSION>" + ct_type[cnt]
									+ "</FILEEXTENSION>");
							wgqxml.append("</PUBATTACH>");
						}
					}
				} else {
					wgqxml.append("<PUBATTACH>");
					wgqxml.append("<FILENAME></FILENAME>");
					wgqxml.append("<FILETYPE>APPLICATION/MSWORD</FILETYPE>");
					wgqxml.append("<FILELENGTH></FILELENGTH>");
					wgqxml.append("<FILECONTENT></FILECONTENT>");
					wgqxml.append("<FILEEXTENSION></FILEEXTENSION>");
					wgqxml.append("</PUBATTACH>");
				}
				wgqxml.append("</FILEPUBATTACH>");
				wgqxml.append("</DATASEND>");
				wgqxml.append("</ROOT>");
				wgqxml.append("</MessageBody>");
				wgqxml.append("<SourceUnitCode></SourceUnitCode>");
				wgqxml.append("<SourceCaseCode></SourceCaseCode>");
				wgqxml.append("<DestUnit>");
				wgqxml.append("<DestUnitCode></DestUnitCode>");
				wgqxml.append("<DestCaseCode></DestCaseCode>");
				wgqxml.append("<InterFaceCode></InterFaceCode>");
				wgqxml.append("</DestUnit>");
				wgqxml.append("<Sender></Sender>");
				wgqxml.append("<SendTime></SendTime>");
				wgqxml.append("<EndTime></EndTime>");
				wgqxml.append("</DEP_DataExchangeData>");

				// 字符串拼接完成，开始调用接口 wgq_01 mario8023
//				System.out.println(wgqxml);
				com.wgqservice.Service1Soap12Stub binding;
				try {
					binding = (com.wgqservice.Service1Soap12Stub) new com.wgqservice.Service1Locator()
							.getService1Soap12();
					String value = null;
					value = binding.intergrade("", username, password,
							wgqxml.toString());
					System.out.println(value);
				} catch (javax.xml.rpc.ServiceException jre) {
					if (jre.getLinkedCause() != null)
						jre.getLinkedCause().printStackTrace();
					throw new junit.framework.AssertionFailedError(
							"JAX-RPC ServiceException caught: " + jre);
				} catch (RemoteException e) {
					// TODO Auto-generated catch block
					e.getMessage();
				}
			}
		}
	}
}
