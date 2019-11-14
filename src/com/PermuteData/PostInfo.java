// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   PostInfo.java

package com.PermuteData;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CMessage;
import java.io.PrintStream;
import java.util.*;
import org.dom4j.Document;

// Referenced classes of package com.PermuteData:
//            PostDocument, Permunte

public class PostInfo
{

    public PostInfo()
    {
    }

    public String getJHID()
    {
        CDataCn pCn = new CDataCn();
        CDataImpl cimpl = new CDataImpl(pCn);
        String sql = "select x.el_id from tb_user u,tb_enterpvisc e ,tb_entemprvisexml x where u.us_id = e.us_id and e.ec_id =x.ec_id and x.el_type ='0' and x.el_post='0' and x.pp_id=34 and x.el_servlet='0'";
        Vector vec = cimpl.splitPage(sql, 1000, 1);
        String elid = "";
        if(vec != null)
        {
            for(int i = 0; i < vec.size(); i++)
            {
                Hashtable map = (Hashtable)vec.get(i);
                String el_id = map.get("el_id").toString();
                if(elid.equals(""))
                    elid = el_id;
                else
                    elid = elid + ";" + el_id;
            }

        }
        cimpl.closeStmt();
        pCn.closeCn();
        return elid;
    }

    public String getInfo(String el_id)
    {
        CDataCn pCn = new CDataCn();
        CDataImpl cimpl = new CDataImpl(pCn);
        String sql = "select u.us_id,x.el_type,x.el_xml,x.el_annex,x.el_id from tb_user u,tb_enterpvisc e ,tb_entemprvisexml x where u.us_id = e.us_id and e.ec_id =x.ec_id and x.el_type ='0' and x.el_post='0' and x.pp_id=34 and x.el_servlet='0' and x.el_id=" + el_id;
        Hashtable map = cimpl.getDataInfo(sql);
        String strxml = "";
        if(map != null)
        {
            String el_xml = map.get("el_xml").toString();
            String el_annex = map.get("el_annex").toString();
            PostDocument pd = new PostDocument();
            Document docxml = pd.getBizXml(el_id, el_xml, el_annex);
            strxml = docxml.asXML();
        }
        cimpl.closeStmt();
        pCn.closeCn();
        return strxml;
    }

    public void retJHID(String jhid, String value)
    {
        CDataCn pCn = new CDataCn();
        CDataImpl cimpl = new CDataImpl(pCn);
        cimpl.edit("tb_entemprvisexml", "el_id", jhid);
        cimpl.setValue("el_servlet", value, 3);
        cimpl.update();
        cimpl.closeStmt();
        pCn.closeCn();
    }

    public void setPost(String el_id, String el_type, String huifu)
    {
        upDb(el_id, el_type, huifu);
    }

    public void upDb(String el_id, String el_type, String huifu)
    {
        System.out.println(new Date() + "->el_id=" + el_id + "->el_type=" + el_type + "->huifu=" + huifu);
        CDataCn pCn = new CDataCn();
        CDataImpl cimpl = new CDataImpl(pCn);
        String sql = "select e.us_id,e.ec_name from tb_enterpvisc e ,tb_entemprvisexml x where e.ec_id =x.ec_id  and x.el_id='" + el_id + "'";
        pCn.beginTrans();
        Hashtable map = cimpl.getDataInfo(sql);
        String msgTitle = "浦东新区外事办公室反馈信息，请点击察看";
        if(map != null)
        {
            String us_id = map.get("us_id").toString();
            cimpl.edit("tb_entemprvisexml", "el_id", el_id);
            cimpl.setValue("el_type", el_type, 3);
            cimpl.update();
            CMessage msg = new CMessage(cimpl);
            msg.addNew();
            msg.setValue(4, us_id);
            msg.setValue(5, map.get("ec_name").toString());
            msg.setValue(1, msgTitle);
            msg.setValue(6, "32");
            msg.setValue(7, "外事办");
            msg.setValue(8, "外事办");
            msg.setValue(3, "1");
            msg.setValue(12, "1");
            msg.setValue(13, "0");
            msg.setValue(9, (new CDate()).getNowTime());
            msg.setValue(2, huifu);
            msg.update();
        }
        pCn.commitTrans();
        cimpl.closeStmt();
        pCn.closeCn();
    }

    public void Pt(String key, String value)
    {
        System.out.println(new Date() + " -> " + key + " -> " + value);
    }

    public void Pe(String value)
    {
        System.err.println(new Date() + " -> " + value);
    }

    public static void main(String arg[])
    {
        Permunte poif = new Permunte();
        String a = poif.getJHid();
        System.out.println(a);
        String b[] = a.split(";");
        for(int i = 0; i < b.length; i++)
        {
            String xml = poif.getJHValue(b[i]);
            System.out.println(xml);
        }

    }
}
