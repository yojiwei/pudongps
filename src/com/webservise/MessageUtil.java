package com.webservise;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
import com.util.ReadProperty;

/**
 * TODO 取得某一部门一个时间段内的信息发布的信息，返回给调用的部门。
 * <p>
 * gwba
 * com.webservice
 * MessageUtil.java
 * </p>
 *@author yo 2009-10-28
 *@vision
*/
public class MessageUtil {
	public static void main(String[] args){
		//查询的测试字符串
		String fileStr = "<?xml version=\"1.0\" encoding=\"GBK\"?><DEP_DataExchangeData><OperationType>LBOA</OperationType><MessageTitle>标题</MessageTitle><MessageID>11</MessageID><MessageBody><queryParam><queryDeptcode>XB0</queryDeptcode><startTime>2009-06-20</startTime><endTime>2009-06-30</endTime><queryNum>1</queryNum></queryParam><recallParam><![CDATA[]]></recallParam></MessageBody></DEP_DataExchangeData>";
		MessageUtil util = new MessageUtil();
		System.out.println("--- "+util.getInfoopenList(fileStr));
		System.out.println("--is over --");
		//util.UpdateInfoStatus(fileStr);
		
	}
	public ReadProperty pro = null;
	/**
	 * 构造函数
	 * messageAttach 查询信息附件存放路径
	 * messageBak 备份信息存放路径
	 */
	public MessageUtil(){
		pro = new ReadProperty();
	}
	/**
	 * Description: 解析xml，取得查询条件后将结果集打包成xml返回给调用者；
	 * @param fileStr 待解析的xml文字字符串
	 * @return 打包成xml的依申请公开信息
	 */
	public  String getInfoopenList(String fileStr){
		String rtnStr = "";
		
		//模板文件的地址
		String filePath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "messagesearch.xml";
		
		//查询条件
		String[] queryParam = new String[4];//1、部门CODE 2、开始查询时间 3、结束查询时间 4、页数（默认为1）
		
		//查询结果集
		Vector xmlVec = null;
		
		//得到根元素
		Element root = initEle(fileStr);
		
		//得到解析对比的模板元素
		Element templateEle = initEle(getTemplateEle(filePath));
		
		StringBuffer errorStr = new StringBuffer("");
		if(root != null){
			
			//验证传过来的查询条件格式是否有效
			errorStr = checkXml(root,templateEle,errorStr);
			
			//调用格式正确，进行数据库验证
			if("".equals(errorStr.toString())){
				queryParam = getQueryParam(root);
				//根据查询条件取得相应记录
				xmlVec = getMessages(queryParam);
				if(xmlVec == null){
					errorStr.append("errorcode:1,没有代号为：" + queryParam[0] + "的部门在时间 " + queryParam[1] + " 到 " + queryParam[2] + "间的数据。");
					rtnStr = errorStr.toString();
				}else{	//拼装返回的xml
					rtnStr = parseMessageList(xmlVec,root,queryParam[1],queryParam[2]);
				}
			}else{
				rtnStr = errorStr.toString();
			}
		}else{
			rtnStr = "errorcode:2,xml格式不能解析。";
		}
		//CFile.write("D:/bsshs/4-gwbamessage.xml",rtnStr.toString());
		return rtnStr;
	}
	
