package com.emailService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CMail;
import com.util.CMessage;
import com.util.CTools;

/**
 * 给删除信件的用户发送短信、邮件、或者电话通知
 * @author yo
 * 2009-08-25
 */
public class CSendEmail {
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	ArrayList arryList = new ArrayList();
	public CSendEmail(){}
	/**
	 * 给xx用户发消息及记录发送情况
	 * @param cw_id 信件ID
	 */
	public void getUserContact(){
		String ucSql = "";
		Hashtable content = null;
		Vector vPage = null;
		String cw_applyingname = "";//发信人姓名
		String cw_id = "";//信件ID
		String cw_subject = "";//发信主题
		String cw_email = "";//发信人信箱
		String cw_content = "";//短信内容
		String us_id = "";//用户ID
		String dt_name = "";//部门名称
		//cw_sendflag是否对用户进行过反馈0正在反馈1反馈成功2反馈失败email
		//cw_sendflagtoo是否对用户进行过反馈0正在反馈1反馈成功2反馈失败tb_message
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			
			ucSql = "select c.cw_id,c.us_id,c.cw_applytime,c.cw_applyingname,c.cw_subject,c.cp_id,c.cw_email," +
					"c.cw_telcode,d.dt_name from tb_connwork c,tb_deptinfo d where c.dd_id = d.dt_id(+) and c.cp_id in('o1','o5','mailYGXX') " +
					"and c.cw_applytime >=to_date('2009-07-02 00:00:01', 'yyyy-MM-dd hh24:mi:ss') and c.cw_applytime <=to_date('2009-08-15 23:59:59', 'yyyy-MM-dd hh24:mi:ss') " +
					"and (c.cw_email is not null or c.us_id is not null) and c.cw_status not in(3,9,12,18) and c.cw_sendflag=0 and c.cw_sendflagtoo=0 ";
			//System.out.println(ucSql);
			vPage = dImpl.splitPage(ucSql,1000,1);
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					content  = (Hashtable)vPage.get(i);
					cw_id = CTools.dealNull(content.get("cw_id"));
					cw_applyingname = CTools.dealNull(content.get("cw_applyingname"));
					cw_subject = CTools.dealNull(content.get("cw_subject"));
					cw_subject = "关于“"+cw_subject+"”的反馈";
					cw_email = CTools.dealNull(content.get("cw_email"));
					us_id = CTools.dealNull(content.get("us_id"));
					dt_name = CTools.dealNull(content.get("dt_name"));
					System.out.println(i+"--"+cw_email+"------------------"+cw_id);
					cw_content = "先生（女士）：<br><br>"+
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由于新区网上信访受理系统升级及办理系统更换，导致您发给新区门户网站区长之窗（阳光信箱）和信访信箱2009年7月2日至8月15日的邮件丢失，内容无法恢复，由此给您带来的诸多不便，我们深表歉意。为此，我们正抓紧组织相关工程技术人员进行处理，特此，请将您发给新区门户网站区长之窗（阳光信箱）和信访信箱的邮件重新发送，同时也非常感谢您对网上信访工作一如既往的给予关心和支持。<br><br>"+
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;特此告知。<br><br><br>"+
						
						"浦东新区信访办<br><br>"+
						"二00九年八月二十八日";
					
					if(!"".equals(us_id)){
						int issu = this.insertMess(cw_id, cw_applyingname, cw_subject, us_id, cw_content, dt_name);
						//发送tb_message成功
						if(issu==0){
							this.editConnWorktoo(cw_id,"1");
						}else{
							this.editConnWorktoo(cw_id, "2");
						}
					}
					if(!"".equals(cw_email)){
						if(this.checkEmail(cw_email)){
							boolean issucc = this.sendEmail(cw_subject,cw_email,cw_content);
							if(issucc){
								//记录邮件发送失败的cw_ids
								this.editConnWork(cw_id,"2");
							}else{
								//记录邮件发送成功的cw_ids
								this.editConnWork(cw_id,"1");
							}
						}else{
							//邮件地址错误记录
							this.editConnWork(cw_id,"2");
						}
					}
				//
				System.out.println("--over--");
				
			}
		}
		}catch(Exception ex){
			System.out.println(ex.toString());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	
	/**
	 * 将反馈信息发送到用户的邮箱
	 * @param us_email 用户邮箱地址
	 * @param us_content 信件内容
	 * @return true发送成功 false发送失败
	 */
	private boolean sendEmail(String cw_subject,String us_email,String us_content){
		//调用浦东邮件服务
//		CMail themail = new CMail("mail.pudong.gov.cn");
//		themail.setSmtpHost("smtp.pudong.gov.cn");
//        themail.setNeedAuth(true);
//        if(!themail.setSubject(cw_subject))
//            return true;
//        if(!themail.setBody(us_content))
//            return true;
//        if(!themail.setTo(us_email))
//            return true;
//        if(!themail.setFrom("pdxf@pudong.gov.cn"))
//            return true;
//        themail.setNamePass("pdxf", "123456");
//        if(!themail.sendout())
//            return true;
//        else
//            return false;
		//调用163邮件服务
		CMail themail = new CMail("smtp.163.com");
        themail.setNeedAuth(true);
        if(!themail.setSubject(cw_subject))
            return true;
        if(!themail.setBody(us_content))
            return true;
        if(!themail.setTo(us_email))
            return true;
        if(!themail.setFrom("yojiwei@163.com"))
            return true;
        themail.setNamePass("yojiwei", "xiaowei163");
        if(themail.sendout())
            return true;
        else
            return false;
        
	}
	
	/**
	 * 验证email
	 * @param email 用户邮件地址
	 * @return true正常邮件地址false错误邮件地址
	 */
	public boolean checkEmail(String email){
        Pattern pattern = Pattern.compile("^\\w+([-.]\\w+)*@\\w+([-]\\w+)*\\.(\\w+([-]\\w+)*\\.)*[a-z]{2,3}$");
        Matcher matcher = pattern.matcher(email);
        if (matcher.matches()){
            return true;
        }
        return false;
    }
	/**
	 * 对用户反馈之后的信件情况email发送进行操作
	 * @param cw_id 信件ID
	 */
	public void editConnWork(String cw_id,String cw_sendflag){
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			//
			dImpl.edit("tb_connwork", "cw_id", cw_id);
			dImpl.setValue("cw_sendflag",cw_sendflag, CDataImpl.STRING);//cw_sendflag是否对用户进行过反馈0正在反馈1反馈成功2反馈失败
			dImpl.update();
		}catch(Exception ex){
			System.out.println(ex.toString());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	/**
	 * 对用户反馈之后的信件情况tb_message进行操作
	 * @param cw_id 信件ID
	 */
	public void editConnWorktoo(String cw_id,String cw_sendflagtoo){
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			//
			dImpl.edit("tb_connwork", "cw_id", cw_id);
			dImpl.setValue("cw_sendflagtoo",cw_sendflagtoo, CDataImpl.STRING);//cw_sendflagtoo是否对用户进行过反馈0正在反馈1反馈成功2反馈失败
			dImpl.update();
		}catch(Exception ex){
			System.out.println(ex.toString());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	/**
	 * 添加到消息表
	 * @param cw_id 信件ID
	 * @param cw_applyingname 发信人
	 * @param cw_subject 信件主题
	 * @param us_id 发信人ID
	 * @param cw_content 消息主要内容
	 * @param dt_name 处理部门
	 */
	public int insertMess(String cw_id,String cw_applyingname,String cw_subject,String us_id,String cw_content,String dt_name){
		try{
			//dCn = new CDataCn("pudongweb");
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			dCn.beginTrans();
			
			CMessage msg = new CMessage(dImpl);
			 msg.addNew();
			 msg.setValue(CMessage.msgReceiverId,us_id);
			 msg.setValue(CMessage.msgReceiverName,cw_applyingname);
			 msg.setValue(CMessage.msgTitle,cw_subject);
			 msg.setValue(CMessage.msgSenderName,dt_name);
			 msg.setValue(CMessage.msgSenderDesc,dt_name);
			 msg.setValue(CMessage.msgIsNew,"1");
			 msg.setValue(CMessage.msgType, "88");
			 msg.setValue(CMessage.msgRelatedType,"1");
			 msg.setValue(CMessage.msgPrimaryId,cw_id);
			 msg.setValue(CMessage.msgSendTime,new CDate().getNowTime());
			 msg.setValue(CMessage.msgContent,cw_content);
			 msg.update();
			 
			 dCn.commitTrans();
			 return 0;
		}catch(Exception ex){
			dCn.rollbackTrans();
			System.out.println(ex.toString());
			return 1;
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		
	}
	/**
	 * main
	 * @param args
	 */
	public static void main(String args[]){
		String testphone = "13120661517";
		String testemail = "yoyo@sina.sss";
		CSendEmail cse = new CSendEmail();
		//System.out.println(cse.checkPhone(testphone)+"--"+cse.checkEmail(testemail));
		//cse.getUserContact();
	}
	
	

}
