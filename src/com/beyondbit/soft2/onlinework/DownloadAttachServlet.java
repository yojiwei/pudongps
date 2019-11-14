package com.beyondbit.soft2.onlinework;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;
import org.w3c.dom.Document;
import com.beyondbit.soft2.utils.XMLUtil;
import org.w3c.dom.xpath.XPathResult;
import org.w3c.dom.Node;
import org.apache.log4j.Logger;
//import com.util.CDownLoad;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class DownloadAttachServlet
    extends HttpServlet {
    private Logger logger;
    private static final String CONTENT_TYPE = "text/html; charset=GBK";

    //Initialize global variables
    public void init() throws ServletException {
        logger = Logger.getLogger(WSBReceiveServlet_bak.class);
    }

    //Process the HTTP Get request
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws
        ServletException, IOException {

        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);

        String wo_id = CTools.dealString(request.getParameter("wo_id")).trim();
        String filename = CTools.dealString(request.getParameter("filename")).
            trim();
        String fjsm = CTools.dealString(request.getParameter("fjsm")).trim();
        String ow_content = null;

        if (!wo_id.equals("")) {
            String sqlStr =
                "select a.ow_content from tb_onlinework a, tb_work b where a.wo_id=b.wo_id and b.wo_id='" +
                wo_id + "'";
            Hashtable content = dImpl.getDataInfo(sqlStr);
            if (content != null) {
                ow_content = content.get("ow_content").toString();

                Document doc = XMLUtil.string2Doc(ow_content);
                XPathResult result = XMLUtil.parseConfig(doc,
                    "//¸½¼þ[(@filename='" + filename + "') and (@name='" + fjsm +
                    "')]");
                Node n;
                if ( (n = result.iterateNext()) != null) {
                    String filecontent = n.getChildNodes().item(0).getNodeValue();

                    response.reset();

                    response.setHeader("Content-Disposition",
                                       "attachment;filename=" + filename);
                    response.setContentType("application/download");

                    javax.servlet.ServletOutputStream stream = response.
                        getOutputStream();

                    BufferedInputStream fif = new BufferedInputStream(new
                        ByteArrayInputStream(new org.apache.commons.codec.binary.
                        Base64().decode(filecontent.getBytes())));
                    byte[] data = new byte[1000];
                    int li_size;
                    while ( (li_size = fif.read(data)) != -1) {
                        stream.write(data, 0, li_size);
                    }

                    stream.flush();
                    fif.close();
                }
            }
        }

        dImpl.closeStmt();
        dCn.closeCn();

    }

    //Clean up resources
    public void destroy() {
    }
}
