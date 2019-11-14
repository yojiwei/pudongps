// FrontEnd Plus GUI for JAD
// DeCompiled : GetUserEdit.class

package com.PermuteData;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.component.database.MyCDataCn;
import com.component.database.MyCDataImpl;
import com.util.CTools;
import com.util.MD5;
import com.util.ReadProperty;
import com.wsbcasuser.CassoUpdatePassServiceTestCase;

import java.util.Date;
import java.util.Hashtable;
/**
 * 外事办修改浦东前台用户信息
 * 通过谢建云的公务员中台
 * @author Administrator
 *
 */
public class GetUserEdit
{
	ReadProperty rp = new ReadProperty();
    public GetUserEdit()
    {
    }
    /**
     * 修改之前的修改浦东前台用户密码的方法
     * @param us_uid
     * @param pass
     */
    /*public void UserPass(String us_uid, String pass)
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String ussql = "select us_id,ws_id,uk_id,us_name from tb_user where us_uid='" + us_uid + "'";
        Hashtable map = dImpl.getDataInfo(ussql);
        if(map != null)
        {
            String us_id = map.get("us_id").toString();
            String ws_id = map.get("ws_id").toString();
            String uk_id = map.get("uk_id").toString();
            String us_name = map.get("us_name").toString();
            User us = new User();
            us.setId(us_id);
            us.setUid(us_uid);
            us.setPwd(pass);
            us.setUserKind(uk_id);
            us.setWsid(ws_id);
            us.setUserName(us_name);
            us.setTel("");
            us.setAddress("");
            us.setZip("");
            us.setEmail("");
            us.setIdCardNumber("");
            us.setCellPhoneNumber("");
            us.updateUser();
            us.getUserName();
        } else
        {
            Pe("用户ID设置错误");
        }
        dImpl.closeStmt();
        dCn.closeCn();
    }*/
    /**
     * 最新外事办内网修改浦东前台用户CASSO密码
     * @param us_uid用户登录名
     * @param pass用户修改密码
     */
    public void UserPass(String us_uid, String pass)
    {
    	String wsbuser = rp.getPropertyValue("wsbuser");
    	String wsbpass = rp.getPropertyValue("wsbpass");
    	System.out.println(us_uid+"---wsbuser=="+wsbuser+"=wsbpass=="+wsbpass);
		try{
			CassoUpdatePassServiceTestCase cupst = new CassoUpdatePassServiceTestCase("1");
			//cupst.updateWsbPass(us_uid,pass,wsbuser,wsbpass);
			cupst.updateWsbPass(us_uid,pass,"wsbfjq","shpdfao123");
		}catch(Exception ex){
			ex.printStackTrace();
		}
    }

    public void EditUsetPope(String name, String value)
    {
        String va[] = value.split(";");
        String dt_id = "34";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        dCn.beginTrans();
        String ussql = "select us_id from tb_user where us_uid='" + name + "'";
        Hashtable usmap = dImpl.getDataInfo(ussql);
        String us_id = usmap.get("us_id").toString();
        String deletesql = "delete from tb_user_proc where us_id = '" + us_id + "' and dt_id=" + dt_id;
        dImpl.getDataInfo(deletesql);
        if(va != null)
        {
            for(int i = 0; i < va.length; i++)
            {
                dImpl.setTableName("tb_user_proc");
                dImpl.setPrimaryFieldName("up_id");
                dImpl.addNew();
                dImpl.setValue("us_id", us_id, 3);
                dImpl.setValue("pr_id", va[i], 3);
                dImpl.setValue("dt_id", dt_id, 3);
                dImpl.update();
            }

        }
        dCn.commitTrans();
        dImpl.closeStmt();
        dCn.closeCn();
    }

    public void Pt(String key, String value)
    {
        System.out.println(new Date() + " -> " + key + " -> " + value);
    }

    public void Pe(String value)
    {
        System.err.println(new Date() + " -> " + value);
    }

    public static void main(String args[])
    {
        GetUserEdit gue = new GetUserEdit();
        gue.UserPass("shpdfao", "shpdfao");
        
    }
}