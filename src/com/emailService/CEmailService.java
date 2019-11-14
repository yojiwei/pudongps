package com.emailService;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Vector;




import Decoder.BASE64Decoder;
import Decoder.BASE64Encoder;

import com.app.CMySelf;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.jspsmart.upload.Request;
import com.sun.xml.internal.fastinfoset.Decoder;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
import com.util.ReadProperty;
/**
 * @version1.0
 * @author yo 20090820
 * 	第一个被调用的邮件接口
 *  传给调用者最新的邮件
 */
public class CEmailService{
	public ArrayList lists  = new ArrayList();
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	CMySelf  cmy = null;
	ReadProperty pro = null;
	EmailModel emailmodel = new EmailModel();
	EmailModel attachmodel = new EmailModel();
	public CEmailService(){
		pro = new ReadProperty();
	}
	
	/**
	 * 获得最老的未转交并且未处理完的那封信件
	 * @param deptxmls 调用此接口需要传入的XMLS参数（包括用户名、密码等）
	 * @return 拼成XML的信件
	 */
	public String getEmails(String deptxmls){
		String [] fList = null;
		String FilePath = "";
		String strSql = "";
		//部门信访入口
		String deptuser = "";
		String deptpassword = "";
		String deptcp_ids = "";
		//区长名
		String cp_id = "";
		String wd_id = "";
		String wd_name = "";
		String yg_name = "";
		String sqlQz = "";
		String sqlYg = "";
		//
		String logstatus = "";
		String cw_id = "";
		String cw_subject = "";
		
		Hashtable contentQz = null;
		Hashtable contentYg = null;
		boolean islogin = false;
		Vector vector = null;
		Hashtable content = null;
		Hashtable contentxf = null;
		CGetEmailService cget = new CGetEmailService();
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			cmy = new CMySelf();

			//文件读取路径
			//cw_status 1待处理、2处理中、8协调中、3已处理、4、已签收、9垃圾、12重复、18父信件完成状态
			//cw_zhuanjiao 0需要同步、1转交成功、2转交失败、3页面提交后台，需要人工同步操作按钮
			String path = dImpl.getInitParameter("workattach_save_path");
			strSql = "select * from (select c.cw_id,c.cw_applytime,c.cw_applyingname,c.dd_id,c.cw_applyingdept,c.cw_telcode,c.cw_email,c.us_id,c.cw_transmittime,c.cw_subject,c.cw_number,c.cw_content,c.cw_status,c.cw_zhuanjiao,c.wd_id,p.cp_name,c.cp_id from tb_connwork c,tb_connproc p " +
					"where c.cp_id = p.cp_id(+) ";
			//未获取XML
			if("".equals(deptxmls)){
				return "";
			}
			//部门信访入口-----------开始-----获取某部门应该调用哪几个信箱
			deptuser = CASUtil.getUserColumn(deptxmls, "DEPTUSER");
			deptpassword = CASUtil.getUserColumn(deptxmls, "DEPTPASSWORD");
			
			islogin = cmy.login(deptuser, deptpassword);
			if(islogin){
				deptcp_ids = pro.getPropertyValue(deptuser);//获得调用的是哪几个信箱		
				if("xfb_01".equals(deptuser)){
					strSql += " and (p.cp_id in ("+deptcp_ids+") or c.cp_id='mailYGXX' ) and c.cw_status = 1"; //信访办只转交待处理
				}else{
					strSql += " and p.cp_id in ("+deptcp_ids+")  and c.cw_status in(1,2,8)";//其它转交所有信件(除了垃圾信件\重复信件)
				}
			}else{
				return "is not login"; //登录失败
			}
			//部门信访入口-------------结束-----获取某部门应该调用哪几个信箱
			//strSql += " and c.cw_zhuanjiao=2 and c.cw_id in('o89132')  order by c.cw_applytime) where rownum<2";
			//正式Sql
			strSql += " and c.cw_zhuanjiao=0  order by c.cw_applytime) where rownum<2";
			
			System.out.println("islogin="+islogin+"=deptcp_ids="+deptcp_ids+"==============第一个接口SQL getEmails＝＝＝＝＝"+strSql);
			
			content  =dImpl.getDataInfo(strSql);
			if(content!=null)
			{
				cw_id = CTools.dealNull(content.get("cw_id"));
				cw_subject = CTools.dealNull(content.get("cw_subject"));
				
				cw_subject = cw_subject.replaceAll("——", " ");
				cw_subject = cw_subject.replaceAll("—", " ");
				
				emailmodel.setCw_number(URLEncoder.encode(cw_id,"utf-8"));//信访cw_id
				emailmodel.setCw_incepttime(URLEncoder.encode(CTools.dealNull(content.get("cw_applytime")),"utf-8"));//信访接收时间
				emailmodel.setCw_applyname(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingname")),"utf-8"));//信访人
				emailmodel.setCw_emailfor(URLEncoder.encode(CTools.dealNull(content.get("dd_id")),"utf-8"));//信访目的
				emailmodel.setCw_applywork(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingdept")),"utf-8"));//信访人的单位
				emailmodel.setCw_applyaddress(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingdept")),"utf-8"));//信访人的地址
				emailmodel.setCw_applytel(URLEncoder.encode(CTools.dealNull(content.get("cw_telcode")),"utf-8"));//信访人的电话
				emailmodel.setCw_applyemail(URLEncoder.encode(CTools.dealNull(content.get("cw_email")),"utf-8"));//信访人的email
				emailmodel.setCw_is_us(URLEncoder.encode(CTools.dealNull(content.get("us_id")),"utf-8"));//为空代表不是注册用户
				emailmodel.setCw_deptfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//来自其他部门
				emailmodel.setCw_deptdeliver_to(URLEncoder.encode(CTools.dealNull(content.get("cw_transmittime")),"utf-8"));//其他部门转交时间
				emailmodel.setCw_strSubject(URLEncoder.encode(cw_subject,"utf-8"));//信访主题
				emailmodel.setCw_querynum(URLEncoder.encode(CTools.dealNull(content.get("cw_number")),"utf-8"));//查询序列号
				
				//对cw_content进行过滤特殊符号、对该字段长度进行限制（1500字内）
				String cw_content = CTools.dealNull(content.get("cw_content"));

				cw_content = cw_content.replace("<", "&lt;");
				cw_content = cw_content.replace(">", "&gt;");
				cw_content = cw_content .length() > 1500 ? cw_content .substring(0,1450) + ".." : cw_content ;
				//System.out.println("new--"+cw_content);
				emailmodel.setCw_strContent(URLEncoder.encode(cw_content,"utf-8"));//信访内容
				//
				//获取区长信箱的来源//获取阳光信箱的来源
				cp_id = CTools.dealNull(content.get("cp_id"));
				wd_id = CTools.dealNull(content.get("wd_id"));
				if(!"".equals(wd_id)){
					if("o1".equals(cp_id)){//区长信箱
						sqlQz = "select wd_name from tb_warden where wd_id='"+wd_id+"'";
						contentQz  = dImpl.getDataInfo(sqlQz);
						if(contentQz!=null)
						wd_name = CTools.dealNull(contentQz.get("wd_name"));
					}else if("mailYGXX".equals(cp_id)){//阳光信箱
						sqlYg = "select sj_id,sj_dir,sj_name from tb_subject where sj_display_flag = '0' and sj_parentid = (select sj_id from tb_subject where sj_dir = 'qwld' and rownum <= 1) and sj_id = '"+wd_id+"' order by sj_sequence";
						contentYg = dImpl.getDataInfo(sqlYg);
						if(contentYg!=null)
						yg_name = CTools.dealNull(contentYg.get("sj_name"));
					}
				}
				emailmodel.setCw_status(URLEncoder.encode(CTools.dealNull(content.get("cw_status")),"utf-8"));//该信访信件的状态
				emailmodel.setCw_receivedept(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//信访件接受部门
				emailmodel.setCw_zhuanjiao(URLEncoder.encode(CTools.dealNull(content.get("cw_zhuanjiao")),"utf-8"));//信件转交状态
				if(cp_id.equals("o1")){
					emailmodel.setCw_emailfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")+";"+wd_name),"utf-8"));//信访来源信箱
				}else if(cp_id.equals("mailYGXX")){
					emailmodel.setCw_emailfrom(URLEncoder.encode("阳光信箱"+";"+yg_name,"utf-8"));//信访来源信箱
				}else {
					emailmodel.setCw_emailfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//信访来源信箱
				}
				//查出附件内容进行base64编码
				strSql="select aa_filename,aa_im_name,aa_path from tb_appealattach where cw_id='"+content.get("cw_id")+"'";
				//System.out.println("attachSql====="+strSql);
				vector = dImpl.splitPage(strSql,20,1);
				if(vector!=null){
					for(int j=0;j<vector.size();j++)
		            {
						contentxf = (Hashtable)vector.get(j);
						String aa_filename = CTools.dealNull(contentxf.get("aa_filename"));
						aa_filename = aa_filename.replaceAll("——", " ");
						aa_filename = aa_filename.replaceAll("—", " ");
						attachmodel.setAa_name(URLEncoder.encode(aa_filename,"utf-8"));//信件附件名称
						
						//对附件的内容进行base64位编码
						String aa_path = CTools.dealNull(contentxf.get("aa_path"));
						String aa_im_name = CTools.dealNull(contentxf.get("aa_im_name"));
						if(!aa_path.equals("")){
							java.io.File imgDir = new java.io.File(path + aa_path + "\\" + aa_im_name);
							if (imgDir.exists()){
								FilePath = path + aa_path + "\\" + aa_im_name;
							 }else{
								 path = dImpl.getInitParameter("workattach_read_path");
								 imgDir = new java.io.File(path + aa_path + "\\" + aa_im_name);
								 if (imgDir.exists()){
									  FilePath = path + aa_path + "\\" + aa_im_name;
								 }
							 }
						}else{
							java.io.File imgDir = new java.io.File(path  + "\\" + aa_im_name);
							if(!"".equals(aa_im_name)){
								path = dImpl.getInitParameter("workattach_read_path");
								 imgDir = new java.io.File(path  + "\\" + aa_im_name);
								 if (imgDir.exists()){
									  FilePath = path  + "\\" + aa_im_name;
								 }
							}
						}
						//System.out.println("--------------------"+FilePath);
						//根据路径读取附件
						String attachContent = CEmailService.readFile(FilePath);
						if(attachContent!=null){
							attachmodel.setAa_content(URLEncoder.encode(attachContent,"utf-8"));//信件附件内容
						}
					  //
						lists.add(attachmodel);
		            }
				}
				//写日志 
				logstatus = "成功";
			}else{
				logstatus = "成功";
				cw_subject  = "暂时没有发送列表";
				return "";
			}
			//组成XMLS
			return emailXml(emailmodel,lists);
		}catch(Exception ex){
			logstatus = "失败";
			System.out.println("---------"+ex.toString());
			return "is error";
		}finally{
			cget.writeLog(cw_id,"信访调用",cw_subject,logstatus);//写日志
			dImpl.closeStmt();
			dCn.closeCn();
		}
		
	}
	
	/**
	 * 部门调用返回多条待处理信件
	 */
	public String getMoreEmails(String deptxmls){
		String [] fList = null;
		String FilePath = "";
		String strSql = "";
		//部门信访入口
		String deptuser = "";
		String deptpassword = "";
		String deptcp_ids = "";
		//区长名
		String cp_id = "";
		String wd_id = "";
		String wd_name = "";
		String yg_name = "";
		String sqlQz = "";
		String sqlYg = "";
		//
		String logstatus = "";
		String cw_id = "";
		String cw_subject = "";
		
		Hashtable contentQz = null;
		Hashtable contentYg = null;
		boolean islogin = false;
		Vector vector = null;
		Vector vectormore = null;
		Hashtable content = null;
		Hashtable contentxf = null;
		StringBuffer sf = new StringBuffer();
		CGetEmailService cget = new CGetEmailService();
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			cmy = new CMySelf();
			
			//文件读取路径
			//cw_status 1待处理、2处理中、8协调中、3已处理、4、已签收、9垃圾、12重复、18父信件完成状态
			//cw_zhuanjiao 0需要同步、1转交成功、2转交失败、3页面提交后台，需要人工同步操作按钮
			String path = dImpl.getInitParameter("workattach_save_path");
			strSql = "select c.cw_id,c.cw_applytime,c.cw_applyingname,c.dd_id,c.cw_applyingdept,c.cw_telcode,c.cw_email,c.us_id,c.cw_transmittime,c.cw_subject,c.cw_number,c.cw_content,c.cw_status,c.cw_zhuanjiao,c.wd_id,p.cp_name,c.cp_id from tb_connwork c,tb_connproc p " +
					"where c.cp_id = p.cp_id(+) ";
			//未获取XML
			if("".equals(deptxmls)){
				return "";
			}
			//部门信访入口-----------开始-----获取某部门应该调用哪几个信箱
			deptuser = CASUtil.getUserColumn(deptxmls, "DEPTUSER");
			deptpassword = CASUtil.getUserColumn(deptxmls, "DEPTPASSWORD");
			
			islogin = cmy.login(deptuser, deptpassword);
			if(islogin){
				deptcp_ids = pro.getPropertyValue(deptuser);//获得调用的是哪几个信箱		
				if("xfb_01".equals(deptuser)){
					strSql += " and (p.cp_id in ("+deptcp_ids+") or c.cp_id='mailYGXX' ) and c.cw_status = 1"; //信访办只转交待处理
				}else{
					strSql += " and p.cp_id in ("+deptcp_ids+")  and c.cw_status in(1,2,8)";//其它转交所有信件(除了垃圾信件\重复信件)
				}
			}else{
				return "is not login"; //登录失败
			}
			
			strSql += " and c.cw_zhuanjiao=0  order by c.cw_applytime";
			
			
			System.out.println("islogin="+islogin+"=deptcp_ids="+deptcp_ids+"==============第一个接口SQL getMoreEmails＝＝＝＝＝"+strSql);
			
			vectormore = dImpl.splitPageOpt(strSql,200,1);
			if(vectormore!=null)
			{
				for(int i=0;i<vectormore.size();i++)
				{
					content = (Hashtable)vectormore.get(i);
					if(content!=null)
					{
						cw_id = CTools.dealNull(content.get("cw_id"));
						cw_subject = CTools.dealNull(content.get("cw_subject"));
						
						cw_subject = cw_subject.replaceAll("——", " ");
						cw_subject = cw_subject.replaceAll("—", " ");
						
						emailmodel.setCw_number(URLEncoder.encode(cw_id,"utf-8"));//信访cw_id
						emailmodel.setCw_incepttime(URLEncoder.encode(CTools.dealNull(content.get("cw_applytime")),"utf-8"));//信访接收时间
						emailmodel.setCw_applyname(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingname")),"utf-8"));//信访人
						emailmodel.setCw_emailfor(URLEncoder.encode(CTools.dealNull(content.get("dd_id")),"utf-8"));//信访目的
						emailmodel.setCw_applywork(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingdept")),"utf-8"));//信访人的单位
						emailmodel.setCw_applyaddress(URLEncoder.encode(CTools.dealNull(content.get("cw_applyingdept")),"utf-8"));//信访人的地址
						emailmodel.setCw_applytel(URLEncoder.encode(CTools.dealNull(content.get("cw_telcode")),"utf-8"));//信访人的电话
						emailmodel.setCw_applyemail(URLEncoder.encode(CTools.dealNull(content.get("cw_email")),"utf-8"));//信访人的email
						emailmodel.setCw_is_us(URLEncoder.encode(CTools.dealNull(content.get("us_id")),"utf-8"));//为空代表不是注册用户
						emailmodel.setCw_deptfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//来自其他部门
						emailmodel.setCw_deptdeliver_to(URLEncoder.encode(CTools.dealNull(content.get("cw_transmittime")),"utf-8"));//其他部门转交时间
						emailmodel.setCw_strSubject(URLEncoder.encode(cw_subject,"utf-8"));//信访主题
						emailmodel.setCw_querynum(URLEncoder.encode(CTools.dealNull(content.get("cw_number")),"utf-8"));//查询序列号
						
						//对cw_content进行过滤特殊符号、对该字段长度进行限制（1500字内）
						String cw_content = CTools.dealNull(content.get("cw_content"));
						//System.out.println("old--"+cw_content);
						cw_content = cw_content.replace("<", "&lt;");
						cw_content = cw_content.replace(">", "&gt;");
						cw_content = cw_content .length() > 1500 ? cw_content .substring(0,1450) + ".." : cw_content ;
						//System.out.println("new--"+cw_content);
						emailmodel.setCw_strContent(URLEncoder.encode(cw_content,"utf-8"));//信访内容
						//
						//获取区长信箱的来源//获取阳光信箱的来源
						cp_id = CTools.dealNull(content.get("cp_id"));
						wd_id = CTools.dealNull(content.get("wd_id"));
						if(!"".equals(wd_id)){
							if("o1".equals(cp_id)){//区长信箱
								sqlQz = "select wd_name from tb_warden where wd_id='"+wd_id+"'";
								contentQz  = dImpl.getDataInfo(sqlQz);
								if(contentQz!=null)
								wd_name = CTools.dealNull(contentQz.get("wd_name"));
							}else if("mailYGXX".equals(cp_id)){//阳光信箱
								sqlYg = "select sj_id,sj_dir,sj_name from tb_subject where sj_display_flag = '0' and sj_parentid = (select sj_id from tb_subject where sj_dir = 'qwld' and rownum <= 1) and sj_id = '"+wd_id+"' order by sj_sequence";
								contentYg = dImpl.getDataInfo(sqlYg);
								if(contentYg!=null)
								yg_name = CTools.dealNull(contentYg.get("sj_name"));
							}
						}
						emailmodel.setCw_status(URLEncoder.encode(CTools.dealNull(content.get("cw_status")),"utf-8"));//该信访信件的状态
						emailmodel.setCw_receivedept(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//信访件接受部门
						emailmodel.setCw_zhuanjiao(URLEncoder.encode(CTools.dealNull(content.get("cw_zhuanjiao")),"utf-8"));//信件转交状态
						if(cp_id.equals("o1")){
							emailmodel.setCw_emailfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")+";"+wd_name),"utf-8"));//信访来源信箱
						}else if(cp_id.equals("mailYGXX")){
							emailmodel.setCw_emailfrom(URLEncoder.encode("阳光信箱"+";"+yg_name,"utf-8"));//信访来源信箱
						}else {
							emailmodel.setCw_emailfrom(URLEncoder.encode(CTools.dealNull(content.get("cp_name")),"utf-8"));//信访来源信箱
						}
						//查出附件内容进行base64编码
						strSql="select aa_filename,aa_im_name,aa_path from tb_appealattach where cw_id='"+content.get("cw_id")+"'";
						//System.out.println("attachSql====="+strSql);
						vector = dImpl.splitPage(strSql,20,1);
						if(vector!=null){
							for(int j=0;j<vector.size();j++)
				            {
								contentxf = (Hashtable)vector.get(j);
								String aa_filename = CTools.dealNull(contentxf.get("aa_filename"));
								aa_filename = aa_filename.replaceAll("——", " ");
								aa_filename = aa_filename.replaceAll("—", " ");
								attachmodel.setAa_name(URLEncoder.encode(aa_filename,"utf-8"));//信件附件名称
								
								//对附件的内容进行base64位编码
								String aa_path = CTools.dealNull(contentxf.get("aa_path"));
								String aa_im_name = CTools.dealNull(contentxf.get("aa_im_name"));
								if(!aa_path.equals("")){
									java.io.File imgDir = new java.io.File(path + aa_path + "\\" + aa_im_name);
									if (imgDir.exists()){
										FilePath = path + aa_path + "\\" + aa_im_name;
									 }else{
										 path = dImpl.getInitParameter("workattach_read_path");
										 imgDir = new java.io.File(path + aa_path + "\\" + aa_im_name);
										 if (imgDir.exists()){
											  FilePath = path + aa_path + "\\" + aa_im_name;
										 }
									 }
								}else{
									java.io.File imgDir = new java.io.File(path  + "\\" + aa_im_name);
									if(!"".equals(aa_im_name)){
										path = dImpl.getInitParameter("workattach_read_path");
										 imgDir = new java.io.File(path  + "\\" + aa_im_name);
										 if (imgDir.exists()){
											  FilePath = path  + "\\" + aa_im_name;
										 }
									}
								}
								//System.out.println("--------------------"+FilePath);
								//根据路径读取附件
								String attachContent = CEmailService.readFile(FilePath);
								if(attachContent!=null){
									attachmodel.setAa_content(URLEncoder.encode(attachContent,"utf-8"));//信件附件内容
								}
							  //
								lists.add(attachmodel);
				            }
						}
						//写日志 
						logstatus = "成功";
					}else{
						logstatus = "成功";
						cw_subject  = "暂时没有发送列表";
						return "";
					}
					
					sf.append(emailXml(emailmodel,lists));
				}
			}
			
			//组成XMLS
			return sf.toString();
		}catch(Exception ex){
			logstatus = "失败";
			System.out.println("---------"+ex.toString());
			return "is error";
		}finally{
			cget.writeLog(cw_id,"信访调用",cw_subject,logstatus);//写日志
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	
	
	/**
	 * 拼成传递的XML字符串
	 * @param email 邮件对象
	 * @param list 附件集合
	 * @return xml字符串
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
		emailXml.append("<ADDRESS>"+email.getCw_applyaddress()+"</ADDRESS>"); //信访人的地址
		emailXml.append("<MOBILEPHONE>"+email.getCw_applytel()+"</MOBILEPHONE>");//信访人的电话
		emailXml.append("<OTHERCONTACT>"+email.getOtherContact()+"</OTHERCONTACT>"); //其它联系方式
		emailXml.append("<EMAIL>"+email.getCw_applyemail()+"</EMAIL>");//信访人的邮箱
		emailXml.append("<REGISTER>"+email.getCw_is_us()+"</REGISTER>");//是否注册用户
		emailXml.append("<HANDOVER>"+email.getCw_deptfrom()+"</HANDOVER>");//来自其他部门
		emailXml.append("<HANDOVERTIME>"+email.getCw_deptdeliver_to()+"</HANDOVERTIME>");//其他部门转交时间
		emailXml.append("<TITLE>"+email.getCw_strSubject()+"</TITLE>");//信访主题
		emailXml.append("<CONTENT>"+email.getCw_strContent()+"</CONTENT>");//信访内容
		emailXml.append("<RECEIVEDEPT>"+email.getCw_receivedept()+"</RECEIVEDEPT>");//信件接受部门
		emailXml.append("<QUERYNUM>"+email.getCw_querynum()+"</QUERYNUM>");//信件查询序列号
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
		String emailMessage="<xml>"+emailXml+"</xml>";
		//System.out.println("emailMessage===="+emailMessage);
		return emailMessage;
	}
	
	/**
	 * 第三方系统调用门户网站接口插入tb_connwork信件表
	 * @param xmls
	 * @param username
	 * @param password
	 * @return
	 */
	public int insertEmails(String xmls,String username,String password){
		Boolean islogin = false;
		String cw_id = "";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			cmy = new CMySelf();
			//验证用户是否登录
			islogin = cmy.login(username, password);
			xmls = getCleanXmls(xmls);
			if(islogin&&!"".equals(xmls)){
				//解析xmls并插入数据库
				dCn.beginTrans();
				
				cw_id = dImpl.addNew("tb_connwork","cw_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
				dImpl.setValue("ui_id",CTools.dealNull(CASUtil.getUserColumn(xmls, "NETLVID")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_applytime",CTools.dealNull(CASUtil.getUserColumn(xmls, "RECEIVETIME")).trim(),CDataImpl.DATE);
				dImpl.setValue("cw_applyingname",CTools.dealNull(CASUtil.getUserColumn(xmls, "SENDER")).trim(),CDataImpl.STRING);
				dImpl.setValue("cp_id",CTools.dealNull(CASUtil.getUserColumn(xmls, "MAILBOX")).trim(),CDataImpl.STRING);
				dImpl.setValue("wd_id",CTools.dealNull(CASUtil.getUserColumn(xmls, "WDNAME")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_status","1",CDataImpl.STRING);
				dImpl.setValue("wd_id","o11726",CDataImpl.STRING);
				dImpl.setValue("cw_zhuanjiao","0",CDataImpl.STRING);
				dImpl.setValue("dd_id",CTools.dealNull(CASUtil.getUserColumn(xmls, "PURPOSE")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_applieddept",CTools.dealNull(CASUtil.getUserColumn(xmls, "DEPT")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_applyingdept",CTools.dealNull(CASUtil.getUserColumn(xmls, "ADDRESS")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_telcode",CTools.dealNull(CASUtil.getUserColumn(xmls, "MOBILEPHONE")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_email",CTools.dealNull(CASUtil.getUserColumn(xmls, "EMAIL")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_ispublish",CTools.dealNull(CASUtil.getUserColumn(xmls, "ISPUBLIC")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_us_ip",CTools.dealNull(CASUtil.getUserColumn(xmls, "IP")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_subject",CTools.dealNull(CASUtil.getUserColumn(xmls, "TITLE")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_number",CTools.dealNull(CASUtil.getUserColumn(xmls, "QUERYNUM")).trim(),CDataImpl.STRING);
				dImpl.setValue("cw_isxd","1",CDataImpl.INT);//新点提交
				dImpl.update();
				dImpl.setClobValue("cw_content", CTools.dealNull(CASUtil.getUserColumn(xmls, "CONTENT")).trim());

				
				 //将附件信息插入数据库		
				if(!(CTools.dealNull(CASUtil.getUserColumn(xmls, "FILECONTENT")).trim()).equals("")){//有附件
					
					dImpl.addNew("tb_appealattach","aa_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
					dImpl.setValue("cw_id",cw_id,CDataImpl.STRING);
					dImpl.setValue("aa_fileName",CTools.dealNull(CASUtil.getUserColumn(xmls, "FILEOLDNAME")),CDataImpl.STRING);//
					int numeral = 0;
					numeral =(int)(Math.random()*100000);
					String pa_path = CDate.getThisday()+ Integer.toString(numeral);
					dImpl.setValue("aa_path",pa_path,CDataImpl.STRING);
					dImpl.setValue("aa_im_name",CTools.dealNull(CASUtil.getUserColumn(xmls, "FILENEWNAME")),CDataImpl.STRING);
					
					String localPath=this.getClass().getResource("/").getPath();
					//localPath = URLDecoder.decode(localPath);//转换编码 如空格
					//localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
					//localPath+="attach/workattach2007/"+pa_path+"/";//目录
					localPath = pro.getPropertyValue("workattach2007path")+pa_path+"/";
					System.out.println("localPath========================"+localPath);
					java.io.File newDir = new java.io.File(localPath);
					if(!newDir.exists())//生成目录
					{
					  newDir.mkdirs();
					}
					localPath+=CTools.dealNull(CASUtil.getUserColumn(xmls, "FILENEWNAME")).trim();//文件地址
					CBase64.saveDecodeStringToFile(CTools.dealNull(CASUtil.getUserNoColumn(xmls, "FILECONTENT")).trim(),localPath);//生成文件
					dImpl.update();
				}
				
				
				dCn.commitTrans();
				
				return 1;
				
			}else{
				return 0;
			}
		}catch(Exception ex){
			dCn.rollbackTrans();
			System.out.println("插入失败 "+CDate.getNowTime()+" CEmailService.insertEmails ");
			ex.printStackTrace();
			return 0;
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	/**
	 * 获取区长信息
	 * @return json
	 */
	public String getQzxx(String username,String password,String qzxxtype){
		Vector vPage = null;
		Hashtable content = null;
		Boolean islogin = false;
		String qzxxSql = "";
		String qzxx = "";
		String id = "";
		StringBuilder json = new StringBuilder();
		cmy = new CMySelf();
		//验证用户是否登录
		islogin = cmy.login(username, password);
		
		if(islogin){
			if("qw".equals(qzxxtype)){
				qzxxSql = "select sj_id as id,sj_name as shortname from tb_subject where sj_display_flag = '0' and sj_parentid = (select sj_id from tb_subject where sj_dir = 'qwld' and rownum <= 1) order by sj_sequence";
			}
			if("qz".equals(qzxxtype)){
				qzxxSql = "SELECT wd_id as id,wd_name as shortname FROM tb_warden where wd_sequence<11 ORDER BY wd_sequence";
			}

			try{
				dCn = new CDataCn();
				dImpl = new CDataImpl(dCn);
				
				
				vPage = dImpl.splitPage(qzxxSql,200,1);
				if(vPage!=null)
				{
					json.append("{");
					 
					for(int i=0;i<vPage.size();i++)
					{
						content = (Hashtable)vPage.get(i);
						id = CTools.dealNull(content.get("id"));
						qzxx = CTools.dealNull(content.get("shortname"));
						//拼成JSon字符串返回
						json.append("\"" + qzxx + "\"" + ":" + "\"" + id + "\"");
		                
		                if (i < vPage.size() - 1) {
		                    json.append(",");
		                }
						
					}
					json.append("}");
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}finally{
				dImpl.closeStmt();
				dCn.closeCn();
			}
		}
		return json.toString();
	}
	
	
	
	
	/**
	 * 还原编码后的特殊字符
	 * @param xmls
	 * @return
	 */
	private String getCleanXmls(String xmls){
		  xmls = xmls.replaceAll("&amp;","&");
		  xmls = xmls.replaceAll("&quot;","");
		  xmls = xmls.replaceAll("&lt;","<");
		  xmls = xmls.replaceAll("&gt;",">");
		  xmls = xmls.replaceAll("&nbsp;"," ");
		  return xmls;
	}
	/**
	 * 将 String 进行 BASE64 编码 
	 * @param s 被传入的进行编码的字符串
	 * @return 返回编码后的字符串
	 */
	private static String getBASE64(String s) { 
		if (s == null) return null; 
		return (new sun.misc.BASE64Encoder()).encode( s.getBytes() ); 
	} 
	/**
	 * 将 File 进行 BASE64 编码
	 * @param filePath 需要编码的file
	 * @return 返回编码后的file
	 */ 
	private static String readFile(String filePath) {
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
	 * 将 BASE64 编码的字符串 s 进行解码 
	 * @param s 需要解码的字符串
	 * @return 返回解码后的字符串
	 */
	private static String getFromBASE64(String s) { 
		if (s == null) return null; 
		BASE64Decoder decoder = new BASE64Decoder(); 
		try { 
			byte[] b = decoder.decodeBuffer(s); 
			return new String(b); 
		} catch (Exception e) { 
			return null; 
		} 
	}
	//test方法
	public void backxml(String xmls){
		
		try{
			BASE64Decoder decoder = new BASE64Decoder(); 
			byte[] b = decoder.decodeBuffer(xmls);  
			FileOutputStream osf = new FileOutputStream(new File("D:\\pudongps\\WebRoot\\attach\\workattach2007\\2016-09-1238836\\abc1.docx"));   
			osf.write(b);   
			osf.flush();   
			osf.close(); 
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * main 方法
	 * @param args
	 */
	public static void main(String args[]){
		CEmailService cemail = new CEmailService();
		//String deptxmls = "<XML><DEPTINFO><DEPTUSER>xfb_01</DEPTUSER><DEPTPASSWORD>28282003</DEPTPASSWORD></DEPTINFO></XML>";//28282003
//		String deptxmls = "<XML><DEPTINFO><DEPTUSER>hbj_04</DEPTUSER><DEPTPASSWORD>hbj1qaz</DEPTPASSWORD></DEPTINFO></XML>";
//		System.out.println("test--------------"+cemail.getEmails(deptxmls));
		//String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><BZNETLVENCINFO><NETLVID>2</NETLVID><RECEIVETIME>2016-09-08</RECEIVETIME><SENDER>信访件发送人</SENDER><MAILBOX>o1</MAILBOX><WDNAME>o11726</WDNAME><PURPOSE>30</PURPOSE><DEPT>信访人的单位</DEPT><ADDRESS>信访人的地址</ADDRESS><MOBILEPHONE>123456</MOBILEPHONE><EMAIL>18901695800@qq.com</EMAIL><ISPUBLIC>0</ISPUBLIC><IP>218.82.190.74</IP><TITLE>信访主题,测试信息稍后删除</TITLE><CONTENT>信访内容，测试信息稍后删除</CONTENT><QUERYNUM>X20151217rfnzyjbs</QUERYNUM><FILECONTENT></FILECONTENT><FILEOLDNAME></FILEOLDNAME><FILENEWNAME></FILENEWNAME></BZNETLVENCINFO>";
		String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><BZNETLVENCINFO><NETLVID>42807</NETLVID><RECEIVETIME>2016-09-12 10:41:11</RECEIVETIME><SENDER>郭晶晶</SENDER><MAILBOX>o1</MAILBOX><WDNAME>o11730</WDNAME><PURPOSE>30</PURPOSE><DEPT></DEPT><ADDRESS>江苏苏州2</ADDRESS><MOBILEPHONE>13800138000</MOBILEPHONE><EMAIL>gb@live.cn</EMAIL><ISPUBLIC>2</ISPUBLIC><IP>101.231.77.118</IP><TITLE>新点测试接口，请设置为垃圾信件1</TITLE><CONTENT>新点测试接口，请设置为垃圾信件12</CONTENT><QUERYNUM>201609120002YHECK</QUERYNUM><FILECONTENT>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</FILECONTENT><FILEOLDNAME>我的测试文档.docx</FILEOLDNAME><FILENEWNAME>mytest1.docx</FILENEWNAME></BZNETLVENCINFO>";
		System.out.println("---"+cemail.insertEmails(xmls, "xd_pudong", "abc123"));
		//String json = cemail.getQzxx("xd_pudong","abc123","qz");
		//System.out.println("---------"+json);
	     //String base64Code="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";
	        
		//cemail.backxml(base64Code);
		
	}
}
