package com.beyondbit.soft2.onlinework;

import org.w3c.dom.Node;
import org.w3c.dom.Document;

import org.w3c.dom.xpath.XPathResult;

import java.util.Hashtable;
import com.beyondbit.soft2.utils.*;
import java.util.Vector;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class WSBCGSPData {
    private Hashtable data = new Hashtable();

    public WSBCGSPData() {
    }

    private String getXML(String wo_id) {
        String xml = null;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Hashtable content = dImpl.getDataInfo(
            "select ow_content from tb_onlinework where wo_id='" + wo_id + "'");
        if (content != null) {
            xml = content.get("ow_content").toString();
        }
        dImpl.closeStmt();
        dCn.closeCn();
        return xml;
    }

    public Hashtable getData(String wo_id) {
        String xml = getXML(wo_id);
        //System.out.println(xml);

        Document doc = new XMLUtil().string2Doc(xml);
        XPathResult result = XMLUtil.parseConfig(doc, "//组团信息");
        Hashtable table = new Hashtable();
        Node node;
        if ( (node = result.iterateNext()) != null) {
            table.put("lwdw",
                      node.getAttributes().getNamedItem("lwdw").getNodeValue());
            table.put("ztdw",
                      node.getAttributes().getNamedItem("ztdw").getNodeValue());
            table.put("ztname",
                      node.getAttributes().getNamedItem("ztname").getNodeValue());
            table.put("ztdwdm",
                      node.getAttributes().getNamedItem("ztdwdm").getNodeValue());
            table.put("ztnum_b",
                      node.getAttributes().getNamedItem("ztnum_b").getNodeValue());
            table.put("cfts_b",
                      node.getAttributes().getNamedItem("cfts_b").getNodeValue());
            table.put("cfrw",
                      node.getAttributes().getNamedItem("cfrw").getNodeValue());
            table.put("pjlx",
                      node.getAttributes().getNamedItem("pjlx").getNodeValue());
        }
        data.put("组团信息", table);

        result = XMLUtil.parseConfig(doc, "//出访地点/*");
        Vector vector = new Vector();
        while ( (node = result.iterateNext()) != null) {
            table = new Hashtable();
            table.put("xuhao",
                      node.getAttributes().getNamedItem("xuhao").getNodeValue());
            table.put("gjname",
                      node.getAttributes().getNamedItem("gjname").getNodeValue());
            table.put("guojing",
                      node.getAttributes().getNamedItem("guojing").getNodeValue());
            table.put("tlsj",
                      node.getAttributes().getNamedItem("tlsj").getNodeValue());
            table.put("yqzhong",
                      node.getAttributes().getNamedItem("yqzhong").getNodeValue());
            table.put("dddate",
                      node.getAttributes().getNamedItem("dddate").getNodeValue());
            table.put("leftdate",
                      node.getAttributes().getNamedItem("leftdate").getNodeValue());
            vector.add(table);
        }
        data.put("出访地点", vector);

        result = XMLUtil.parseConfig(doc, "//人员组成/*");
        vector = new Vector();
        while ( (node = result.iterateNext()) != null) {
            table = new Hashtable();
            table.put("recordnum",
                      node.getAttributes().getNamedItem("recordnum").
                      getNodeValue());
            table.put("name",
                      node.getAttributes().getNamedItem("name").getNodeValue());
            table.put("xb",
                      node.getAttributes().getNamedItem("xb").getNodeValue());
            table.put("csdate",
                      node.getAttributes().getNamedItem("csdate").getNodeValue());
            table.put("idcard",
                      node.getAttributes().getNamedItem("idcard").getNodeValue());
            table.put("gzdw",
                      node.getAttributes().getNamedItem("gzdw").getNodeValue());
            table.put("nzw",
                      node.getAttributes().getNamedItem("nzw").getNodeValue());
            table.put("nzc",
                      node.getAttributes().getNamedItem("nzc").getNodeValue());
            vector.add(table);
        }
        data.put("人员组成", vector);

        result = XMLUtil.parseConfig(doc, "//出访费用");
        table = new Hashtable();
        if ( (node = result.iterateNext()) != null) {
            table.put("gjlf",
                      node.getAttributes().getNamedItem("gjlf").getNodeValue());
            table.put("sif",
                      node.getAttributes().getNamedItem("sif").getNodeValue());
            table.put("suf",
                      node.getAttributes().getNamedItem("suf").getNodeValue());
            table.put("gzf",
                      node.getAttributes().getNamedItem("gzf").getNodeValue());
            table.put("lyj",
                      node.getAttributes().getNamedItem("lyj").getNodeValue());
            table.put("byj",
                      node.getAttributes().getNamedItem("byj").getNodeValue());
            table.put("qt",
                      node.getAttributes().getNamedItem("qt").getNodeValue());
        }
        data.put("出访费用", table);

        table = new Hashtable();
        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/visitObjectRelation");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("visitObjectRelation",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("visitObjectRelation", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/visitObjectReason");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("visitObjectReason",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("visitObjectReason", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/visitojectQuestion");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("visitojectQuestion",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("visitojectQuestion", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/visitObjectCalendar");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("visitObjectCalendar",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("visitObjectCalendar", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/personStructTask");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("personStructTask",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("personStructTask", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/personStructExplain");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("personStructExplain",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("personStructExplain", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/personStructReason");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("personStructReason",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("personStructReason", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/personTwoAccess");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("personTwoAccess",
                      node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("personTwoAccess", "");
        }

        result = XMLUtil.parseConfig(doc, "//出访团组详细情况/Other");
        node = result.iterateNext();
        if (node.getChildNodes().getLength() > 0) {
            table.put("Other", node.getChildNodes().item(0).getNodeValue());
        }
        else {
            table.put("Other", "");
        }

        data.put("出访团组详细情况", table);

        result = XMLUtil.parseConfig(doc, "//附件");
        vector = new Vector();
        while ( (node = result.iterateNext()) != null) {
            table = new Hashtable();
            table.put("fjsm",
                      node.getAttributes().getNamedItem("name").getNodeValue());
            table.put("filename",
                      node.getAttributes().getNamedItem("filename").
                      getNodeValue());
            vector.add(table);
        }
        data.put("附件", vector);

        return data;
    }
}
