package com.beyondbit.dom4j;

import java.util.List;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * 权力事项xml解析类
 * @author chentianyu
 *
 */
public class PowerStdParse {
	private static Logger logger = Logger.getLogger(PowerStdParse.class);
	public final String MESSAGE_BODY_ELEMENT = "MessageBody";
	/**
	 * webservice 方法，解析并处理xml输入
	 * @param inputXml
	 * @return String 返回success为处理成功
	 */
	public String GetInfoData(String BiztalkKey,String BiztalkCode,String Message){
//		System.out.println("get:::----"+Message);
		Document powerDoc;
		try {
			powerDoc = DocumentHelper.parseText(Message);
			//取根元素应该为Message
			Element root = powerDoc.getRootElement();
			//取根元素下的MessageBody元素
			//Element body = root.element(MESSAGE_BODY_ELEMENT);
			//调用老接口
//                        System.out.println(body.asXML());
			Element body = root.element(MESSAGE_BODY_ELEMENT);
			if(body == null){
				return "缺少MessageBody元素";
			}
			List children = body.elements();
			if(children.size() < 1){
				return "MessageBody缺少子元素";
			}
			Element content = (Element) children.get(0);
			//调用老接口
           // System.out.println(content.asXML());
			return new NewParsePowerXml().presistentDataByXml(content.asXML());
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			logger.error(e);
//                        e.printStackTrace();
			return e.getMessage();
		}

	}



}
