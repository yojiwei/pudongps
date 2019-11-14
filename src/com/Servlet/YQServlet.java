// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   YQServlet.java

package com.Servlet;

import com.util.Xml2DataDictionary;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.w3c.dom.*;

// Referenced classes of package com.Servlet:
//            XMLUtil

public class YQServlet extends HttpServlet
{

    public YQServlet()
    {
    }

    public void destroy()
    {
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	doRealGet(request,response);
    }
    
    private synchronized void doRealGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	Document doc = XMLUtil.inputStream2Doc(request.getInputStream());
        try
        {
            if(doc != null)
            {
                String textValue = doc.getElementsByTagName("办事信息").item(0).getAttributes().getNamedItem("办事内容").getNodeValue();
                System.out.println("edit--20080605-textValue = " + textValue);
                Xml2DataDictionary tranXml = new Xml2DataDictionary();
                tranXml.doInsertTable(textValue);
            } else
            {
                System.out.println("接收非XML");
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        doGet(request, response);
    }
}
