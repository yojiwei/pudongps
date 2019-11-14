/**
 * @(#)MobileNote.java
 *用于对短信频道的东东进行处理
 * @author 
 * @version 1.00 2007/9/11
 */
package com.mobile;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

public class MobileNote extends CError{
	private String phoneNumber;
    public MobileNote() {
    }
    /**
     *获取6位数验证码
     */
    public static int getValidateNumber(){
    	 Random random = new Random();
    	 int number=0;
         for(int i = 0; i < 6;i++) {
         	number=Math.abs(random.nextInt())%10;
         }	
    	return number;
    }
    /**
     * 显示用户订阅的信息
     */
    public Hashtable selectMessages(String phoneNumber){    	
    	Hashtable table = null;
		Vector vPage = dImpl.splitPage("select * from notes  where tid=(select id from table where phoneNumber='"+phoneNumber+"'", 100, 1);
		if (vPage != null) {
			table = new Hashtable();
			for (int i = 0, n = vPage.size(); i < n; i++) {
				Hashtable content = (Hashtable)vPage.get(i);
				String phoneNumber = content.get("phoneNumber").toString();
				String username = content.get("username").toString();
				table.put(phoneNumber, username);
			}
			
		}
		return table;
    	
    }
    /**
     *向这个手机号码发送验证码
     */
     public void setMessages(String phone){
     	int number=this.getValidateNumber();
     	String sql="insert into table(vali_number) values('"+number+"') where phoneNumber="+phoneNumber;
	 	
	 //保存验证码以便与用户输入的进行比较
	 //Session.getSession().setAttribute();
     	
     }
     /**
      *保存用户订制的信息:订阅的栏目、订阅的时间等。
      */
     public void saveMessages(String notes[]){
     	for(int i=0;i<notes.length;i++){
     		String sql="insert into table(tid) values('"+notes[i]+"') where phoneNumber="+number;
     		dImpl.executeUpdae(sql);
     	}     	
    }
     /**
      * 用户修改他所订制的信息：订阅栏目等。
      */
     public void updateMessages(String notes[]){
    	 
     }
     /**
      * 当验证码验证成功，保存手机号码到用户的用户表中
      * 
      */
     public void savePhone(String phoneNumber){
    	 setPhoneNumber(phoneNumber);
     }
    /**
     *对用户信息列表进行管理 ----删除
     *
     */
     public void deleteNote(String msId){
    	dImpl.delete("tbl_message", "ms_id", Long.parseLong(msId));
 		dImpl.update();
     }
     /**
      *测试专用
      */
     public static void main(String args[]){
         MobileNote mobile = new MobileNote();
         mobile.getValidateNumber();
     }
    
    
}