package com.infoopen;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CFile;
import com.util.CTools;
import com.webservise.WebserviceReadProperty;

/**
 * 处理公文备案的依申请公开答复书
 * @author yo 20111108
 *  "4"   政府信息公开申请答复书－主动公开
	"5"   政府信息公开申请答复书－国家秘密、商业秘密、个人隐私，不予公开
	"6"   政府信息公开申请答复书－商业秘密、个人隐私，予以公开
	"7"   政府信息公开申请答复书－公开权利人信息告知单
	"8"   政府信息公开申请答复书－商业秘密、个人隐私，征求权利人意见//停用
	"9"   政府信息公开申请答复书－权利人意见征询
	"10"  政府信息公开申请答复书－非《条例》、《规定》所指政府信息
	"11"  政府信息公开申请答复书－政府信息不存在 
	"12"  政府信息公开申请答复书－不属于本机关公开职责权限范围
	"13"  政府信息公开申请答复书－部分公开
	"14"  政府信息公开申请答复书－危及“三安全一稳定”
	"15"  政府信息公开申请答复书－不属于政府信息公开申请//停用
	"16"  政府信息公开申请答复书－补正申请
	"17"  政府信息公开申请答复书－补正申请表
	"18"  政府信息公开申请答复书－重复申请
	"19"  政府信息公开申请答复书－延期答复
	"21"  政府信息公开申请答复书－已移交国家档案馆的信息
	"22"  政府信息公开申请答复书－涉及信访事项信息//停用
	"23"  政府信息公开申请答复书－涉及行政复议信息//停用
	"24"  政府信息公开申请答复书－依申请公开
	"25"  政府信息公开申请答复书－内部管理信息及过程性信息
	"26"  政府信息公开申请答复书－其他法律法规另有规定
	"27"  政府信息公开申请答复书－“三需要”补充材料
	"28"  政府信息公开申请答复书－未补充“三需要”证明材料，不予提供
	"29"  政府信息公开申请答复书－与“三需要”无关，不予提供
	"30"  政府信息公开申请答复书－补正后出现新申请事项//停用
	"31"  政府信息公开申请答复书－不符合申请要求（咨询）//停用
	"32"  政府信息公开申请答复书－历史信息
	"33"  政府信息公开申请答复书－不符合申请要求（申请内容不明确）
	"34"  政府信息公开申请答复书－不符合申请要求（其他）
	"35"  政府信息公开申请答复书－涉及房地产登记信息//停用
	"36"  政府信息公开申请答复书－党政混合信息（公开）
	"37"  政府信息公开申请答复书－党政混合信息（不予公开）
	"38"  政府信息公开申请答复书－党政混合信息公开意见征询单
	"39"  政府信息公开申请答复书－党政混合信息公开意见回复
	"40" 政府信息公开申请答复书－公开权利人信息告知
	"41" 政府信息公开申请答复书－信访信息函告
	"42" 政府信息公开申请答复书－行政复议信息函告
	"43" 政府信息公开申请答复书－涉诉信息函告
	"44" 政府信息公开申请答复书－信访活动函告
	"45" 政府信息公开申请答复书－查阅案卷函告
	"46" 政府信息公开申请答复书－特定领域信息函告
	"47" 政府信息公开申请答复书－咨询函告

	
 *
 */
