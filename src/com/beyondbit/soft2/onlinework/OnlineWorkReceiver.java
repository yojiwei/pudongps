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

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class OnlineWorkReceiver extends HttpServlet {
    private Logger logger;
    private static final String CONTENT_TYPE = "text/html; charset=GBK";

    //Initialize global variables
    public void init() throws ServletException {
        logger = Logger.getLogger(OnlineWorkReceiver.class);
    }

    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType(CONTENT_TYPE);
        Document doc = XMLUtil.inputStream2Doc(request.getInputStream());

        XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
        Node node = result.iterateNext();
        String ow_id = CTools.dealNull(node.getAttributes().getNamedItem("办事ID").getNodeValue());
        String wo_opinion = CTools.dealNull(node.getAttributes().getNamedItem("回复意见").getNodeValue());
        String wo_status = CTools.dealNull(node.getAttributes().getNamedItem("状态").getNodeValue());
        logger.info("update db for wsb feedback start");
        logger.info(ow_id + ":" + wo_opinion + ":" + wo_status);
        this.updateDB(ow_id, wo_opinion, wo_status);
    }

    //Process the HTTP Get request
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType(CONTENT_TYPE);
        this.doGet(request, response);
    }


    //Clean up resources
    public void destroy() {
    }

    private void updateDB(String ow_id, String wo_opinion, String wo_status){
        String wo_id = "";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl  = new CDataImpl(dCn);
        dCn.beginTrans();

        Hashtable cont = dImpl.getDataInfo("select wo_id from tb_onlinework where ow_id='" + ow_id + "'");
        if(cont != null){
            wo_id = cont.get("wo_id").toString();
        }

        dImpl.edit("tb_work", "wo_id", wo_id);
        dImpl.setValue("wo_status", wo_status, CDataImpl.INT);
        dImpl.update();

        dImpl.setClobValue("wo_opinion", wo_opinion);

        if(!"".equals(dCn.getLastErrString())){
            dCn.rollbackTrans();
            logger.error("error update db");
        }
        else{
            dCn.commitTrans();
        }
        logger.info("update db for wsb feedback end");
        dImpl.closeStmt();
        dCn.closeCn();
    }
}
