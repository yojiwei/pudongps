package com.emailService;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Hashtable;

import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import javax.xml.rpc.encoding.XMLType;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.service.log.LogservicePd;
import com.util.CDate;
import com.util.CTools;
import com.webservise.IGetServicesWS;

/**
 * @version1.0
 * @author yo 20100611
 * 	第二个被调用的邮件接口
 *  判断对方是否调用到、得到对方的相应的反馈
 */
public class CGetEmailService {
	
	public CGetEmailService(){}
	
	int noUpdate = 0;
	SimpleDateFormat logdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * 判断对方是否调用成功并作相应的处理
	 * @param getXmls 被调用者传递的参数
	 * @return true转交成功false转交失败
	 */
	//cw_status 1待处理、2处理中、8协调中、3已处理、*4、已签收、9垃圾、12重复、18父信件完成状态
	//cw_zhuanjiao 0未转交、1转交成功、2转交失败
	public boolean getEmailServcieOne(String getXmls){
		int isUpdate = 1;//0成功1失败
		boolean isSucc = false;//true更新成功 false更新失败
		String log_success = "";
		String cw_id = CASUtil.getUserColumn(getXmls, "NETLVID");
		String cw_content = CASUtil.getUserNoColumn(getXmls, "CONTENT");//不要包含特殊字符getUserNoColumn()不经过解码
		String cw_status = CASUtil.getUserColumn(getXmls, "STATUS");//传递过来的是否接受成功的状态值1成功、2失败
		String cw_num = CASUtil.getUserColumn(getXmls, "NUM");//转交四次仍为转交成功则置为转交失败
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		System.out.println("getEmailServcieOne's getxmls========"+getXmls);
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			if (!cw_id.equals("") && !cw_status.equals("")) {// 转交反馈不为空
				//对方正常接受返回1
				if(cw_status.equals("1")){
					log_success = "成功";
					isUpdate = updateEmailStatus(cw_id,true,dImpl);//去修改该信件为已转交状态 
				}else{
					log_success = "失败";
					noUpdate = Integer.parseInt(cw_num);
					if(noUpdate==4){
						isUpdate = updateEmailStatus(cw_id,false,dImpl);//去修改该信件为转交失败状态
					}
				}
				cw_content = cw_content+" 信访件转交"+log_success; //信访件转交写日志内容
				if(isUpdate==0){
					log_success = "成功";
					isSucc = true;
				}else{
					log_success = "失败";
					isSucc = false;
				}
				cw_content = cw_content+" pudong数据状态修改"+log_success;//信访件修改PUDONG数据状态
				
			}else{
				log_success = "失败";
				cw_content = "getXmls内容相关参数为空无法调用反馈接口";
				isSucc = false;
			}
		}catch(Exception ex){
			cw_content = cw_content+"-catch-出错"+ex.toString();
			log_success = "失败";
			isSucc = false;
		}finally{
			//this.writeLog(cw_id,"信访转交", cw_content, log_success);
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
		return isSucc;
	}
	/**
	 * 修改某信访信件的转交成功状态
	 * @param cw_id 信件ID
	 * @param status 是否转交成功的标志 true转交成功、false转交失败
	 * @param dImpl 数据库链接
	 * @return 0修改状态成功1失败
	 */
	public int updateEmailStatus(String cw_id,boolean status,CDataImpl dImpl){
		try {
			String cp_id = "";
			String seSql = "select cp_id from tb_connwork where cw_id = '"+cw_id+"'";
			Hashtable content  =dImpl.getDataInfo(seSql);
			if(content!=null){
				cp_id = CTools.dealNull(content.get("cp_id"));
			}
			
			dImpl.edit("tb_connwork", "cw_id", cw_id);
			if(status){
				dImpl.setValue("cw_zhuanjiao","1", CDataImpl.STRING);// 信访信件转交状态 1 已转交
				//信访办的处理||环保局的处理
				//if(cp_id.equals("o1")||cp_id.equals("o5")||cp_id.equals("mailYGXX")||cp_id.equals("o11873")||cp_id.equals("o25")){
					dImpl.setValue("cw_status","2", CDataImpl.STRING);// 信件转交成功到处理中
				//}
			}else{
				dImpl.setValue("cw_zhuanjiao","2", CDataImpl.STRING);// 信访信件转交状态 2 转交失败
			}
			dImpl.update();
			return 0;
		} catch (Exception ee) {
			System.out.println("updateEmailStatus-------------"+ee.toString());
			return 1;
		} 
	}
	
