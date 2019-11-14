// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   ProxyValidate.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.ticket.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Referenced classes of package edu.yale.its.tp.cas.servlet:
//            ServiceValidate

public class ProxyValidate extends ServiceValidate
{

    private ServletContext app;
    private String serviceValidate;

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
        stCache = (ServiceTicketCache)servletconfig.getServletContext().getAttribute("ptCache");
        app = servletconfig.getServletContext();
        serviceValidate = app.getInitParameter("edu.yale.its.tp.cas.serviceValidate");
        if(serviceValidate == null)
            throw new ServletException("need edu.yale.its.tp.cas.serviceValidate");
        else
            return;
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException, ServletException
    {
        String s = httpservletrequest.getParameter("ticket");
        if(s != null && s.startsWith("ST"))
            app.getRequestDispatcher(serviceValidate).forward(httpservletrequest, httpservletresponse);
        else
            super.doGet(httpservletrequest, httpservletresponse);
    }

    protected void validationSuccess(PrintWriter printwriter, ServiceTicket serviceticket, String s)
    {
        if(!(serviceticket instanceof ProxyTicket))
            throw new IllegalArgumentException("can't take generic ServiceTicket; need ProxyTicket");
        ProxyTicket proxyticket = (ProxyTicket)serviceticket;
        printwriter.println("<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>");
        printwriter.println("  <cas:authenticationSuccess>");
        printwriter.println("    <cas:user>" + proxyticket.getUsername() + "</cas:user>");
        if(s != null && !s.equals(""))
            printwriter.println("    <cas:proxyGrantingTicket>" + s + "</cas:proxyGrantingTicket>");
        printwriter.println("    <cas:proxies>");
        for(Iterator iterator = proxyticket.getProxies().iterator(); iterator.hasNext(); printwriter.println("      <cas:proxy>" + iterator.next() + "</cas:proxy>"));
        printwriter.println("    </cas:proxies>");
        printwriter.println("  </cas:authenticationSuccess>");
        printwriter.println("</cas:serviceResponse>");
    }

    public ProxyValidate()
    {
    }
}
