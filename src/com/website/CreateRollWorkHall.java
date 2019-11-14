package com.website;
import java.util.TimerTask;
import javax.servlet.http.HttpServletRequest;
import com.service.log.LogservicePd;
import com.util.CDate;
import com.util.ReadProperty;
/**
 * 生成办事大厅滚动动态部分
 * @author yao
 * 
 */
public class CreateRollWorkHall extends TimerTask{
	private CUrl curl = null;
	private String url_source = "";
	private String real_source = "";
	private String real_path = "";
	private ReadProperty pro = new ReadProperty();
	public CreateRollWorkHall(){}
	/**
	 * 生成静态首页办事部分
	 * @return
	 */
	public boolean createIndex(){
		boolean b_flag = false;
		String b_status = "";
		curl = new CUrl();
		url_source = pro.getPropertyValue("url_source");
		real_path = pro.getPropertyValue("real_path");
		real_source = pro.getPropertyValue("real_source");
		
		b_flag = curl.createHtml(url_source,real_path,real_source," ");
		if(b_flag){
			b_status = "成功";
		}else{
			b_status = "失败";
		}
		this.writeLogs(b_status);
		return b_flag;
	}
	
	/**
     * 记录生成首页动态部分页面的日志
     * @param b_status 生成状态
     */
    private void writeLogs(String b_status){
    	LogservicePd logservicepd = new LogservicePd();
    	String sm_nowtime = CDate.getNowTime();//当前详细时间
		String log_levn = "办事大厅中间滚动动态页面";
		String log_description = log_levn+sm_nowtime+"生成"+b_status;
		logservicepd.writeLog(log_levn,log_description,b_status,"administrator");
    }
	
    /**
     * 动态监听启动
     * @param args
     */
    public void run(){
    	this.createIndex();    	
    }
    /**
     * main
     * @param args
     */
	public static void main(String args[]){
		CUrl curl = new CUrl();
		CreateIndexWorkHall ciwh = new CreateIndexWorkHall();
		String url_source = "http://localhost/website/workHall/rollworkHall.jsp";
		String real_path = "F:\\pudongps\\WebRoot\\";
		String real_source = "\\website\\workHall\\rollwork.jsp";
		//System.out.println("办事动态首页部分页面生成======"+curl.createHtml(url_source ,real_path, real_source," "));
		ciwh.createIndex();
	}
}

