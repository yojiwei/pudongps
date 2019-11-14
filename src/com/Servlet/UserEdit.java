/*
 * 创建日期 2011-01-26
 *
 * TODO 要更改此生成的文件的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
package com.Servlet;

import com.PermuteData.Permunte;
import com.util.CTools;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.xpath.XPathResult;

/**
 * @author Administrator
 *
 * TODO 要更改此生成的类型注释的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */
public class UserEdit extends HttpServlet
{

    public UserEdit()
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
        {
            String strxml = XMLUtil.doc2String(doc);
            Permunte per = new Permunte();
            try
            {
                XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
                Node node = result.iterateNext();
                String UserXml = CTools.dealNull(node.getAttributes().getNamedItem("办事内容").getNodeValue()).trim();
                StringReader ioStrrad = new StringReader(UserXml);
                SAXReader sexReader = new SAXReader();
                Document xmldoc = sexReader.read(ioStrrad);
                Element root = xmldoc.getRootElement();
                String username = root.attributeValue("username");
                String pwd = root.attributeValue("pwd");
                System.out.println("用户密码修改->" + username);
                per.UserPass(username, pwd);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        } else
        {
            System.out.println("接收非XML");
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        doGet(request, response);
    }
}