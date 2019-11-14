package com.beyondbit.soft2.onlinework;

import java.io.File;
import java.util.Hashtable;
import java.util.Iterator;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import java.io.*;
import javax.xml.parsers.*;
import javax.xml.soap.Node;
import org.w3c.dom.*;


import com.beyondbit.soft2.utils.XMLUtil;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CMessage;

public class WSBService {
	
	public WSBService(){}
	
	public void getMessage(String xmls){
		String xm_id = "";
		String xm_option = "";
		String xm_status = "";
		String xm_workid = "";
		String filename = xmls;
		Document doc = null;
		  try{
			   DocumentBuilderFactory.newInstance(); //定义工厂 API，使应用程序能够从 XML 文档获取生成 DOM 对象树的解析器。
			   DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance(); //newInstance  获取 DocumentBuilderFactory 的新实例。
			   dbf.setNamespaceAware(true); // 指定由此代码生成的解析器将提供对 XML 名称空间的支持。
			   DocumentBuilder db = dbf.newDocumentBuilder(); //使用当前配置的参数创建一个新的 DocumentBuilder 实例。
			   doc = db.parse(new FileInputStream(filename)); //将给定 InputStream 的内容解析为一个 XML 文档，并且返回一个新的 DOM Document 对象。
			   
			   Element root = doc.getDocumentElement();
			   if(root!=null){
				  NodeList elements = root.getElementsByTagName("BackInfo"); // 取得元素列表 
				  for(int i = 0; i < elements.getLength(); i++) { 
					Element subs =(Element) elements.item(i); 
					
				  }
			   }
			   String nm = "*";
			   NodeList n1 = doc.getElementsByTagNameNS(nm,"BackInfo");//NodeList 接口提供对节点的有序集合的抽象，没有定义或约束如何实现此集合。 以文档顺序返回具有给定本地名称和名称空间 URI 的所有 Elements 的 NodeList。
			   for(int i = 0; i < n1.getLength(); i++){
			    org.w3c.dom.Node n = n1.item(i); // 返回集合中的第 index 个项。返回Node
			    xm_id = n.getAttributes().getNamedItem("ID").getNodeValue();
			    xm_option = n.getAttributes().getNamedItem("info").getNodeValue();
			    xm_status = n.getAttributes().getNamedItem("status").getNodeValue();
			    xm_workid = n.getAttributes().getNamedItem("workID").getNodeValue();
			   }
			   //
			   //updateDB(xm_workid,xm_option,xm_status);
		  }catch(Exception e){
		   System.out.println("异常"+e.getMessage());
		   e.printStackTrace();
		  }
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
                } else
                {
                    dCn.commitTrans();
                }
            } else
            {
                //logger.warn("ow_id " + ow_id + " not found");
            }
            dImpl.closeStmt();
            dCn.closeCn();
        } else
        {
            //logger.warn("wo_status " + wo_status + " not found");
        }
    }
    
    public static void main(String args[]){
    	WSBService wsb = new WSBService();
    	wsb.getMessage("d:\\xml.xml");
    }
}
