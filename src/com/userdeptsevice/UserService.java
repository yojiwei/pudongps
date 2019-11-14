package com.userdeptsevice;
/**
 * 后台用户同步操作
 * 用户操作对应用户的UI_UID
 */
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.CASUtil;
import com.util.CTools;
import com.util.SecurityTest;
public class UserService {
	//
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	public UserService(){}
	/**
	 * 传递过来的XML
	 */
	public String getUserServcie(String getXmls){
		UserModel usermodel = new UserModel();
		try{
			//用户model
			System.out.println("userModel------------"+getXmls);
			usermodel.setUi_id(CTools.dealNumber(CASUtil.getUserColumn(getXmls, "UIID")));
			usermodel.setUi_name(CTools.dealNull(CASUtil.getUserColumn(getXmls, "UINAME")));
			usermodel.setUi_uid(CTools.dealNull(CASUtil.getUserColumn(getXmls, "UIUID")));
			usermodel.setUi_password(CTools.dealNull(CASUtil.getUserColumn(getXmls, "UIPASSWORD")));
			usermodel.setUi_active_flag(CTools.dealNull(CASUtil.getUserColumn(getXmls, "UIACTIVEFLAG")));
			usermodel.setUi_sex(CTools.dealNull(CASUtil.getUserColumn(getXmls, "UISEX")));
			usermodel.setDt_id(CTools.dealNumber(CASUtil.getUserColumn(getXmls, "DTID")));
			//usermodel.setUi_sequence(CTools.dealNumber(CASUtil.getUserColumn(getXmls, "UISEQUENCE")));
			//操作
			String action = CASUtil.getUserColumn(getXmls, "UIACTION").toLowerCase();
			if (action.equals("add")) { 
				String isadd = addUser(usermodel);//去新增用户
				return isadd;
			}else if(action.equals("update")){
				String isupdate = updateUser(usermodel);//去修改用户
				return isupdate;
			}else if(action.equals("delete")){
				String isdelete = deleteUser(usermodel);//去删除用户
				return isdelete;
			}
		}catch(Exception ex){
			return "action----"+ex.toString();
		}
		return "ok";
	}
	/**
	 * 新增
	 */
	public String addUser(UserModel users){
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			//dImpl.addNewValue("tb_userinfo", "ui_id", Integer.parseInt(users.getUi_id()));
			dImpl.addNew("tb_userinfo", "ui_id");
			dImpl.setValue("ui_name",users.getUi_name(),CDataImpl.STRING);//用户名
			dImpl.setValue("ui_uid",users.getUi_uid(),CDataImpl.STRING);//用户登录名
			//用户密码加密
			String us_pwd = users.getUi_password();
			us_pwd = new sun.misc.BASE64Encoder().encode(us_pwd.getBytes());
			us_pwd = SecurityTest.encode(us_pwd);
			//加密结束
			dImpl.setValue("ui_password",us_pwd,CDataImpl.STRING);//密码
			dImpl.setValue("ui_active_flag",users.getUi_active_flag().equals("1")?"0":"1",CDataImpl.STRING);//帐号停用状态(1停用0正常)
			dImpl.setValue("ui_sex",users.getUi_sex(),CDataImpl.STRING);//用户性别
			if(!"administrator".equals(users.getUi_uid())){
				dImpl.setValue("dt_id",users.getDt_id(),CDataImpl.STRING);//所属部门ID
			}
			//dImpl.setValue("ui_sequence",users.getUi_sequence(),CDataImpl.STRING);//用户排名
			dImpl.update();
			
			if(!"".equals(dCn.getLastErrString()))
			{
				return dCn.getLastErrString();
			}
		} catch (Exception ee) {
			return "add-user--"+users.getUi_uid()+"--"+ee.toString();
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "ok";
	}
	/**
	 * 修改
	 */
	public String updateUser(UserModel users){
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);			 
			dImpl.edit("tb_userinfo", "ui_uid",users.getUi_uid());
			dImpl.setValue("ui_name",users.getUi_name(),CDataImpl.STRING);//用户名
			dImpl.setValue("ui_uid",users.getUi_uid(),CDataImpl.STRING);//用户登录名
			if(!"".equals(users.getUi_password())){
				//用户密码加密
				String us_pwd = users.getUi_password();
				us_pwd = new sun.misc.BASE64Encoder().encode(us_pwd.getBytes());
				us_pwd = SecurityTest.encode(us_pwd);
				//加密结束
				dImpl.setValue("ui_password",us_pwd,CDataImpl.STRING);//密码
			}
			if(users.getUi_active_flag()!=null&&!"".equals(users.getUi_active_flag())){
				dImpl.setValue("ui_active_flag",users.getUi_active_flag().equals("1")?"0":"1",CDataImpl.STRING);//帐号停用状态(1停用0正常)
			}else{
				dImpl.setValue("ui_active_flag","0",CDataImpl.STRING);//帐号停用状态(1停用0正常)
			}
			
			dImpl.setValue("ui_sex",users.getUi_sex(),CDataImpl.STRING);//用户性别
			if(!"administrator".equals(users.getUi_uid())){
				dImpl.setValue("dt_id",users.getDt_id(),CDataImpl.STRING);//所属部门ID
			}
			//dImpl.setValue("ui_sequence",users.getUi_sequence(),CDataImpl.STRING);//用户排名
			dImpl.update();
			if(!"".equals(dCn.getLastErrString()))
			{
				return dCn.getLastErrString();
			}
		} catch (Exception ee) {
			return "update-user--"+users.getUi_uid()+"--"+ee.toString();
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "ok";
	}
	/**
	 * 删除
	 */
	public String deleteUser(UserModel users){
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			System.out.println("ui_uid==="+users.getUi_uid());
			dImpl.delete("tb_userinfo","ui_uid",users.getUi_uid());
			dImpl.update();
			if(!"".equals(dCn.getLastErrString()))
			{
				return dCn.getLastErrString();
			}
		} catch (Exception ee) {
			return "delete-user--"+users.getUi_uid()+"--"+ee.toString();
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "ok";
	}
}
