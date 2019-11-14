package com.beyondbit.soft2.onlinework;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.util.Vector;
import java.util.Hashtable;
import org.w3c.dom.Document;
import com.beyondbit.soft2.utils.XMLUtil;
import org.w3c.dom.Element;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class Extract2BizData {
    private Logger logger;
    private Vector retVector = new Vector();

    public Extract2BizData() {
        logger = Logger.getLogger(Extract2BizData.class);
        logger.info("start initializing Extract2BizData!");
        //PropertyConfigurator.configure(System.getProperty("configpath") + "\\" + System.getProperty("logconfig"));
    }

    public static void main(String[] args) {
        Extract2BizData extract2BizData1 = new Extract2BizData();
        Vector v = extract2BizData1.getData();
        for (int i = 0; i < v.size(); i++) {
            System.out.println(v.get(i));
        }

    }

    public Vector getData() {

        String xml = null;

        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        logger.info(dCn.getConnection().toString());
        String sql = "select a.wo_id, a.wo_applypeople, a.wo_tel, a.wo_postcode, a.wo_idcard, a.wo_address, a.wo_projectname, to_char(a.wo_applytime, 'yyyy-mm-dd hh24:mi:ss') wo_applytime, b.ow_id, b.ow_content, c.pf_url, c.pr_id, d.oe_id from tb_work a, tb_onlinework b, tb_proceedingforward c, tb_owexch d where a.wo_id=b.wo_id and a.pr_id=c.pr_id and a.wo_id=d.wo_id and d.oe_status=0";
        //sql = "select * from tb_owexch";
        Vector vPage = dImpl.splitPage(sql, 1000, 1);
        if (vPage != null) {
            for (int i = 0; i < vPage.size(); i++) {
                Document doc = XMLUtil.string2Doc("<?xml version=\"1.0\"?><ns0:在线办事消息 xmlns:ns0=\"http://POCBiztalkOnlineWorkSchema.OnlineWorkSchema\" />");
                Element root = doc.getDocumentElement();
                //doc.appendChild(root);
                Element tempNode = null;

                Hashtable content = (Hashtable) vPage.get(i);
                tempNode = doc.createElement("用户信息");
                tempNode.setAttribute("用户名",
                                      content.get("wo_applypeople").toString());
                tempNode.setAttribute("电话", content.get("wo_tel").toString());
                tempNode.setAttribute("邮编", content.get("wo_postcode").toString());
                tempNode.setAttribute("身份证", content.get("wo_idcard").toString());
                tempNode.setAttribute("地址", content.get("wo_address").toString());
                root.appendChild(tempNode);

                tempNode = doc.createElement("办事信息");
                tempNode.setAttribute("事项类型ID", content.get("pr_id").toString());
                tempNode.setAttribute("办事ID", content.get("ow_id").toString());
                tempNode.setAttribute("事项名称",
                                      content.get("wo_projectname").toString());
                String owcontent = content.get("ow_content").toString();
                owcontent = owcontent.substring(owcontent.indexOf("?>") + 2);
                tempNode.setAttribute("办事内容", owcontent);
                tempNode.setAttribute("申请时间",
                                      content.get("wo_applytime").toString());
                tempNode.setAttribute("状态", "1");
                //tempNode.setAttribute("回复意见", "");
                Element temp3 = doc.createElement("回复意见");
                temp3.appendChild(doc.createTextNode(""));
                tempNode.appendChild(temp3);
                root.appendChild(tempNode);

                tempNode = doc.createElement("路由信息");
                Element temp1 = doc.createElement("目标");
                temp1.setAttribute("目标ID", "78");
                tempNode.appendChild(temp1);
                root.appendChild(tempNode);
                xml = XMLUtil.doc2String(doc);
                retVector.add(xml);
                retVector.add(content.get("pf_url").toString());
                retVector.add(content.get("wo_id").toString());
                retVector.add(content.get("oe_id").toString());
                logger.debug("pf_url: " + content.get("pf_url").toString());
            }

        }
        dImpl.closeStmt();
        dCn.closeCn();
        return retVector;
    }

}
