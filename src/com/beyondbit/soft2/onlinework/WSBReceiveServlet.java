package com.beyondbit.soft2.onlinework;

import com.beyondbit.soft2.utils.XMLUtil;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.*;

import java.io.IOException;
import java.util.Hashtable;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.w3c.dom.*;
import org.w3c.dom.xpath.XPathResult;
/**
 * update 20100817
 * @author Administrator
 *<?xml version="1.0" encoding="gb2312"?><BackInfo ID="" info="申请已批准。明日起，请持《邀请外国人来沪申请表》正本（盖好公章）到合欢路
2号A2柜台领取签证通知表。办理工作（Z）签证的，取件时还须持就业许可证原件和护照复
印件交柜台验看。领取时间：上午9：00-11：30 下午13：30-16：30（如遇周六、周日、国
家法定节假日顺延）" status="3" workID="o134120"></BackInfo>
 */
public class WSBReceiveServlet extends HttpServlet
{

    private Logger logger;

    public WSBReceiveServlet()
    {
    }
    /**
     * init方法
     */
    public void init()
        throws ServletException
    {
        logger = Logger.getLogger(com.beyondbit.soft2.onlinework.WSBReceiveServlet.class);
    }
    /**
     * doGet方法
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	org.w3c.dom.Document doc = XMLUtil.inputStream2Doc(request.getInputStream());
        System.out.println(doc);
        XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
        System.out.println(result);
        Node node = result.iterateNext();
        String ow_id = CTools.dealNull(node.getAttributes().getNamedItem("办事ID").getNodeValue()).trim();
        String wo_opinion = CTools.dealNull(node.getChildNodes().item(0).getChildNodes().item(0).getNodeValue());
        String wo_status = CTools.dealNull(node.getAttributes().getNamedItem("状态").getNodeValue()).trim();
        logger.info("update db for wsb feedback start");
        logger.info(ow_id + ":" + wo_opinion + ":" + wo_status);
        System.out.println(ow_id + ":" + wo_opinion + ":" + wo_status);
        //updateDB(ow_id, wo_opinion, wo_status);
    }
    /**
     * doPost方法
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        doGet(request, response);
    }
    /**
     * 销毁方法
     */
    public void destroy()
    {
    }
    /**
     * 修改外事办状态、办事内容等反馈
     * @param ow_id
     * @param wo_opinion
     * @param wo_status
     */
    private void updateDB(String ow_id, String wo_opinion, String wo_status)
    {
        String wo_id = "";
        String us_id = "";
        String wo_applypeople = "";
        String wo_projectname = "";
        String dt_id = "";
        String dt_name = "";
        if(wo_status.equals("1") || wo_status.equals("2") || wo_status.equals("3") || wo_status.equals("4"))
        {
            CDataCn dCn = new CDataCn();
            CDataImpl dImpl = new CDataImpl(dCn);
            Hashtable cont = dImpl.getDataInfo("select a.wo_id, b.us_id, b.wo_applypeople, b.wo_projectname, c.DT_ID, d.DT_NAME from tb_onlinework a, tb_work b, tb_proceeding c, tb_deptinfo d where c.dt_id=d.dt_id and b.pr_id=c.pr_id and a.wo_id=b.wo_id and a.ow_id='" + ow_id + "'");
            if(cont != null)
            {
                wo_id = cont.get("wo_id").toString();
                us_id = cont.get("us_id").toString();
                wo_applypeople = cont.get("wo_applypeople").toString();
                wo_projectname = cont.get("wo_projectname").toString();
                dt_id = cont.get("dt_id").toString();
                dt_name = cont.get("dt_name").toString();
                String msgContent = null;
                if("3".equals(wo_status))
                    msgContent = "已经通过";
                if("4".equals(wo_status))
                    msgContent = "没有通过";
                if("2".equals(wo_status))
                    msgContent = "需修改";
                dCn.beginTrans();
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", wo_status, 0);
                if("3".equals(wo_status) || "4".equals(wo_status))
                {
                    new CDate();
                    dImpl.setValue("wo_finishtime", CDate.getNowTime(), 5);
                }
                dImpl.update();
                dImpl.setClobValue("wo_opinion", wo_opinion);
                CMessage msg = new CMessage(dImpl);
                msg.addNew();
                msg.setValue(CMessage.msgReceiverId, us_id);
                msg.setValue(CMessage.msgReceiverName, wo_applypeople);
                msg.setValue(CMessage.msgTitle,"您申请的项目“" + wo_projectname + "”" + msgContent);
                msg.setValue(CMessage.msgSenderId, dt_id);
                msg.setValue(CMessage.msgSenderName, dt_name);
                msg.setValue(CMessage.msgSenderDesc, dt_name);
                msg.setValue(CMessage.msgIsNew, "1");
                msg.setValue(CMessage.msgRelatedType, "1");
                msg.setValue(CMessage.msgPrimaryId, wo_id);
                msg.setValue(CMessage.msgSendTime, new CDate().getNowTime());
                msg.setValue(CMessage.msgContent, wo_opinion);
                msg.update();
                
                if(!"".equals(dCn.getLastErrString()))
                {
                    dCn.rollbackTrans();
                    logger.error("error update db");
                } else
                {
                    dCn.commitTrans();
                }
                logger.info("update db for wsb feedback end");
            } else
            {
                logger.warn("ow_id " + ow_id + " not found");
            }
            dImpl.closeStmt();
            dCn.closeCn();
        } else
        {
            logger.warn("wo_status " + wo_status + " not found");
        }
    }
}