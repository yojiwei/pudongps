// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Proxy.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.ticket.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;

public class Proxy extends HttpServlet
{

    private static final String INVALID_REQUEST = "INVALID_REQUEST";
    private static final String BAD_PGT = "BAD_PGT";
    private static final String INTERNAL_ERROR = "INTERNAL_ERROR";
    private GrantorCache pgtCache;
    private ServiceTicketCache ptCache;

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        ServletContext servletcontext = servletconfig.getServletContext();
        pgtCache = (GrantorCache)servletcontext.getAttribute("pgtCache");
        ptCache = (ServiceTicketCache)servletcontext.getAttribute("ptCache");
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        PrintWriter printwriter = null;
        try
        {
            printwriter = httpservletresponse.getWriter();
            if(httpservletrequest.getParameter("pgt") == null || httpservletrequest.getParameter("targetService") == null)
            {
                proxyFailure(printwriter, "INVALID_REQUEST", "'pgt' and 'targetService' parameters are both required");
            } else
            {
                String s = httpservletrequest.getParameter("pgt");
                String s1 = httpservletrequest.getParameter("targetService");
                ProxyGrantingTicket proxygrantingticket = (ProxyGrantingTicket)pgtCache.getTicket(s);
                if(proxygrantingticket == null)
                {
                    proxyFailure(printwriter, "BAD_PGT", "unrecognized pgt: '" + s + "'");
                } else
                {
                    ProxyTicket proxyticket = new ProxyTicket(proxygrantingticket, s1);
                    String s2 = ptCache.addTicket(proxyticket);
                    proxySuccess(printwriter, s2);
                }
            }
        }
        catch(Exception exception)
        {
            try
            {
                if(printwriter != null)
                    proxyFailure(printwriter, "INTERNAL_ERROR", "Unexpected exception");
            }
            catch(IOException ioexception) { }
        }
    }

    protected void proxyFailure(PrintWriter printwriter, String s, String s1)
        throws IOException
    {
        printwriter.println("<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>");
        printwriter.println("  <cas:proxyFailure code='" + s + "'>");
        printwriter.println("    " + s1);
        printwriter.println("  </cas:proxyFailure>");
        printwriter.println("</cas:serviceResponse>");
    }

    protected void proxySuccess(PrintWriter printwriter, String s)
    {
        printwriter.println("<cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>");
        printwriter.println("  <cas:proxySuccess>");
        printwriter.println("    <cas:proxyTicket>" + s + "</cas:proxyTicket>");
        printwriter.println("  </cas:proxySuccess>");
        printwriter.println("</cas:serviceResponse>");
    }

    public Proxy()
    {
    }
}
