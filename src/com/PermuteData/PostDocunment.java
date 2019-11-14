// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   PostDocunment.java

package com.PermuteData;

import org.dom4j.*;

public class PostDocunment
{

    public PostDocunment()
    {
    }

    public String getBizXml(String wo_id, String el_xml, String type, String typeName, String aim)
    {
        String xml = "";
        xml = el_xml;
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
        baninfoElem.addAttribute("事项类型ID", type);
        baninfoElem.addAttribute("办事ID", wo_id);
        baninfoElem.addAttribute("事项名称", typeName);
        baninfoElem.addAttribute("办事内容", xml);
        baninfoElem.addAttribute("申请时间", "");
        baninfoElem.addAttribute("状态", "0");
        Element a = baninfoElem.addElement("回复意见");
        Element luinfoElem = booksElement.addElement("路由信息");
        Element mubiaoElem = luinfoElem.addElement("目标");
        mubiaoElem.addAttribute("目标ID", aim);
        return document.asXML();
    }

    public static void main(String args1[])
    {
    }
}
