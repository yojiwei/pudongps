// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   SampleHandler.java

package edu.yale.its.tp.cas.auth.provider;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletRequest;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;
import com.util.MD5;

// Referenced classes of package edu.yale.its.tp.cas.auth.provider:
//            WatchfulPasswordHandler

public class SampleHandler extends WatchfulPasswordHandler
{

    public boolean authenticate(ServletRequest servletrequest, String username, String password)
    {
    	CDataCn cDn =null;
    	CDataImpl dImpl=null;
    	Vector vPage = null;
    	Hashtable content = null;
    	try{
    		cDn =new CDataCn();
    		dImpl =new CDataImpl(cDn);
    		//if(s.indexOf("@")!=-1){
	    		//String cassite = s.substring(s.lastIndexOf("@")+1);//取出用户名中的cassite
	    		//s=s.substring(0,s.indexOf("@"));//取出用户名中不带@之前的真实用户名
    			//us_isok用户是否被停用1正常0已停用
	    		String sql = "select us_pwd from tb_user where us_isok=1 and us_uid='"+username+"'";
	    		vPage  = dImpl.splitPage(sql,10,1);
	    		if(vPage!=null){
	    			if(vPage.size()==1){
	    				content = (Hashtable)vPage.get(0);
	    				String us_pwd=CTools.dealNull(content.get("us_pwd"));
	    				//如果SSO服务器端用户密码MD5加密过
	    				MD5 md =new MD5();
	    				password = md.getMD5ofStr(password);//加密比较
	    				if(password.equals(us_pwd))return true;
	    				else return false;
	    			}
	    			else return false;
	    		}
    		//}
    	}catch (Exception e) {
			// TODO: handle exception
    		System.out.println("SampleHandler.java:"+e.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
        return false;
    }

    public SampleHandler()
    {
    }
}
