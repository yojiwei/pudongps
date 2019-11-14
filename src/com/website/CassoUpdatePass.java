package com.website;

import java.util.Hashtable;
import com.component.database.MyCDataCn;
import com.component.database.MyCDataImpl;
import com.util.CTools;
import com.util.MD5;
import com.util.ReadProperty;
/**
 * 单点登录用户初始化密码接口
 * @author Administrator
 *
 */
public class CassoUpdatePass {
	private MyCDataCn myCDataCn = null;
	private MyCDataImpl myCDataImpl = null;
	Hashtable content = null;
	ReadProperty rp = new ReadProperty();
	/**
	 * 初始化密码方法
	 * @param userUid 用户登录名
	 * @param password 初始化密码
	 * @return
	 */
	public String UpdatePass(String userUid,String pwd,String wsbuser,String wsbpass)
	{
		String us_id = "";
		String pdwsbuser = rp.getPropertyValue("pdwsbuser");
		String pdwsbpass = rp.getPropertyValue("pdwsbpass");
		System.out.println("userUid==="+userUid+"==pwd"+pwd+"pdwsbuser==="+pdwsbuser+"==pdwsbpass==="+pdwsbpass);
		//设置调用该接口的用户名和密码
		if(!wsbuser.equals(pdwsbuser) && !wsbpass.equals(pdwsbpass)){
			return "error login";
		}
		//判断参数
		if("".equals(userUid)||"".equals(pwd))
		{
			return "error parameter";
		}
		try{
		myCDataCn = new MyCDataCn();
		myCDataImpl = new MyCDataImpl(myCDataCn);
		MD5 md = new MD5();
		String usSql = "select us_id from tb_user where us_uid = '"+userUid+"@pudong.gov.cn'";
		
		content = (Hashtable)myCDataImpl.getDataInfo(usSql);
		if(content!=null){
			us_id = CTools.dealNull(content.get("us_id"));
			
			myCDataImpl.edit("tb_user", "us_id", us_id);
			myCDataImpl.setValue("us_pwd", md.getMD5ofStr(pwd), MyCDataImpl.STRING);
			myCDataImpl.update();
			
		}else{
			return "error useruid";
		}
		
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			if(myCDataImpl!=null)
				myCDataImpl.closeStmt();
			if(myCDataCn!=null)
				myCDataCn.closeCn();
		}
		return "ok";
		
	}
	
	public static void main(String args[]){
		CassoUpdatePass cup = new CassoUpdatePass();
		String userUid = "shpdfao";
		String password = "shpdfao";
		String wsbuser = "";
		String wsbpass = "";
		System.out.println(cup.UpdatePass(userUid, password,wsbuser,wsbpass));
	}
}
