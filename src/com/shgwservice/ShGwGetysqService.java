package com.shgwservice;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.TimerTask;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.rpc.ParameterMode;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CRandom;
import com.util.CTools;
import com.webservise.WebserviceReadProperty;

/**
 * 调用上海市公文备案依申请公开接口获取待办申请列表
 * http://10.81.96.38:8080/services/ApplyOpenExportService
 * @author yaojiwei
 *
 */
public class ShGwGetysqService  extends TimerTask{ 
	/**
	 * 执行监听的方法
	 */
	public void run(){
		getShYsqList();
	}
	/**
	 * 
	 * @param args
	 */
//	  public static void main( String[] args ) throws Exception
//	  {
//
//	    String userAccount = "pdxqzf";
//	    String reback = "";
//	    Service service = new Service();
//	    Call call = ( Call ) service.createCall();
//
//	    //设置访问点
//	    call.setTargetEndpointAddress( "http://10.81.96.38:8080/services/ApplyOpenExportService" );
//
//	    //设置操作名
//	    call.setOperationName( "exportApplyList" );//导出申请信息列表
//
//	    //设置入口参数
//	    call.addParameter( "userAccount", XMLType.XSD_STRING, ParameterMode.IN );
//	    call.setReturnType( XMLType.XSD_STRING );
//
//	    //调用服务
//	    reback =  (String)call.invoke( new Object[] {userAccount} ) ;
//	    System.out.println("reback==="+reback);
//	    CFile.write("D:\\gwba\\shysq\\govsaab1.xml","reback-------------->" + reback);
//		
//	}
	  
//	public static void main(String[] args) throws Exception{
//		//读取数据文件
//	    byte[] infoXmlByte = null;
//	    File file = new File("D:/gwba/shysq/govsaab.xml");
//	    FileInputStream fis = null;
//	    try{
//		    fis = new FileInputStream(file);
//		    int byte_size = fis.available();
//		    infoXmlByte = new byte[byte_size];
//		    fis.read(infoXmlByte);
//	    }finally{
//	    	if(fis!=null) fis.close();
//	    }
//
//	    String infoXml = new String(infoXmlByte);
//	    ShGwGetysqService sgts = new ShGwGetysqService();
//	    sgts.getShYsqList(infoXml);
//	    System.out.println("----over----");
//	}
	
//	public static void main(String[] args) throws Exception{
//		ShGwGetysqService sgts = new ShGwGetysqService();
//	    sgts.getShYsqList();
//	    System.out.println("----over----");
//	}
	/**
	 * 调用获取申请列表方法 
	 */
	public String getShYsqList(){
		String reback = "";
		String userAccount = "pdxqzf";
		String rtnStr = "";
		String templateStr = "";
		try {
			 Service service = new Service();
			    Call call = ( Call ) service.createCall();

			    //设置访问点
			    call.setTargetEndpointAddress( "http://10.81.96.38:8080/services/ApplyOpenExportService" );

			    //设置操作名
			    call.setOperationName( "exportApplyList" );

			    //设置入口参数
			    call.addParameter( "userAccount", XMLType.XSD_STRING, ParameterMode.IN );
			    call.setReturnType( XMLType.XSD_STRING );
			    
			    //调用服务获取返回xmls
			    reback = (String)call.invoke( new Object[] {userAccount});
			    
			    
			    //插入依申请公开表
				String tempFile = System.getProperty("user.dir")
						+ System.getProperty("file.separator") + "GetShYsqTemplate.xml";
				
				
				templateStr = getTemplateEle(tempFile);
				Element templateEle = initEle(templateStr);
				if(!"".equals(reback)){
					rtnStr = parseXml(reback, templateEle);
				}
			    
			    
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
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
					.println("GetShYsqXml:getTemplateEle " + e.getMessage());
		}
		return source.toString();
	}
	
