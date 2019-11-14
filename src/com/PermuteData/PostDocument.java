// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   PostDocument.java

package com.PermuteData;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.io.*;
import java.util.Iterator;
import java.util.List;
import org.dom4j.*;
import org.dom4j.io.SAXReader;

// Referenced classes of package com.PermuteData:
//            PostInfo, Base64Java

public class PostDocument
{

    public PostDocument()
    {
    }

    public Document getBizXml(String el_id, String el_xml, String el_annex)
    {
        String xml = "";
        xml = el_xml;
        if(!el_annex.equals(""))
            xml = getXML(el_xml, el_annex);
        Document document = DocumentHelper.createDocument();
        Element booksElement = document.addElement("ns0:在线办事消息");
        booksElement.addAttribute("xmlns:ns0", "http://POCBiztalkOnlineWorkSchema.OnlineWorkSchema");
        Element userinfoElem = booksElement.addElement("用户信息");
        userinfoElem.addAttribute("用户名", "");
        userinfoElem.addAttribute("电话", "");
        userinfoElem.addAttribute("邮编", "");
        userinfoElem.addAttribute("身份证", "");
        userinfoElem.addAttribute("地址", "");
        Element baninfoElem = booksElement.addElement("办事信息");
        baninfoElem.addAttribute("事项类型ID", "o1225");
        baninfoElem.addAttribute("办事ID", el_id);
        baninfoElem.addAttribute("事项名称", "外事办企业注册");
        baninfoElem.addAttribute("办事内容", xml);
        baninfoElem.addAttribute("申请时间", "");
        baninfoElem.addAttribute("状态", "2");
        Element a = baninfoElem.addElement("回复意见");
        Element luinfoElem = booksElement.addElement("路由信息");
        Element mubiaoElem = luinfoElem.addElement("目标");
        mubiaoElem.addAttribute("目标ID", "100000");
        return document;
    }

    public String getXML(String xml, String el_annex)
    {
        PostInfo poif = new PostInfo();
        CDataCn pCn = new CDataCn();
        CDataImpl cimpl = new CDataImpl(pCn);
        String path = cimpl.getInitParameter("info_save_path_107");
        String filename = path + "\\\\" + el_annex;
        cimpl.closeStmt();
        pCn.closeCn();
        System.out.println("GetXml");
        Base64Java base64 = new Base64Java();
        byte b[] = (byte[])null;
        b = base64.ReadFile(filename);
        String ret = base64.Base64File(b);
        String retsize = String.valueOf((new File(filename)).length());
        String retfile = String.valueOf((new File(filename)).getName()).substring((new File(filename)).getName().lastIndexOf(".") + 1);
        try
        {
            SAXReader saxReader = new SAXReader();
            StringReader ipStr = new StringReader(xml);
            Document doc = saxReader.read(ipStr);
            List list = null;
            list = doc.selectNodes("/beyondbit/substie");
            Element afelement;
            for(Iterator iter = list.iterator(); iter.hasNext(); afelement.setText(retfile))
            {
                Element sbelement = (Element)iter.next();
                Element avelement = sbelement.addElement("AnnexValue");
                avelement.setText(ret);
                Element aselement = sbelement.addElement("AnnexSize");
                aselement.setText(retsize);
                afelement = sbelement.addElement("AnnexFile");
            }

            xml = doc.asXML();
            xml = xml.substring(xml.indexOf(">") + 1);
            return xml;
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return "";
    }

    public static void main(String args1[])
    {
    }
}
