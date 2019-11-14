package com.beyondbit.soft2.onlinework;

import java.util.Vector;
import java.util.TimerTask;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.HttpClient;
import java.io.*;
import org.apache.log4j.Logger;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import org.w3c.dom.Document;
import com.beyondbit.soft2.utils.XMLUtil;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class OnlineWorkPoller
    extends TimerTask {
    private String pr_id = null;
    private Extract2BizData extract;
    private HttpClient httpclient;
    private Logger logger;

    public OnlineWorkPoller() {
        logger = Logger.getLogger(OnlineWorkPoller.class);
        logger.info("start initializing OnlineWorkPoller!");

        httpclient = new HttpClient();
    }

    private int sendWork() {
        extract = new Extract2BizData();
        Vector data = extract.getData();
        for (int i = 0; i < data.size(); i += 4) {
            String xml = data.get(i).toString();
            String destinationURL = data.get(i + 1).toString();
            String wo_id = data.get(i + 2).toString();
            String oe_id = data.get(i + 3).toString();
            Document doc = XMLUtil.string2Doc(xml);
            XMLUtil.doc2File(doc);
            /*
            try {
                doc = XMLUtil.inputStream2Doc(new FileInputStream("c:\\t11.xml"));
            }
            catch (FileNotFoundException ex1) {
                ex1.printStackTrace();
            }*/
            PostMethod post = new PostMethod(destinationURL);
            post.setRequestHeader("Content-type",
                                  "text/xml; charset=UTF-8");

            //post.setRequestBody(xml);
            post.setRequestBody(XMLUtil.doc2String(doc));

            doc.getDocumentElement();
            XMLUtil.doc2File(doc);

            try {
                logger.info("sending data to " + destinationURL);
                httpclient.executeMethod(post);
                logger.info("data sended");
                logger.info("updating database ...");
                this.updateDB(wo_id, oe_id);
                logger.info("database updated");
            }
            catch (IOException ex) {
                logger.error(null, ex);
            }

        }
        return 0;
    }

    private void updateDB(String wo_id, String oe_id) {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl  = new CDataImpl(dCn);
        dCn.beginTrans();
        /*
        dImpl.edit("tb_work", "wo_id", wo_id);
        dImpl.setValue("wo_status", "2", CDataImpl.INT);
        dImpl.update();*/

        dImpl.edit("tb_owexch", "oe_id", oe_id);
        dImpl.setValue("oe_status", "1", CDataImpl.STRING);
        dImpl.update();

        if(!"".equals(dCn.getLastErrString())){
            dCn.rollbackTrans();
        }
        else{
            dCn.commitTrans();
        }

        dImpl.closeStmt();
        dCn.closeCn();
    }

    public static void main(String[] args) {
        OnlineWorkPoller onlineWorkPoller1 = new OnlineWorkPoller();
        onlineWorkPoller1.sendWork();
    }

    public void run() {
        sendWork();
    }
}
