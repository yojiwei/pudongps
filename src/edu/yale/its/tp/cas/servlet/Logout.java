// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Logout.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.ticket.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;


public class Logout extends HttpServlet
{

    /**
	 * update by yo 20081113
	 */
	private static final long serialVersionUID = 1L;
    private ServletContext app;
    private GrantorCache tgcCache;
    private String logoutPage;
    private	String isLogout="logout is ok!";//用户登出成功
    public Logout(){}
    //init.method
    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        app = servletconfig.getServletContext();
        tgcCache = (GrantorCache)app.getAttribute("tgcCache");
        
    }
    //doGet.method
    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        httpservletresponse.setHeader("pragma", "no-cache");
        httpservletresponse.setHeader("Cache-Control", "no-cache");
        httpservletresponse.setHeader("Cache-Control", "no-store");
        httpservletresponse.setDateHeader("Expires", 0L);      
        Cookie acookie[] = httpservletrequest.getCookies();
        String service = httpservletrequest.getParameter("service");//得到客户端的URL
        
        if(acookie!=null)
        {
            for(int i = 0; i < acookie.length; i++)
            {
            	//去掉cookie,保存在服务器端cookie里的ticket
				if(acookie[i].getName().equals("casTicketYp")){
					tgcCache.deleteTicket(acookie[i].getValue());
					//acookie[i].setMaxAge(0);
					//acookie[i].setSecure(true);
					acookie[i].setValue(null);
					httpservletresponse.addCookie(acookie[i]);
				}
				
				//去掉ticket,根据S保存在服务器端cookie里的
                if(!acookie[i].getName().equals("CASTGC"))
                    continue;
                TicketGrantingTicket ticketgrantingticket = (TicketGrantingTicket)tgcCache.getTicket(acookie[i].getValue());
                if(ticketgrantingticket != null)
                {
                    tgcCache.deleteTicket(acookie[i].getValue());
                    destroyTgc(acookie[i].getName(),httpservletrequest, httpservletresponse);
                }
                
                
            }

        }
        httpservletresponse.sendRedirect(service);
       //app.getRequestDispatcher(logouttoPage).forward(httpservletrequest, httpservletresponse);
    }

    private void destroyTgc(String cookieName,HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        Cookie cookie = new Cookie(cookieName, "destroyed");
        cookie.setPath(httpservletrequest.getContextPath());
        cookie.setMaxAge(0);
        cookie.setSecure(true);
        httpservletresponse.addCookie(cookie);
    }
    //doPost.method
    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    throws ServletException, IOException
	{
	    	doGet(httpservletrequest,httpservletresponse);
	}
    
    //destroy.method
    public void destroy(){
    	super.destroy();
    }

    
}
