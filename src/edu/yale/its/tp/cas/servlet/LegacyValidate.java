// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   LegacyValidate.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.ticket.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;

import com.util.CDate;
import com.util.CTools;

public class LegacyValidate extends HttpServlet
{

    private ServiceTicketCache stCache;
    
    private	String isSuccess=("<success>no</success>");//用户默认登陆不成功

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        stCache = (ServiceTicketCache)servletconfig.getServletContext().getAttribute("stCache");
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        try
        { 
        	//String s1 = CTools.dealString(httpservletrequest.getParameter("service"));//转换中文编码
            PrintWriter printwriter = httpservletresponse.getWriter();
            //客户端的URL
            if(httpservletrequest.getParameter("service") == null || httpservletrequest.getParameter("ticket") == null)
            {
                printwriter.print(isSuccess);
            } else
            {
                String s = httpservletrequest.getParameter("ticket");//当前票据
                String s1 = CTools.dealString(httpservletrequest.getParameter("service"));//转换中文编码
                String s2 = httpservletrequest.getParameter("renew");
                ServiceTicket serviceticket = (ServiceTicket)stCache.getTicket(s);
                if(serviceticket == null)//退出登录后跳转到这儿
                    printwriter.print(isSuccess);
                else
                if("true".equals(s2) && !serviceticket.isFromNewLogin())
                    printwriter.print(isSuccess);
                else{
                	String userMessage="";
                	String uid=serviceticket.getUsername();
            		//String site = uid.substring(uid.lastIndexOf("@")+1);//取出用户名中的cassite
            		//uid=uid.substring(0,uid.indexOf("@"));//取出用户名中不带@之前的真实用户名
            		//再次验证并去取登录用户信息
                	GetUserMessage getUserMessage =new GetUserMessage();
                	if(getUserMessage.getUserMessageByUidSite(uid)!=null)
                	//取得服务器端的登录用户的基本信息
                	userMessage=getUserMessage.getUserMessageByUidSite(uid).toString();
                	userMessage="<?xml version=\"1.0\" encoding=\"utf-8\"?><root>"+userMessage+"</root>";
                	//System.out.println(CDate.getNowTime()+" CAS's Back to-- "+s1+" --Client's Message is--:"+userMessage); 
                	printwriter.print(userMessage);//返回用户信息给子网站
	            }
              }
            
        }
        catch(Exception exception)
        {
            try
            {
                httpservletresponse.getWriter().print(isSuccess);
            }
            catch(IOException ioexception) { }
        }
    }

    public LegacyValidate()
    {
    }
    public void destroy() {
    	// TODO Auto-generated method stub
    	super.destroy();
    }
}