public class ParseInfoopen {
	String oladdress = "";//36党政混合信息（公开）使用
	public static void main(String[] args) {
		ParseInfoopen info = new ParseInfoopen();
		String filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen8Template.xml";
		System.out.println(info.parseXml(filepath));
		System.out.println(filepath);

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
			System.err.println("ParseInfoopen：initEle XML编码错误: "
					+ ex.getMessage());
		} catch (JDOMException ex) {
			System.err.println("ParseInfoopen：initEle XML解析错误: "
					+ ex.getMessage());
		}
		return element;
	}

	/**
	 * Description：得到文件的字符串
	 * 
	 * @param 文件路径
	 * @return 模板的字符串
	 */
	private String getTemplateEle(String filepath) {
		StringBuffer source = new StringBuffer();
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
					.println("ParseInfoopen:getTemplateEle " + e.getMessage());
		}
		return source.toString();
	}

	public String printView(HttpServletRequest request){
		String xmlStr = saveXml(request);
		String xmlPath = createFileByDate("xmlsavepath");
		String ipId = CTools.dealString(request.getParameter("ip_id"));
		String fileName = xmlPath + "/" + ipId + ".xml";
		System.out.println("fileName = " + fileName);
		
		CFile.write(fileName,xmlStr);
		return parseXml(fileName);
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
						+ calendar.get(Calendar.MONTH) + 1))
				+ "-"
				+ (calendar.get(Calendar.DAY_OF_MONTH) < 10 ? ("0" + calendar
						.get(Calendar.DAY_OF_MONTH)) : ""
						+ calendar.get(Calendar.DAY_OF_MONTH));
		filePath = xmlsavepath + filePath;
		File file = new File(filePath);
		if (!file.exists()) {
			if (!file.mkdir())
				System.err.println("ParseBeianXml：initEle 创建文件夹时报错！");
		}
		return filePath;
	}
	
	public String parseXml(String filepath) {
		StringBuffer rtnStr = new StringBuffer();
		String fileStr = getTemplateEle(filepath);
		
		Element root = initEle(fileStr);
		
		Element child = null;
		List list = null;
		String deptname = root.getChild("deptname").getTextTrim();
		String applytime = root.getChild("applytime").getTextTrim();
		String othermothed = root.getChild("othermothed").getTextTrim();

		if(deptname.length() > 9){
			for(int cnt = 0; cnt < deptname.length() - 9; cnt++){
				applytime += "&nbsp;";
			}
		}
		rtnStr.append("<from name=\"formprint\">");
		rtnStr.append("<div id=\"eformdiv\">");
		rtnStr.append("<div align=\"center\" style=\"width:680px;line-height:30px;font-family:仿宋;margin-top:50px;margin-right:40px;margin-left:40px\">");
		//页面标题
		if(root.getChild("doctitle")!=null){
			rtnStr.append("<div align=\"left\" style=\"font-size:18px;height:25px\">");
			rtnStr.append("&nbsp;");
			rtnStr.append("</div>");
			rtnStr.append("<div align=\"center\" style=\"font-size:24px\"><strong>");
			rtnStr.append(root.getChild("doctitle").getTextTrim());
			rtnStr.append("</strong></div>");
		}
		rtnStr.append("<div align=\"left\" style=\"font-size:18px;height:25px\">");
		rtnStr.append("&nbsp;");
		rtnStr.append("</div>");
		//System.out.println("---------------"+root.getChild("flownum"));
		if(root.getChild("flownum")!=null){
			//编号
			rtnStr.append("<div align=\"right\" style=\"font-size:18px\">");
			rtnStr.append(root.getChild("flownum").getAttributeValue("text"));
			rtnStr.append(root.getChild("flownum").getTextTrim());
			rtnStr.append("&nbsp;&nbsp;&nbsp;&nbsp;");
			rtnStr.append("</div>");
		}
		//申请人姓名
		rtnStr.append("<div align=\"left\" style=\"font-size:18px\">");
		rtnStr.append(root.getChild("username").getTextTrim());
		rtnStr.append("：");
		rtnStr.append("</div>");
		//内容主体部分
		list = root.getChildren("paragraph");
		if(list != null){
			for(int cnt =0; cnt < list.size(); cnt++){
				child = (Element)list.get(cnt);
				rtnStr.append(addXml(child));
			}
		}
		
		
		//部门
		rtnStr.append("<div align=\"left\" style=\"font-size:18px;height:25px\">");
		rtnStr.append("&nbsp;");
		rtnStr.append("</div>");rtnStr.append("<div align=\"left\" style=\"font-size:18px;height:25px\">");
		rtnStr.append("&nbsp;");
		rtnStr.append("</div>");
		rtnStr.append("<div align=\"right\" style=\"font-size:18px\">");
		rtnStr.append(deptname);
		rtnStr.append("&nbsp;&nbsp;&nbsp;&nbsp;");
		rtnStr.append("</div>");
		//申请时间
		rtnStr.append("<div align=\"right\" style=\"font-size:18px\">");
		rtnStr.append(applytime);
		rtnStr.append("&nbsp;&nbsp;&nbsp;&nbsp;");
		rtnStr.append("</div>");
		
		//36党政混合信息（公开）
		if(!"".equals(oladdress)){
			rtnStr.append("<div align=\"left\" style=\"text-indent:2em;font-size:18px;word-break:break-all;\">");
			rtnStr.append(oladdress);
			rtnStr.append("</div>");
		}
		
		//附加信息
		rtnStr.append("<div align=\"left\" style=\"text-indent:2em;font-size:18px;word-break:break-all;\">");
		rtnStr.append(othermothed);
		rtnStr.append("</div>");
		//
		
		rtnStr.append("</div>");
		rtnStr.append("</div>");
		
		return rtnStr.toString();
	}
	
	private StringBuffer addXml(Element ele){
		String text = "";
		String eleName = "";
		String eleValue = "";
		Element child = null;
		List list = null;
		StringBuffer rtnStr = new StringBuffer();
		text = ele.getAttributeValue("text");
		rtnStr.append("<div align=\"left\" style=\"text-indent:2em;font-size:18px;word-break:break-all;\">");
		rtnStr.append(text);
		list = ele.getChildren();
		if(list != null){
			for(int cnt =0; cnt < list.size(); cnt++){
				child = (Element)list.get(cnt);
				eleName = child.getName();
				eleValue = child.getTextTrim();
				
				if(!eleName.startsWith("info_type")){
//					System.out.println("name = " + eleName + "||value = " +eleValue);
					if(child.hasChildren())
						rtnStr.append(getSegmant(child));
					else{
						if("true".equals(child.getAttributeValue("selected")))
							rtnStr.append(child.getAttributeValue("text"));
						rtnStr = new StringBuffer(rtnStr.toString().replaceAll(eleName,eleValue));
					}
				}else{
					rtnStr.append(getSegmant(child));
				}
			}
		}
		rtnStr.append("</div>");
		return rtnStr;
	}
	
	/**
	 * 答复书展示
	 * @param request
	 * @return
	 */
	public String saveXml(HttpServletRequest request){
		String filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "InfoNoopenTemplate.xml";
		//System.out.println("filepath=============="+filepath);
		Element root = initEle(getTemplateEle(filepath));
		
		XMLOutputter outputter = new XMLOutputter();
		String id = CTools.dealNull(request.getParameter("ip_id"));
		String type = CTools.dealNull(request.getParameter("printtype"));
		String indexnum = CTools.dealString(request.getParameter("indexnum"));
		String newindexnum = CTools.dealString(request.getParameter("newindexnum"));
		String applyname = CTools.dealString(request.getParameter("applyname"));
		String applyyear =  CTools.dealString(request.getParameter("year"));
		String applymonth = CTools.dealString(request.getParameter("month"));
		String applyday = CTools.dealString(request.getParameter("day"));
		String title = CTools.dealString(request.getParameter("title"));
		String content = CTools.dealString(request.getParameter("content"));

		
		//update by yo 20091020
		String indexnum_="";
		String bindexnum_ = "";
		String content_ ="";
		String bcontent_ = "";
		String btitle = "";
		String bindexnum = "";
		String bcontent = "";
		String correction = "";
		//16 补正
		if(title.indexOf("补正内容：")>0||newindexnum.indexOf("补正内容：")>0||content.indexOf("补正内容：")>0){
			
			
			//标题——暂时隐藏
			if(!"".equals(title) && title.indexOf("补正内容：")>0){
				btitle = title.substring(title.indexOf("补正内容：")+5,title.length());
				title = title.substring(0,title.indexOf("补正内容：")-1);
				btitle = "信息名称："+btitle+"　";
			}
			
			//文号——暂时隐藏
			if(!"".equals(newindexnum) && newindexnum.indexOf("补正内容：")>0){
				bindexnum = newindexnum.substring(newindexnum.indexOf("补正内容：")+5,newindexnum.length());
				newindexnum = newindexnum.substring(0,newindexnum.indexOf("补正内容：")-1);
				bindexnum_ = "文号：" +bindexnum+"　";
			}
			//申请的信息内容
			if(!"".equals(content) && content.indexOf("补正内容：")>0){
				bcontent = content.substring(content.indexOf("补正内容：")+5,content.length());
				content = content.substring(0,content.indexOf("补正内容：")-1);//
				//bcontent_ = "申请的信息内容：" + bcontent;
				bcontent_ = bcontent;
			}
			
			if(!"".equals(bindexnum)||!"".equals(bcontent)){
				bcontent = bindexnum_ + bcontent_ ;
			}
			//补正内容
			correction = getBuTime(id)+"收到您（单位）提交的补正申请，补正内容为：“"+btitle+bcontent+"”。";
		}
		
		//标题——暂时隐藏
		if(!"".equals(title)){
			title = "信息名称："+title+"　";
		}
		//文号——暂时隐藏
		if(!"".equals(newindexnum)){
			indexnum_ = "文号：" +newindexnum+"　";
		}
		//申请的信息内容
		if(!"".equals(content)){
			//content_ = "申请的信息内容：" + content;
			content_ = content;
		}
		if(!"".equals(newindexnum)||!"".equals(content)){
			content = indexnum_ + content_ ;
		}
		//title+content
		//getBuTime(id)+btitle+bcontent
		//udpate by yo 20091020
		
		String deptname = CTools.dealString(request.getParameter("deptname"));
		String applytime = CTools.dealString(request.getParameter("applyyear"))+ "年" 
				+ CTools.dealString(request.getParameter("applymonth"))+ "月" 
				+ CTools.dealString(request.getParameter("applyday"))+ "日";
		String info_type = CTools.dealString(request.getParameter("info_type"));
		String get_wise = CTools.dealString(request.getParameter("get_wise"));
		String get_spot = CTools.dealString(request.getParameter("get_spot"));
		String get_addr = CTools.dealString(request.getParameter("get_addr"));
		String [] get_wises = request.getParameterValues("get_wises");
		String medium_type_other = CTools.dealString(request.getParameter("medium_type_other"));
		String op_address = CTools.dealString(request.getParameter("op_address"));
		String othermothed = CTools.dealString(request.getParameter("othermothed"));
		String again_unit1 = CTools.dealString(request.getParameter("again_unit1"));
		String again_unit2 = CTools.dealString(request.getParameter("again_unit2"));
		
		
		Element child = null;
		List childList = null;
		
		if("0".equals(type)){//0 收件回执
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen0Template.xml";
			
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
						}
					}
				}
				
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
		}else if("4".equals(type)){//主动公开
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen4Template.xml";
			
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
							child.getChild("correction").setText(correction);
						}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
						}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("infotype").setText(""+op_address+"");
							child.getChild("getwise").setText(""+medium_type_other+"。");
						}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("again_unit1").setText(again_unit1);
							if("".equals(again_unit2)){
								child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
							}else{
								child.getChild("again_unit2").setText(again_unit2);
							}
						}
						
					}
				}
				
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
	}else if("5".equals(type)){	//5  国家秘密、商业秘密、个人隐私，不予公开
	String secrecy_type = CTools.dealString(request.getParameter("secrecy_type"));
	
	filepath = System.getProperty("user.dir")
			+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen5Template.xml";
	root = initEle(getTemplateEle(filepath));
	if(root != null){
		//编号
		child = root.getChild("flownum");
		child.setText(indexnum);
		
		//部门
		child = root.getChild("deptname");
		child.setText(deptname);
		
		//用户
		child = root.getChild("username");
		child.setText(applyname);
		
		//提交时间
		child = root.getChild("applytime");
		child.setText(applytime);
		
		//各段落信息
		childList = root.getChildren("paragraph");
		if(childList != null){
			for(int cnt = 0; cnt < childList.size(); cnt++){
				child = (Element)childList.get(cnt);
				//受理提示的一段
				if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.getChild("year").setText(applyyear);
					child.getChild("month").setText(applymonth);
					child.getChild("day").setText(applyday);
					child.getChild("title").setText(title);
					child.getChild("content").setText(content);
					child.getChild("correction").setText(correction);
				}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
				}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
					if("1".equals(secrecy_type)){
						child.getChild("secrecy_type1").setAttribute("selected","true");
					}if("2".equals(secrecy_type)){
						child.getChild("secrecy_type2").setAttribute("selected","true");
					}if("3".equals(secrecy_type)){
						child.getChild("secrecy_type3").setAttribute("selected","true");
					}
				}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
					child.getChild("again_unit1").setText(again_unit1);
					if("".equals(again_unit2)){
						child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
					}else{
						child.getChild("again_unit2").setText(again_unit2);
					}
				}
			}
		}
		//附加信息
		child = root.getChild("othermothed");
		child.setText(othermothed);
	}
}else if("6".equals(type)){//6 商业秘密、个人隐私、予以公开
	String secrecy_type = CTools.dealString(request.getParameter("secrecy_type"));
	String wise_type = CTools.dealString(request.getParameter("wise_type"));
	String transact_wist = CTools.dealString(request.getParameter("transact_wist"));
	op_address = CTools.dealString(request.getParameter("op_address"));
	filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen6Template.xml";
	
	String secrecy_type1 = "商业秘密。";
	String secrecy_type2 = "个人隐私。";
	String transact_wist1 = "经征求权利人同意，本机关（机构）决定予以公开。";
	String transact_wist2 = "本机关（机构）认为不公开可能对公共利益造成重大影响，决定予以公开。";
	String wise_type1 = "现将该政府信息提供给您（单位），请查收。";
	String wise_type2 = "请到"+op_address+"办理具体手续后，由本机关（机构）予以提供。";
	
	
	root = initEle(getTemplateEle(filepath));
	if(root != null){
		//编号
		child = root.getChild("flownum");
		child.setText(indexnum);
		
		//部门
		child = root.getChild("deptname");
		child.setText(deptname);
		
		//用户
		child = root.getChild("username");
		child.setText(applyname);
		
		//提交时间
		child = root.getChild("applytime");
		child.setText(applytime);
		
		//各段落信息
		childList = root.getChildren("paragraph");
		if(childList != null){
			for(int cnt = 0; cnt < childList.size(); cnt++){
				child = (Element)childList.get(cnt);
				//受理提示的一段
				if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.getChild("year").setText(applyyear);
					child.getChild("month").setText(applymonth);
					child.getChild("day").setText(applyday);
					child.getChild("title").setText(title);
					child.getChild("content").setText(content);
					child.getChild("correction").setText(correction);
				}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
				}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
					//
					if("1".equals(secrecy_type)){
						child.getChild("secrecytype").setText(secrecy_type1);
					}
					if("2".equals(secrecy_type)){
						child.getChild("secrecytype").setText(secrecy_type2);
					}
					//
					if("1".equals(transact_wist)){
						child.getChild("transactwist").setText(transact_wist1);
					}
					if("2".equals(transact_wist)){
						child.getChild("transactwist").setText(transact_wist2);
					}
					//
					if("1".equals(wise_type)){
						child.getChild("wisetype").setText(wise_type1);
					}
					if("2".equals(wise_type)){
						child.getChild("wisetype").setText(wise_type2);
					}
					
				}
			}
		}
		//附加信息
		child = root.getChild("othermothed");
		child.setText(othermothed);
	}
		
}else if("7".equals(type)){	//7 公开权利人信息告知单
	filepath = System.getProperty("user.dir")
			+ System.getProperty("file.separator")  + "/XMLtemplate/" + "Infoopen7Template.xml";
		
	root = initEle(getTemplateEle(filepath));
	if(root != null){
		//编号
		child = root.getChild("flownum");
		child.setText(indexnum);
		
		//部门
		child = root.getChild("deptname");
		child.setText(deptname);
		
		//用户
		child = root.getChild("username");
		child.setText(applyname);
		
		//提交时间
		child = root.getChild("applytime");
		child.setText(applytime);
		
		//各段落信息
		childList = root.getChildren("paragraph");
		if(childList != null){
			for(int cnt = 0; cnt < childList.size(); cnt++){
				child = (Element)childList.get(cnt);
				//受理提示的一段
				if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.getChild("title").setText(title);
					child.getChild("content").setText(content);
					child.getChild("correction").setText(correction);
				}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
				}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
					child.getChild("again_unit1").setText(again_unit1);
					if("".equals(again_unit2)){
						child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
					}else{
						child.getChild("again_unit2").setText(again_unit2);
					}
					
				}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
				}
			}
		}
		//附加信息
		child = root.getChild("othermothed");
		child.setText(othermothed);
	}
}else if("9".equals(type)){//9 权利人意见征询单
	
	String openyear = CTools.dealString(request.getParameter("openyear"));
	String openmonth = CTools.dealString(request.getParameter("openmonth"));
	String openday = CTools.dealString(request.getParameter("openday"));
	String address = CTools.dealString(request.getParameter("address"));
	String postcode = CTools.dealString(request.getParameter("postcode"));
	filepath = System.getProperty("user.dir")
			+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen9Template.xml";
	root = initEle(getTemplateEle(filepath));
	if(root != null){
		//编号
		child = root.getChild("flownum");
		child.setText(indexnum);
		
		//部门
		child = root.getChild("deptname");
		child.setText(deptname);
		
		//用户
		child = root.getChild("username");
		child.setText(applyname);
		
		//提交时间
		child = root.getChild("applytime");
		child.setText(applytime);
		
		//各段落信息
		childList = root.getChildren("paragraph");
		if(childList != null){
			for(int cnt = 0; cnt < childList.size(); cnt++){
				child = (Element)childList.get(cnt);
				//受理提示的一段
				if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.getChild("title").setText(title);
					child.getChild("content").setText(content);
					child.getChild("correction").setText(correction);
				}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
					child.getChild("isopen1").setAttribute("selected","true");
					child.getChild("isopen2").setAttribute("selected","true");
					child.getChild("isopen3").setAttribute("selected","true");
				}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
					child.getChild("openyear").setText(openyear);
					child.getChild("openmonth").setText(openmonth);
					child.getChild("openday").setText(openday);
					child.getChild("address").setText(address);
					child.getChild("postcode").setText(postcode);
				}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
					child.setAttribute("selected","true");
				}
			}
		}
		//附加信息
		child = root.getChild("othermothed");
		child.setText(othermothed);
	}
}else if("10".equals(type) || "36".equals(type) || "37".equals(type)){	//10  非《条例》、《规定》所指政府信息	36党政混合信息（公开） 37党政混合信息（不予公开）

		filepath = System.getProperty("user.dir")
			+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen"+type+"Template.xml";
		root = initEle(getTemplateEle(filepath));
		if(root != null){
			//编号
			child = root.getChild("flownum");
			child.setText(indexnum);
			
			//部门
			child = root.getChild("deptname");
			child.setText(deptname);
			
			//用户
			child = root.getChild("username");
			child.setText(applyname);
			
			//提交时间
			child = root.getChild("applytime");
			child.setText(applytime);
			
			//各段落信息
			childList = root.getChildren("paragraph");
			if(childList != null){
				for(int cnt = 0; cnt < childList.size(); cnt++){
					child = (Element)childList.get(cnt);
					//受理提示的一段
					if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.getChild("year").setText(applyyear);
						child.getChild("month").setText(applymonth);
						child.getChild("day").setText(applyday);
						child.getChild("title").setText(title);
						child.getChild("content").setText(content);
						child.getChild("correction").setText(correction);
					}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						child.getChild("again_unit1").setText(again_unit1);
						if("".equals(again_unit2)){
							child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
						}else{
							child.getChild("again_unit2").setText(again_unit2);
						}
					}
				}
			}
			//党政混合信息（公开）
			if("36".equals(type)){
				child = root.getChild("opaddress");
				child.setText("另，现基于便民原则，将"+op_address+"提供给您（单位）参考。");
				oladdress = "另，现基于便民原则，将"+op_address+"提供给您（单位）参考。";
			}
		
		//附加信息
		child = root.getChild("othermothed");
		child.setText(othermothed);
		}
		
	}else if("11".equals(type)){//11 政府信息不存在
		String other_message = CTools.dealString(request.getParameter("other_message"));
		String noexist_type =  CTools.dealString(request.getParameter("noexist_type"));
		filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen11Template.xml";
		root = initEle(getTemplateEle(filepath));
		if(root != null){
			//编号
			child = root.getChild("flownum");
			child.setText(indexnum);
			
			//部门
			child = root.getChild("deptname");
			child.setText(deptname);
			
			//用户
			child = root.getChild("username");
			child.setText(applyname);
			
			//提交时间
			child = root.getChild("applytime");
			child.setText(applytime);
			
			//各段落信息
			childList = root.getChildren("paragraph");
			if(childList != null){
				for(int cnt = 0; cnt < childList.size(); cnt++){
					child = (Element)childList.get(cnt);
					//受理提示的一段
					if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.getChild("year").setText(applyyear);
						child.getChild("month").setText(applymonth);
						child.getChild("day").setText(applyday);
						child.getChild("title").setText(title);
						child.getChild("content").setText(content);
						child.getChild("correction").setText(correction);
					}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						if("1".equals(noexist_type)){
							child.getChild("other_message").setText("因本机关（机构）未制作，该信息不存在。");
						}else if("2".equals(noexist_type)){
							child.getChild("other_message").setText("因本机关(机构)未汇总（加工、重新制作），该信息不存在。");
						}else if("3".equals(noexist_type)){
							child.getChild("other_message").setText("因本机关(机构)未获取，该信息无法提供。");
						}else if("4".equals(noexist_type)){
							child.getChild("other_message").setText("因本机关(机构)未保存，该信息无法提供。");
						}else if("5".equals(noexist_type)){
							child.getChild("other_message").setText("因本机关(机构)已依法销毁，该信息无法提供。");
						}else{
							child.getChild("other_message").setText("因"+other_message+"，该信息无法提供。");
						}
						
					}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						child.getChild("again_unit1").setText(again_unit1);
						if("".equals(again_unit2)){
							child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
						}else{
							child.getChild("again_unit2").setText(again_unit2);
						}
						
					}
				}
			}
			//附加信息
			child = root.getChild("othermothed");
			child.setText(othermothed);
		}
	}else if("12".equals(type)){//12 不属于本机关公开职责权限范围
		String consultant = CTools.dealString(request.getParameter("consultant"));
		String address = CTools.dealString(request.getParameter("address"));
		filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen12Template.xml";
		root = initEle(getTemplateEle(filepath));
		if(root != null){
			//编号
			child = root.getChild("flownum");
			child.setText(indexnum);
			
			//部门
			child = root.getChild("deptname");
			child.setText(deptname);
			
			//用户
			child = root.getChild("username");
			child.setText(applyname);
			
			//提交时间
			child = root.getChild("applytime");
			child.setText(applytime);
			
			//各段落信息
			childList = root.getChildren("paragraph");
			if(childList != null){
				for(int cnt = 0; cnt < childList.size(); cnt++){
					child = (Element)childList.get(cnt);
					//受理提示的一段
					if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.getChild("year").setText(applyyear);
						child.getChild("month").setText(applymonth);
						child.getChild("day").setText(applyday);
						child.getChild("title").setText(title);
						child.getChild("content").setText(content);
						child.getChild("correction").setText(correction);
					}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						if(!"".equals(consultant)||!"".equals(address)){
							child.getChild("consultant").setText("建议您（单位）向"+consultant+"咨询，联系方式："+address+"。");
						}
					}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						child.getChild("again_unit1").setText(again_unit1);
						if("".equals(again_unit2)){
							child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
						}else{
							child.getChild("again_unit2").setText(again_unit2);
						}
					}
				}
			}
			//附加信息
			child = root.getChild("othermothed");
			child.setText(othermothed);
		}
	}else if("13".equals(type)){//13 部分公开
		String secrecy_type = CTools.dealString(request.getParameter("secrecy_type"));
		String transact_wist = CTools.dealString(request.getParameter("transact_wist"));
		op_address = CTools.dealString(request.getParameter("op_address"));
		filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen13Template.xml";
		
		root = initEle(getTemplateEle(filepath));
		if(root != null){
			//编号
			child = root.getChild("flownum");
			child.setText(indexnum);
			
			//部门
			child = root.getChild("deptname");
			child.setText(deptname);
			
			//用户
			child = root.getChild("username");
			child.setText(applyname);
			
			//提交时间
			child = root.getChild("applytime");
			child.setText(applytime);
			
			//各段落信息
			childList = root.getChildren("paragraph");
			if(childList != null){
				for(int cnt = 0; cnt < childList.size(); cnt++){
					child = (Element)childList.get(cnt);
					//受理提示的一段
					if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.getChild("year").setText(applyyear);
						child.getChild("month").setText(applymonth);
						child.getChild("day").setText(applyday);
						child.getChild("title").setText(title);
						child.getChild("content").setText(content);
						child.getChild("correction").setText(correction);
					}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						
					}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						if("1".equals(secrecy_type)){
							child.getChild("secrecy_type1").setAttribute("selected","true");
						}if("2".equals(secrecy_type)){
							child.getChild("secrecy_type2").setAttribute("selected","true");
						}if("3".equals(secrecy_type)){
							child.getChild("secrecy_type3").setAttribute("selected","true");
						}if("4".equals(secrecy_type)){
							child.getChild("secrecy_type4").setAttribute("selected","true");
						}
						child.getChild("secrecy_other").setAttribute("selected","true");
						
					}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						if("1".equals(transact_wist)){
							child.getChild("transact_wist1").setAttribute("selected","true");
						}if("2".equals(transact_wist)){
							child.getChild("transact_wist2").setAttribute("selected","true");
							child.getChild("transact_wist2").getChild("address").setText(op_address);
						}
					}else if("5".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						child.getChild("again_unit1").setText(again_unit1);
						if("".equals(again_unit2)){
							child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
						}else{
							child.getChild("again_unit2").setText(again_unit2);
						}
						
					}
				}
			}
			//附加信息
			child = root.getChild("othermothed");
			child.setText(othermothed);
		}
			
	}else if("14".equals(type)){//14  危及“三安全一稳定”
		String safe_type = CTools.dealString(request.getParameter("safe_type"));
		filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" +"Infoopen14Template.xml";
		root = initEle(getTemplateEle(filepath));
		if(root != null){
			//编号
			child = root.getChild("flownum");
			child.setText(indexnum);
			
			//部门
			child = root.getChild("deptname");
			child.setText(deptname);
			
			//用户
			child = root.getChild("username");
			child.setText(applyname);
			
			//提交时间
			child = root.getChild("applytime");
			child.setText(applytime);
			
			//各段落信息
			childList = root.getChildren("paragraph");
			if(childList != null){
				for(int cnt = 0; cnt < childList.size(); cnt++){
					child = (Element)childList.get(cnt);
					//受理提示的一段
					if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.getChild("year").setText(applyyear);
						child.getChild("month").setText(applymonth);
						child.getChild("day").setText(applyday);
						child.getChild("title").setText(title);
						child.getChild("content").setText(content);
						child.getChild("correction").setText(correction);
					}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						if("1".equals(safe_type)){
							child.getChild("safe_type").getChild("safe_type1").setAttribute("selected","true");
						}else if("2".equals(safe_type)){
							child.getChild("safe_type").getChild("safe_type2").setAttribute("selected","true");
						}else if("3".equals(safe_type)){
							child.getChild("safe_type").getChild("safe_type3").setAttribute("selected","true");
						}else{
							child.getChild("safe_type").getChild("safe_type4").setAttribute("selected","true");
						}
					}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						child.getChild("again_unit1").setText(again_unit1);
						if("".equals(again_unit2)){
							child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
						}else{
							child.getChild("again_unit2").setText(again_unit2);
						}
					}
				}
			}
			//附加信息
			child = root.getChild("othermothed");
			child.setText(othermothed);
		}
	}else if("15".equals(type)){//15 不属于政府信息公开申请   //停用
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen15Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("16".equals(type)){//16 补正申请告知
			String openyear = CTools.dealString(request.getParameter("openyear"));
			String openmonth = CTools.dealString(request.getParameter("openmonth"));
			String openday = CTools.dealString(request.getParameter("openday"));
			String consultant = CTools.dealString(request.getParameter("consultant"));
			if("（根据需要，向申请人说明需要补正的原因，或指引申请人提供确定具体信息所必备的其他特征项）".equals(consultant)){
				consultant = "";
			}
			
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen16Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("openyear").setText(openyear);
								child.getChild("openmonth").setText(openmonth);
								child.getChild("openday").setText(openday);
								//if("XA1".equals(deptcode)){
								//	child.getChild("txdz").setText("（通讯地址：世纪大道2001号区政府法制办，邮编：200135）");
								//}
								child.getChild("op_address").setText(op_address);
								child.getChild("consultant").setText(consultant);
							}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("18".equals(type)){//18 重复申请
			String openanswer = CTools.dealString(request.getParameter("openanswer"));
			String phonenumber = CTools.dealString(request.getParameter("phonenumber"));
			String openyear = CTools.dealString(request.getParameter("openyear"));
			String openmonth = CTools.dealString(request.getParameter("openmonth"));
			String openday = CTools.dealString(request.getParameter("openday"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen18Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("openyear").setText(openyear);
								child.getChild("openmonth").setText(openmonth);
								child.getChild("openday").setText(openday);
								child.getChild("openanswer").setText(openanswer);
							}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("again_unit1").setText(again_unit1);
								if("".equals(again_unit2)){
									child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
								}else{
									child.getChild("again_unit2").setText(again_unit2);
								}
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
			}else if("19".equals(type)){//19 延期答复告知
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen19Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("21".equals(type)){//21 已移交国家档案馆的信息
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen21Template.xml";
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
							child.getChild("correction").setText(correction);
						}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
						}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							if("1".equals(get_spot)){
								child.getChild("get_addr1").setAttribute("selected","true");
							}if("2".equals(get_spot)){
								child.getChild("get_addr2").setAttribute("selected","true");
							}
						}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("again_unit1").setText(again_unit1);
							if("".equals(again_unit2)){
								child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
							}else{
								child.getChild("again_unit2").setText(again_unit2);
							}
						}
					}
				}
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
		}else if("22".equals(type)){//22  涉及信访事项信息
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen22Template.xml";
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
							child.getChild("correction").setText(correction);
						}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
						}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("op_address").setText(op_address);
						}
					}
				}
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
		}else if("23".equals(type) || "35".equals(type)){//23 涉及行政复议信息  35 涉及房地产登记信息
			filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen"+type+"Template.xml";
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
							child.getChild("correction").setText(correction);
						}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
						}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("op_address").setText(op_address);
						}
					}
				}
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
		
		}else if("24".equals(type)){//24 依申请公开告知单
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen24Template.xml";
			String info_type1 = "现将该信息提供给您（单位），请查收。";
			String info_type2 = "请到"+op_address+"办理具体手续后，由本机关（机构）予以提供。";
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
							child.getChild("correction").setText(correction);
						}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
						}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							if("1".equals(info_type)){
								child.getChild("infotype").setText(info_type1);
							}else if("2".equals(info_type)){
								child.getChild("infotype").setText(info_type2);
							}
						}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("again_unit1").setText(again_unit1);
							if("".equals(again_unit2)){
								child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
							}else{
								child.getChild("again_unit2").setText(again_unit2);
							}
						}
						
					}
				}
				
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
	}else if("25".equals(type)){//25  内部管理信息及过程性信息
		
		filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" +"Infoopen25Template.xml";
		root = initEle(getTemplateEle(filepath));
		if(root != null){
			//编号
			child = root.getChild("flownum");
			child.setText(indexnum);
			
			//部门
			child = root.getChild("deptname");
			child.setText(deptname);
			
			//用户
			child = root.getChild("username");
			child.setText(applyname);
			
			//提交时间
			child = root.getChild("applytime");
			child.setText(applytime);
			
			//各段落信息
			childList = root.getChildren("paragraph");
			if(childList != null){
				for(int cnt = 0; cnt < childList.size(); cnt++){
					child = (Element)childList.get(cnt);
					//受理提示的一段
					if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.getChild("year").setText(applyyear);
						child.getChild("month").setText(applymonth);
						child.getChild("day").setText(applyday);
						child.getChild("title").setText(title);
						child.getChild("content").setText(content);
						child.getChild("correction").setText(correction);
					}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
					}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
						child.setAttribute("selected","true");
						child.getChild("again_unit1").setText(again_unit1);
						if("".equals(again_unit2)){
							child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
						}else{
							child.getChild("again_unit2").setText(again_unit2);
						}
					}
				}
			}
			//附加信息
			child = root.getChild("othermothed");
			child.setText(othermothed);
		}
	}else if("26".equals(type)){//26 其他法律法规另有规定
		String otherlaw = CTools.dealString(request.getParameter("otherlaw"));
		String phonenumber = CTools.dealString(request.getParameter("phonenumber"));
		
		filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen26Template.xml";
			root = initEle(getTemplateEle(filepath));
			if(root != null){
				//编号
				child = root.getChild("flownum");
				child.setText(indexnum);
				
				//部门
				child = root.getChild("deptname");
				child.setText(deptname);
				
				//用户
				child = root.getChild("username");
				child.setText(applyname);
				
				//提交时间
				child = root.getChild("applytime");
				child.setText(applytime);
				
				//各段落信息
				childList = root.getChildren("paragraph");
				if(childList != null){
					for(int cnt = 0; cnt < childList.size(); cnt++){
						child = (Element)childList.get(cnt);
						
						//受理提示的一段
						if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.getChild("year").setText(applyyear);
							child.getChild("month").setText(applymonth);
							child.getChild("day").setText(applyday);
							child.getChild("title").setText(title);
							child.getChild("content").setText(content);
							child.getChild("correction").setText(correction);
						}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
						}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("otherlaw").setText(otherlaw);
							child.getChild("phonenumber").setText(phonenumber);
						}else if("4".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
							child.setAttribute("selected","true");
							child.getChild("again_unit1").setText(again_unit1);
							if("".equals(again_unit2)){
								child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
							}else{
								child.getChild("again_unit2").setText(again_unit2);
							}
						}
					}
				}
				//附加信息
				child = root.getChild("othermothed");
				child.setText(othermothed);
			}
		
	}else if("27".equals(type)){//27 "三需要"补充材料
			String openyear = CTools.dealString(request.getParameter("openyear"));
			String openmonth = CTools.dealString(request.getParameter("openmonth"));
			String openday = CTools.dealString(request.getParameter("openday"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen27Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("openyear").setText(openyear);
								child.getChild("openmonth").setText(openmonth);
								child.getChild("openday").setText(openday);
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("28".equals(type)){//28 未补充“三需要”证明材料，不予提供
			String openyear = CTools.dealString(request.getParameter("openyear"));
			String openmonth = CTools.dealString(request.getParameter("openmonth"));
			String openday = CTools.dealString(request.getParameter("openday"));
			String purpose = CTools.dealString(request.getParameter("purpose"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen28Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("purpose").setText(purpose);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("openyear").setText(openyear);
								child.getChild("openmonth").setText(openmonth);
								child.getChild("openday").setText(openday);
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("29".equals(type)){//29  与“三需要”无关，不予提供
			String openyear = CTools.dealString(request.getParameter("openyear"));
			String openmonth = CTools.dealString(request.getParameter("openmonth"));
			String openday = CTools.dealString(request.getParameter("openday"));
			String getyear = CTools.dealString(request.getParameter("getyear"));
			String getmonth = CTools.dealString(request.getParameter("getmonth"));
			String getday = CTools.dealString(request.getParameter("getday"));
			String purpose = CTools.dealString(request.getParameter("purpose"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen29Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("purpose").setText(purpose);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("openyear").setText(openyear);
								child.getChild("openmonth").setText(openmonth);
								child.getChild("openday").setText(openday);
								
								child.getChild("getyear").setText(getyear);
								child.getChild("getmonth").setText(getmonth);
								child.getChild("getday").setText(getday);
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("30".equals(type)){//30 补正后出现新申请事项 //停用
			String openyear = CTools.dealString(request.getParameter("openyear"));
			String openmonth = CTools.dealString(request.getParameter("openmonth"));
			String openday = CTools.dealString(request.getParameter("openday"));
			String bnewtitle = CTools.dealString(request.getParameter("bnewtitle"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen30Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("openy").setText(openyear);
								child.getChild("openm").setText(openmonth);
								child.getChild("opend").setText(openday);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("bnewtitle").setText(bnewtitle);
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("31".equals(type) || "33".equals(type) || "34".equals(type)){//31 不符合申请要求（咨询）  33不符合申请要求（申请内容不明确） 34不符合申请要求（其他）+补正的情况说明
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen"+type+"Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("again_unit1").setText(again_unit1);
								if("".equals(again_unit2)){
									child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
								}else{
									child.getChild("again_unit2").setText(again_unit2);
								}
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("32".equals(type)){//32 历史信息
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen32Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("38".equals(type)){//38 党政混合信息公开意见征询单
			String pname = CTools.dealString(request.getParameter("pname"));
			String getyear = CTools.dealString(request.getParameter("getyear"));
			String getmonth = CTools.dealString(request.getParameter("getmonth"));
			String getday = CTools.dealString(request.getParameter("getday"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen38Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//编号
					child = root.getChild("flownum");
					child.setText(indexnum);
					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("pname").setText(pname);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("getyear").setText(getyear);
								child.getChild("getmonth").setText(getmonth);
								child.getChild("getday").setText(getday);
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("39".equals(type)){//39 党政混合信息公开意见回复单
			String pname = CTools.dealString(request.getParameter("pname"));
			String opentype = CTools.dealString(request.getParameter("opentype"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen39Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("pname").setText(pname);
								child.getChild("correction").setText(correction);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								if("1".equals(opentype)){
									child.getChild("opentype").setText("同意公开。");
								}else if("2".equals(opentype)){
									child.getChild("opentype").setText("不同意公开。理由为："+op_address+"");
								}
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("40".equals(type)){//40 公开权利人信息告知
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen40Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("again_unit1").setText(again_unit1);
								if("".equals(again_unit2)){
									child.setAttribute("text","如对本答复不服，可以在收到本答复之日起60日内向again_unit1申请行政复议，或者在6个月内向人民法院提起行政诉讼。");
								}else{
									child.getChild("again_unit2").setText(again_unit2);
								}
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("41".equals(type)){//41信访信息函告
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen41Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("42".equals(type)){//42行政复议信息函告
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen42Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("43".equals(type)){//43涉诉信息函告
			String transact_wist = CTools.dealString(request.getParameter("transact_wist"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen43Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								
								if("1".equals(transact_wist)){
									child.getChild("transact_wist1").setAttribute("selected","true");
								}
								if("2".equals(transact_wist)){
									child.getChild("transact_wist2").setAttribute("selected","true");
								}
								if("3".equals(transact_wist)){
									child.getChild("transact_wist3").setAttribute("selected","true");
									child.getChild("transact_wist3").getChild("address").setText(op_address);
								}
								
								
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}else if("3".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("44".equals(type)){//44信访活动函告
			String transact_wist = CTools.dealString(request.getParameter("transact_wist"));
			String op_xfhg1 = CTools.dealString(request.getParameter("op_xfhg1"));
			String op_xfhg2 = CTools.dealString(request.getParameter("op_xfhg2"));
			String op_xfhg3 = CTools.dealString(request.getParameter("op_xfhg3"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen44Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								if("1".equals(transact_wist)){
									child.getChild("transact_wist1").setAttribute("selected","true");
									child.getChild("transact_wist1").getChild("address").setText(op_xfhg1);
								}
								if("2".equals(transact_wist)){
									child.getChild("transact_wist2").setAttribute("selected","true");
									child.getChild("transact_wist2").getChild("address").setText(op_xfhg2);
								}
								if("3".equals(transact_wist)){
									child.getChild("transact_wist3").setAttribute("selected","true");
									child.getChild("transact_wist3").getChild("address").setText(op_xfhg3);
								}
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("45".equals(type)){//45 查阅案卷函告
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen45Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
							}else if("2".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.setAttribute("selected","true");
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);
								child.getChild("get_wise").setText(get_wise);
								child.getChild("get_spot").setText(get_spot);
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("46".equals(type)){//46特定领域信息函告
			String transact_wist = CTools.dealString(request.getParameter("transact_wist"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen46Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);
								child.getChild("title").setText(title);
								child.getChild("content").setText(content);

								if("1".equals(transact_wist)){
									child.getChild("transact_wist1").setAttribute("selected","true");
									child.getChild("transact_wist1").getChild("address").setText(op_address);
									child.getChild("transact_wist1").getChild("medium_type_other").setText(medium_type_other);
								}
								if("2".equals(transact_wist)){
									child.getChild("transact_wist2").setAttribute("selected","true");
								}
								if("3".equals(transact_wist)){
									child.getChild("transact_wist3").setAttribute("selected","true");
								}
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}else if("47".equals(type)){//47咨询函告
			String transact_wist = CTools.dealString(request.getParameter("transact_wist"));
			filepath = System.getProperty("user.dir")
					+ System.getProperty("file.separator") + "/XMLtemplate/" + "Infoopen47Template.xml";
				root = initEle(getTemplateEle(filepath));
				if(root != null){					
					//部门
					child = root.getChild("deptname");
					child.setText(deptname);
					
					//用户
					child = root.getChild("username");
					child.setText(applyname);
					
					//提交时间
					child = root.getChild("applytime");
					child.setText(applytime);
					
					//各段落信息
					childList = root.getChildren("paragraph");
					if(childList != null){
						for(int cnt = 0; cnt < childList.size(); cnt++){
							child = (Element)childList.get(cnt);
							
							//受理提示的一段
							if("1".equals(CTools.dealNull(child.getAttributeValue("tagnum")))){
								child.getChild("year").setText(applyyear);
								child.getChild("month").setText(applymonth);
								child.getChild("day").setText(applyday);

								if("1".equals(transact_wist)){
									child.getChild("transact_wist1").setAttribute("selected","true");
									child.getChild("transact_wist1").getChild("address").setText(op_address);
								}
								if("2".equals(transact_wist)){
									child.getChild("transact_wist2").setAttribute("selected","true");
									child.getChild("transact_wist2").getChild("medium_type_other").setText(medium_type_other);
								}
							}
						}
					}
					//附加信息
					child = root.getChild("othermothed");
					child.setText(othermothed);
				}
			
		}
		
		return "<?xml version=\"1.0\" encoding=\"GBK\"?>" + outputter.outputString(root);
	}
	
	private String getSegmant(Element ele){
		String slt = ele.getAttributeValue("selected");
		String text = ele.getAttributeValue("text");
		String eleName = "";
		String eleValue = "";
		List list = null;
		StringBuffer rtnStr = new StringBuffer();
		Element child = null;
		if("true".equals(slt)){
			rtnStr.append(text);
			if(ele.hasChildren()){
				list = ele.getChildren();
				for(int cnt = 0; cnt < list.size(); cnt++){
					child = (Element) list.get(cnt);
					eleName = child.getName();
					eleValue = child.getTextTrim();
					if(eleName.startsWith("get"))
						rtnStr.append(getSegmant(child));
					else{
						rtnStr = new StringBuffer(rtnStr.toString().replaceAll(eleName,eleValue));
					}
				}
			}
		}
		return rtnStr.toString();
		
	}
	
	/**
	 * Description：得到中文的日期字符串
	 * @param dateStr 原日期字符串
	 * @return 中文日期字符串
	 */
	public static String getYearDate(String dateStr){
    	String rtnStr = "";
    	String[] list = dateStr.split("");
    	for(int cnt = 1; cnt <= dateStr.length(); cnt++){
//    		System.out.println(list[cnt]);
    		rtnStr += getOneword(list[cnt]);
    	}
    	return rtnStr;
    }
    
	/**
	 * Description：简单的数字、中文数字替换
	 * @param source 传入的比较字符
	 * @return 替换后的字符，如果不是数字直接返回
	 */
    public static String getOneword(String  source){
    	String target = "";
    	String intStr = "0123456789";
    	if(intStr.indexOf(source) != -1){
    		switch(Integer.parseInt(source)){
    			case 0:
    				target = "O";
    				break;
    			case 1:
    				target = "一";
    				break;
    			case 2:
    				target = "二";
    				break;
    			case 3:
    				target = "三";
    				break;
    			case 4:
    				target = "四";
    				break;
    			case 5:
    				target = "五";
    				break;
    			case 6:
    				target = "六";
    				break;
    			case 7:
    				target = "七";
    				break;
    			case 8:
    				target = "八";
    				break;
    			case 9:
    				target = "九";
    				break;
    			default:
    				break;
    		}
    	}else{
    		target = source;
    	}
    	return target;
    }
    
    /**
     * Description：得到日期的中文形式
     * @param source 日期的数字形式
     * @return 中文的日期
     */
    public static String getDayWord(String source){
    	String target = "";
    	String tempStr = "";
		if(source.length() == 2 && source.startsWith("1")){
			tempStr = "十";
			source = source.substring(1,2);
		}else if (source.length() == 2 && source.startsWith("2")){
			tempStr = "二十";
			source = source.substring(1,2);
		}else if (source.length() == 2 && source.startsWith("3")){
			tempStr = "三十";
			source = source.substring(1,2);
		}
		if(!"".equals(source)){
			switch(Integer.parseInt(source)){
				case 0:
					target = "O";
					break;
				case 1:
					target = "一";
					break;
				case 2:
					target = "二";
					break;
				case 3:
					target = "三";
					break;
				case 4:
					target = "四";
					break;
				case 5:
					target = "五";
					break;
				case 6:
					target = "六";
					break;
				case 7:
					target = "七";
					break;
				case 8:
					target = "八";
					break;
				case 9:
					target = "九";
					break;
				default:
					break;
			}	
		}
		if(!"O".equals(target))
			target = tempStr + target;
		else
			target = tempStr;
    	
    	return target;
    	
    }
    
    /**
     * Description：得到月份的中文形式
     * @param source 数字的月份
     * @return 中文的月份
     */
    public static String getMonthWord(String source){
    	String target = "";
    	switch(Integer.parseInt(source)){
			case 1:
				target = "一";
				break;
			case 2:
				target = "二";
				break;
			case 3:
				target = "三";
				break;
			case 4:
				target = "四";
				break;
			case 5:
				target = "五";
				break;
			case 6:
				target = "六";
				break;
			case 7:
				target = "七";
				break;
			case 8:
				target = "八";
				break;
			case 9:
				target = "九";
				break;
			case 10:
				target = "十";
				break;
			case 11:
				target = "十一";
				break;
			case 12:
				target = "十二";
				break;
			default:
				break;
    	}
    	return target;
    }
    
    public String buzhengXml(HttpServletRequest request){
    	String rtnStr = "";
    	String deptName = CTools.dealString(request.getParameter("dept_name"));
    	String bzgzs_num = CTools.dealString(request.getParameter("bzgzs_num"));
    	String bzsqb_num = CTools.dealString(request.getParameter("bzsqb_num"));
    	String fileName = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "infoopen.html";
    	rtnStr = getTemplateEle(fileName);
    	rtnStr = rtnStr.replaceAll("_deptname",deptName);
    	rtnStr = rtnStr.replaceAll("_bzgzs_num",bzgzs_num);
    	rtnStr = rtnStr.replaceAll("_bzsqb_num",bzsqb_num);
    	return rtnStr;
    }
    
    /**
	 * 申请表单
	 * @param filepath
	 * @return
	 */
	public String applyopenparseXml(String applyid) {
		StringBuffer rtnSb = new StringBuffer();
		String rtnStr = "";
		String _flownum = ""; //流水号
		String _proposer = ""; //申请人类型：个人 0，企业 1
		String _pname = ""; //申请人姓名（个人）
		String _pcard = ""; //证件名称
		String _pcardnum = ""; //证件号
		String _ename = ""; // 申请人（法人或者其他组织）名称
		String _edeputy = ""; //法定代表人
		String _paddress = ""; //通信地址
		String _pzipcode = "";  //邮政编码
		String _ptele = ""; //联系电话
		String _elinkman = ""; //联系人
		String _eemail = ""; //电子邮箱
		String _dname = ""; //政府信息公开义务机关（机构）名称
		String _infotitle = ""; //政府信息名称
		String _indexnum = ""; //政府信息文号
		String _commentinfo = ""; //或者其他特征描述
		String _gainmode = ""; 
		String temp = "";
		String[] gainmodeList = new String[]{"邮寄","递送","电子邮件","传真","当面领取","现场查阅"};//获取政府信息的方式 √邮寄&nbsp;&nbsp; □传真&nbsp;&nbsp; □递送&nbsp;&nbsp;□当面领取&nbsp;&nbsp;□现场查阅　&nbsp;&nbsp;□电子邮件
		String _offermode = ""; 
		String[] offermodeList = new String[]{"纸质文本","电子邮件","磁盘","光盘"};//政府信息的载体形式 □纸质文本 &nbsp;&nbsp;&nbsp;&nbsp;□光盘 &nbsp;&nbsp;&nbsp;&nbsp;□磁盘 &nbsp;&nbsp;&nbsp;&nbsp;□电子邮件
		String _purpose = ""; 
		String[] purposeList = new String[]{"生产的需要","生活的需要","科研的需要","查验自身信息"};//所需政府信息的用途□生产的需要&nbsp;&nbsp;&nbsp;&nbsp; □生活的需要 &nbsp;&nbsp;&nbsp;&nbsp; □科研的需要&nbsp;&nbsp;&nbsp;&nbsp; □查验自身信息
		String _free = ""; //特别声明
		String[] freeList = new String[]{"属于享受城乡居民最低生活保障对象","确有其他经济困难"};//特别声明
		String _applytime = ""; //申请时间
		
		String filepath = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "/XMLtemplate/" + "apply.html";
		
		String applySql = "select id,infoid,infotitle,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode,ptele," +
				"pemail,ename,ecode,ebunissinfo,edeputy,elinkman,etele,eemail,to_char(applytime,'yyyy-MM-dd') as applytime,commentinfo,indexnum,purpose," +
				"ischarge,offermode,gainmode,othermode,feedback,status,dealmode,finishtime,ispublish,signmode,did,dname," +
				"flownum,isspot,isrunit,fdid,fdname,applymode,limittime,olimittime,memo,us_id,checktype,isovertime,systemname," +
				"sender,putstatus,step,stepmessage,status_name,lastmessage,free,parentid from infoopen where id = "+applyid;
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		//System.out.println("---------------filepath = " + filepath);
		try{
			//取得申请页面的模板；
			rtnSb.append(getTemplateEle(filepath));
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			
			// 取得数据；
			content = dImpl.getDataInfo(applySql);
			if(content!=null){
				_flownum = CTools.dealNull(content.get("flownum"));
				_proposer = CTools.dealNull(content.get("proposer"));
				if("0".equals(_proposer)){
					_pname = CTools.dealNull(content.get("pname"));
					_pcard = CTools.dealNull(content.get("pcard"));
					_pcardnum = CTools.dealNull(content.get("pcardnum"));
					_paddress = CTools.dealNull(content.get("paddress"));
					_pzipcode = CTools.dealNull(content.get("pzipcode"));
					_ptele = CTools.dealNull(content.get("ptele"));
					_elinkman = CTools.dealNull(content.get("elinkman"));
					_eemail = CTools.dealNull(content.get("pemail"));
					
				}else if("1".equals(_proposer)){
					_ename = CTools.dealNull(content.get("ename"));
					_elinkman = CTools.dealNull(content.get("elinkman"));
					_paddress = CTools.dealNull(content.get("paddress"));
					_pzipcode = CTools.dealNull(content.get("pzipcode"));
					_eemail = CTools.dealNull(content.get("eemail"));
					_ptele = CTools.dealNull(content.get("etele"));
					_edeputy = CTools.dealNull(content.get("edeputy"));
				}
				_infotitle = CTools.dealNull(content.get("infotitle"));
				_indexnum = CTools.dealNull(content.get("indexnum"));
				_commentinfo = CTools.dealNull(content.get("commentinfo"));
				_dname = CTools.dealNull(content.get("dname"));
				
				_gainmode = CTools.dealNull(content.get("gainmode"));
				if("".equals(_gainmode))
					_gainmode = "-1";
				else
					_gainmode = CTools.dealNumber(_gainmode);
				
				_offermode = CTools.dealNull(content.get("offermode"));
				if("".equals(_offermode))
					_offermode = "-1";
				else
					_offermode = CTools.dealNumber(_offermode);
				
				_purpose = CTools.dealNull(content.get("purpose"));
				
				_free = CTools.dealNull(content.get("free"));
				if("".equals(_free))
					_free = "3";
				else
					_free = CTools.dealNumber(_free);
				
				
				_applytime = CTools.dealNull(content.get("applytime"));
			}
			
			//对应替换文本
			rtnStr = rtnSb.toString();
			rtnStr = rtnStr.replaceAll("_flownum",_flownum);	//流水号
			rtnStr =rtnStr.replaceAll("_pname",_pname);			//申请人（个人）名称
			rtnStr =rtnStr.replaceAll("_pcard",_pcard);			//证件名称
			rtnStr =rtnStr.replaceAll("_cardnum",_pcardnum);			//证件号
			rtnStr =rtnStr.replaceAll("_ename",_ename);			//申请人（法人或者其他组织）名称
			rtnStr =rtnStr.replaceAll("_edeputy",_edeputy);			//法定代表人
			rtnStr =rtnStr.replaceAll("_paddress",_paddress);			//通信地址
			rtnStr =rtnStr.replaceAll("_pzipcode",_pzipcode);			//邮政编码
			rtnStr =rtnStr.replaceAll("_ptele",_ptele);			//联系电话
			rtnStr =rtnStr.replaceAll("_elinkman",_elinkman);			//联系人
			rtnStr =rtnStr.replaceAll("_eemail",_eemail);			//电子邮箱
			rtnStr =rtnStr.replaceAll("_dname",_dname);			//政府信息公开义务机关（机构）名称
			rtnStr =rtnStr.replaceAll("_infotitle",_infotitle);			//政府信息名称
			rtnStr =rtnStr.replaceAll("_indexnum",_indexnum);			//政府信息文号
			rtnStr =rtnStr.replaceAll("_commentinfo",_commentinfo);			//或者其他特征描述
			
			//获取政府信息的方式
			for(int cnt = 0; cnt < gainmodeList.length; cnt++){
				if(_gainmode.equals(String.valueOf(cnt))){
					temp += "√" + gainmodeList[cnt];
				}else{
					temp += "□" + gainmodeList[cnt];
				}
				temp += "&nbsp;&nbsp;";
			}
			rtnStr =rtnStr.replaceAll("_gainmode",temp);
			temp = "";
			
			//政府信息的载体形式 _offermode
			for(int cnt = 0; cnt < offermodeList.length; cnt++){
				if(_offermode.equals(String.valueOf(cnt))){
					temp += "√" + offermodeList[cnt];
				}else{
					temp += "□" + offermodeList[cnt];
				}
				temp += "&nbsp;&nbsp;";
			}
			rtnStr =rtnStr.replaceAll("_offermode",temp);
			temp = "";
			
			//所需政府信息的用途 _purpose
			for(int cnt = 0; cnt < purposeList.length; cnt++){
				if(_purpose.indexOf(purposeList[cnt]) != -1){
					temp += "√" + purposeList[cnt];
				}else{
					temp += "□" + purposeList[cnt];
				}
				temp += "&nbsp;&nbsp;";
			}
			rtnStr =rtnStr.replaceAll("_purpose",temp);
			temp = "";
			
			//特别声明
			for(int cnt = 0; cnt < freeList.length; cnt++){
				if(_free.indexOf(String.valueOf(cnt + 1)) != -1){
					temp += "√" + freeList[cnt];
				}else{
					temp += "□" + freeList[cnt];
				}
				temp += "&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			rtnStr =rtnStr.replaceAll("_free",temp);
			temp = "";
			if(_applytime.length() >= 10)
				_applytime = _applytime.substring(0,4) + "年" + _applytime.substring(5,7) + "月" + _applytime.substring(8,10) + "日";
			rtnStr =rtnStr.replaceAll("_applytime",_applytime); //申请时间
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return rtnStr;
	}
	/**
	 * 返回补正提交的时间
	 * @param id
	 * @return
	 */
	public String getBuTime(String id){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		String bapplyyear =  "";
		String bapplymonth = "";
		String bapplyday = "";
		String butime = "";
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			//String sqlStr = "select to_char(starttime,'yyyy') as bapplyyear,to_char(starttime,'MM') as bapplymonth,to_char(starttime,'dd') as bapplyday from taskcenter where iid ="+id+" and rownum = 1   order by id desc  ";
			String sqlStr = " select to_char(starttime,'yyyy') as bapplyyear,to_char(starttime,'MM') as bapplymonth,to_char(starttime,'dd') as bapplyday from taskcenter where id=(select max(id) from (select id from taskcenter where iid = "+id+" order by id desc))";
			content = dImpl.getDataInfo(sqlStr);
			if (content != null) {
				bapplyyear = CTools.dealNull(content.get("bapplyyear"));
				bapplymonth = CTools.dealNull(content.get("bapplymonth"));
				bapplyday = CTools.dealNull(content.get("bapplyday"));
			}
			butime = bapplyyear+"年"+bapplymonth+"月"+bapplyday+"日";
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return butime;
	}
	
}