	/**
	 * Description:解析xml
	 * @param xmlStr xml源
	 * @param templateEle xml解析模板
	 * @return 错误信息
	 */
	private String parseXml(String xmlStr, Element templateEle) {

		// xml文件保存到本地的路径
		String filePath = "";

		// xml文件存在本地的文件名
		String fileName = "";

		// xml中Data元素的List
		List dataList = null;

		// xml中数据的节点
		Element ele = null;

		// xml保存是否成功
		boolean flag = false;
		
		// 初始化根元素
		Element rootEle = initEle(xmlStr);
		if(rootEle == null||rootEle.getChild("applyOpenInfo")==null)
			return "errorcode:0,XML格式不完整。";

		// 初始化错误返回值
		StringBuffer rtnStr = new StringBuffer("");

		// 将xml文件保存到本地
		filePath = createFileByDate("xmlsavepath");
		fileName = createRandomFileName(filePath,"xml");
		
		
		try {
			flag = CFile.write(fileName, new String(xmlStr.getBytes("GBK"),
					"GBK"));
		} catch (UnsupportedEncodingException e) {
			System.err.println("GetShYsqXml:xml文件保存出错："
					+ e.getMessage());
		}

		// 如果保存失败返回错误信息
		if (!flag) {
			rtnStr.append("errorcode:1,数据传输失败，请重新传输。");
			return rtnStr.toString();
		} else {
			//验证xml完整性
			rtnStr = checkXmlIsComplete(rootEle,templateEle);
			if (!"".equals(rtnStr.toString())) // 如果验证不合格，返回验证错误信息
				return rtnStr.toString();
			// 验证xml元素属性是否正确
			rtnStr = checkXml(rootEle.getChild("applyOpenInfo"), templateEle.getChild("APPLYOPENINFO"), rtnStr);
			
			if (!"".equals(rtnStr.toString())) // 如果验证不合格，返回验证错误信息
				return rtnStr.toString();
			else { // 验证合格,解析文件进行数据库插入操作
				if(rootEle!= null)
					dataList = rootEle.getChildren(
							"applyOpenInfo");
				else
					return rtnStr.toString();
				//模板
				templateEle = templateEle.getChild("APPLYOPENINFO");
				
				System.out.println(dataList.size());
				if (dataList != null) {
					for (int cnt = 0; cnt < dataList.size(); cnt++) {
						ele = (Element) dataList.get(cnt);
						rtnStr = rtnStr
								.append(dealWithElement(ele, templateEle));
					}
				}
				
			}
		}

		return rtnStr.toString();
	}
	
	
	/**
	 * Description:将xml信息插入数据库
	 * @param ele 待解析的xml文件
	 * @param templateEle
	 * @return 错误信息
	 */
	private String dealWithElement(Element ele, Element templateEle) {
		List children = ele.getChildren();
		Element child = null;

		StringBuffer rtnStr = new StringBuffer("");// 错误返回值
		String eleName = "";// 元素名
		String eleValue = "";// 元素值
		String columnName = "";// 元素在数据库对应的字段名名
		String applyNo = "";// 流水号
		String dt_code = "";// 部门代码
		String in_catchnum = "";// 公文流水号
		String primaryKey_old = "";// 公文原主键
		String subjectcode = "";//报送到门户网站的栏目代码
		String[] sjList = null;
		String sjNames = ""; //栏目名
		String opeType = ""; //操作类型

		List attachList = null;
		String fileName = "";
		String filePath = "";
		String fileExName = "";
		String fileStr = "";
		String paName = "";
		String[] deptAttr = null;
		String did = "";
		String dname = "";
		String proposer = "";
		String sqrtype = "";
		String applytime = "";
		String commentinfo = "";
		String id = ""; // 信息主键
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			dCn.beginTrans();
			if (children != null) {

				child = ele.getChild("applyNo");
				applyNo = child.getTextTrim();
				if (!"".equals(applyNo)) {
					if (hasIndexnum(applyNo)) { // 验证流水号
						if ("".equals(rtnStr.toString()))
							rtnStr.append("errorcode:3,数据错误。");
						rtnStr.append("ADD 流水号重复:"
								+ in_catchnum + ";");
						return rtnStr.toString();
					}
				}
				//插入infoopen
				id = String.valueOf(dImpl.addNew("infoopen", "id"));
				for (int cnt = 0; cnt < children.size(); cnt++) {
					child = (Element) children.get(cnt);
					eleName = child.getName();
					eleName = eleName.toUpperCase();
					eleValue = child.getTextTrim();
					
					columnName = templateEle.getChild(eleName) != null ? templateEle.getChild(eleName).getAttributeValue("COLUMNNAME"): "";
					
					if (!"".equals(eleValue) && !"".equals(columnName)) {
						
						
						dImpl.setValue(columnName, eleValue, CDataImpl.STRING);
						
						
						//申请人类型：公民、法人
						if("proposer".equals(columnName)){
							if(!"".equals(eleValue)){
								if("公民".equals(eleValue)){
									proposer = "0";
								}
								if("法人".equals(eleValue)){
									proposer = "1";
								}
							}
							dImpl.setValue("proposer", proposer, CDataImpl.STRING);
						}
						//申请人联系方式
						if("ptele".equals(columnName)){
							if(!"".equals(eleValue)){
								if("0".equals(proposer)){
									sqrtype = "ptele";//公民
								}
								if("1".equals(proposer)){
									sqrtype = "etele";//法人
								}
							}
							dImpl.setValue(sqrtype, eleValue, CDataImpl.STRING);
						}
						//获取信息的方式，选项：邮寄、当面领取、现场查阅、电子邮件
						if("gainmode".equals(columnName)){
							if(!"".equals(eleValue)){
								if("邮寄".equals(eleValue)){
									eleValue = "0";
								}
								if("当面领取".equals(eleValue)){
									eleValue = "4";
								}
								if("现场查阅".equals(eleValue)){
									eleValue = "5";
								}
								if("电子邮件".equals(eleValue)){
									eleValue = "2";
								}
							}
							dImpl.setValue("gainmode", eleValue, CDataImpl.STRING);
						}
						//信息的载体形式，选项：纸质文本、数据电文
						if("offermode".equals(columnName)){
							if(!"".equals(eleValue)){
								if("纸质文本".equals(eleValue)){
									eleValue = "0";
								}
								if("数据电文".equals(eleValue)){
									eleValue = "1";
								}
							}
							dImpl.setValue("offermode", eleValue, CDataImpl.STRING);
						}
						//申请方式，信函、门户网站、电子邮件、传真、当面、其他
						if("signmode".equals(columnName)){
							if(!"".equals(eleValue)){
								if("门户网站".equals(eleValue)){
									eleValue = "0";
								}
								if("当面".equals(eleValue)){
									eleValue = "1";
								}
								if("电子邮件".equals(eleValue)){
									eleValue = "2";
								}
								if("信函".equals(eleValue)){
									eleValue = "3";
								}
								if("传真".equals(eleValue)){
									eleValue = "5";
								}
								if("其他".equals(eleValue)){
									eleValue = "6";
								}
							}
							dImpl.setValue("signmode", eleValue, CDataImpl.STRING);
							
						}
						//受理单位名称
						if("did".equals(columnName)){
							
							if(!"".equals(eleValue)){
								did = queryDeptId(eleValue);
								dname = queryDeptName(eleValue);
							}
							dImpl.setValue("did", did, CDataImpl.STRING);
							dImpl.setValue("dname", dname, CDataImpl.STRING);
						}
						//日期保存
						if("applytime".equals(columnName)||"limittime".equals(columnName)){
							if("applytime".equals(columnName)){
								applytime = eleValue;
							}
							dImpl.setValue(columnName, eleValue, CDataImpl.DATE);
							if("limittime".equals(columnName)){
								dImpl.setValue("olimittime", eleValue, CDataImpl.DATE);
							}
						}
						//申请内容
						if("commentinfo".equals(columnName)){
							commentinfo = eleValue;
							if(!"".equals(commentinfo))
							{
								commentinfo = commentinfo.replace("&#13;", "");
							}
						}
						//待处理申请
						dImpl.setValue("status", "1", CDataImpl.STRING);
						dImpl.setValue("step", "2", CDataImpl.STRING);
					}
				}
				dImpl.update();
				
				//插入taskcenter
				if(!"".equals(id)){
					dImpl.addNew("taskcenter","id");
			   		dImpl.setValue("iid",id,CDataImpl.INT);
			   		dImpl.setValue("did",did,CDataImpl.INT);
			   		dImpl.setValue("dname",dname,CDataImpl.STRING);
			   		dImpl.setValue("starttime",applytime,CDataImpl.DATE);
			   		dImpl.setValue("endtime",applytime,CDataImpl.DATE);
			   		dImpl.setValue("commentinfo",commentinfo,CDataImpl.STRING);
			   		dImpl.setValue("status",0,CDataImpl.INT);
			   		dImpl.setValue("isovertime",0,CDataImpl.INT);
			   		dImpl.setValue("genre","网上申请",CDataImpl.STRING);
				   	dImpl.update();
				}
				

				//数据库操作---附件
				dImpl.executeUpdate("delete from tb_publishattach where io_id = '"+ id +"'");
				//附件保存路径
				WebserviceReadProperty pro = new WebserviceReadProperty();
				String xmlsavepath = pro.getPropertyValue("xmlattachpath");
				String fileRealPath = "";
				String fileRealName = "";
				filePath = createFileByDate("xmlattachpath");
				fileRealPath = filePath.replace(xmlsavepath, "");
				
				//公民上传身份证正反面
				if("0".equals(proposer)){
					//存身份证正面
					fileName = ele.getChild("applyCardFrontPhotoFileName").getTextTrim();
					paName = createRandomFileName(filePath,fileName.substring(fileName.indexOf("."),fileName.length()));
					fileStr = ele.getChild("applyCardFrontPhotoFile").getTextTrim();
					CBase64.saveDecodeStringToFile(fileStr,paName);
					fileRealName = paName.replace(filePath+"/", "");
					if(!"".equals(fileName)){
						dImpl.addNew("tb_publishattach","pa_id");
						dImpl.setValue("io_id",id,CDataImpl.STRING);
						dImpl.setValue("pa_path",fileRealPath,CDataImpl.STRING);
						dImpl.setValue("pa_name",fileName,CDataImpl.STRING);
						dImpl.setValue("pa_filename",fileRealName,CDataImpl.STRING);
						dImpl.update();
					}
					
					//存身份证反面
					fileName = ele.getChild("applyCardBackPhotoFileName").getTextTrim();
					
					paName = createRandomFileName(filePath,fileName.substring(fileName.indexOf("."),fileName.length()));
					fileStr = ele.getChild("applyCardBackPhotoFile").getTextTrim();
					CBase64.saveDecodeStringToFile(fileStr,paName);
					fileRealName = paName.replace(filePath+"/", "");
					if(!"".equals(fileName)){
						dImpl.addNew("tb_publishattach","pa_id");
						dImpl.setValue("io_id",id,CDataImpl.STRING);
						dImpl.setValue("pa_path",fileRealPath,CDataImpl.STRING);
						dImpl.setValue("pa_name",fileName,CDataImpl.STRING);
						dImpl.setValue("pa_filename",fileRealName,CDataImpl.STRING);
						dImpl.update();
					}
				}
				//法人上传法人身份证明
				if("1".equals(proposer)){
					//存身份证正面
					fileName = ele.getChild("applyLegalCardPhotoFileName").getTextTrim();
					paName = createRandomFileName(filePath,fileName.substring(fileName.indexOf("."),fileName.length()));
					fileStr = ele.getChild("applyLegalCardPhotoFile").getTextTrim();
					CBase64.saveDecodeStringToFile(fileStr,paName);
					fileRealName = paName.replace(filePath+"/", "");
					if(!"".equals(fileName)){
						dImpl.addNew("tb_publishattach","pa_id");
						dImpl.setValue("io_id",id,CDataImpl.STRING);
						dImpl.setValue("pa_path",fileRealPath,CDataImpl.STRING);
						dImpl.setValue("pa_name",fileName,CDataImpl.STRING);
						dImpl.setValue("pa_filename",fileRealName,CDataImpl.STRING);
						dImpl.update();
					}
				}
				
				
			}
			dCn.commitTrans();
			
			if("".equals(rtnStr.toString())){
				rtnStr.append(" success，主键是：" + id + ";");
			}
		} catch (Exception e) {
			System.err.println("GetShYsqXml:dealWithElement " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}

		return rtnStr.toString();
	}
	
	
	
