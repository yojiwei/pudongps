package com.beyondbit.soft2.onlinework;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import org.w3c.dom.Document;
import com.beyondbit.soft2.utils.XMLUtil;
import org.w3c.dom.xpath.XPathResult;
import org.w3c.dom.Node;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import org.apache.log4j.Logger;
import com.util.CTools;
import com.util.CMessage;
import com.util.CDate;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class WSBReceiveServlet_bak
    extends HttpServlet {
    private Logger logger;

    //private static final String CONTENT_TYPE = "text/html; charset=GBK";

    //Initialize global variables
    public void init() throws ServletException {
        logger = Logger.getLogger(WSBReceiveServlet_bak.class);
    }

    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws
        ServletException, IOException {
        Document doc = XMLUtil.inputStream2Doc(request.getInputStream());

        XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
        //XMLUtil.doc2File(doc);
        Node node = result.iterateNext();
        String ow_id = CTools.dealNull(node.getAttributes().getNamedItem("办事ID").
                                       getNodeValue()).trim();
        String wo_opinion = CTools.dealNull(node.getChildNodes().item(0).
                                            getChildNodes().item(0).
                                            getNodeValue());
        String wo_status = CTools.dealNull(node.getAttributes().getNamedItem(
            "状态").getNodeValue()).trim();
        logger.info("update db for wsb feedback start");
        logger.info(ow_id + ":" + wo_opinion + ":" + wo_status);
        this.updateDB(ow_id, wo_opinion, wo_status);
    }

    //Process the HTTP Get request
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws
        ServletException, IOException {
        //response.setContentType(CONTENT_TYPE);
        this.doGet(request, response);
    }

    //Clean up resources
    public void destroy() {
    }

    private void updateDB(String ow_id, String wo_opinion, String wo_status) {
        String wo_id = "";
        String us_id = "";
        String wo_applypeople = "";
        String wo_projectname = "";
        String dt_id = "";
        String dt_name = "";

        if(wo_status.equals("1") || wo_status.equals("2") || wo_status.equals("3") || wo_status.equals("4")){
            CDataCn dCn = new CDataCn();
            CDataImpl dImpl = new CDataImpl(dCn);

            Hashtable cont = dImpl.getDataInfo("select a.wo_id, b.us_id, b.wo_applypeople, b.wo_projectname, c.DT_ID, d.DT_NAME from tb_onlinework a, tb_work b, tb_proceeding c, tb_deptinfo d where c.dt_id=d.dt_id and b.pr_id=c.pr_id and a.wo_id=b.wo_id and a.ow_id='" +
                                               ow_id + "'");
            if (cont != null) {
                wo_id = cont.get("wo_id").toString();
                us_id = cont.get("us_id").toString();
                wo_applypeople = cont.get("wo_applypeople").toString();
                wo_projectname = cont.get("wo_projectname").toString();
                dt_id = cont.get("dt_id").toString();
                dt_name = cont.get("dt_name").toString();

                String msgContent = null;
                if ("3".equals(wo_status)) {
                    msgContent = "已经通过";
                }
                if ("4".equals(wo_status)) {
                    msgContent = "没有通过";
                }
                if ("2".equals(wo_status)) {
                    msgContent = "需修改";
                }
                dCn.beginTrans();
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", wo_status, CDataImpl.INT);
                if ("3".equals(wo_status) || "4".equals(wo_status)) dImpl.
                    setValue("wo_finishtime", new CDate().getNowTime(),
                             CDataImpl.DATE);
                dImpl.update();

                dImpl.setClobValue("wo_opinion", wo_opinion);

                CMessage msg = new CMessage(dImpl);
                msg.addNew();
                msg.setValue(CMessage.msgReceiverId, us_id);
                msg.setValue(CMessage.msgReceiverName, wo_applypeople);
                msg.setValue(CMessage.msgTitle,
                             "您申请的项目“" + wo_projectname + "”" + msgContent);
                msg.setValue(CMessage.msgSenderId, dt_id);
                msg.setValue(CMessage.msgSenderName, dt_name);
                msg.setValue(CMessage.msgSenderDesc, dt_name);
                msg.setValue(CMessage.msgIsNew, "1");
                msg.setValue(CMessage.msgRelatedType, "1");
                msg.setValue(CMessage.msgPrimaryId, wo_id);
                msg.setValue(CMessage.msgSendTime, new CDate().getNowTime());
                msg.setValue(CMessage.msgContent, wo_opinion);
                msg.update();

                if (!"".equals(dCn.getLastErrString())) {
                    dCn.rollbackTrans();
                    logger.error("error update db");
                }
                else {
                    dCn.commitTrans();
                }
                logger.info("update db for wsb feedback end");
            }
            else{
                logger.warn("ow_id " + ow_id + " not found");
            }
            dImpl.closeStmt();
            dCn.closeCn();
        }
        else {
            logger.warn("wo_status " + wo_status + " not found");
        }
    }
/*
    public static void main(String[] args) {

        WSBReceiveServlet test = new WSBReceiveServlet();
        test.go();
    }
    public void go(){
        logger = Logger.getLogger(WSBReceiveServlet.class);
        try {
            Document doc = XMLUtil.inputStream2Doc(new FileInputStream(
                "p:\\ttttt.xml"));
            XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
            XMLUtil.doc2File(doc);
            Node node = result.iterateNext();
            String ow_id = CTools.dealNull(node.getAttributes().getNamedItem(
                "办事ID").
                                           getNodeValue()).trim();
            String wo_opinion = CTools.dealNull(node.getChildNodes().item(0).
                                                getChildNodes().item(0).
                                                getNodeValue()).trim();
            String wo_status = CTools.dealNull(node.getAttributes().
                                               getNamedItem(
                "状态").getNodeValue()).trim();

            this.updateDB(ow_id, wo_opinion, wo_status);

        }
        catch (FileNotFoundException ex) {
            ex.printStackTrace();
        }

    }*/
}
