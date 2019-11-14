package com.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * @author 作者：
 * @version 创建时间：Aug 6, 2009 1:12:24 PM
 * 类说明
 */
public class JVMMonitor extends TimerTask {
	static String send_toemail=""; 
	ReadProperty pro = null;
	String send_pass = "";
	String send_name = "";
	public void run() {
		try{
			//配置文件配置发送到相关人员的邮箱地址
			pro = new ReadProperty();
			send_toemail = pro.getPropertyValue("to_email");
			send_name = pro.getPropertyValue("send_name");
			send_pass = pro.getPropertyValue("send_pass");
			//写死配置文件地址
//			Properties propertie = new Properties();
//			FileInputStream in= new FileInputStream("F:\\Tomcat_pudong\\bin\\database.properties");
//			propertie.load(in);
//			in.close();
//			send_toemail=propertie.getProperty("to_email");
			
		}catch(Exception ex){
			System.out.println(ex.toString());
		}

		
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		
		try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn); 

	    IMonitorService service = new MonitorServiceImpl();    
	    MonitorInfoBean monitorInfo;
	    double totalMemory=0;//可使用内存
	    double freeMemory=0;//剩余内存
			monitorInfo = service.getMonitorInfoBean();
			totalMemory=monitorInfo.getTotalMemory();
			freeMemory=monitorInfo.getFreeMemory();
			if(freeMemory < totalMemory*0.2){//当剩余内存小于20%时
				//浦东外事办的邮件提醒
				StringBuffer sb=new StringBuffer("您好！<br>上海浦东门户网站-外事办Tomcat4127_wsb现可用剩余内存已低于<font color='red'>20%</font>可用剩余内存为<font color='red'>"+freeMemory+"KB</font>,CPU占有率为<font color='red'>" + monitorInfo.getCpuRatio()+"%</font>，请您查看或联系相关人员！");
				//浦东门户网站的邮件提醒
				//StringBuffer sb=new StringBuffer("您好！<br>上海浦东门户网站-Tomcat5.0 现可用剩余内存已低于<font color='red'>20%</font>可用剩余内存为<font color='red'>"+freeMemory+"KB</font>,CPU占有率为<font color='red'>" + monitorInfo.getCpuRatio()+"%</font>，请您查看或联系相关人员！");
				//读写最频繁的语句
				String sql="select * from (select buffer_gets, sql_text from v$sqlarea where buffer_gets > 50000 order by buffer_gets desc) where rownum<=5";
				ResultSet rs=dImpl.executeQuery(sql);
				sb.append("<br>读写最频繁的语句：<br>");
				int j=0;
				while(rs.next())
				{
					j++;
					sb.append(j+": 读写次数："+rs.getString("buffer_gets")+"<p>"+rs.getString("sql_text")+"<p>");				
				}
				rs.close();
				
				//最消耗瓷盘的语句
				sql="select * from (select sql_text,disk_reads from v$sql where disk_reads > 1000 or (executions > 0 and buffer_gets/executions > 30000) order by disk_reads desc) where rownum<=5";
				rs=dImpl.executeQuery(sql);
				sb.append("<br>最消耗瓷盘的语句：<br>");
				int x = 0;
				while(rs.next())
				{
					sb.append(x+": 磁盘读写数："+rs.getString("disk_reads")+"<p>"+rs.getString("sql_text")+"<p>");	
				}
				rs.close();
				
				//最消耗cpu的语句
				sb.append("<br>	最消耗cpu的语句：<br>");
				sql="select * from (select a.sid,spid,status,substr(a.program,1,40) prog,a.terminal,osuser,value/60/100 value     from v$session a,v$process b,v$sesstat c where c.statistic#=12 and c.sid=a.sid and a.paddr=b.addr order by value desc ) where rownum<=5";
				rs=dImpl.executeQuery(sql);
				String spid="";
				while(rs.next())
				{
					spid+=rs.getString("spid")+",";
				}
				rs.close();
				String[] ArrSpid=spid.split(",");
				j=0;
				for(int i=0;i<ArrSpid.length;i++)
				{				
					sql="select sql_text from v$sqltext a where a.hash_value=(select sql_hash_value from v$session b where b.paddr=(select addr from v$process where spid="+ArrSpid[i]+")) ";
					rs=dImpl.executeQuery(sql);
					String sqlText1="",
					sqlText="";
					while(rs.next())
					{
						sqlText1+=rs.getString("sql_text")+"~";
					}
					if(!"".equals(sqlText1)){
						j++;
					String[] ArrSqlText=sqlText1.split("~");
					for(int ii=ArrSqlText.length-1;ii>=0;ii--)
					{
						sqlText+=ArrSqlText[ii]+"";
					}
					rs.close();
					sb.append(j+":"+sqlText+"<p>");	
					}	
				}
				
				//内存占用情况
				sb.append("<br>	内存占用情况：<br>");
				Runtime lRuntime = Runtime.getRuntime();
				sb.append("--------BEGIN MEMERY STATISTICS -------</BR>");
				sb.append("Free Momery:"+lRuntime.freeMemory()/1024+"KB</BR>");
				sb.append("Max Momery:"+lRuntime.maxMemory()/1024+"KB</BR>");
				sb.append("Total Momery:"+lRuntime.totalMemory()/1024+"KB</BR>");
				sb.append("Available Processors : "+lRuntime.availableProcessors()+"</BR>");//线程池数
				sb.append("--------END MEMERY STATISTICS ------");
				
				
				//新建Mail对象 mail.pudong.gov.cn 浦东邮箱邮关
				CMail sMail = new CMail("mail.pudong.gov.cn"); 
				sMail.setSmtpHost("smtp.pudong.gov.cn");
				String send_toemails[]=send_toemail.split(",");
				for(int i=0;i<send_toemails.length;i++){
					send_toemail=send_toemails[i];
					if(!send_toemail.equals("")){
						System.out.println(send_toemail);
						sMail.setNeedAuth(true);
						sMail.setNamePass(send_name,send_pass);//发件箱用户名、密码 shbeyondbit 123456
						sMail.setSubject("上海浦东服务器警告");//发送信件主题
						sMail.setBody(sb.toString());//发送信件正文
						sMail.setFrom("wangjingjing@pudong.gov.cn");//beyondbit_pd@163.com
						sMail.setTo(send_toemail);//收件箱 xxx@xxx.xxx
						sMail.sendout();
					}
				}
			}else{
				System.out.println("服务器正常,可使用内存为："+freeMemory);
			}
		}catch(Exception testexp){
			testexp.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
			System.gc();
		}
		
	}
	
	public static void main(String[] args){
		JVMMonitor jm=new JVMMonitor();
		jm.run();
	}
}



