// FrontEnd Plus GUI for JAD
// DeCompiled : YGServlet.class

package com.Servlet;

import com.PermuteData.Permunte;
import com.util.CTools;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.w3c.dom.Node;
import org.w3c.dom.xpath.XPathResult;

// Referenced classes of package com.Servlet:
//            XMLUtil, CTools

public class YGServlet extends HttpServlet
{

    private static final long serialVersionUID = 1L;

    public YGServlet()
    {
    }

    public void destroy()
    {
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        org.w3c.dom.Document doc = XMLUtil.inputStream2Doc(request.getInputStream());
        if(doc != null)
            try
            {
                XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
                XPathResult res = XMLUtil.parseConfig(doc, "//回复意见");
                Node node = result.iterateNext();
                String wo_id = CTools.dealNull(node.getAttributes().getNamedItem("办事ID").getNodeValue()).trim();
                String wo_status = CTools.dealNull(node.getAttributes().getNamedItem("状态").getNodeValue()).trim();
                Node nores = res.iterateNext();
                String huifu = CTools.dealNull(nores.getFirstChild().getNodeValue()).trim();
                Permunte perm = new Permunte();
                if(wo_status.equals("1"))
                    wo_status = "0";
                perm.setStatus(wo_id,huifu, wo_status);
                System.out.println("因公出国——接收政务网数据！" + wo_id);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        else
            System.out.println("接收非XML");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        doGet(request, response);
    }
}