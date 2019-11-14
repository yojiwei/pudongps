package com.smsCase;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.service.log.LogservicePd;
import com.util.CDate;
import com.util.CTools;
import com.util.ReadProperty;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;
/**
 * 用户门户网站推送天气预报、互动反馈等信息
 * 数据表tb_sms
 * @author Administrator
 * 接口地址http://sms.pudong.sh/SmsWebservice/SendSmsService.asmx
 */
public class DxpdQ extends TimerTask
{
  private static String PassWord = "";
  private static String retVal = "";
  private CDataCn dCn = null;
  private CDataImpl dImpl = null;
  private boolean isnextSms = false;
  private Vector vectorPage = null;
  private Hashtable content = null;
  private ReadProperty pro = new ReadProperty();
  private BusyFlag busyFlag = new BusyFlag();

  /**
   * 主方法
   * 监听执行该方法对未推送的短信进行推送
   */
  public void DxpdCheck()
  {
    String sm_tel = "";
    String sm_con = "";
    String sm_id = "";
    String us_id = "";
    String sm_sendtime = "";
    String limit_time = "";
    String limit_truetime = "";
    String limit_type = "";
    String sm_sj_dir = "";
    int days = 0;
    String sm_nowtime = CDate.getNowTime();
    String now_time = CDate.getThisday();
    this.isnextSms = true;
    try
    {
      this.dCn = new CDataCn();
      this.dImpl = new CDataImpl(this.dCn);

      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");

      String StrSql = "select s.sm_id,s.sm_tel,s.sm_con,s.sm_flag,s.sm_flagtoo,s.sm_check,s.sm_sendtime,floor(to_number(sysdate-to_date(to_char(sm_sendtime,'yyyy-MM-dd'),'yyyy-MM-dd'))) days,u.sj_dir from tb_sms s,tb_subject u where s.sm_flag=3 and s.sm_check=2 and s.sm_sj_id = u.sj_id(+) and s.sm_sendtime is not null order by s.sm_flag asc,s.sm_sendtime desc,s.sm_id desc";

      this.vectorPage = this.dImpl.splitPage(StrSql, 20, 1);
      if (this.vectorPage != null)
      {
        for (int j = 0; j < this.vectorPage.size(); j++)
        {
          this.content = ((Hashtable)this.vectorPage.get(j));
          if(this.content!=null){
        	  sm_id = CTools.dealNull(this.content.get("sm_id"));
	          sm_tel = CTools.dealNull(this.content.get("sm_tel"));
	          sm_con = CTools.dealNull(this.content.get("sm_con"));
	          sm_sendtime = CTools.dealNull(this.content.get("sm_sendtime"));
	          sm_sj_dir = CTools.dealNull(this.content.get("sj_dir"));
	          days = Integer.parseInt(CTools.dealNumber(this.content.get("days")));
          }
          sm_sj_dir = "".equals(sm_sj_dir) ? "dxpd_checkcode" : sm_sj_dir;

          Date nowdate = formatter.parse(sm_nowtime);
          Date senddate = formatter.parse(sm_sendtime);
          long nowtime = nowdate.getTime() / 1000L;
          long sendtime = senddate.getTime() / 1000L;

          limit_type = this.pro.getPropertyValue(sm_sj_dir + "_sendtype");
          limit_time = this.pro.getPropertyValue(sm_sj_dir);

          limit_truetime = now_time + " " + limit_time;

          if (days >= 0) {
            if (limit_type.equals("1")) {
              int timedays = Integer.parseInt(limit_time);
              if (days >= timedays)
                setOverTime(sm_id, sm_con, sm_tel, us_id, this.dImpl);
              else
                sendDxpdMessage(sm_id, sm_con, sm_tel, us_id, this.dImpl);
            }
            else if (limit_type.equals("2")) {
              int timehour = Integer.parseInt(limit_time);
              if (nowtime - sendtime >= timehour * 60 * 60)
                setOverTime(sm_id, sm_con, sm_tel, us_id, this.dImpl);
              else
                sendDxpdMessage(sm_id, sm_con, sm_tel, us_id, this.dImpl);
            }
            else if (limit_type.equals("3")) {
              if (days == 0) {
                Date limitdate = formatter.parse(limit_truetime);
                if (nowdate.getTime() >= limitdate.getTime())
                  setOverTime(sm_id, sm_con, sm_tel, us_id, this.dImpl);
                else
                  sendDxpdMessage(sm_id, sm_con, sm_tel, us_id, this.dImpl);
              }
              else if (days > 0) {
                setOverTime(sm_id, sm_con, sm_tel, us_id, this.dImpl);
              }
            }
          }
          else {
        	  System.out.println("还没有到发送的时间！");
          }
        }
      }
      else {
        System.out.println("暂时没有发送列表，谢谢!");
      }
    }
    catch (Exception e)
    {
      System.out.println("DxpdCheck-------" + sm_nowtime + "------" + e.toString());
    } finally {
      if (this.dImpl != null)
        this.dImpl.closeStmt();
      if (this.dCn != null)
        this.dCn.closeCn();
    }
    this.isnextSms = false;
  }
  /**
   * 调用接口推送短信内容
   * @param sm_id
   * @param sm_con
   * @param sm_tel
   * @param us_id
   * @param dImpl
   */
  public void sendDxpdMessage(String sm_id, String sm_con, String sm_tel, String us_id, CDataImpl dImpl)
  {
    String logstatus = "";
    //String sm_nowtime = CDate.getNowTime();
    String sm_nowtime = CDate.getThisday();
    try {
      SmpService sms = new SmpService();
      String smbk_flag = "";

      PassWord = SmpService.PassWord;

      if (sm_tel.equals("")) 
      {
        dImpl.executeUpdate("update tb_sms set sm_flag=1,sm_endtime=sysdate where sm_id='" + sm_id + "'");
      } else {
    	  
        retVal = sms.sendSms(sm_tel, sm_con, PassWord);
        System.out.println("retVal=========" + retVal);

        dImpl.edit("tb_sms", "sm_id", sm_id);
        if ("短信发送成功".equals(retVal)) {
          smbk_flag = "1";
          logstatus = "成功";
          dImpl.setValue("sm_flag", "1", 3);
          dImpl.setValue("sm_endtime", sm_nowtime, 5);
        } else {
          smbk_flag = "0";
          logstatus = " 失败";
          dImpl.setValue("sm_flag", "0", 3);
          dImpl.setValue("sm_endtime", sm_nowtime, 5);
        }
        dImpl.update();
      }

    }
    catch (Exception ex)
    {
      logstatus = "catch失败";
      System.out.println("sendDxpdMessage------" + sm_nowtime + "--------" + ex.toString());
    }
  }

