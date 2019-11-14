package com.webservise;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.Hashtable;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.app.CMySelf;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.component.database.MyCDataCn;
import com.component.database.MyCDataImpl;
import com.util.CDate;
import com.util.CTools;
import com.util.MD5;

/**
 * 提供新点调用操作浦东门户网站单点登录用户（用户注册、登录、修改密码）
 * @author Administrator
 *
 */
public class PdwebSsoUserService {
	
	CMySelf  cmy = null;
	String sqlStr = "";
	Hashtable pdwebcontent = null;
	String us_id = "";
	String useruid = "";
	String userpass = "";
	String userrepass = "";
	WebserviceReadProperty pro = null;
	/**
	 * 构造函数
	 */
	public PdwebSsoUserService(){
		pro = new WebserviceReadProperty();
	}
	/**
	 * 用户登录
	 * @param loginxmls
	 * 1 登录成功
	 * 0 登录失败
	 * @return
	 * loginxmls="<xml><XDUSERNAME>xd_pd</XDUSERNAME><XDPASSWORD>sjdd_10604</XDPASSWORD><USERUID>pd_test</USERUID><USERPASS>123456a</USERPASS></xml>"
	 */
	public String UserLogin(String loginxmls){
		Element element = null;
		String us_repass = "";
		MyCDataCn dCn=null;   //新建数据库连接对象
		MyCDataImpl dImpl=null;  //新建数据接口对象
		try {
			dCn = new MyCDataCn(); 
			dImpl = new MyCDataImpl(dCn); 
			
			loginxmls = this.getstandardxmls(loginxmls);
			System.out.println("loginxmls===="+loginxmls);
			if (!"".equals(loginxmls)) {
				element = this.initEle(loginxmls);
				if (element != null) {
					if(Authentication(element.getChildTextTrim("XDUSERNAME"),element.getChildTextTrim("XDPASSWORD"))==1){
						//判断用户登录信息
						useruid = element.getChildTextTrim("USERUID")+"@pudong.gov.cn";
						userpass = element.getChildTextTrim("USERPASS");
						//MD5加密
						userpass = new MD5().getMD5ofStr(userpass);
						
						sqlStr = "select us_pwd from tb_user where us_uid = '"+useruid+"'";
						pdwebcontent = (Hashtable)dImpl.getDataInfo(sqlStr);
						if(pdwebcontent!=null){
							us_repass = CTools.dealNull(pdwebcontent.get("us_pwd"));
							if(us_repass.equals(userpass)){
								return "<xml><result>1</result></xml>";
							}
						}else{
							return "<xml><result>0</result></xml>";
						}
						
					}
					
				}
			}
		} catch (Exception ex) {
			System.out.println(new Date() + "PdwebSsoUserService---UserLogin--"
					+ ex.getMessage());
			ex.printStackTrace();
			return "<xml><result>0</result></xml>";
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "<xml><result>0</result></xml>";
	}
	/**
	 * 用户注册
	 * @param userxmls
	 * 1 注册成功
	 * 0 注册失败
	 * @return
	 * userxmls="<xml><XDUSERNAME>xd_pd</XDUSERNAME><XDPASSWORD>sjdd_10604</XDPASSWORD><USERUID>pd_test</USERUID><USERPASS>123456a</USERPASS></xml>"
	 */
	public String RegUser(String userxmls){
		Element element = null;
		MyCDataCn dCn=null;   //新建数据库连接对象
		MyCDataImpl dImpl=null;  //新建数据接口对象
		try {
			dCn = new MyCDataCn(); 
			dImpl = new MyCDataImpl(dCn); 
			
			userxmls = this.getstandardxmls(userxmls);
			System.out.println("userxmls===="+userxmls);
			if (!"".equals(userxmls)) {
				element = this.initEle(userxmls);
				if (element != null) {
					if(Authentication(element.getChildTextTrim("XDUSERNAME"),element.getChildTextTrim("XDPASSWORD"))==1){
						//用户注册
						useruid = element.getChildTextTrim("USERUID")+"@pudong.gov.cn";
						userpass = element.getChildTextTrim("USERPASS");
						//MD5加密
						userpass = new MD5().getMD5ofStr(userpass);
						
						sqlStr = "select us_id from tb_user where us_uid = '"+useruid+"' ";
						pdwebcontent = (Hashtable)dImpl.getDataInfo(sqlStr);
						if(pdwebcontent!=null){
							return "<xml><result>0</result></xml>";
						}else{
							dImpl.addNew("tb_user","us_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
							dImpl.setValue("us_uid",useruid,CDataImpl.STRING);
							dImpl.setValue("us_pwd",userpass,CDataImpl.STRING);
							dImpl.setValue("us_regdate",CDate.getThisday(),CDataImpl.STRING);
							dImpl.setValue("us_isok","1",CDataImpl.STRING);
							dImpl.setValue("us_status","0",CDataImpl.STRING);
							dImpl.update();
							return "<xml><result>1</result></xml>";
						}
					}
					
				}
			}
		} catch (Exception ex) {
			System.out.println(new Date() + "PdwebSsoUserService---RegUser--"
					+ ex.getMessage());
			ex.printStackTrace();
			return "<xml><result>0</result></xml>";
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "<xml><result>0</result></xml>";
	}
	/**
	 * 修改密码
	 * @param passxmls
	 * 1 修改密码成功
	 * 0 修改密码失败
	 * @return
	 * passxmls="<xml><XDUSERNAME>xd_pd</XDUSERNAME><XDPASSWORD>sjdd_10604</XDPASSWORD><USERUID>pd_test</USERUID><USERPASS>123456a</USERPASS><USERREPASS>a123456</USERREPASS></xml>"
	 */
	public String Updpass(String passxmls){
		Element element = null;
		String oldpass = "";
		MyCDataCn dCn=null;   //新建数据库连接对象
		MyCDataImpl dImpl=null;  //新建数据接口对象
		try {
			dCn = new MyCDataCn(); 
			dImpl = new MyCDataImpl(dCn); 
			
			passxmls = this.getstandardxmls(passxmls);
			System.out.println("loginxmls===="+passxmls);
			if (!"".equals(passxmls)) {
				element = this.initEle(passxmls);
				if (element != null) {
					if(Authentication(element.getChildTextTrim("XDUSERNAME"),element.getChildTextTrim("XDPASSWORD"))==1){
						//修改密码
						useruid = element.getChildTextTrim("USERUID")+"@pudong.gov.cn";
						//原密码
						userpass = element.getChildTextTrim("USERPASS");
						//MD5加密
						userpass = new MD5().getMD5ofStr(userpass);
						//新密码
						userrepass = element.getChildTextTrim("USERREPASS");
						//MD5加密
						userrepass = new MD5().getMD5ofStr(userrepass);
						
						sqlStr = "select us_pwd from tb_user where us_uid = '"+useruid+"' ";
						pdwebcontent = (Hashtable)dImpl.getDataInfo(sqlStr);
						if(pdwebcontent!=null){
							oldpass = CTools.dealNull(pdwebcontent.get("us_pwd"));
							if(oldpass.equals(userpass)){
								dImpl.edit("tb_user", "us_uid", useruid); 
								dImpl.setValue("us_pwd",userrepass,CDataImpl.STRING);
								dImpl.update();
								return "<xml><result>1</result></xml>";
							}
						}else{
							return "<xml><result>0</result></xml>";
						}
					}
					
				}
			}
		} catch (Exception ex) {
			System.out.println(new Date() + "PdwebSsoUserService---Updpass--"
					+ ex.getMessage());
			ex.printStackTrace();
			return "<xml><result>0</result></xml>";
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "<xml><result>0</result></xml>";
	}
	/**
	 * 调用接口用户认证
	 * @return
	 */
	private int Authentication(String username,String password){
		MyCDataCn dCn=null;   //新建数据库连接对象
		MyCDataImpl dImpl=null;  //新建数据接口对象
		try {
			dCn = new MyCDataCn(); 
			dImpl = new MyCDataImpl(dCn); 
			cmy = new CMySelf();
			
			String user_name = pro.getPropertyValue("xd_user_name");
			String user_pass = pro.getPropertyValue("xd_user_pass");
			if(username.equals(user_name)&&password.equals(user_pass)){
				return 1;
			}else{
				return 0;
			}
			
		}catch(Exception ex){
			System.out.println(new Date() + "PdwebSsoUserService---Authentication--"
					+ ex.getMessage());
			ex.printStackTrace();
			return 0;
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		
		
	}
	
	
	/**
	 * Description：初始化变量
	 * 
	 * @param fileStr
	 *            一段xml的字符串
	 */
	private Element initEle(String fileStr) {
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try {
			sb = new SAXBuilder();
			InputStream inputStream = new ByteArrayInputStream(fileStr
					.getBytes("utf-8"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		} catch (Exception ex) {
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}
	
	/**
	 * 还原编码后的特殊字符
	 * @param xmls
	 * @return
	 */
	private String getstandardxmls(String xmls){
		  xmls = xmls.replaceAll("&amp;","&");
		  xmls = xmls.replaceAll("&quot;","");
		  xmls = xmls.replaceAll("&lt;","<");
		  xmls = xmls.replaceAll("&gt;",">");
		  xmls = xmls.replaceAll("&nbsp;"," ");
		  return xmls;
	}
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String args[]){
		PdwebSsoUserService pdss = new PdwebSsoUserService();
		//登录
		//String loginxmls = "<xml><XDUSERNAME>xd_pd</XDUSERNAME><XDPASSWORD>sjdd_10604</XDPASSWORD><USERUID>pd_test</USERUID><USERPASS>a123456</USERPASS></xml>";
		//System.out.println("userlogin====="+pdss.UserLogin(loginxmls));
		//注册
		String regxmls = "<xml><XDUSERNAME>xd_pd</XDUSERNAME><XDPASSWORD>sjdd_10604</XDPASSWORD><USERUID>pd_test1</USERUID><USERPASS>123456a</USERPASS></xml>";
		System.out.println("userreg====="+pdss.RegUser(regxmls));
		//修改密码
		//String updaxmls = "<xml><XDUSERNAME>xd_pd</XDUSERNAME><XDPASSWORD>sjdd_10604</XDPASSWORD><USERUID>pd_test</USERUID><USERPASS>123456a</USERPASS><USERREPASS>a123456</USERREPASS></xml>";
		//System.out.println("userlogin====="+pdss.Updpass(updaxmls));
	}
}