	/**
	 * Description：得到文件的字符串
	 * 
	 * @param 文件路径
	 * @return 模板的字符串
	 */
	private String getTemplateEle(String filepath) {
		StringBuffer source = new StringBuffer("");
		BufferedReader reader = null;
		try {
			reader = CFile.read(filepath);
			while (reader.ready()) {
				source.append(new String(reader.readLine().getBytes("GBK"),
						"GBK"));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err
					.println("ParseBeianXml:getTemplateEle " + e.getMessage());
		}
		return source.toString();
	}
	
	/**
	 * Description：根据模板检查传入的xml格式是否有错误
	 * @param rootEle待检查的xml
	 * @param templateEle模板xml
	 * @param rtnStr错误描述
	 * @return 整合在一起的错误描述
	 */
	private StringBuffer checkXml(Element rootEle, Element templateEle,
			StringBuffer rtnStr) {
		List childList = null;
		Element child = null;
		String eleName = ""; // 元素名
		String eleValue = ""; // 元素值
		String compareValue = ""; // 比较值
		String compareTo = ""; // 显示值
		String parentName = ""; // 父元素名
		String parentValue = ""; // 父元素值
		String parentCompareTo = ""; // 父元素选择值
		Element tempEle = null; // 模板元素
		Element parentEle = null; // 父元素
		String notnull = ""; // 是否为空属性
		String regEx = ""; // 正则匹配值

		// 待检查元素是否有效
		if (rootEle != null) {
			childList = rootEle.getChildren();
			if (childList != null) {
				// 遍历整个xml的子元素
				for (int cnt = 0; cnt < childList.size(); cnt++) {
					child = (Element) childList.get(cnt);
					// 如果子元素还有子节点，循环调用
					if (child.hasChildren()) {
						checkXml(child, templateEle, rtnStr);
					} else {
						eleName = child.getName();
						eleValue = child.getTextTrim();
						
						tempEle = templateEle.getChild(eleName);
						if (tempEle != null) {
							
							compareTo = CTools.dealNull(tempEle
									.getAttributeValue("COMPARETO"));
							notnull = CTools.dealNull(tempEle
									.getAttributeValue("NOTNULL"));
							compareValue = CTools.dealNull(tempEle
									.getAttributeValue("COMPAREVALUE"));
							parentName = CTools.dealNull(tempEle
									.getAttributeValue("PARENTNAME"));
							regEx = CTools.dealNull(tempEle
									.getAttributeValue("REGEX"));

							// 验证正则表达是否正确
							if (!"".equals(regEx) && !"".equals(eleValue)) {
								if (!checkRegex(eleValue, regEx)) {
									if ("".equals(rtnStr.toString()))
										rtnStr.append("errorcode:2,xml格式错误。");
									rtnStr.append(eleName);
									rtnStr.append("节点格式错误,");
								}
							}

							// 根据父元素的值判断子元素的赋值情况
							if (!"".equals(parentName)) {
								parentEle = (Element) rootEle
										.getChild(parentName);
								if (parentEle != null) {
									parentValue = parentEle.getTextTrim();

									// 判断比较值是否与父元素的值一致，或父元素要求非空
									if (compareValue.equals(parentValue)
											|| ("".equals(compareValue) && !""
													.equals(parentValue))) {
										parentCompareTo = CTools
												.dealNull(templateEle.getChild(
														parentName)
														.getAttributeValue(
																"COMPARETO"));
										if ("Y".equals(notnull)
												&& "".equals(eleValue)) {
											if ("".equals(rtnStr.toString()))
												rtnStr
														.append("errorcode:2,xml格式错误。");
											rtnStr.append(eleName);
											rtnStr.append("节点错误:");
											rtnStr.append(compareTo);
											if (!"".equals(parentCompareTo)) {
												if ("".equals(compareValue))
													rtnStr.append("在"
															+ parentCompareTo
															+ "不为空时，");
												else
													rtnStr.append("在"
															+ parentCompareTo
															+ "选择为 "
															+ compareValue
															+ " 时，");
											}
											rtnStr.append("不能为空；");
										}
									}
								}
							} else { // 没有父元素的情况
								if ("Y".equals(notnull) && "".equals(eleValue)) {
									
									if ("".equals(rtnStr.toString()))
										rtnStr.append("errorcode:2,xml格式错误。");
									rtnStr.append(eleName);
									rtnStr.append("节点错误:");
									rtnStr.append(compareTo);
									rtnStr.append("不能为空；");
								}
							}
						}
					}
				}
			}
		}
		return rtnStr;
	}
	
	/**
	 * Description：验证传入的字符串与正则表达式是否匹配
	 * @param value 要验证的字符串
	 * @param regEx 正则表达式
	 * @return 正确返回true，否则返回false
	 */
	private boolean checkRegex(String value, String regEx) {
		Pattern p = Pattern.compile(regEx); // 生成一个prttern对象
		Matcher m = p.matcher(value); // 去掉正则以内的字符串
		String s = m.replaceAll(""); // 去掉空格
		return "".equals(s) ? true : false;
	}
	
	/**
	 * Description：初始化变量
	 * @param fileStr 一段xml的字符串
	 */
	private static Element initEle(String fileStr) {
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try {
			sb = new SAXBuilder();
			InputStream inputStream = new ByteArrayInputStream(fileStr
					.getBytes("GBK"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
			
		} catch (UnsupportedEncodingException ex) {
			System.err.println("ParseInfoopen：initEle XML编码错误:UnsupportedEncodingException "
					+ ex.getMessage());
		} catch (JDOMException ex) {
			System.err.println("ParseInfoopen：initEle XML解析错误:JDOMException "
					+ ex.getMessage());
		}
		return element;
	}
	/**
	 * 得到某时间段的信息集合
	 * @param queryParam
	 * @return
	 */
	private Vector getMessages(String[] queryParam){
		Vector vec = null;
		//1、dtcode部门CODE 2、startTime开始查询时间 3、endTime结束查询时间 4、num页数（默认为1｜每页显示条数为50条）
		String dtcode = queryParam[0];
		String startTime = queryParam[1];
		String endTime = queryParam[2];
		String num = queryParam[3];
		int numa = Integer.parseInt(num);
		
		String strSql = "";
		
		CDataCn dCn = null;
		CDataImpl dImpl= null;
		//开始时间、结束时间都为空时，查询当天的依申请公开信息
		strSql = "select decode(m.cm_type,'1','add','2','update','3','delete') as operater,c.ct_id as id,c.ct_id as formid,c.ct_specialflag as special,c.CT_url as link,c.ct_title as title,c.sj_id as subjectid,d.ct_content as content,c.dt_name as sendunit,c.in_filenum as filecode,c.in_catchnum as ndex,c.in_gongkaitype as publish,c.in_carriertype as carrier,c.in_infotype as annal,m.sj_id as subjectcode,c.CT_source as source,c.ct_memo as describe,c.CT_keywords as key,m.cm_dtcode as deptcode,c.in_draft as importantflag from tb_content c,tb_contentmessage m,tb_contentdetail d where  c.ct_id = m.ct_id and m.ct_id = d.ct_id  ";
		if(!"".equals(startTime)){
		 	strSql=strSql + " and  m.cm_inserttime >= TO_DATE('"+ startTime +"','YYYY-MM-DD')";
		 }
		 if(!"".equals(endTime)){
		 	strSql=strSql + " and  m.cm_inserttime <= TO_DATE('"+ endTime +"','YYYY-MM-DD')";
		 }
		 if(!"".equals(dtcode)){
			 strSql += " and m.cm_dtcode ='"+dtcode+"'";
		 }
		 strSql += " and c.in_gongkaitype=0  order by c.ct_id";
		System.out.println("strsql ====== " + strSql);
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(strSql,50,numa);//numa页数
		}catch(Exception e){
			System.out.println("getInfoopen : " + e.getMessage());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return vec;
	}
	
	/**
	 * Description：得到调用者的查询条件
	 * @param root 待解析的xml元素
	 * @return 查询条件的字符串数组
	 */
	private String[] getQueryParam(Element root){
		String[] queryParam = new String[4];
		Element element  = null;
		
		//查询部门代号
		element = root.getChild("MessageBody").getChild("queryParam").getChild("queryDeptcode");
		if(element != null)
			queryParam[0] = element.getTextTrim();
		
		//查询的开始日期
		element = root.getChild("MessageBody").getChild("queryParam").getChild("startTime");
		if(element != null)
			queryParam[1] = element.getTextTrim();
		
		//查询的结束时间
		element = root.getChild("MessageBody").getChild("queryParam").getChild("endTime");
		if(element != null)
			queryParam[2] = element.getTextTrim();
		
		//显示的页数（默认为1、每页显示条数为50条）
		element = root.getChild("MessageBody").getChild("queryParam").getChild("queryNum");
		if(element != null)
			queryParam[3] = element.getTextTrim();
		
		return queryParam;
	}
	
	/**
	 * Description：拼装xml
	 * @param vec 查询出的结果集
	 * @param root xml根元素
	 * @return 返回给调用者的xml字符串
	 */
	private String parseMessageList(Vector vec,Element root,String stratTime,String endTime){
		StringBuffer targetStr = new StringBuffer("");
		Hashtable table = null;
		
		//		模板文件的地址
		String filePath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "messagelist.xml";
		Element templateroot = initEle(getTemplateEle(filePath));
		Element templateEle = null;
		if(templateroot != null)
			templateEle = templateroot.getChild("MessageBody").getChild("ROOT").getChild("DATASEND");
		String eleName = "";
		String lwoereleName = "";
		List list = templateEle.getChildren();
		Element child = null;
		targetStr.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		targetStr.append("<DEP_DataExchangeData>");
		targetStr.append("<OperationType>MESSAGELISTS</OperationType>");
		targetStr.append("<MessageTitle>返回查询结果</MessageTitle>");
		targetStr.append("<MessageID>001</MessageID>");
		
		//主体开始
		targetStr.append("<MessageBody>");
		targetStr.append("<ROOT>");
		
		for(int cnt = 0; cnt < vec.size(); cnt++){
			targetStr.append("<DATASEND>");
			table = (Hashtable) vec.get(cnt);
			for(int count = 0; count < list.size(); count++){
				child = (Element)list.get(count);
				eleName = child.getName();
				lwoereleName = eleName.toLowerCase();
				
				if("FILEPUBATTACH".equals(eleName)){
					targetStr.append(getAttachXml(CTools.dealNull(table.get("formid"))));
				}else if("STARTTIME".equals(eleName)){//开始时间
					targetStr.append("<" + eleName + ">");
					targetStr.append(stratTime);
					targetStr.append("</" + eleName + ">");
				}else if("ENDTIME".equals(eleName)){//结束时间
					targetStr.append("<" + eleName + ">");
					targetStr.append(endTime);
					targetStr.append("</" + eleName + ">");
				}else if("ID".equals(eleName)){//ID+栏目CODE
					targetStr.append("<" + eleName + ">");
					targetStr.append(CTools.dealNull(table.get("id"))+CTools.dealNull(table.get("subjectcode")));
					targetStr.append("</" + eleName + ">");
				}else if("INDEX".equals(eleName)){//索取号
					targetStr.append("<" + eleName + ">");
					targetStr.append(CTools.dealNull(table.get("ndex")));
					targetStr.append("</" + eleName + ">");
				}else if("TITLE".equals(eleName)){//标题
					targetStr.append("<" + eleName + ">");
					targetStr.append("<![CDATA[");
					targetStr.append(CTools.dealNull(table.get(lwoereleName)));
					targetStr.append("]]>");
					targetStr.append("</" + eleName + ">");
				}else if("CONTENT".equals(eleName)){//内容
					targetStr.append("<" + eleName + ">");
					targetStr.append("<![CDATA[");
					targetStr.append(CTools.dealNull(table.get(lwoereleName)));
					targetStr.append("]]>");
					targetStr.append("</" + eleName + ">");
				}else{
					targetStr.append("<" + eleName + ">");
					targetStr.append(CTools.dealNull(table.get(lwoereleName)));
					targetStr.append("</" + eleName + ">");
				}
			}
			targetStr.append("</DATASEND>");
		}
		//主体结束
		targetStr.append("</ROOT>");
		targetStr.append("</MessageBody>");
		//其他
		targetStr.append("<SourceUnitCode>216</SourceUnitCode>");
		targetStr.append("<SourceCaseCode>330</SourceCaseCode>");
		targetStr.append("<DestUnit>");
		targetStr.append("<DestUnitCode>216</DestUnitCode>");
		targetStr.append("<DestCaseCode>304</DestCaseCode>");
		targetStr.append("<InterFaceCode>200</InterFaceCode>");
		targetStr.append("</DestUnit>");
		targetStr.append("<Sender>公文备案数据</Sender>");
		targetStr.append("<SendTime>"+CDate.getThisday()+"</SendTime>");
		targetStr.append("<EndTime>"+CDate.getNowTime()+"</EndTime>");
		  
		//通过中台调用接收接口的必须元素；
		targetStr.append(getRecallStr(root));
		targetStr.append("</DEP_DataExchangeData>");
		
		//生成备份文件以备查询
		String ctoday = CDate.getThisday();
		int cnumeral = 0;
		cnumeral = (int)(Math.random()*1000000); 
		String cwa_path = ctoday + Integer.toString(cnumeral);//日期+随机
		cwa_path = cwa_path.replaceAll("-","");
		String messagebak = pro.getPropertyValue("messageBak");
		
		return targetStr.toString();
	}
	/**
	 * 获得信息的附件XML
	 * @param ct_id
	 * @return
	 */
	private StringBuffer getAttachXml(String ct_id){
		StringBuffer target = new StringBuffer("");
		String sql = "select pa_path,pa_filename,pa_name from tb_publishattach where ct_id = '"+ ct_id +"'";
		//System.out.println("attach sql = " + sql);
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Vector vec = null;
		Hashtable table = null;
		String filePath = "";
		String fileStr = "";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			filePath = pro.getPropertyValue("messageAttach");
			//filePath = "D:\\gwba\\WebRoot\\attach\\infoattach\\";
			vec = dImpl.splitPage(sql,100,1);
			if(vec != null){
				target.append("<FILEPUBATTACH>");
				for(int cnt = 0; cnt < vec.size(); cnt++){
					table = (Hashtable) vec.get(cnt);
					target.append("<PUBATTACH>");
					
					//附件名
					target.append("<FILENAME>");
					target.append(CTools.dealNull(table.get("pa_filename")));
					target.append("</FILENAME>");
					
					//附件名
					target.append("<FILEREALNAME>");
					target.append(CTools.dealNull(table.get("pa_name")));
					target.append("</FILEREALNAME>");
					
					//附件 base64 编码以后的字符串
					target.append("<FILECONTENT>");
					filePath = filePath + "\\" + CTools.dealNull(table.get("pa_path")) + "\\" + CTools.dealNull(table.get("pa_filename"));
					fileStr = CBase64.getFileEncodeString(filePath);
					target.append(fileStr);
					target.append("</FILECONTENT>");
					
					target.append("</PUBATTACH>");
				}
				target.append("</FILEPUBATTACH>");
			}else
				target.append("<FILEPUBATTACH/>");
		}catch(Exception e){
			System.out.println("getAttachXml: " + e.getMessage());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return target;
	}
	
	/**
	 * Description：通过中台调用接收接口需要的元素
	 * @param root xml根元素
	 * @return 通过中台调用接收接口需要的元素
	 */
	private String getRecallStr(Element root){
		String rtnStr = "";
		Element recall = root.getChild("MessageBody").getChild("recallParam");
		if(recall != null)
			rtnStr = recall.getTextTrim();
		return rtnStr;
	}
}