  /**
   * 设置短信超期，超期短信将不再推送
   * @param sm_id
   * @param sm_con
   * @param sm_tel
   * @param us_id
   * @param dImpl
   */
  public void setOverTime(String sm_id, String sm_con, String sm_tel, String us_id, CDataImpl dImpl)
  {
    String sm_nowtime = CDate.getNowTime();
    try {
      dImpl.executeUpdate("update tb_sms set sm_flag=9,sm_endtime=sysdate where sm_id='" + sm_id + "'");
    } catch (Exception ex) {
      System.out.println("setOverTime-------" + sm_nowtime + "-------" + ex.toString());
    }
    finally {
      writeLogs(sm_tel, sm_con, "过期", us_id);
    }
  }
  /**
   * 记录短信推送日志，在浦东新区门户网站后台日志管理查看
   * @param tel
   * @param sm_con
   * @param issuccess
   * @param us_id
   */
  public void writeLogs(String tel, String sm_con, String issuccess, String us_id)
  {
    LogservicePd logservicepd = new LogservicePd();
    String sm_nowtime = CDate.getNowTime();
    String log_levn = "短信发送";
    String log_description = sm_nowtime + "发送给" + tel + "手机用户：" + sm_con + "的消息";
    //System.out.println("===" + log_description + " ==" + issuccess);
    logservicepd.writeLog(log_levn, log_description, issuccess, us_id);
  }
  /**
   * run监听执行方法
   */
  public void run()
  {
    lock();
    if (!this.isnextSms)
    {
    	DxpdCheck();
    }
    unlock();
  }
  /**
   * 开始执行锁定
   */
  public void lock()
  {
    this.busyFlag.getBusyFlag();
  }
  /**
   * 执行完毕，解锁
   */
  public void unlock()
  {
    this.busyFlag.freeBusyFlag();
  }
  /**
   * main 方法，测试
   * @param args
   */
  public static void main(String[] args)
  {
    DxpdQ dxpd = new DxpdQ();
    dxpd.run();
  }
}