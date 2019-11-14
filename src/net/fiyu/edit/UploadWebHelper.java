// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   UploadWebHelper.java

package net.fiyu.edit;

import java.io.File;
import java.io.PrintStream;
import java.util.Iterator;
import java.util.List;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

// Referenced classes of package net.fiyu.edit:
//            UploadBean, EditWebhelper

public class UploadWebHelper
{

    Document document;
    EditWebhelper ew;
    public String filename;

    public UploadWebHelper()
    {
        filename = "D:/style2.xml";
        document = null;
        ew = null;
    }

    public UploadBean InitPara()
    {
        UploadBean bean;
        bean = new UploadBean();
        String sToolBar = "";
        List list = document.selectNodes("Edit_Style/style");
        bean.setSfileext(getNodeValue(list, "sfileext"));
        bean.setSfilesize(getNodeValue(list, "sfilesize"));
        bean.setSflashext(getNodeValue(list, "sflashext"));
        bean.setSflashsize(getNodeValue(list, "sflashsize"));
        bean.setSimageext(getNodeValue(list, "simageext"));
        bean.setSimagesize(getNodeValue(list, "simagesize"));
        bean.setSmediaext(getNodeValue(list, "smediaext"));
        bean.setSmediasize(getNodeValue(list, "smediasize"));
        bean.setSremoteext(getNodeValue(list, "sremoteext"));
        bean.setSremotesize(getNodeValue(list, "sremotesize"));
        bean.setSuploaddir(getNodeValue(list, "suploaddir"));
        break MISSING_BLOCK_LABEL_163;
        Exception e;
        e;
        System.out.println(e.getMessage());
        document = null;
        return bean;
    }

    public UploadWebHelper getInstance()
    {
        UploadWebHelper uw = new UploadWebHelper();
        SAXReader saxReader = new SAXReader();
        document = saxReader.read(new File(filename));
        break MISSING_BLOCK_LABEL_54;
        Exception e;
        e;
        System.out.println(e.getMessage());
        return uw;
    }

    public String getNodeValue(List list, String Node)
    {
        Iterator it = list.iterator();
        if(it.hasNext())
        {
            Element styleElement = (Element)it.next();
            Iterator memo = styleElement.elementIterator(Node);
            if(memo.hasNext())
            {
                Element memostring = (Element)memo.next();
                return memostring.getTextTrim();
            } else
            {
                return "";
            }
        } else
        {
            return "";
        }
    }

    public static void main(String args[])
    {
        UploadWebHelper w = new UploadWebHelper();
        w.getInstance();
        UploadBean bean = w.InitPara();
        System.out.println(bean.getSfileext());
    }
}
