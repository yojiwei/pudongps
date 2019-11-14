// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   EditWebhelper.java

package net.fiyu.edit;

import java.io.File;
import java.io.PrintStream;
import java.util.Iterator;
import java.util.List;
import org.dom4j.*;
import org.dom4j.io.SAXReader;

// Referenced classes of package net.fiyu.edit:
//            EditBean

public class EditWebhelper
{

    String aButtonCode[];
    String aButtonHTML[];
    Document document;
    Document document2;
    EditWebhelper ew;
    public String filename;
    public String filename2;
    String sStyleDir;
    int size;

    public EditWebhelper()
    {
        size = 255;
        filename = "D:/style2.xml";
        filename2 = "D:/button2.xml";
        document = null;
        document2 = null;
        ew = null;
        sStyleDir = "blue";
        aButtonCode = new String[size];
        aButtonHTML = new String[size];
    }

    public String Code2HTML(String s_Code)
    {
        String CodeToHTML = "";
        for(int i = 0; i < size; i++)
        {
            if(aButtonCode[i].equals(s_Code))
            {
                CodeToHTML = aButtonHTML[i];
                return CodeToHTML;
            }
        }

        return CodeToHTML;
    }

    public void InitButtonArray()
    {
        List list = document2.selectNodes("Edit_Button/bcode");
        List list2 = document2.selectNodes("Edit_Button/bcode/@name");
        Iterator it = list.iterator();
        Iterator it2 = list2.iterator();
        int i = 0;
        int option = 0;
        while(it.hasNext()) 
        {
            Attribute attribute = (Attribute)it2.next();
            Element button = (Element)it.next();
            aButtonCode[i] = attribute.getValue();
            option = Integer.parseInt(memoString(button, "btype").getTextTrim());
            switch(option)
            {
            case 0: // '\0'
                aButtonHTML[i] = "<DIV CLASS=\"" + memoString(button, "bclass").getTextTrim() + "\" TITLE=\"" + memoString(button, "btitle").getTextTrim() + "\" onclick=\"" + memoString(button, "bevent").getTextTrim() + "\"><IMG CLASS=\"Ico\" SRC=\"buttonimage/" + sStyleDir + "/" + memoString(button, "bimage").getTextTrim() + "\"></DIV>";
                break;

            case 1: // '\001'
                aButtonHTML[i] = "<SELECT CLASS=\"" + memoString(button, "bclass").getTextTrim() + "\" onchange=\"" + memoString(button, "bevent").getTextTrim() + "\">" + memoString(button, "bhtml").getTextTrim() + "</SELECT>";
                break;

            case 2: // '\002'
                aButtonHTML[i] = "<DIV CLASS=\"" + memoString(button, "bclass").getTextTrim() + "\">" + notNull(memoString(button, "bhtml").getTextTrim()) + "</DIV>";
                break;
            }
            i++;
        }
        size = i;
        break MISSING_BLOCK_LABEL_444;
        Exception e;
        e;
        e.printStackTrace();
        return;
    }

    public EditBean InitPara()
    {
        EditBean bean;
        bean = new EditBean();
        String sToolBar = "";
        List list = document.selectNodes("Edit_Style/style");
        bean.setSAutoRemote(getNodeValue(list, "sautoremote"));
        bean.setSStyleName("standard");
        bean.setSBaseUrl(getNodeValue(list, "sbaseurl"));
        bean.setSDetectFromWord(getNodeValue(list, "sdetectfromword"));
        bean.setSInitMode(getNodeValue(list, "sinitmod"));
        bean.setSStyleID(getNodeValue(list, "sid"));
        bean.setSStyleDir(getNodeValue(list, "sdir"));
        bean.setNStateFlag(getNodeValue(list, "sstateflag"));
        sStyleDir = getNodeValue(list, "sdir");
        InitButtonArray();
        String aButton[] = getNodeValue(list, "stoolbar1").split("\\|");
        String sToolBar = "<table border=0 cellpadding=0 cellspacing=0 width='100%' class='Toolbar' id='eWebEditor_Toolbar'>";
        sToolBar = sToolBar + "<tr><td><div class='yToolbar'>";
        for(int i = 0; i < aButton.length; i++)
        {
            if(aButton[i].equalsIgnoreCase("MAXIMIZE"))
                aButton[i] = "Minimize";
            sToolBar = sToolBar + Code2HTML(aButton[i]);
        }

        sToolBar = sToolBar + "</div></td></tr>";
        String aButton2[] = getNodeValue(list, "stoolbar2").split("\\|");
        sToolBar = sToolBar + "<tr><td><div class='yToolbar'>";
        for(int j = 0; j < aButton2.length; j++)
        {
            if(aButton2[j].equalsIgnoreCase("MAXIMIZE"))
                aButton2[j] = "Minimize";
            sToolBar = sToolBar + Code2HTML(aButton2[j]);
        }

        sToolBar = sToolBar + "</div></td></tr></table>";
        bean.setSToolBar(sToolBar);
        bean.setSStyleName(getNodeValue(list, "sdir"));
        bean.setSStyleUploadDir(getNodeValue(list, "suploaddir"));
        bean.setSVersion("∑…”„–ﬁ∏ƒ∞Ê");
        bean.setSReleaseDate("2004-11-30");
        break MISSING_BLOCK_LABEL_420;
        Exception e;
        e;
        System.out.println(e.getMessage());
        document = null;
        return bean;
    }

    public EditWebhelper getInstance()
    {
        EditWebhelper ew = new EditWebhelper();
        SAXReader saxReader = new SAXReader();
        document = saxReader.read(new File(filename));
        document2 = saxReader.read(new File(filename2));
        break MISSING_BLOCK_LABEL_73;
        Exception e;
        e;
        System.out.println(e.getMessage());
        return ew;
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
        EditWebhelper editWebhelper1 = new EditWebhelper();
        editWebhelper1.filename = "D:/style2.xml";
        editWebhelper1.getInstance();
        EditBean bean = editWebhelper1.InitPara();
        System.out.println(bean.getSToolBar());
    }

    public Element memoString(Element button, String Node)
    {
        Iterator memo = button.elementIterator(Node);
        if(memo.hasNext())
        {
            Element memostring = (Element)memo.next();
            return memostring;
        } else
        {
            return null;
        }
    }

    public String notNull(String str)
    {
        String s = str;
        if(str == null)
            return "";
        else
            return s;
    }
}