	/**
	 * 得到对方处理信件后的反馈
	 *	NOTICETYPE 告知单类型
	 *	1:受理告知单
	 *	2:不予受理告知单
	 *	3:转送告知单
	 *	4:处理答复
	 *	@param getXmls 对方处理信件后的反馈xml
	 *  @return true反馈修改成功false反馈修改失败
	*/
	public boolean getEmailServcieTwo(String getXmls){
		String us_id = "";//用户ID
		String cw_email = "";//用户email
		String cw_applyingname = "";//用户名
		String cw_subject = "";
		String ma_content = "";
		String cw_dtname = "";
		String cw_id = "";
		String cw_feedback = "";
		String feedback = "";
		String cw_status = "";
		String logContent = "";
		String logSuccess = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			System.out.println("getEmailServcieTwo's getXMLS========"+getXmls);
			
			if (!getXmls.equals("")) { // 转交反馈不为空
				cw_id = CTools.dealString(CASUtil.getUserColumn(getXmls, "NETLVID")).trim();//信访件ID
				cw_status = CTools.dealString(CASUtil.getUserColumn(getXmls, "STATUS")).trim();//办理反馈的状态
				feedback = cw_feedback = CTools.dealNull(CASUtil.getUserNoColumn(getXmls, "CONTENT")).trim();//信访反馈内容
				
				//注：信访办调用传递过来的CONTENT内容没有经过编码处理
				cw_feedback = cw_feedback.replaceAll(" ", "");//去掉英文空格
				cw_feedback = cw_feedback.replaceAll("　", "");//去掉中文空格
				//cw_feedback = cw_feedback.replaceAll("%", "");//去掉%---如果内容有%，不便处理
				
				if("".equals(cw_feedback)&& "3".equals(cw_status)){//处理完成必须有反馈内容
					logContent = "处理完成但是没有反馈内容";
					logSuccess = "失败";
					return false;
				}else{
				String strSql = "select c.us_id,c.cw_email,c.cw_subject,c.cw_applyingname,p.dt_id,p.dt_name,c.ui_id from tb_connwork c,tb_connproc p where c.cp_id = p.cp_id and c.cw_id ='"+cw_id+"'";
				System.out.println("strSql====="+strSql);
				content  =dImpl.getDataInfo(strSql);
				if(content!=null)
				{
					us_id = CTools.dealNull(content.get("us_id"));
					cw_email = CTools.dealNull(content.get("cw_email"));
					cw_applyingname = CTools.dealNull(content.get("cw_applyingname"));
					cw_subject = CTools.dealNull(content.get("cw_subject"));
					cw_dtname = CTools.dealNull(content.get("dt_name"));
					//反馈到用户的用户中心
						dCn.beginTrans();
						//记录到tb_message表
						 ma_content=cw_subject+"&nbsp;&nbsp;"+feedback;
						 
						 dImpl.addNew("tb_message","ma_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);//新增网上咨询
						 dImpl.setValue("ma_title", cw_subject, CDataImpl.STRING);
				         dImpl.setValue("ma_senderid", "51", CDataImpl.STRING);
				         dImpl.setValue("ma_senderName", cw_dtname, CDataImpl.STRING);
				         dImpl.setValue("ma_senderDesc", cw_dtname, CDataImpl.STRING);
				         dImpl.setValue("ma_receiverId", us_id, CDataImpl.STRING);
				         dImpl.setValue("ma_receiverName", cw_applyingname,CDataImpl.STRING);
				         dImpl.setValue("ma_isNew", "1", CDataImpl.STRING);
				         dImpl.setValue("ma_sendTime", CDate.getThisday(), CDataImpl.DATE);
				         dImpl.setValue("ma_RelatedType", "1",CDataImpl.STRING);
				         dImpl.setValue("ma_primaryid", cw_id, CDataImpl.STRING);
				         dImpl.update();
				         dImpl.setClobValue("ma_content", ma_content);
				         
				        
						//更新tb_connwork表
						//cw_status 1待处理、2处理中、8协调中、3已处理、9垃圾、12重复、4已签收
						dImpl.edit("tb_connwork", "cw_id",cw_id);
						if(cw_status.equals("2")||cw_status.equals("8")||cw_status.equals("9")||cw_status.equals("12"))
						{
							//cw_status = cw_status;
						}else{
							cw_status = "3";
						}
						dImpl.setValue("cw_status",cw_status,CDataImpl.STRING);//信访信件状态
						dImpl.setValue("cw_finishtime",CDate.getThisday(),CDataImpl.DATE);//反馈时间 
						dImpl.setValue("cw_isxd","1",CDataImpl.INT);//信访件反馈是否需要同步给新点0不1是
						dImpl.update();
						dImpl.setClobValue("cw_feedback", feedback);
						
						dCn.commitTrans();
				}
				logContent = "反馈修改浦东数据库";
				logSuccess = "成功";
			 }
				
				//反馈信息给新点
				String strSql = "select ui_id from tb_connwork where cw_id='"+cw_id+"' and cw_isxd = 1";
				content = dImpl.getDataInfo(strSql);
				if(content!=null)
				{
					sendFeedbackMessage(CTools.dealNull(content.get("ui_id")),getXmls);
				}
				
				return true;
			}else{
				logContent = "getXmls相关参数为空调用反馈接口";
				logSuccess = "成功";
				return false;
			}
		}catch(Exception ex){
			logContent = cw_status+"++"+ma_content+"==ERROR=="+ex.fillInStackTrace().getMessage().toString();
			logSuccess = "失败";
			ex.printStackTrace();
			dCn.rollbackTrans();
			return false;
		}finally{
			writeLog(cw_id,"信访反馈",logContent,logSuccess);
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
	}
	
	/**
	 * 依申请公开处理结果反馈给新点
	 * @param feedbackXmls
	 */
	public int sendFeedbackMessage(String ui_id,String feedbackXmls){
		//重新找到对应新点ID
		String xml="<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		xml=xml+"<bznetlvencfeedback>";
		xml=xml+"<netlvid>"+ui_id+"</netlvid>";
		xml=xml+"<content>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "content")).trim()+"</content>";
		xml=xml+"<status>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "STATUS")).trim()+"</status>";
		xml=xml+"<finishtime>"+CTools.dealString(CASUtil.getUserColumn(feedbackXmls, "finishtime")).trim()+"</finishtime>";
		xml=xml+"</bznetlvencfeedback>";
		
		
		
		String uid = "hr_pudong";
		String pwd = "abc456";
		String xdfeedbackservice = "http://61.129.89.214/shpdhrservice/EpointService.asmx?wsdl";//测试地址
		int returnStr = 0;
		String returns = "";
		String gwnamespaceuri = "http://tempuri.org/";
		String gwsoapactionuri = "http://tempuri.org/MailReply";
		try{
			//使用Call
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(xdfeedbackservice));
			call.setOperationName(new QName(gwnamespaceuri, "MailReply"));
			call.addParameter(new QName(gwnamespaceuri,"uid"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"pwd"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new QName(gwnamespaceuri,"xml"), org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(gwsoapactionuri);
			
			returns= (String) call.invoke(new Object[] {uid,pwd,xml});
			if(!"".equals(returns)){
				returnStr = Integer.parseInt(returns);
			}


		}catch(Exception ex){
			ex.printStackTrace();
		}
		return returnStr;
	}
	
	/**
	 * 记录日志
	 * @param cw_id 信件ID
	 * @param cw_content 信件内容
	 * @param log_levn 信访反馈
	 * @param log_success 信件日志成功与否的动作说明
	 */
	public void writeLog(String cw_id,String log_levn,String cw_content,String log_success){
		String log_descript = "";
		LogservicePd logservicepd = new LogservicePd();
		log_descript = "信访办在"+logdf.format(new java.util.Date())+log_levn+" "+cw_id+"-"+cw_content;
		logservicepd.writeLog(log_levn,log_descript,log_success,"pudong");
	}
	 
	/**
	 * main
	 * @param args
	 */ 
	public static void main(String args[]){
		CGetEmailService cgemail = new CGetEmailService();
		//String emailXmls = "<XML><BZNETLVENCFEEDBACK><NETLVID>o42790</NETLVID><NOTICETYPE></NOTICETYPE><CONTENT>你好，这件事，我们不处理的！</CONTENT><STATUS>3</STATUS><NUM>1</NUM></BZNETLVENCFEEDBACK></XML>";
		//String emailXmls = "<XML><BZNETLVENCFEEDBACK><NETLVID>o92603</NETLVID><NOTICETYPE>2</NOTICETYPE><CONTENT>属于垃圾信息，不予受理！</CONTENT><STATUS>9</STATUS><NUM>1</NUM></BZNETLVENCFEEDBACK>";
		//cgemail.getEmailServcieTwo(emailXmls);
		
		String emailXmls = "<?xml version=\"1.0\" encoding=\"utf-8\"?><bznetlvencfeedback><netlvid>42807</netlvid><content>信访反馈的内容77888899</content><status>2</status><finishtime>2016-09-12</finishtime></bznetlvencfeedback>";
		System.out.println("返回值===="+cgemail.sendFeedbackMessage("42807",emailXmls));
		System.out.println(CDate.getNowTime());
	}
	
}
