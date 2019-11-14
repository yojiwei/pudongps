/*
 * Created on 2004-12-10
 *
 */
package com.beyondbit.soft2.onlinework;

import java.io.IOException;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.Text;
import org.w3c.dom.traversal.DocumentTraversal;
import org.w3c.dom.traversal.NodeFilter;
import org.w3c.dom.traversal.TreeWalker;

import com.beyondbit.soft2.utils.XMLUtil;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.jspsmart.upload.File;
import com.util.CDate;
import com.util.CTools;
import com.website.User;

/**
 * @author along
 *
 * 本Servlet适用于通用表单提交，对表单要求如下：
 * 1、表单中form属性应包含 enctype="multipart/form-data"
 * 2、表单中的元素名称应与XML模板中的定义严格一致
 * 
 */
public class OnlineWorkSubmitServlet extends HttpServlet {
	
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 使用于通用表单提交
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException,
			IOException {
		
		javax.servlet.jsp.PageContext pageContext = javax.servlet.jsp.
		JspFactory.getDefaultFactory().getPageContext(this, request,
				response, null, true, 8192, true);
		com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.
		SmartUpload();
		myUpload.initialize(pageContext);
		
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		
		Document doc = null;
		
		try {
			// 设置上传文件后缀限制
			myUpload.setDeniedFilesList("exe,bat,jsp"); 
			myUpload.upload();
			
			String pr_id = CTools.dealUploadString(myUpload.getRequest().
					getParameter("pr_id")).trim();
			String wo_id = CTools.dealUploadString(myUpload.getRequest().
                    getParameter("wo_id")).trim();
			String ow_id = CTools.dealUploadString(myUpload.getRequest().
					getParameter("ow_id")).trim();
			String owt1_id = CTools.dealUploadString(myUpload.getRequest().
					getParameter("owt1_id")).trim();
			String pr_name = CTools.dealUploadString(myUpload.getRequest().
					getParameter("pr_name")).trim();
			String ow_attpath = CTools.dealUploadString(myUpload.getRequest().
					getParameter("ow_attpath")).trim();
			
			User user = (User) (request.getSession().getAttribute("user"));
			
			/**
			 * 判断用户是否登录
			 */
			if (user == null) { 
				dImpl.closeStmt();
				dCn.closeCn();
				
				response.sendRedirect("/website/login/Login.jsp?oPage=/website/onlinework/wsb.jsp?pr_id=" +	pr_id + "&ow_id=" + ow_id + "&owt1_id=" + owt1_id +	"&pr_name=" + pr_name);
			}
			String us_id = user.getId();

			dCn.beginTrans();
			
			/**
			 * 获取XML模板
			 */
			String xmlTemplate = null;
			String needExchange = null;
			Hashtable xmlTemplateHashtable = dImpl.getDataInfo("select owt1_xml, owt1_needexchange from tb_onlineworkxmltype where pr_id='" + pr_id + "'");
			if(xmlTemplateHashtable != null){
				xmlTemplate = xmlTemplateHashtable.get("owt1_xml").toString();
				needExchange = xmlTemplateHashtable.get("owt1_needexchange").toString();
			}
			
			/**
			 * Tree Walker
			 */
			doc = XMLUtil.string2Doc(xmlTemplate);
			
			if(doc == null)System.out.println("null");
			DOMImplementation domimpl = doc.getImplementation();
			if (domimpl.hasFeature("Traversal", "2.0")) {
				
				Node root = doc.getDocumentElement();
				int whattoshow = NodeFilter.SHOW_ALL;
				NodeFilter nodefilter = null; 
				boolean expandreferences = false;
				
				DocumentTraversal traversal = (DocumentTraversal)doc;
				
				TreeWalker walker = traversal.createTreeWalker(root, whattoshow, nodefilter, expandreferences);
				Node thisNode = null;
				thisNode = walker.nextNode();
				while (thisNode != null) {
					String nodeName = thisNode.getNodeName();
					if (thisNode.getNodeType() == Node.ELEMENT_NODE) {
						Element thisElement = (Element)thisNode;
						NamedNodeMap attributes = thisElement.getAttributes();
						
						HashMap attrMap = new HashMap();
						for (int i = 0; i < attributes.getLength(); i++) {
							attrMap.put(attributes.item(i).getNodeName(), attributes.item(i).getNodeValue());
						}
						int occurnum = Integer.parseInt(attrMap.get("occurnum").toString());
						Set keySet = attrMap.keySet();
						Iterator iterator = keySet.iterator();
						
						String checkLenField = null;
						
						/**
						 * occurnum == -1 表示该节点的个数不定
						 */
						if (occurnum == -1 && !nodeName.equals("attachment")) {
							int len = 0;
							while(iterator.hasNext()){
								String fieldName = iterator.next().toString();
								if (!fieldName.equals("occurnum")) {
									attrMap.put(fieldName, myUpload.getRequest().getParameterValues(fieldName));
									len = myUpload.getRequest().getParameterValues(fieldName).length;
								}
							}
							
							iterator = keySet.iterator();
							for (int i = 0; i < len; i++) {
								if (i == 0) {
									while (iterator.hasNext()) {
										String fieldName = (String) iterator.next();
										if (!fieldName.equals("occurnum")) {
											String [] fieldValues = (String [])attrMap.get(fieldName);
											attributes.getNamedItem(fieldName).setNodeValue(fieldValues[i]);
										}
									}
								}
								else {
									Element tempElement = (Element)thisNode.cloneNode(true);
									attributes = tempElement.getAttributes();
									while (iterator.hasNext()) {
										String fieldName = (String) iterator.next();
										if (!fieldName.equals("occurnum")) {
											String [] fieldValues = (String [])attrMap.get(fieldName);
											attributes.getNamedItem(fieldName).setNodeValue(fieldValues[i]);
										}
									}
									thisNode.getParentNode().appendChild(tempElement);
									thisNode = tempElement;
								}
								iterator = keySet.iterator();
							}
						}
						/**
						 * attachment 节点较特殊, 附件内容放在该节点的text节点内
						 */
						else if(occurnum == -1 && nodeName.equals("attachment")){
							String [] fjsm = myUpload.getRequest().getParameterValues("fjsm");
							if (fjsm != null) {
								for (int i = 0; i < fjsm.length; i++) {
				                    String filename = myUpload.getFiles().getFile(i).getFileName().trim();
				                    File file = myUpload.getFiles().getFile(i);
				                    int contentsize = file.getSize();
				                    
				                    byte[] fileArray = new byte[contentsize];
				                    for (int j = 0; j < contentsize; j++) {
				                        fileArray[j] = file.getBinaryData(j);
				                    }

				                    String contenttype = file.getFileExt();


				                    byte[] base64Array = new org.apache.commons.codec.binary.
				                        Base64().
				                        encode(fileArray);
				                    
				                    if(i == 0){
				                    	/**
				                    	 * 以下几个属性是固定的
				                    	 * filename 附件文件名
				                    	 * contentsize 附件大小
				                    	 * contenttype 附件文件扩展名
				                    	 * fjsm 附件说明
				                    	 */
				                    	attributes.getNamedItem("filename").setNodeValue(filename);
				                    	attributes.getNamedItem("contentsize").setNodeValue(String.valueOf(contentsize));
				                    	attributes.getNamedItem("contenttype").setNodeValue(contenttype);
				                    	attributes.getNamedItem("fjsm").setNodeValue(fjsm[i]);
				                    	((Text)(thisNode.getChildNodes().item(0))).setData(new String(base64Array));
				                    }
				                    else {
				                    	Element tempElement = (Element)thisNode.cloneNode(true);
										attributes = tempElement.getAttributes();
										attributes.getNamedItem("filename").setNodeValue(filename);
				                    	attributes.getNamedItem("contentsize").setNodeValue(String.valueOf(contentsize));
				                    	attributes.getNamedItem("contenttype").setNodeValue(contenttype);
				                    	attributes.getNamedItem("fjsm").setNodeValue(fjsm[i]);
				                    	((Text)(tempElement.getChildNodes().item(0))).setData(new String(base64Array));
				                    	thisNode.getParentNode().appendChild(tempElement);
										thisNode = tempElement;
				                    }
				                }
							}
							/**
							 * 如果request中没有传值，表示没有附件，删除附件节点
							 */
							else {
								thisNode.getParentNode().removeChild(thisNode);
							}
						}
						/**
						 * occurnum == 1 表示该节点的个数为1
						 */
						else if(occurnum == 1){
							while (iterator.hasNext()) {
								String fieldName = (String) iterator.next();
								if (!fieldName.equals("occurnum")) {
									attributes.getNamedItem(fieldName).setNodeValue(CTools.dealUploadString(myUpload.getRequest().getParameter(fieldName)).trim());
								}
							}
						}
					}
					/**
					 * 处理特殊的text节点，该节点内容与父节点的值关联
					 */
					else if (thisNode.getNodeType() == Node.TEXT_NODE) {
						String parentNodeName = thisNode.getParentNode().getNodeName();
						if(!parentNodeName.equals("attachment")) thisNode.setNodeValue(CTools.dealUploadString(myUpload.getRequest().getParameter(parentNodeName)).trim());
					}
					
					walker.setCurrentNode(thisNode);
					thisNode = walker.nextNode();
				}
				
			} else {
				System.out.println("不支持DOM遍历！");
			}
			
			String ow_content = XMLUtil.doc2String(doc);            

            if (ow_id == null || ow_id.equals("")) {
            	/**
            	 * 在tb_work表中新增一条记录
            	 */
                wo_id = dImpl.addNew("tb_work", "wo_id",
                                     CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                dImpl.setValue("pr_id", pr_id, CDataImpl.STRING);
                dImpl.setValue("wo_applyPeople", user.getUserName(),
                               CDataImpl.STRING);
                dImpl.setValue("wo_contactpeople", user.getUserName(),
                               CDataImpl.STRING);
                dImpl.setValue("wo_tel", user.getTel(), CDataImpl.STRING);
                dImpl.setValue("us_id", us_id, CDataImpl.STRING);
                dImpl.setValue("wo_postcode", user.getZip(), CDataImpl.STRING);
                dImpl.setValue("wo_projectname", pr_name, CDataImpl.STRING);
                dImpl.setValue("wo_address", user.getAddress(),
                               CDataImpl.STRING);
                dImpl.setValue("wo_idcard", user.getIdCardNumber(),
                               CDataImpl.STRING);
                dImpl.setValue("WO_STATUS", "1", CDataImpl.STRING); //项目状态
                dImpl.setValue("WO_ISSTAT", "0", CDataImpl.STRING); //项目是否统计过
                dImpl.setValue("WO_APPLYTIME", new CDate().getNowTime(),
                               CDataImpl.DATE); //项目的申请时间
                dImpl.update();
                
                /**
                 * 在tb_onlinework表中新增一条记录
                 */
                ow_id = dImpl.addNew("tb_onlinework", "ow_id",
                                     CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                dImpl.setValue("wo_id", wo_id, CDataImpl.STRING);
                dImpl.setValue("ow_content", ow_content, CDataImpl.SLONG);
                dImpl.setValue("owt1_id", owt1_id, CDataImpl.STRING);
                dImpl.setValue("ow_attpath", ow_attpath, CDataImpl.STRING);
                dImpl.update();
                
                /**
                 * 是否需要交换, 是则在tb_owexch表中新增一条记录
                 */
                if (needExchange.equals("1")) {
                	ow_id = dImpl.addNew("tb_owexch", "oe_id",
                			CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                	dImpl.setValue("wo_id", wo_id, CDataImpl.STRING);
                	dImpl.setValue("oe_status", "0", CDataImpl.INT);
                	dImpl.update();
                }
            }
            else{
                
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", "1", CDataImpl.STRING);
                dImpl.update();
                
                dImpl.edit("tb_onlinework", "ow_id", ow_id);
                dImpl.setValue("ow_content", ow_content, CDataImpl.SLONG);
                dImpl.setValue("ow_attpath", ow_attpath, CDataImpl.STRING);
                dImpl.update();
                
                /**
                 * 是否需要交换, 是则在tb_owexch表中新增一条记录
                 */
                if (needExchange.equals("1")) {
                	ow_id = dImpl.addNew("tb_owexch", "oe_id",
                			CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                	dImpl.setValue("wo_id", wo_id, CDataImpl.STRING);
                	dImpl.setValue("oe_status", "0", CDataImpl.INT);
                	dImpl.update();
                }
            }
            dCn.commitTrans();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.print("Problem parsing the file.");
		}
		
		
		dImpl.closeStmt();
		dCn.closeCn();
		response.sendRedirect("/website/usercenter/index.jsp");
		
	}
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException,
			IOException {
		this.doPost(request, response);
	}
	
	public void test(){
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		//String xmlTemplate = null;
		
//		String xmlTemplate = "<?xml version=\"1.0\" encoding=\"gb2312\"?><因公出国或赴港澳任务申请表><组团信息 cfrw=\"出访任务：\" cfts_b=\"12\" lwdw=\"申报单位：\" pjlx=\"批件类型：\" ztdw=\"组团单位：\" ztdwdm=\"1212\" ztname=\"团组名：\" ztnum_b=\"12\" occurnum=\"1\"/><出访地点 occurnum=\"0\"><地点 dddate=\"2004-12-1\" gjname=\"出访地点1\" guojing=\"是\" leftdate=\"2004-12-2\" tlsj=\"12\" xuhao=\"1\" yqzhong=\"邀请方1\" occurnum=\"-1\"/></出访地点><人员组成 occurnum=\"0\"><人员 csdate=\"2004-12-1\" gzdw=\"234234\" idcard=\"12213\" name=\"姓名1\" nzc=\"3453\" nzw=\"2342342\" recordnum=\"1\" xb=\"男\" occurnum=\"-1\"/></人员组成><出访费用 byj=\"feeB,feeD,\" gjlf=\"feeA,feeC,\" gzf=\"feeB,feeD,\" lyj=\"feeA,feeB,feeC,feeD,\" qt=\"feeA,feeB,feeC,feeD,\" sif=\"feeA,feeB,feeC,feeD,\" suf=\"feeA,feeC,\" occurnum=\"1\"/><出访团组详细情况 occurnum=\"0\"><visitObjectRelation occurnum=\"0\">visitObjectRelation</visitObjectRelation><visitojectQuestion occurnum=\"0\">visitojectQuestion</visitojectQuestion><visitObjectReason occurnum=\"0\">visitObjectCalendar</visitObjectReason><visitObjectCalendar occurnum=\"0\">visitObjectCalendar</visitObjectCalendar><personStructTask occurnum=\"0\">personStructTask</personStructTask><personStructExplain occurnum=\"0\">personStructExplain</personStructExplain><personStructReason occurnum=\"0\">personStructReason</personStructReason><personTwoAccess occurnum=\"0\">personTwoAccess</personTwoAccess><Other occurnum=\"0\">Other</Other></出访团组详细情况><attachment contentsize=\"54784\" contenttype=\"doc\" filename=\"along.doc\" fjsm=\"along\" occurnum=\"-1\">attachment</attachment></因公出国或赴港澳任务申请表>";
//		dImpl.edit("tb_onlineworkxmltype", "owt1_id", "o1");
//		dImpl.setValue("owt1_xml", xmlTemplate, CDataImpl.SLONG);
//		dImpl.update();
//		
//		Hashtable xmlTemplateHashtable = dImpl.getDataInfo("select owt1_xml from tb_onlineworkxmltype where pr_id='o1211'");
//		if(xmlTemplateHashtable != null){
//			xmlTemplate = xmlTemplateHashtable.get("owt1_xml").toString();
//		}
//		
//		Document doc = XMLUtil.string2Doc(xmlTemplate);
//		
//		if(doc == null)System.out.println("null");
//		DOMImplementation domimpl = doc.getImplementation();
//		if (domimpl.hasFeature("Traversal", "2.0")) {
//			
//			Node root = doc.getDocumentElement();
//			int whattoshow = NodeFilter.SHOW_ALL;
//			NodeFilter nodefilter = null; 
//			boolean expandreferences = false;
//			
//			DocumentTraversal traversal = (DocumentTraversal)doc;
//			
//			TreeWalker walker = traversal.createTreeWalker(root, 
//					whattoshow, 
//					nodefilter, 
//					expandreferences);
//			Node thisNode = null;
//			thisNode = walker.nextNode();
//			while (thisNode != null) {
//				if (thisNode.getNodeType() == Node.ELEMENT_NODE) {
//					System.out.print(thisNode.getNodeName() + " ");
//					Element thisElement = (Element)thisNode;
//					NamedNodeMap attributes = thisElement.getAttributes();
//					System.out.print("(");
//					for (int i = 0; i < attributes.getLength(); i++) {
//						System.out.print(attributes.item(i).getNodeName() + "=\"" +
//								attributes.item(i).getNodeValue() + "\" ");
//					}
//					System.out.print(") : ");
//				} else if (thisNode.getNodeType() == Node.TEXT_NODE) {
//					thisNode.setNodeValue("changed");
//					System.out.println(thisNode.getNodeValue());
//					String parentNodeName = thisNode.getParentNode().getNodeName();
//					thisNode.setNodeValue("changed");
//				}
//				thisNode = walker.nextNode();
//			}
//			
//		} else {
//			System.out.println("The Traversal module isn't supported.");
//		}
		
//		System.out.println(xmlTemplate);
		dImpl.closeStmt();
		dCn.closeCn();
	}
	
	public static void main(String [] args){
		OnlineWorkSubmitServlet t = new OnlineWorkSubmitServlet();
		t.test();
	}
}
