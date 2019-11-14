package com.emailService;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Vector;
import sun.misc.BASE64Encoder;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;

/**
 * @version1.0
 * @author yo 20090820
 * 	第三个接口--暂时未用
 */
public class CTransEmail {
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	ResultSet rs = null;
	Vector vector = null;
	Hashtable content = null;
	Hashtable contentwh = null;
	Hashtable contentsh = null;
	Hashtable contentxf = null;
	//
	private String strSql = "";
	public ArrayList lists  = new ArrayList();
	String [] fList = null;
	String FilePath = "";
	/**
	 * 构造函数
	 */
	public CTransEmail(){}
	/**
	 * 获得处理完成的那封信件反馈给
	 * @return String
	 */
	public String getEmails(){
		EmailModel emailmodel = new EmailModel();
		EmailModel attachmodel = new EmailModel();
//		CMySelf self = (CMySelf)session.getAttribute("mySelf");
//		String selfdtid = String.valueOf(self.getDtId());
//		String sender_id = String.valueOf(self.getMyID());
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			//文件读取路径
			String path = dImpl.getInitParameter("workattach_save_path");
			strSql = "select * from (select cw_id,cw_number,cw_applytime,cw_applyingname,cw_parentid,cw_applyingdept,cw_telcode,cw_email,cw_zhuanjiao,cw_feedback,us_id,dd_id,cw_transmittime,cw_subject,cw_content,cw_status from tb_connwork  where cw_zhuanjiao = 0 order by cw_applytime desc) where rownum<2";
			content  =dImpl.getDataInfo(strSql);
			if(content!=null)
			{
				//表tb_connwork
				emailmodel.setCw_number(URLEncoder.encode(CTools.dealNull(content.get("cw_id")),"utf-8"));//信访cw_id
				emailmodel.setCw_incepttime(URLEncoder.encode(CTools.dealNull(content.get("cw_applytime")),"utf-8"));//信访接收时间
				emailmodel.setCw_applyname(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingname")),"utf-8"));//信访人
				emailmodel.setCw_emailfor(URLEncoder.encode(CTools.dealNull(content.get("dd_id")),"utf-8"));//信访目的
				emailmodel.setCw_applywork(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingdept")),"utf-8"));//信访人的单位
				emailmodel.setCw_applyaddress(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingdept")),"utf-8"));//信访人的地址
				emailmodel.setCw_applytel(URLEncoder.encode(CTools.dealNull(content.get("cw_telcode")),"utf-8"));//信访人的电话
				emailmodel.setCw_applyemail(URLEncoder.encode(CTools.dealNull(content.get("cw_email")),"utf-8"));//信访人的email
				emailmodel.setCw_zhuanjiao(URLEncoder.encode(CTools.dealNull(content.get("cw_zhuanjiao")),"utf-8"));//信件转交状态
				emailmodel.setCw_closeadvice(URLEncoder.encode(CTools.dealNull(content.get("cw_feedback")),"utf-8"));//办结意见
				emailmodel.setCw_is_us(URLEncoder.encode(CTools.dealNull(content.get("us_id")),"utf-8"));//为空代表不是注册用户
				emailmodel.setCw_deptdeliver_to(URLEncoder.encode(CTools.dealNull(content.get("cw_transmittime")),"utf-8"));//其他部门转交时间
				emailmodel.setCw_strSubject(URLEncoder.encode(CTools.dealNull(content.get("cw_subject")),"utf-8"));//信访主题
				//对cw_content进行过滤特殊符号
				String cw_content = CTools.dealNull(content.get("cw_content"));
				cw_content = cw_content.replace("<", "&lt;");
				cw_content = cw_content.replace(">", "&gt;");
				cw_content = cw_content .length() > 1500 ? cw_content .substring(0,1450) + ".." : cw_content ;
				emailmodel.setCw_strContent(URLEncoder.encode(cw_content,"utf-8"));//信访内容
				//
				emailmodel.setCw_status(URLEncoder.encode(CTools.dealNull(content.get("cw_status")),"utf-8"));//该信访信件的状态
				emailmodel.setCw_querynum(URLEncoder.encode(CTools.dealNull(content.get("cw_number")),"utf-8"));//查询序列号
				emailmodel.setCw_emailfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//信访来源信箱
				//
				strSql="select e.de_requesttime,d.co_corropioion from tb_documentexchange e,tb_correspond d where d.co_id = e.de_primaryid and d.cw_id = '"+content.get("cw_id")+"'";
				contentwh  =dImpl.getDataInfo(strSql);
				if(contentwh!=null){
					emailmodel.setCw_transtimelimit(URLEncoder.encode(CTools.dealNull(contentwh.get("de_requesttime")),"utf-8"));//转办时限
					emailmodel.setCw_transadvice(URLEncoder.encode(CTools.dealNull(contentwh.get("co_corropioion")),"utf-8"));//转办部门意见
				}
				//
				strSql="select p.cp_name,d.dt_name from tb_connproc p,tb_connwork c,tb_deptinfo d where c.cp_id = p.cp_id and p.dt_id = d.dt_id and c.cw_id = '"+content.get("cw_id")+"'";
				contentsh  =dImpl.getDataInfo(strSql);
				if(contentsh!=null){
					emailmodel.setCw_transdept(URLEncoder.encode(CTools.dealNull(contentsh.get("dt_name")),"utf-8"));//转办部门
					emailmodel.setCw_receivedept(URLEncoder.encode(CTools.dealNull(contentsh.get("cp_name")),"utf-8"));//信访件接受部门
					emailmodel.setCw_deptfrom(URLEncoder.encode(CTools.dealNull(contentsh.get("cp_name")),"utf-8"));//来自其他部门
					emailmodel.setCw_closedept(URLEncoder.encode(CTools.dealNull(contentsh.get("cp_name")),"utf-8"));//当前办结部门
				}
				emailmodel.setCw_closer(URLEncoder.encode(CTools.dealNull(content.get("cw_closer")),"utf-8"));//办结人 -- 当前后台登录部门用户
				//查出附件内容进行base64编码
				strSql="select aa_filename,aa_im_name,aa_path from tb_appealattach where cw_id='"+content.get("cw_id")+"'";
				vector = dImpl.splitPage(strSql,20,1);
				if(vector!=null){
					for(int j=0;j<vector.size();j++)
		            {
						contentxf = (Hashtable)vector.get(j);
						attachmodel.setAa_name(URLEncoder.encode(CTools.dealNull(contentxf.get("aa_filename")),"utf-8"));//信件附件名称
						//对附件的内容进行base64位编码
						String aa_path = contentxf.get("aa_path").toString();
						if(!aa_path.equals("")){
							java.io.File imgDir = new java.io.File(path + aa_path);
							if (imgDir.exists()){
								fList = imgDir.list();
								if (!fList[fList.length-1].equals("")){
								  FilePath = path + aa_path + "\\" + fList[fList.length-1];
								}
							 }
						}
						//根据路径读取附件
						String attachContent = this.readFile(FilePath);
						attachmodel.setAa_content(URLEncoder.encode(attachContent,"utf-8"));//信件附件内容
						//
						lists.add(attachmodel);
		            }
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return emailXml(emailmodel,lists);
	}
	/**
	 *  将 File 进行 BASE64 编码 
	 * @param filePath
	 * @return
	 */
	public static String readFile(String filePath) {
	  try {
		   BASE64Encoder encoder = new BASE64Encoder();
		   File file = new File(filePath);
		   FileInputStream in = new FileInputStream(file);
		   byte[] b = new byte[(int) file.length()];
		   in.read(b);
		   String result =encoder.encode(b);
		   in.close();
		   return result;
	  } catch (Exception e) {
		  e.printStackTrace();
	  }
	  return null;
	 }
	/**
	 * 拼接成XML字符串并传递 
	 * @param email
	 * @param list
	 * @return
	 */
	private String emailXml(EmailModel email,ArrayList list) {
		StringBuffer emailXml  =new StringBuffer();
		emailXml.append("<BZNETLVENCINFO>");
		emailXml.append("<NETLVID>"+email.getCw_number()+"</NETLVID>");//网上信访件ID
		emailXml.append("<RECEIVETIME>"+email.getCw_incepttime()+"</RECEIVETIME>");//信访接收时间
		emailXml.append("<SENDER>"+email.getCw_applyname()+"</SENDER>"); //信访发送人
		emailXml.append("<MAILBOX>"+email.getCw_emailfrom()+"</MAILBOX>");  //信访来源信箱
		emailXml.append("<PURPOSE>"+email.getCw_emailfor()+"</PURPOSE>"); //信访目的
		emailXml.append("<DEPT>"+email.getCw_applywork()+"</DEPT>");  //信访人的单位
		emailXml.append("<ADDRESS>"+email.getCw_applyaddress()+"</ADDRESS >"); //信访人的地址
		emailXml.append("<TEL>"+email.getCw_applytel()+"</TEL>");//信访人的电话
		emailXml.append("<EMAIL>"+email.getCw_applyemail()+"</EMAIL>");//信访人的邮箱
		emailXml.append("<REGISTER>"+email.getCw_is_us()+"</REGISTER>");//是否注册用户
		emailXml.append("<HANDOVER>"+email.getCw_deptfrom()+"</HANDOVER>");//来自其他部门
		emailXml.append("<HANDOVERTIME>"+email.getCw_deptdeliver_to()+"</HANDOVERTIME>");//其他部门转交时间
		emailXml.append("<TITLE>"+email.getCw_strSubject()+"</TITLE>");//信访主题
		emailXml.append("<CONTENT>"+email.getCw_strContent()+"</CONTENT>");//信访内容
		emailXml.append("<RECEIVEDEPT>"+email.getCw_receivedept()+"</RECEIVEDEPT>");//信件接受部门
		emailXml.append("<QUERYNUM>"+email.getCw_querynum()+"</QUERYNUM>");//信件查询序列号
		emailXml.append("<TRANSDEPT>"+email.getCw_transdept()+"</TRANSDEPT>");//转办部门
		emailXml.append("<TRANSTIMELIMIT>"+email.getCw_transtimelimit()+"</TRANSTIMELIMIT>");//转办时限
		emailXml.append("<TRANSADVICE>"+email.getCw_transadvice()+"</TRANSADVICE>");//转办部门意见
		emailXml.append("<CLOSEDEPT>"+email.getCw_closedept()+"</CLOSEDEPT>");//当前办结部门
		emailXml.append("<CLOSER>"+email.getCw_closer()+"</CLOSER>");//办结人
		emailXml.append("<CLOSEADVICE>"+email.getCw_closeadvice()+"</CLOSEADVICE>");//办结意见
		emailXml.append("</BZNETLVENCINFO>");
        //如果有多份附件
		emailXml.append("<list type=\"BZENCLOSURE\">");
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				EmailModel emailm = (EmailModel)list.get(i);
				emailXml.append("<BZENCLOSURE rowNum=\""+i+"\">");
				emailXml.append("<ENCNAME>"+emailm.getAa_name()+"</ENCNAME>");//附件主题
				emailXml.append("<ENCCONTENT>"+emailm.getAa_content()+"</ENCCONTENT>");//附件内容
				emailXml.append("</BZENCLOSURE>");
			}
		}
		emailXml.append("</list>");
		//
		String emailMessage="<xml>"+emailXml+"</xml>";
		return emailMessage;
	}
	/**
	 * main 
	 * @param args
	 */
	public static void main(String args[]){
		CTransEmail ctmail = new CTransEmail();
		System.out.println("trans--------------"+ctmail.getEmails());
	}
}