	/**
	 * Description:根据当前日期创建文件夹yyyy-MM-dd
	 * 
	 * @return 创建的文件夹名
	 */
	private String createFileByDate(String xmlpath) {
		String filePath = "";
		WebserviceReadProperty pro = new WebserviceReadProperty();
		String xmlsavepath = pro.getPropertyValue(xmlpath);
		Calendar calendar = Calendar.getInstance();
		filePath = calendar.get(Calendar.YEAR)
				+ "-"
				+ ((calendar.get(Calendar.MONTH) + 1) < 10 ? ("0" + (calendar
						.get(Calendar.MONTH) + 1)) : (""
						+ (calendar.get(Calendar.MONTH) + 1)))
				+ "-"
				+ (calendar.get(Calendar.DAY_OF_MONTH) < 10 ? ("0" + calendar
						.get(Calendar.DAY_OF_MONTH)) : ""
						+ calendar.get(Calendar.DAY_OF_MONTH));
		filePath = xmlsavepath + filePath;
		File file = new File(filePath);
		if (!file.exists()) {
			if (!file.mkdir())
				System.err.println("GetShYsqXml：initEle 创建文件夹时报错！");
		}
		return filePath;
	}

	/**
	 * Description：在指定目录下创建随即文件名的文件
	 * 
	 * @param filePath
	 *            文件路径
	 * @return 文件全路径
	 */
	private String createRandomFileName(String filePath,String fileExName) {
		String fileName = "";
		Calendar calendar = Calendar.getInstance();
		fileName = calendar.get(Calendar.HOUR_OF_DAY)
				+ ""
				+ (calendar.get(Calendar.MINUTE) < 10 ? "0"
						+ calendar.get(Calendar.MINUTE) : ""
						+ calendar.get(Calendar.MINUTE))
				+ ""
				+ (calendar.get(Calendar.SECOND) < 10 ? "0"
						+ calendar.get(Calendar.SECOND) : ""
						+ calendar.get(Calendar.SECOND)) + ""
				+ CRandom.getRandom(1, 5);

		fileName = filePath + "/" + fileName + fileExName;
		File file = new File(fileName);
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException ex) {
				System.err
						.println("GetShYsqXml：createRandomFileName 创建文件出错: "
								+ ex.getMessage());
			}
		} else
			createRandomFileName(filePath,fileExName);
		return fileName;
	}

	/**
	 * Description：初始化变量
	 * 
	 * @param fileStr
	 *            一段xml的字符串
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
			System.err.println("GetShYsqXml：initEle XML编码错误: "
					+ ex.getMessage());
		} catch (JDOMException ex) {
			System.err.println("GetShYsqXml：initEle XML解析错误: "
					+ ex.getMessage());
		}
		return element;
	}
	
	/**
	 * Description:得到某一栏目下所有子节点的元素名
	 * @param rootEle 根栏目
	 * @param rtnStr 放返回值的字符串
	 * @return 以“/”拼接的元素名字符串
	 */
	private String getAllChildEle(Element rootEle,StringBuffer rtnStr){
		List list = null;
		Element child = null;
		if(rootEle.hasChildren()){
			list = rootEle.getChildren();
			for(int cnt = 0; cnt < list.size(); cnt++){
				child = (Element) list.get(cnt);
				if(child.hasChildren()){
					rtnStr.append(child.getName().toUpperCase()+"/");
					getAllChildEle(child,rtnStr);
				}else{
					rtnStr.append(child.getName().toUpperCase());
					rtnStr.append("/");
				}
			}
		}else{
			rtnStr.append(child.getName().toUpperCase());
			rtnStr.append("/");
		}
		return rtnStr.toString();
	}
	
	/**
	 * Description:xml节点是否齐全
	 * @param rootEle 传入的接口xml元素
	 * @param templateEle 模板的xml元素
	 * @return 验证信息
	 */
	private StringBuffer checkXmlIsComplete(Element rootEle,Element templateEle){
		String eleNames = getAllChildEle(rootEle,new StringBuffer());
		List childList = null;
		Element child = null;
		String eleName = ""; // 元素名
		StringBuffer rtnStr = new StringBuffer();
		if(templateEle != null){
			
			childList = templateEle.getChildren();
			if(childList != null){
				for(int cnt = 0; cnt < childList.size();cnt++){
					child = (Element)childList.get(cnt);
					eleName = child.getName();
					System.out.println(eleNames.toString()+"-----------"+eleName);
					if(eleNames.toString().indexOf(eleName) == -1){
						if ("".equals(rtnStr.toString()))
							rtnStr.append("errorcode:2,xml格式错误。缺少节点：");
						else
							rtnStr.append("/");
						rtnStr.append(eleName);
					}
				}
			}
		}
		return rtnStr;
	}

	/**
	 * Description：根据模板检查传入的xml格式是否有错误
	 * 
	 * @param rootEle
	 *            待检查的xml
	 * @param templateEle
	 *            模板xml
	 * @param rtnStr
	 *            错误描述
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
						eleName = child.getName().toUpperCase();
						eleValue = child.getTextTrim();
						
						//System.out.println("eleName==="+eleName+"====eleValue=="+eleValue);
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
									rtnStr.append("验证不通过");
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
									//
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
	 * 
	 * @param value
	 *            要验证的字符串
	 * @param regEx
	 *            正则表达式
	 * @return 正确返回true，否则返回false
	 */
	private boolean checkRegex(String value, String regEx) {
		Pattern p = Pattern.compile(regEx); // 生成一个prttern对象
		Matcher m = p.matcher(value); // 去掉正则以内的字符串
		String s = m.replaceAll(""); // 去掉空格
		return "".equals(s) ? true : false;
	}

	/**
	 * Description:返回信息在公文备案系统的主键
	 * 
	 * @param dt_code
	 *            部门代码
	 * @param ct_id
	 *            信息主键
	 * @return 信息在公文备案系统的主键
	 */
	private String hasContent(String dt_code, String ct_id_old) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable table = null;
		String ct_id = "";
		dt_code += "_";
		dt_code += ct_id_old;
		String sql = "select ct_id from infoopen where primarykey_id = '"
				+ dt_code + "'";
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
			if (table != null)
				ct_id = CTools.dealNull(table.get("ct_id"));
		} catch (Exception e) {
			System.err.println("GetShYsqXml:hasContent " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return ct_id;
	}
	/**
	 * Description:判断流水号是否存在于数据库
	 * 
	 * @param indexnum
	 *            传入的流水号
	 * @return 存在返回true，否则返回false
	 */
	private boolean hasIndexnum(String indexnum) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable table = null;
		String sql = "select id from infoopen where flownum = '"
				+ indexnum + "'";
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
		} catch (Exception e) {
			System.err.println("ParseBeianXml:hasIndexnum " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return table != null ? true : false;
	}
	/**
	 * 查询部门ID
	 * @param deptname
	 * @return
	 */
	private String queryDeptId(String deptname) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable table = null;
		String dt_id = "";
		String sql = "select dt_id from tb_deptinfo where dt_shortname = '"
				+ deptname + "'";
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
			if (table != null)
				dt_id = CTools.dealNull(table.get("dt_id"));
		} catch (Exception e) {
			System.err.println("ParseBeianXml:hasIndexnum " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return dt_id;
	}
	/**
	 * 查询部门名称
	 * @param deptname
	 * @return
	 */
	private String queryDeptName(String deptname) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable table = null;
		String dt_name = "";
		String sql = "select dt_name from tb_deptinfo where dt_shortname = '"
				+ deptname + "'";
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			table = dImpl.getDataInfo(sql);
			if (table != null)
				dt_name = CTools.dealNull(table.get("dt_name"));
		} catch (Exception e) {
			System.err.println("ParseBeianXml:hasIndexnum " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return dt_name;
	}
	
}
