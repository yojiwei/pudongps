package com.beyondbit.soft2.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class CMessageProxy {
	private Logger logger;

	private SimpleDateFormat sdf;
	private long mtId = -1;

	private CDataImpl dImpl = null;

	/**
	 * 写消息使用此构造方法
	 * @param dCn
	 * @param msTypeCode
	 */
	public CMessageProxy(CDataCn dCn, String msTypeCode) {
		logger = Logger.getLogger(CMessageProxy.class);
		this.dImpl = new CDataImpl(dCn);
		sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mtId = this.getMessageTypeId(msTypeCode);
		System.out.println("mt_id1: " + mtId);
	}
	
	/**
	 * 读消息使用此构造方法
	 * @param dCn
	 */
	public CMessageProxy(CDataCn dCn) {
		logger = Logger.getLogger(CMessageProxy.class);
		this.dImpl = new CDataImpl(dCn);
		sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 新增消息
	 * @param message 消息对象
	 */
	public void addMessage(CMessage message) {
		dImpl.setTableName("tbl_message");
		dImpl.setPrimaryFieldName("ms_id");
		message.setMs_id(Long.toString(dImpl.addNew()));
		message.setMt_id(String.valueOf(mtId));
		System.out.println("mt_id2: " + String.valueOf(mtId));

		message.setMs_isnew("0");
		dImpl.setValue("ms_isnew", message.getMs_isnew(), CDataImpl.STRING);

		if (message.getMt_id() == null) {
			logger.warn("未设置消息类型，使用默认类型0");
			message.setMt_id("0");
			dImpl.setValue("mt_id", message.getMt_id(), CDataImpl.INT);
			
		}
		dImpl.setValue("mt_id", message.getMt_id(), CDataImpl.INT);
		System.out.println("mt_id3: " + message.getMt_id());

		if (message.getMs_senderid() == null) {
			logger.warn("未设置消息发送者id!");
			message.setMs_senderid("-1");
		}
		dImpl.setValue("ms_senderid", message.getMs_senderid(), CDataImpl.INT);

		if (message.getMs_receiverid() == null) {
			logger.warn("未设置消息接受者id!");
			message.setMs_receiverid("-1");
		}
		dImpl.setValue("ms_receiverid", message.getMs_receiverid(),
				CDataImpl.INT);

		if (message.getMs_title() == null) {
			logger.warn("未设置消息标题!");
			message.setMs_title("(无标题)");
		}
		dImpl.setValue("ms_title", message.getMs_title(), CDataImpl.STRING);

		if (message.getMs_content() == null) {
			logger.warn("未设置消息内容!");
			message.setMs_content("(无内容)");
		}
		dImpl.setValue("ms_content", message.getMs_content(), CDataImpl.STRING);

		if (message.getMs_direction() == null) {
			logger.warn("未设置消息发送方向!");
			message.setMs_direction("0");
		}
		dImpl.setValue("ms_direction", message.getMs_direction(),
				CDataImpl.STRING);

		if (message.getMs_sendername() != null) {
			dImpl.setValue("ms_sendername", message.getMs_sendername(),
					CDataImpl.STRING);
		}

		dImpl.setValue("ms_sendtime", sdf.format(Calendar.getInstance()
				.getTime()), CDataImpl.DATE);
		;

		if (message.getMs_receivername() != null) {
			dImpl.setValue("ms_receivername_6", message.getMs_receivername(),
					CDataImpl.STRING);
		}

		if (message.getMs_primaryid() != null) {
			dImpl.setValue("ms_primaryid", message.getMs_primaryid(),
					CDataImpl.INT);
		}

		dImpl.update();
	}

	/**
	 * 阅读消息
	 * 
	 * @param msId 消息id
	 * @return CMessage 消息对象
	 */
	public CMessage readMessage(String msId) {
		CMessage [] messages = this.getMessageByMsid(msId);
		if(messages.length > 0){
			if (messages[0].getMs_isnew().equals("0")) {
				dImpl.edit("tbl_message", "ms_id", Long.parseLong(msId));
				dImpl.setValue("ms_isnew", "1", CDataImpl.STRING);
				dImpl.setValue("ms_receivetime", sdf.format(Calendar.getInstance()
						.getTime()), CDataImpl.DATE);
				dImpl.update();
			}
			return messages[0];
		}
		return null;
	}

	/**
	 * 根据消息ID获取消息内容
	 * 
	 * @param msId
	 *            String
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage [] getMessageByMsid(String msId) {
		return getMessageBySQL("select * from tbl_message where ms_id=" + msId);
	}

	/**
	 * 根据消息发送者ID获取消息内容
	 * @param senderId 发送者id
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageBySenderid(String senderId) {
		return getMessageBySQL("select * from tbl_message where ms_senderid=" + senderId + " order by ms_sendtime desc");
	}
	
	/**
	 * 获取与某人相关的某类型消息
	 * @param personId 用户id
	 * @param mtCode 消息类型代码
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageByPersonType(String personId, String mtCode) {
		return getMessageBySQL("select * from tbl_message where ms_receiverid=" + personId	+ " or ms_senderid=" + personId	+ " and mt_id in (select mt_id from tbl_messagetype where mt_code='" + mtCode + "') order by ms_sendtime desc");
	}
	
	/**
	 * 获取与某类型的事件相关消息
	 * @param pkId 事件id
	 * @param mtCode 消息类型代码
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageByAffairType(String pkId, String mtCode) {
		return getMessageBySQL("select * from tbl_message where ms_primaryid=" + pkId	+ " and mt_id in (select mt_id from tbl_messagetype where mt_code='" + mtCode + "') order by ms_sendtime desc");
	}

	/**
	 * 根据消息接受者ID获取消息内容
	 * 
	 * @param receiverId 消息接受者id
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageByReceiverid(String receiverId) {
		return getMessageBySQL("select * from tbl_message where ms_receiverid=" + receiverId + " order by ms_sendtime desc");
	}

	/**
	 * 获取与某人相关的所有消息
	 * 
	 * @param personId 用户id
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageByPerson(String personId) {
		return getMessageBySQL("select * from tbl_message where ms_receiverid=" + personId	+ " or ms_senderid=" + personId	+ " order by ms_sendtime desc");
	}

	/**
	 * 获取与某事件相关的所有消息
	 * 
	 * @param primaryId 事件id
	 * @param mtId 消息类型代码
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageByAffair(String primaryId, String mtId) {
		return getMessageBySQL("select * from tbl_message where ms_receiverid=" + primaryId 	+ " and mt_id=" + mtId + " order by ms_sendtime desc");
	}
	
	/**
	 * 获取与某人做某事件相关的所有消息
	 * 
	 * @param personId 用户id
	 * @param primaryId 事件id
	 * @param mtId 消息类型代码
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageByPersonAffair(String personId, String primaryId, String mtId) {
		return getMessageBySQL(	"select * from tbl_message where ms_receiverid=" + primaryId + " and mt_id=" + mtId + " and (ms_senderid=" + personId + " or ms_receiverid=" + personId + ") order by ms_sendtime desc");
	}
	
	/**
	 * 根据SQL语句查消息
	 * 
	 * @param sql SQL语句
	 * @return CMessage [] 消息对象数组
	 */
	public CMessage[] getMessageBySQL(String sql) {
		CMessage[] messages = null;
		Vector vector = dImpl.splitPage(sql, 1000, 1);
		if (vector != null) {
			messages = new CMessage[vector.size()];
			for (int i = 0, n = vector.size(); i < n; i++) {
				Hashtable content = (Hashtable) vector.get(i);
				messages[i] = new CMessage();
				messages[i].setMessageContent(content);
			}
		}
		if (messages == null)
			messages = new CMessage[0];
		return messages;
	}

	/**
	 * 删除消息
	 * @param msId 消息id
	 */
	public void deleteMessage(String msId) {
		dImpl.delete("tbl_message", "ms_id", Long.parseLong(msId));
		dImpl.update();
	}
	
	/**
	 * 获取所有消息类型
	 * @return table Hashtable 每个Entry为id/name对 
	 */
	public Hashtable getMessageTypes(){
		Hashtable table = null;
		Vector vPage = dImpl.splitPage("select mt_id, mt_name from tbl_messagetype", 100, 1);
		if (vPage != null) {
			table = new Hashtable();
			for (int i = 0, n = vPage.size(); i < n; i++) {
				Hashtable content = (Hashtable)vPage.get(i);
				String mt_id = content.get("mt_id").toString();
				String mt_name = content.get("mt_name").toString();
				table.put(mt_id, mt_name);
			}
			
		}
		return table;
	}
	
	/**
	 * 获取所有消息类型
	 * @return table Hashtable 每个Entry为id/name对 
	 */
	public Hashtable getEnglishMessageTypes(){
		Hashtable table = null;
		Vector vPage = dImpl.splitPage("select mt_id, mt_engname from tbl_messagetype", 100, 1);
		if (vPage != null) {
			table = new Hashtable();
			for (int i = 0, n = vPage.size(); i < n; i++) {
				Hashtable content = (Hashtable)vPage.get(i);
				String mt_id = content.get("mt_id").toString();
				String mt_name = content.get("mt_engname").toString();
				table.put(mt_id, mt_name);
			}
			
		}
		return table;
	}
	
	public long getMessageTypeId(String msTypeCode){
		long mt_id = 0;
		Hashtable content = dImpl.getDataInfo("select mt_id from tbl_messagetype where mt_code='" + msTypeCode.trim() + "'");
		System.out.println("select mt_id from tbl_messagetype where mt_code='" + msTypeCode.trim() + "'");
		if (content != null) {
			mt_id = Long.parseLong(content.get("mt_id").toString());
		}
		return mt_id;
	}

	public static void main(String[] args) {
		CDataCn dCn = new CDataCn();
		CMessageProxy proxy = new CMessageProxy(dCn,"licenceoperator");
//		CMessage message = new CMessage();
//		System.out.println(proxy.getMessageTypeId("licenceoperator"));
//		System.out.println(proxy.mtId);
//		message.setMt_id(String.valueOf(proxy.mtId));
//		System.out.println(message.getMt_id());
//
//		//proxy.readMessage("5");
//		//proxy.deleteMessage("2");
//
//		CMessage message = new CMessage();
//
//		message.setMs_content("test");
//		message.setMs_direction("1");
//		message.setMs_primaryid("44");
//		message.setMs_receiverid("3");
//		message.setMs_receivername("test");
//		message.setMs_senderid("1");
//		message.setMs_sendername("sender");
//		message.setMs_title("tstt");
//		message.setMt_id("1");
//		//message.readMessage("5");
//
////		proxy.addMessage(message);
//		
//		Hashtable types = proxy.getMessageTypes();
//		Set keySet = types.keySet();
//		Iterator iterator = keySet.iterator();
//		while (iterator.hasNext()) {
//			String key = (String) iterator.next();
//			String value = types.get(key).toString();
//			System.out.println(key);
//			System.out.println(value);
//		}
	}
}
