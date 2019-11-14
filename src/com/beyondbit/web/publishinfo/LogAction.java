/**
 * 2007-01-12
 */
package com.beyondbit.web.publishinfo;
import com.beyondbit.web.form.PublishForm;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.component.database.CLog;

/**
 * @author Administrator
 * 记录下后台登入用户操作过的记录
 */
public class LogAction {
	
	private PublishForm form1 = null;
	
	public LogAction() {}
	
	public LogAction(PublishForm form) {
		form1 = form;
	}
	
	/**
	 * 记录日志
	 * @param userName
	 * @param infoStatus
	 * @param userId
	 */
	public void setLog(String userName,String infoStatus,String userId) {
		String action = getType(infoStatus);
	    CDataCn dCn = new CDataCn();
		CLog log = new CLog(dCn); 
		String ct_id = form1.getCtId();
		String ct_title = form1.getCtTitle();
		if (!"".equals(userId)) action += "," + userId;
		if (!"".equals(ct_id)) action += "," + ct_id;
		log.setLog(CLog.ACTION,action,ct_title,userName);
		dCn.closeCn();
	}
	
	public void setDelLog(String userName,String action,String ct_title) {
		CDataCn dCn = new CDataCn();
		CLog log = new CLog(dCn); 
		log.setLog(CLog.ACTION,"删除" + action,ct_title,userName);
		dCn.closeCn();
	}
    
	/**
	 * 确定用户的操作状态
	 * //1--新增 2--修改  3--审核 4-审批 5-退回 6-正式发布 7-退回修改
	 * @param infoStatus	操作状态
	 * @return
	 */
	private String getType(String infoStatus) {
		String reType = "";
		if (infoStatus == null) return "无记录";
		if ("".equals(infoStatus)) return "无记录";
		int i = Integer.parseInt(infoStatus);
		switch (i) {
			case 1: reType = "新增";break;
			case 2: reType = "修改";break;
			case 3: reType = "审核";break;
			case 4: reType = "审批";break;
			case 5: reType = "退回";break;
			case 6: reType = "正式发布";break;
			case 7: reType = "退回修改";break;
		}
		return reType;
	}
	
	public static void main(String args[]) {
		LogAction lan = new LogAction();
		System.out.println(lan.getType("1"));
	}
	
}
